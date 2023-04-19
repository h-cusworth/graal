package com.oracle.truffle.llvm.parser.factories;

import com.oracle.truffle.llvm.runtime.memory.LLVMSyscallOperationNode;
import com.oracle.truffle.llvm.runtime.nodes.asm.syscall.LLVMNativeSyscallNode;
import com.oracle.truffle.llvm.runtime.nodes.asm.syscall.LLVMSyscallExitNode;
import com.oracle.truffle.llvm.runtime.nodes.asm.syscall.linux.aarch64.LinuxAArch64Syscall;
import com.oracle.truffle.llvm.runtime.nodes.intrinsics.llvm.aarch64.linux.LLVMLinuxAarch64VaListStorage;
import com.oracle.truffle.llvm.runtime.nodes.intrinsics.llvm.aarch64.linux.LLVMLinuxAarch64VaListStorageFactory.Aarch64VAListPointerWrapperFactoryNodeGen;
import com.oracle.truffle.llvm.runtime.nodes.intrinsics.llvm.va.LLVMVAListNode;
import com.oracle.truffle.llvm.runtime.nodes.intrinsics.llvm.va.LLVMVaListStorage.VAListPointerWrapperFactory;
import com.oracle.truffle.llvm.runtime.pointer.LLVMPointer;
import com.oracle.truffle.llvm.runtime.types.Type;

final class FreeBSDAArch64PlatformCapability extends BasicAarch64PlatformCapability<LinuxAArch64Syscall> {

    FreeBSDAArch64PlatformCapability(boolean loadCxxLibraries) {
        super(LinuxAArch64Syscall.class, loadCxxLibraries);
    }

    @Override
    protected LLVMSyscallOperationNode createSyscallNode(LinuxAArch64Syscall syscall) {
        switch (syscall) {
            case SYS_exit:
            case SYS_exit_group: // TODO: implement difference to SYS_exit
                return new LLVMSyscallExitNode();
            default:
                return new LLVMNativeSyscallNode(syscall);
        }
    }

    // TODO: The following methods temporarily return X86 va_list objects until the AArch64 managed
    // va_list is implemented.

    @Override
    public Object createVAListStorage(LLVMVAListNode allocaNode, LLVMPointer vaListStackPtr, Type vaListType) {
        return new LLVMLinuxAarch64VaListStorage(vaListStackPtr, vaListType);
    }

    @Override
    public Type getGlobalVAListType(Type type) {
        return LLVMLinuxAarch64VaListStorage.VA_LIST_TYPE_14.equals(type) ? LLVMLinuxAarch64VaListStorage.VA_LIST_TYPE_14
                        : LLVMLinuxAarch64VaListStorage.VA_LIST_TYPE_12.equals(type) ? LLVMLinuxAarch64VaListStorage.VA_LIST_TYPE_12 : null;
    }

    @Override
    public VAListPointerWrapperFactory createNativeVAListWrapper(boolean cached) {
        return cached ? Aarch64VAListPointerWrapperFactoryNodeGen.create() : Aarch64VAListPointerWrapperFactoryNodeGen.getUncached();
    }

    @Override
    public OS getOS() {
        return OS.FreeBSD;
    }

    @Override
    public int getDoubleLongSize() {
        return 128;
    }
}
