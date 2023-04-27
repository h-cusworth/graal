; ModuleID = 'cat.c'
source_filename = "cat.c"
target datalayout = "e-m:e-pf200:128:128:128:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-freebsd"

module asm ".ident\09\22$FreeBSD$\22"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, i8*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64, %struct.pthread_mutex*, %struct.pthread*, i32, i32, %union.__mbstate_t, i32 }
%struct.__sbuf = type { i8*, i32 }
%struct.pthread_mutex = type opaque
%struct.pthread = type opaque
%union.__mbstate_t = type { i64, [120 x i8] }
%struct.flock = type { i64, i64, i32, i16, i16, i32 }

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"belnstuv\00", align 1
@nflag = dso_local global i32 0, align 4
@bflag = dso_local global i32 0, align 4
@vflag = dso_local global i32 0, align 4
@eflag = dso_local global i32 0, align 4
@lflag = dso_local global i32 0, align 4
@sflag = dso_local global i32 0, align 4
@tflag = dso_local global i32 0, align 4
@__stdoutp = external dso_local global %struct.__sFILE*, align 8
@optind = external dso_local global i32, align 4
@.str.2 = private unnamed_addr constant [7 x i8] c"stdout\00", align 1
@rval = dso_local global i32 0, align 4
@filename = dso_local global i8* null, align 8
@__stderrp = external dso_local global %struct.__sFILE*, align 8
@.str.3 = private unnamed_addr constant [35 x i8] c"usage: cat [-belnstuv] [file ...]\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"stdin\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@__stdinp = external dso_local global %struct.__sFILE*, align 8
@.str.7 = private unnamed_addr constant [2 x i8] c"r\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %ch = alloca i32, align 4
  %stdout_lock = alloca %struct.flock, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i8* @setlocale(i32 2, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str, i64 0, i64 0))
  br label %while.cond

while.cond:                                       ; preds = %sw.epilog, %entry
  %0 = load i32, i32* %argc.addr, align 4
  %1 = load i8**, i8*** %argv.addr, align 8
  %call1 = call i32 @getopt(i32 %0, i8** %1, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0))
  store i32 %call1, i32* %ch, align 4
  %cmp = icmp ne i32 %call1, -1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %ch, align 4
  switch i32 %2, label %sw.default [
    i32 98, label %sw.bb
    i32 101, label %sw.bb2
    i32 108, label %sw.bb3
    i32 110, label %sw.bb4
    i32 115, label %sw.bb5
    i32 116, label %sw.bb6
    i32 117, label %sw.bb7
    i32 118, label %sw.bb8
  ]

sw.bb:                                            ; preds = %while.body
  store i32 1, i32* @nflag, align 4
  store i32 1, i32* @bflag, align 4
  br label %sw.epilog

sw.bb2:                                           ; preds = %while.body
  store i32 1, i32* @vflag, align 4
  store i32 1, i32* @eflag, align 4
  br label %sw.epilog

sw.bb3:                                           ; preds = %while.body
  store i32 1, i32* @lflag, align 4
  br label %sw.epilog

sw.bb4:                                           ; preds = %while.body
  store i32 1, i32* @nflag, align 4
  br label %sw.epilog

sw.bb5:                                           ; preds = %while.body
  store i32 1, i32* @sflag, align 4
  br label %sw.epilog

sw.bb6:                                           ; preds = %while.body
  store i32 1, i32* @vflag, align 4
  store i32 1, i32* @tflag, align 4
  br label %sw.epilog

sw.bb7:                                           ; preds = %while.body
  %3 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8
  call void @setbuf(%struct.__sFILE* %3, i8* null)
  br label %sw.epilog

sw.bb8:                                           ; preds = %while.body
  store i32 1, i32* @vflag, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %while.body
  call void @usage() #5
  unreachable

sw.epilog:                                        ; preds = %sw.bb8, %sw.bb7, %sw.bb6, %sw.bb5, %sw.bb4, %sw.bb3, %sw.bb2, %sw.bb
  br label %while.cond, !llvm.loop !8

