; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@start = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [25 x i8] c"\E8\BF\99\E6\98\AF\E4\B8\80\E4\B8\AA\E5\AE\8F\E5\AE\9A\E4\B9\89\EF\BD\9E\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@stop = dso_local global i64 0, align 8
@duration = dso_local global double 0.000000e+00, align 8
@.str.4 = private unnamed_addr constant [25 x i8] c"\E7\A8\8B\E5\BA\8F\E8\BF\90\E8\A1\8C\E6\97\B6\E9\97\B4\E4\B8\BA\EF\BC\9A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %8 = call i64 @clock() #3
  store i64 %8, i64* @start, align 8
  %9 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1, i64 0, i64 0))
  store i32 0, i32* %2, align 4
  store i32 1, i32* %3, align 4
  store i32 1, i32* %4, align 4
  store i32 2000, i32* %7, align 4
  %10 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), i32* noundef %6)
  %11 = load i32, i32* %2, align 4
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %11)
  %13 = load i32, i32* %3, align 4
  %14 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %13)
  br label %15

15:                                               ; preds = %19, %0
  %16 = load i32, i32* %4, align 4
  %17 = load i32, i32* %6, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %29

19:                                               ; preds = %15
  %20 = load i32, i32* %3, align 4
  store i32 %20, i32* %5, align 4
  %21 = load i32, i32* %2, align 4
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %21, %22
  store i32 %23, i32* %3, align 4
  %24 = load i32, i32* %3, align 4
  %25 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %24)
  %26 = load i32, i32* %5, align 4
  store i32 %26, i32* %2, align 4
  %27 = load i32, i32* %4, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, i32* %4, align 4
  br label %15, !llvm.loop !6

29:                                               ; preds = %15
  %30 = call i64 @clock() #3
  store i64 %30, i64* @stop, align 8
  %31 = load i64, i64* @stop, align 8
  %32 = load i64, i64* @start, align 8
  %33 = sub nsw i64 %31, %32
  %34 = sitofp i64 %33 to double
  %35 = fdiv double %34, 1.000000e+06
  store double %35, double* @duration, align 8
  %36 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.4, i64 0, i64 0))
  %37 = load double, double* @duration, align 8
  %38 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i64 0, i64 0), double noundef %37)
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @clock() #1

declare i32 @printf(i8* noundef, ...) #2

declare i32 @__isoc99_scanf(i8* noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
