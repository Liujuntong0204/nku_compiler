; 两个需要打印的字符串，三个格式化字符
; 请输入第一个浮点数: 
@.str = private unnamed_addr constant [30 x i8] c"\E8\AF\B7\E8\BE\93\E5\85\A5\E7\AC\AC\E4\B8\80\E4\B8\AA\E6\B5\AE\E7\82\B9\E6\95\B0: \00", align 1
; %f
@.str.1 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
; 请输入第二个浮点数: 
@.str.2 = private unnamed_addr constant [30 x i8] c"\E8\AF\B7\E8\BE\93\E5\85\A5\E7\AC\AC\E4\BA\8C\E4\B8\AA\E6\B5\AE\E7\82\B9\E6\95\B0: \00", align 1
; %.2f 大于 %.2f\n
@.str.3 = private unnamed_addr constant [18 x i8] c"%.2f \E5\A4\A7\E4\BA\8E %.2f\0A\00", align 1
; %.2f 不大于 %.2f\n
@.str.4 = private unnamed_addr constant [21 x i8] c"%.2f \E4\B8\8D\E5\A4\A7\E4\BA\8E %.2f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4

  ; 声明num1与num2，32位浮点型float指针
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  
  ; 调用print，scanf函数
  %4 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str, i64 0, i64 0))
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), float* noundef %2)
  %6 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2, i64 0, i64 0))
  %7 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), float* noundef %3)
  
  ; 取出num1，num2到两个临时变量。
  %8 = load float, float* %2, align 4
  %9 = load float, float* %3, align 4

  ; fcmp比较。ogt用于比较两个浮点数，有序大于
  %10 = fcmp ogt float %8, %9

  ; br跳转。条件为%10这个布尔值。
  br i1 %10, label %11, label %17

11:         
  ; 为真                                      ; preds = %0
  ; C 语言中，当 printf 被调用时，float 类型会被自动转换为 double 类型。
  ; 所以在调用printf之前fpext做一个类型转换
  %12 = load float, float* %2, align 4
  %13 = fpext float %12 to double
  %14 = load float, float* %3, align 4
  %15 = fpext float %14 to double
  %16 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.3, i64 0, i64 0), double noundef %13, double noundef %15)
  ; 为真后要跳到if函数外，不再执行为假的代码
  br label %23

17:  
  ; 为假                                             ; preds = %0
  %18 = load float, float* %2, align 4
  %19 = fpext float %18 to double
  %20 = load float, float* %3, align 4
  %21 = fpext float %20 to double
  %22 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i64 0, i64 0), double noundef %19, double noundef %21)
  br label %23

23:      
  ; 结束，返回                                         ; preds = %17, %11
  ret i32 0
}

; 函数声明
declare i32 @printf(i8* noundef, ...) 
declare i32 @__isoc99_scanf(i8* noundef, ...) 