while.end:                                        ; preds = %while.cond
  %4 = load i32, i32* @optind, align 4
  %5 = load i8**, i8*** %argv.addr, align 8
  %idx.ext = sext i32 %4 to i64
  %add.ptr = getelementptr inbounds i8*, i8** %5, i64 %idx.ext
  store i8** %add.ptr, i8*** %argv.addr, align 8
  %6 = load i32, i32* @lflag, align 4
  %tobool = icmp ne i32 %6, 0
  br i1 %tobool, label %if.then, label %if.end12

if.then:                                          ; preds = %while.end
  %l_len = getelementptr inbounds %struct.flock, %struct.flock* %stdout_lock, i32 0, i32 1
  store i64 0, i64* %l_len, align 8
  %l_start = getelementptr inbounds %struct.flock, %struct.flock* %stdout_lock, i32 0, i32 0
  store i64 0, i64* %l_start, align 8
  %l_type = getelementptr inbounds %struct.flock, %struct.flock* %stdout_lock, i32 0, i32 3
  store i16 3, i16* %l_type, align 4
  %l_whence = getelementptr inbounds %struct.flock, %struct.flock* %stdout_lock, i32 0, i32 4
  store i16 0, i16* %l_whence, align 2
  %call9 = call i32 (i32, i32, ...) @fcntl(i32 1, i32 13, %struct.flock* %stdout_lock)
  %cmp10 = icmp eq i32 %call9, -1
  br i1 %cmp10, label %if.then11, label %if.end

if.then11:                                        ; preds = %if.then
  call void (i32, i8*, ...) @err(i32 1, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0)) #5
  unreachable

if.end:                                           ; preds = %if.then
  br label %if.end12

if.end12:                                         ; preds = %if.end, %while.end
  %7 = load i32, i32* @bflag, align 4
  %tobool13 = icmp ne i32 %7, 0
  br i1 %tobool13, label %if.then23, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end12
  %8 = load i32, i32* @eflag, align 4
  %tobool14 = icmp ne i32 %8, 0
  br i1 %tobool14, label %if.then23, label %lor.lhs.false15

lor.lhs.false15:                                  ; preds = %lor.lhs.false
  %9 = load i32, i32* @nflag, align 4
  %tobool16 = icmp ne i32 %9, 0
  br i1 %tobool16, label %if.then23, label %lor.lhs.false17

lor.lhs.false17:                                  ; preds = %lor.lhs.false15
  %10 = load i32, i32* @sflag, align 4
  %tobool18 = icmp ne i32 %10, 0
  br i1 %tobool18, label %if.then23, label %lor.lhs.false19

lor.lhs.false19:                                  ; preds = %lor.lhs.false17
  %11 = load i32, i32* @tflag, align 4
  %tobool20 = icmp ne i32 %11, 0
  br i1 %tobool20, label %if.then23, label %lor.lhs.false21

lor.lhs.false21:                                  ; preds = %lor.lhs.false19
  %12 = load i32, i32* @vflag, align 4
  %tobool22 = icmp ne i32 %12, 0
  br i1 %tobool22, label %if.then23, label %if.else

if.then23:                                        ; preds = %lor.lhs.false21, %lor.lhs.false19, %lor.lhs.false17, %lor.lhs.false15, %lor.lhs.false, %if.end12
  %13 = load i8**, i8*** %argv.addr, align 8
  call void @scanfiles(i8** %13, i32 1)
  br label %if.end24

if.else:                                          ; preds = %lor.lhs.false21
  %14 = load i8**, i8*** %argv.addr, align 8
  call void @scanfiles(i8** %14, i32 0)
  br label %if.end24

if.end24:                                         ; preds = %if.else, %if.then23
  %15 = load %struct.__sFILE*, %struct.__sFILE** @__stdoutp, align 8
  %call25 = call i32 @fclose(%struct.__sFILE* %15)
  %tobool26 = icmp ne i32 %call25, 0
  br i1 %tobool26, label %if.then27, label %if.end28

