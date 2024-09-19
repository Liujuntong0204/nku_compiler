; 数组大小不变，全局处开辟并赋值，可以在主函数中灵活使用
@_.numbers = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16
@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1

; 主函数
define dso_local i32 @main() {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  
  ; 在栈中为数组开辟空间
  %2 = alloca [5 x i32], align 16
  ; 声明两个变量，a分表用于保存数组的长度和当前下标
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  
  ; bitcast 类型转换指令。这里将[5 x i32]型转为i8型的指针。便于memcpy函数进行字节级别的操作
  %5 = bitcast [5 x i32]* %2 to i8*
  ; 调用memcpy函数
  ; .p0i8.p0i8.i64：目标地址和源地址分别为两个i8类型的指针，第三个参数是一个 64 位整数，表示要复制的字节数
  call void @llvm.memcpy.p0i8.p0i8.i64(
    i8* align 16 %5,  ; 目标地址为在栈中开辟的数组 
    i8* align 16 bitcast ([5 x i32]* @_.numbers to i8*),  ; 源地址为全局数组，也用bitcast做了指针类型转换
    i64 20,  ; 共20个字节u需要复制，数组大小：32*5 = 160bit/8 = 20字节
    i1 false)  ; 这是一个布尔值参数，用于指示这次 memcpy 操作是否是“易失性”操作。
               ; false 表示这个操作是“非易失性”的，意味着这个操作可以被编译器优化，而不会产生其他副作用。
  
  ; 修改数组的值
  ; 将numbers[1]的地址存入%6，修改地址中的值
  %6 = getelementptr inbounds [5 x i32], [5 x i32]* %2, i64 0, i64 1
  store i32 6, i32* %6, align 4

  ; 存储数组大小与初始下标零。没有再进行size的计算，程序已知了数组大小
  store i32 5, i32* %3, align 4
  store i32 0, i32* %4, align 4
  
  ; 跳转到条件判断，开始for循环
  br label %7

7: 
  ; 对比数组大小与当前下标                                               ; preds = %17, %0
  %8 = load i32, i32* %4, align 4
  %9 = load i32, i32* %3, align 4
  ; icmp比较，slt为整数比较，严格小于
  %10 = icmp slt i32 %8, %9
  ; bri条件跳转，%10为真则到%11执行循环体
  br i1 %10, label %11, label %20

11: 
  ; 循环体，打印当前数组元素                                              ; preds = %7
  %12 = load i32, i32* %4, align 4  ; 取出当前下标值
  %13 = sext i32 %12 to i64  ; sext 类型转换，下标转为i64，便于取地址指针
  %14 = getelementptr inbounds [5 x i32], [5 x i32]* %2, i64 0, i64 %13  ; i64 %13按当前下标取地址指针
  %15 = load i32, i32* %14, align 4  ; 加载当前地址中的值
  ; 打印
  %16 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %15)
  ; 调到%17，进行下标的更新
  br label %17

17:                        
  ; 更新下标                       ; preds = %11
  %18 = load i32, i32* %4, align 4
  ; 下标加1，nsw表示编译器可以假设该操作不会发生有符号溢出
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* %4, align 4
  ; 下标更新后，再次进行条件判断（删除了循环标识）
  br label %7

20:     
  ; 程序结束                                          ; preds = %7
  ret i32 0
}

; 函数声明
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) 
declare i32 @printf(i8* noundef, ...) 
