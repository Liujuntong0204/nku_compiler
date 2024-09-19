; ModuleID = 'main.c'

; 标明源程序为"main.c"
source_filename = "main.c"

; 目标架构的数据布局方式。这个描述了如何在内存中排列数据，如整数和浮点数的大小、对齐方式等。
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
; 定义目标系统的三元组
target triple = "x86_64-pc-linux-gnu"

; 这一部分先对程序的常量、全局变量；字符串；格式化字符;进行了声明。
; 为了便于查看，调整了声明顺序
; 1、全局变量
; 用于计时的clock_t型全局变量，可以看到是用64位整数来实现
; dso_local表示这个全局变量在当前的编译单元中是本地的，不会被其他编译单元引用。
@start = dso_local global i64 0, align 8
@stop = dso_local global i64 0, align 8
; 一个全局双精度浮点变量，初始值为0.0,用于存储程序运行的时间结果
@duration = dso_local global double 0.000000e+00, align 8
; 2、字符串与格式化字符（宏定义里那个字符串也在这里）
; 用于打印的字符串与格式化字符都被声明为常量，常量名按顺序标号
; private 表示该字符串常量仅在当前模块内可见，其他模块无法引用它。
; unnamed_addr 表示LLVM可以自由地优化该常量的地址，假设多个常量具有相同的内容，LLVM可以将它们共享相同的内存地址。
; constant 表示这个是一个不可修改的常量。
; 对字符串用数组实现，并且都在末尾有“\00”作为字符串结束标识
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [25 x i8] c"\E8\BF\99\E6\98\AF\E4\B8\80\E4\B8\AA\E5\AE\8F\E5\AE\9A\E4\B9\89\EF\BD\9E\00", align 1
; str2与3可以观察到对于不同的格式化字符是单独声明的，即“%d”与“%d\n”是不相关的，并不是在使用的时候拼接“%—”与“\n”
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.4 = private unnamed_addr constant [25 x i8] c"\E7\A8\8B\E5\BA\8F\E8\BF\90\E8\A1\8C\E6\97\B6\E9\97\B4\E4\B8\BA\EF\BC\9A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
; 定义main函数
; #0 是属性编号(属性声明在末尾) 
define dso_local i32 @main() #0 {
  ; 声明局部变量，源代码中有a, b, i, t, n，c
  %1 = alloca i32, align 4  ; 怀疑是被函数clock()隐式调用的一个中间变量
  %2 = alloca i32, align 4  ; a
  %3 = alloca i32, align 4  ; b
  %4 = alloca i32, align 4  ; i
  %5 = alloca i32, align 4  ; t
  %6 = alloca i32, align 4  ; n
  %7 = alloca i32, align 4  ; c
  
  store i32 0, i32* %1, align 4
  ; 调用clock函数，之前看到start被声明为全局变量。这里将函数调用先存入%8临时寄存器，再存入start，更贴近底层逻辑
  %8 = call i64 @clock() #3
  store i64 %8, i64* @start, align 8

  ; 调用printf函数，(i8*, ...)表示 printf 函数接受一个字符指针（i8*）作为第一个参数，后面可以有任意数量的可变参数（...）
  ; 传入了两个参数。传入参数格式如下：
  ; i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)
  ; i8* 是传递给 printf 的参数类型
  ; noundef 是一个修饰符，表示这个指针参数不能是未定义值。
  ; getelementptr inbounds 是LLVM中常用的指令，用于计算数组或结构体中某个元素的指针。
  ; inbounds 确保访问是有效的，超出范围会触发未定义行为
  ; [4 x i8]：是 getelementptr 操作的类型参数，要对这样一个数组进行操作
  ; [4 x i8]* @.str：这里的[4 x i8]*是一个指针类型，指向@.str，是实际需要被操作的数组。
  ; i64 0, i64 0：第0个元素的，第0个字节处，即取字符串的起始地址。
  %9 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1, i64 0, i64 0))
  
  ; 为局部变量赋值
  ; a用于测试常量折叠的优化，这里可以看到。直接没有运算+1-1把0给了%2
  store i32 0, i32* %2, align 4
  store i32 1, i32* %3, align 4
  store i32 1, i32* %4, align 4
  ; 这里是原本的c，虽然没有使用过该变量，也没有被去除
  store i32 2000, i32* %7, align 4

  ; scanf函数的调用，第二个参数变为一个32位整形指针，指向%6，即n
  %10 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), i32* noundef %6)
  ; 打印整型局部变量，是先将其放入另一个局部寄存器在打印
  ; LLVM 是基于静态单赋值形式（SSA）的中间表示，每个寄存器只能在赋值后使用一次，且一旦赋值，不可更改。
  ; 因此，局部变量值首先存储在内存中的某个位置（如 %2），然后在打印之前需要通过 load 指令加载该值，并将其存储到一个新的虚拟寄存器 %11 中。%11 实际上是 SSA 中的一个唯一名称标识符，用于跟踪变量的值。
  %11 = load i32, i32* %2, align 4
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %11)
  %13 = load i32, i32* %3, align 4
  %14 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %13)
  
  ; br是跳转指令，这里无条件。开始循环前要进行条件判断，%15就是这样一个代码块
  br label %15