if.then27:                                        ; preds = %if.end24
  call void (i32, i8*, ...) @err(i32 1, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0)) #5
  unreachable

if.end28:                                         ; preds = %if.end24
  %16 = load i32, i32* @rval, align 4
  call void @exit(i32 %16) #5
  unreachable
}

declare dso_local i8* @setlocale(i32, i8*) #1

declare dso_local i32 @getopt(i32, i8**, i8*) #1

declare dso_local void @setbuf(%struct.__sFILE*, i8*) #1

; Function Attrs: noinline noreturn nounwind optnone uwtable
define internal void @usage() #2 {
entry:
  %0 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8
  %call = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.3, i64 0, i64 0))
  call void @exit(i32 1) #5
  unreachable
}

declare dso_local i32 @fcntl(i32, i32, ...) #1

; Function Attrs: noreturn
declare dso_local void @err(i32, i8*, ...) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @scanfiles(i8** %argv, i32 %verbose) #0 {
entry:
  %argv.addr = alloca i8**, align 8
  %verbose.addr = alloca i32, align 4
  %fd = alloca i32, align 4
  %i = alloca i32, align 4
  %path = alloca i8*, align 8
  %fp = alloca %struct.__sFILE*, align 8
  store i8** %argv, i8*** %argv.addr, align 8
  store i32 %verbose, i32* %verbose.addr, align 4
  store i32 0, i32* %i, align 4
  store i32 -1, i32* %fd, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end26, %entry
  %0 = load i8**, i8*** %argv.addr, align 8
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 %idxprom
  %2 = load i8*, i8** %arrayidx, align 8
  store i8* %2, i8** %path, align 8
  %cmp = icmp ne i8* %2, null
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %while.cond
  %3 = load i32, i32* %i, align 4
  %cmp1 = icmp eq i32 %3, 0
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %while.cond
  %4 = phi i1 [ true, %while.cond ], [ %cmp1, %lor.rhs ]
  br i1 %4, label %while.body, label %while.end

while.body:                                       ; preds = %lor.end
  %5 = load i8*, i8** %path, align 8
  %cmp2 = icmp eq i8* %5, null
  br i1 %cmp2, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %while.body
  %6 = load i8*, i8** %path, align 8
  %call = call i32 @strcmp(i8* %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)) #6
  %cmp3 = icmp eq i32 %call, 0
  br i1 %cmp3, label %if.then, label %if.else

if.then:                                          ; preds = %lor.lhs.false, %while.body
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8** @filename, align 8
  store i32 0, i32* %fd, align 4
  br label %if.end

if.else:                                          ; preds = %lor.lhs.false
  %7 = load i8*, i8** %path, align 8
  store i8* %7, i8** @filename, align 8
  %8 = load i8*, i8** %path, align 8
  %call4 = call i32 (i8*, i32, ...) @open(i8* %8, i32 0)
  store i32 %call4, i32* %fd, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %9 = load i32, i32* %fd, align 4
  %cmp5 = icmp slt i32 %9, 0
  br i1 %cmp5, label %if.then6, label %if.else7

if.then6:                                         ; preds = %if.end
  %10 = load i8*, i8** %path, align 8
  call void (i8*, ...) @warn(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i64 0, i64 0), i8* %10)
  store i32 1, i32* @rval, align 4
  br label %if.end22

if.else7:                                         ; preds = %if.end
  %11 = load i32, i32* %verbose.addr, align 4
  %tobool = icmp ne i32 %11, 0
  br i1 %tobool, label %if.then8, label %if.else15

if.then8:                                         ; preds = %if.else7
  %12 = load i32, i32* %fd, align 4
  %cmp9 = icmp eq i32 %12, 0
  br i1 %cmp9, label %if.then10, label %if.else11

if.then10:                                        ; preds = %if.then8
  %13 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %14 = ptrtoint %struct.__sFILE* %13 to i64
  %15 = load i32, i32* %verbose.addr, align 4
  call void @do_cat(i64 %14, i32 %15)
  br label %if.end14

