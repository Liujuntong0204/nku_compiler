; 格式化字符与字符串
; "%d %d"
; "The sum of %d and %d is %d\n"
@.str = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"The sum of %d and %d is %d\0A\00", align 1

; addNumbers函数定义
; 这里存在问题：1、为什么这里从%0开始？从%1开始会报错。2、为什么没有%2,直接%3？写成%2会报错
define dso_local i32 @addNumbers(i32 noundef %0, i32 noundef %1) {
  %3 = add nsw i32 %0, %1
  ret i32 %3
}

; main函数
define dso_local i32 @main() {
  ; 声明局部变量
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4

  ; num1;num2;sum
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  ; 调用scanf，第一个参数为格式字符@.str，第二、三个参数为指向%2、%3的指针
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32* noundef %2, i32* noundef %3)
  
  ; 调用addNumbers，num1,num2放入临时寄存器
  %6 = load i32, i32* %2, align 4
  %7 = load i32, i32* %3, align 4
  %8 = call i32 @addNumbers(i32 noundef %6, i32 noundef %7)
  
  ; 将函数返回结果存入%4，sum
  store i32 %8, i32* %4, align 4

  ; 调用printf，num1,num2,sum放入临时寄存器
  %9 = load i32, i32* %2, align 4
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %4, align 4
  ; 第一个参数为字符串@.str.1，第二、三、四个参数为几个临时寄存器
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i64 0, i64 0), i32 noundef %9, i32 noundef %10, i32 noundef %11)
  
  ; 结束，返回
  ret i32 0
}

; 函数声明
declare i32 @__isoc99_scanf(i8* noundef, ...) 
declare i32 @printf(i8* noundef, ...) 

