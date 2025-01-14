/*
 * Copyright (c) 2022, 2022, Oracle and/or its affiliates. All rights reserved.
 * Copyright (c) 2022, 2022, Red Hat Inc. All rights reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.  Oracle designates this
 * particular file as subject to the "Classpath" exception as provided
 * by Oracle in the LICENSE file that accompanied this code.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
 * or visit www.oracle.com if you need additional information or have any
 * questions.
 */

package com.oracle.svm.hosted.jdk;

import com.oracle.svm.core.feature.InternalFeature;

import java.lang.management.PlatformManagedObject;

import java.util.Set;

import com.oracle.svm.core.jdk.NativeLibrarySupport;
import com.oracle.svm.hosted.FeatureImpl.BeforeAnalysisAccessImpl;
import com.oracle.svm.core.jdk.PlatformNativeLibrarySupport;
import org.graalvm.nativeimage.impl.ConfigurationCondition;
import org.graalvm.nativeimage.ImageSingletons;
import com.oracle.svm.core.configure.ResourcesRegistry;
import com.oracle.svm.core.jdk.proxy.DynamicProxyRegistry;
import org.graalvm.nativeimage.hosted.RuntimeReflection;
import com.oracle.svm.core.jdk.RuntimeSupport;
import com.oracle.svm.core.jdk.management.ManagementAgentStartupHook;
import com.oracle.svm.core.feature.AutomaticallyRegisteredFeature;
import com.oracle.svm.core.VMInspectionOptions;
import com.oracle.svm.core.jdk.management.ManagementSupport;

@AutomaticallyRegisteredFeature
public class JmxServerFeature implements InternalFeature {
    @Override
    public boolean isInConfiguration(IsInConfigurationAccess access) {
        return VMInspectionOptions.hasJmxServerSupport();
    }

    private static void handleNativeLibraries(BeforeAnalysisAccess access) {
        // This is required for password authentication.
        // JMX checks the restrictions on the password file via a JNI native method.
        NativeLibrarySupport.singleton().preregisterUninitializedBuiltinLibrary("management_agent");
        BeforeAnalysisAccessImpl beforeAnalysisAccess = (BeforeAnalysisAccessImpl) access;
        beforeAnalysisAccess.getNativeLibraries().addStaticJniLibrary("management_agent");
        // Resolve calls to jdk_internal_agent* as builtIn. For calls to native method
        // isAccessUserOnly0.
        PlatformNativeLibrarySupport.singleton().addBuiltinPkgNativePrefix("jdk_internal_agent");
    }

    @Override
    public void beforeAnalysis(BeforeAnalysisAccess access) {
        handleNativeLibraries(access);
        registerJMXAgentResources();
        configureReflection(access);
        configureProxy(access);
        RuntimeSupport.getRuntimeSupport().addStartupHook(new ManagementAgentStartupHook());
    }

    private static void registerJMXAgentResources() {
        ResourcesRegistry resourcesRegistry = ImageSingletons.lookup(ResourcesRegistry.class);

        resourcesRegistry.addResourceBundles(ConfigurationCondition.alwaysTrue(),
                        "jdk.internal.agent.resources.agent");

        resourcesRegistry.addResourceBundles(ConfigurationCondition.alwaysTrue(),
                        "sun.security.util.Resources"); // required for password auth
    }

    private static void configureProxy(BeforeAnalysisAccess access) {
        DynamicProxyRegistry dynamicProxySupport = ImageSingletons.lookup(DynamicProxyRegistry.class);

        dynamicProxySupport.addProxyClass(access.findClassByName("java.rmi.Remote"),
                        access.findClassByName("java.rmi.registry.Registry"));

        dynamicProxySupport.addProxyClass(access.findClassByName("javax.management.remote.rmi.RMIServer"));
    }

    private static void configureReflection(BeforeAnalysisAccess access) {
        /*
         * Register all the custom substrate MXBeans. They won't be accounted for by the native
         * image tracing agent so a user may not know they need to register them.
         */
        Set<PlatformManagedObject> platformManagedObjects = ManagementSupport.getSingleton().getPlatformManagedObjects();
        for (PlatformManagedObject p : platformManagedObjects) {

            // The platformManagedObjects list contains some PlatformManagedObjectSupplier objects
            // that are meant to help initialize some MXBeans at runtime. Skip them here.
            if (p instanceof ManagementSupport.PlatformManagedObjectSupplier) {
                continue;
            }
            Class<?> clazz = p.getClass();
            RuntimeReflection.register(clazz);
            RuntimeReflection.register(clazz.getDeclaredConstructors());
            RuntimeReflection.register(clazz.getDeclaredMethods());
            RuntimeReflection.register(clazz.getDeclaredFields());
            RuntimeReflection.register(clazz.getInterfaces());
        }

        // Only JmxServerFeature, not JmxClientFeature, has registrations for platform MBeans
        String[] classes = {
                        "com.sun.management.GarbageCollectorMXBean",
                        "com.sun.management.OperatingSystemMXBean",
                        "com.sun.management.ThreadMXBean",
                        "com.sun.management.UnixOperatingSystemMXBean", "java.lang.management.CompilationMXBean",
                        "java.lang.management.GarbageCollectorMXBean", "java.lang.management.MemoryMXBean",
                        "java.lang.management.MemoryManagerMXBean", "java.lang.management.MemoryPoolMXBean",
                        "java.lang.management.RuntimeMXBean", "java.lang.management.BufferPoolMXBean",
                        "java.lang.management.ClassLoadingMXBean", "java.lang.management.PlatformLoggingMXBean"
        };

        String[] methods = {
                        "com.sun.management.OperatingSystemMXBean",
                        "com.sun.management.ThreadMXBean", "com.sun.management.UnixOperatingSystemMXBean",
                        "java.lang.management.BufferPoolMXBean",
                        "java.lang.management.ClassLoadingMXBean", "java.lang.management.CompilationMXBean",
                        "java.lang.management.GarbageCollectorMXBean", "java.lang.management.MemoryMXBean",
                        "java.lang.management.MemoryManagerMXBean", "java.lang.management.MemoryPoolMXBean",
                        "java.lang.management.RuntimeMXBean",
                        "java.lang.management.PlatformLoggingMXBean"
        };

        for (String clazz : classes) {
            RuntimeReflection.register(access.findClassByName(clazz));
        }
        for (String clazz : methods) {
            RuntimeReflection.register(access.findClassByName(clazz).getMethods());
        }
    }
}