if.else11:                                        ; preds = %if.then8
  %16 = load i32, i32* %fd, align 4
  %call12 = call %struct.__sFILE* @fdopen(i32 %16, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i64 0, i64 0))
  store %struct.__sFILE* %call12, %struct.__sFILE** %fp, align 8
  %17 = load %struct.__sFILE*, %struct.__sFILE** %fp, align 8
  %18 = ptrtoint %struct.__sFILE* %17 to i64
  %19 = load i32, i32* %verbose.addr, align 4
  call void @do_cat(i64 %18, i32 %19)
  %20 = load %struct.__sFILE*, %struct.__sFILE** %fp, align 8
  %call13 = call i32 @fclose(%struct.__sFILE* %20)
  br label %if.end14

if.end14:                                         ; preds = %if.else11, %if.then10
  br label %if.end21

if.else15:                                        ; preds = %if.else7
  %21 = load i32, i32* %fd, align 4
  %conv = sext i32 %21 to i64
  %22 = load i32, i32* %verbose.addr, align 4
  call void @do_cat(i64 %conv, i32 %22)
  %23 = load i32, i32* %fd, align 4
  %cmp16 = icmp ne i32 %23, 0
  br i1 %cmp16, label %if.then18, label %if.end20

if.then18:                                        ; preds = %if.else15
  %24 = load i32, i32* %fd, align 4
  %call19 = call i32 @close(i32 %24)
  br label %if.end20

if.end20:                                         ; preds = %if.then18, %if.else15
  br label %if.end21

if.end21:                                         ; preds = %if.end20, %if.end14
  br label %if.end22

if.end22:                                         ; preds = %if.end21, %if.then6
  %25 = load i8*, i8** %path, align 8
  %cmp23 = icmp eq i8* %25, null
  br i1 %cmp23, label %if.then25, label %if.end26

if.then25:                                        ; preds = %if.end22
  br label %while.end

if.end26:                                         ; preds = %if.end22
  %26 = load i32, i32* %i, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, i32* %i, align 4
  br label %while.cond, !llvm.loop !10

while.end:                                        ; preds = %if.then25, %lor.end
  ret void
}

declare dso_local i32 @fclose(%struct.__sFILE*) #1

; Function Attrs: noreturn
declare dso_local void @exit(i32) #3

declare dso_local i32 @fprintf(%struct.__sFILE*, i8*, ...) #1

; Function Attrs: nounwind readonly willreturn
declare dso_local i32 @strcmp(i8*, i8*) #4

declare dso_local i32 @open(i8*, i32, ...) #1

declare dso_local void @warn(i8*, ...) #1

declare dso_local void @do_cat(i64, i32) #1

declare dso_local %struct.__sFILE* @fdopen(i32, i8*) #1

declare dso_local i32 @close(i32) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+dotprod,+fp-armv8,+fullfp16,+morello,+neon,+rcpc,+spe,+ssbs,+v8.2a,-c64" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+dotprod,+fp-armv8,+fullfp16,+morello,+neon,+rcpc,+spe,+ssbs,+v8.2a,-c64" }
attributes #2 = { noinline noreturn nounwind optnone uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+dotprod,+fp-armv8,+fullfp16,+morello,+neon,+rcpc,+spe,+ssbs,+v8.2a,-c64" }
attributes #3 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+dotprod,+fp-armv8,+fullfp16,+morello,+neon,+rcpc,+spe,+ssbs,+v8.2a,-c64" }
attributes #4 = { nounwind readonly willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+dotprod,+fp-armv8,+fullfp16,+morello,+neon,+rcpc,+spe,+ssbs,+v8.2a,-c64" }
attributes #5 = { noreturn }
attributes #6 = { nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"branch-target-enforcement", i32 0}
!2 = !{i32 1, !"sign-return-address", i32 0}
!3 = !{i32 1, !"sign-return-address-all", i32 0}
!4 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{i32 7, !"frame-pointer", i32 1}
!7 = !{!"clang version 13.0.0"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
