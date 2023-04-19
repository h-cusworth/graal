package com.oracle.truffle.llvm.toolchain.launchers.freebsd;

import com.oracle.truffle.llvm.toolchain.launchers.common.ClangLike;
import com.oracle.truffle.llvm.toolchain.launchers.common.Driver;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public final class FreeBSDLinker extends Driver {

    public static final String LLD = "lld";

    private FreeBSDLinker() {
        super(LLD);
    }

    public static List<String> getLinkerFlags() {
        return Arrays.asList("--mllvm=-lto-embed-bitcode=optimized", "--lto-O0", "-fuse-ld=lld");
    }

    public static void link(String[] args) {
        new FreeBSDLinker().doLink(args);
    }

    private void doLink(String[] args) {
        List<String> sulongArgs = new ArrayList<>();
        sulongArgs.add(exe);
        sulongArgs.add("-L" + getSulongHome().resolve(ClangLike.NATIVE_PLATFORM).resolve("lib"));
        sulongArgs.addAll(FreeBSDLinker.getLinkerFlags());
        List<String> userArgs = Arrays.asList(args);
        boolean verbose = userArgs.contains("-v");
        runDriver(sulongArgs, userArgs, verbose, false, false);
    }
}