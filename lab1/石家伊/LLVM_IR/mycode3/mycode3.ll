; ModuleID = 'mycode3.c'
source_filename = "mycode3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [30 x i8] c"\E8\AF\B7\E8\BE\93\E5\85\A5\E7\AC\AC\E4\B8\80\E4\B8\AA\E6\B5\AE\E7\82\B9\E6\95\B0: \00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"\E8\AF\B7\E8\BE\93\E5\85\A5\E7\AC\AC\E4\BA\8C\E4\B8\AA\E6\B5\AE\E7\82\B9\E6\95\B0: \00", align 1
@.str.3 = private unnamed_addr constant [18 x i8] c"%.2f \E5\A4\A7\E4\BA\8E %.2f\0A\00", align 1
@.str.4 = private unnamed_addr constant [21 x i8] c"%.2f \E4\B8\8D\E5\A4\A7\E4\BA\8E %.2f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store i32 0, i32* %1, align 4
  %4 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str, i64 0, i64 0))
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), float* noundef %2)
  %6 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2, i64 0, i64 0))
  %7 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), float* noundef %3)
  %8 = load float, float* %2, align 4
  %9 = load float, float* %3, align 4
  %10 = fcmp ogt float %8, %9
  br i1 %10, label %11, label %17

11:                                               ; preds = %0
  %12 = load float, float* %2, align 4
  %13 = fpext float %12 to double
  %14 = load float, float* %3, align 4
  %15 = fpext float %14 to double
  %16 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.3, i64 0, i64 0), double noundef %13, double noundef %15)
  br label %23

17:                                               ; preds = %0
  %18 = load float, float* %2, align 4
  %19 = fpext float %18 to double
  %20 = load float, float* %3, align 4
  %21 = fpext float %20 to double
  %22 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i64 0, i64 0), double noundef %19, double noundef %21)
  br label %23

23:                                               ; preds = %17, %11
  ret i32 0
}

declare i32 @printf(i8* noundef, ...) #1

declare i32 @__isoc99_scanf(i8* noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