15:
  ; 循环条件判断
  ; 先加载i，n的值到临时寄存器                                               ; preds = %19, %0
  %16 = load i32, i32* %4, align 4  ; i
  %17 = load i32, i32* %6, align 4  ; n
  ; icmp用于整数比较，slt是小于。小于则置为1
  %18 = icmp slt i32 %16, %17
  ; i1 %18表示一个布尔值，作为条件。为真跳转到%19,否则%29
  br i1 %18, label %19, label %29

19:    
  ; 循环体                                           ; preds = %15
  ; t = b：将%20作为中间寄存器，取出%3中b的值，存入%5的t中
  %20 = load i32, i32* %3, align 4
  store i32 %20, i32* %5, align 4

  ; b = a + b：将a、b从内存中取出放入两个临时寄存器
  %21 = load i32, i32* %2, align 4
  %22 = load i32, i32* %3, align 4
  ; 计算a+b：add为加法指令；nsw表示 "No Signed Wrap"，即无符号溢出，编译器假定该操作不会导致有符号整数溢出。
  %23 = add nsw i32 %21, %22
  ; 更新内存中b的值，为本次计算得到的斐波那契数
  store i32 %23, i32* %3, align 4

  ; 打印更新后的b值
  %24 = load i32, i32* %3, align 4
  %25 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %24)
  
  ; a = t：将%26作为中间寄存器，取出%5中t的值，存入%2的a中
  %26 = load i32, i32* %5, align 4
  store i32 %26, i32* %2, align 4

  ; 取出i，加上1，再将新值放进去
  %27 = load i32, i32* %4, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, i32* %4, align 4

  ; 跳转回%15进行条件判断。
  ; !llvm.loop !6 ：一个元数据。!llvm.loop 表示该分支指令与循环有关；!6 是指向元数据的引用，该元数据包含了与循环优化相关的具体信息。
  br label %15, !llvm.loop !6

29:                                               ; preds = %15
  ; 调用clock函数，记录stop
  %30 = call i64 @clock() #3
  store i64 %30, i64* @stop, align 8
  ; 计算stop-start
  %31 = load i64, i64* @stop, align 8
  %32 = load i64, i64* @start, align 8
  %33 = sub nsw i64 %31, %32  ; 减法sub

  ; sitofp 指令用于将一个有符号整数转换为浮点数，有符号转换
  %34 = sitofp i64 %33 to double
  ; fdiv 是浮点数的除法操作,%34中的doule除以1*10的六次方
  %35 = fdiv double %34, 1.000000e+06
  ; 时间结果存入duration
  store double %35, double* @duration, align 8
  ; 打印字符串与时间
  %36 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.4, i64 0, i64 0))
  %37 = load double, double* @duration, align 8
  %38 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i64 0, i64 0), double noundef %37)
  
  ; main函数的返回值为0
  ret i32 0
}

; Function Attrs: nounwind
; 函数声明
declare i64 @clock() #1

declare i32 @printf(i8* noundef, ...) #2

declare i32 @__isoc99_scanf(i8* noundef, ...) #2

; 函数属性：用于描述函数在编译期间的行为和目标平台的特性。
attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}  ; 声明一些标识，用于记录与整个模块相关的编译器设置，通常包括一些平台和环境特定的标志：
!llvm.ident = !{!5} ;生成该 LLVM IR 的编译器信息

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
; 之前用到的元数据!6，用于标识循环属性。!7中的标识说明这是一个必须有进展的循环（不能死循环）
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
