	#文件标识、选项和属性声明，指定了目标框架、未使用位置无关代码（PIC）、对齐等
	.file	"test1.c" #源文件为test1.c
	.option nopic #设置汇编器选项 nopic表示不使用位置无关代码（pic）位置无关码是一种一个在内存中任何位置运行的代码，在动态链接时使用
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0" #设置架构属性，arch为目标架构的特性集。这里包括risc-v的若干扩展，如整数（i）、乘除法（m）、原子（a）、浮点（f和d）、压缩（c)和访问控制状态寄存器（zicsr）
	.attribute unaligned_access, 0 #设置属性unaligned_access为0，表示生成的代码不包含未对齐内存地址的访问。访问未对齐地址可能导致性能下降或者硬件异常。这样可以保证代码的兼容性和可移植性。
	.attribute stack_align, 16 #设置栈对齐属性，值为16，表示栈指针（sp）应该始终保持在16字节的边界上。
 
	.text #标记代码段开始
	.section	.rodata  #rodata段，存储只读数据
	.align	3  #指定接下来的数据或代码应该对齐到2的3次方（即8字节）的边界
 
.LC1:
	.string	"%d " #字符串常量
	.align	3
 
.LC0:  
        #在当前位置插入五个word大小的整数常量
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5 
	.text
	.align	1
	.globl	main #标记全局
	.type	main, @function  #函数类型
 
main:  #main函数开始
	#为main函数设置栈帧
	addi	sp,sp,-48  #留出局部变量和寄存器的空间
	sd	ra,40(sp)  #ra寄存器储存到sp+40位置
	sd	s0,32(sp)  #s0储存到sp+32位置
	addi	s0,sp,48  #设置新的栈底指针s0
        
    #初始化局部变量
    #栈上存好1 2 3 4 5 5 0 a5=5  0和5用于循环计数和循环结束判断
	lui	a5,%hi(.LC0)  #加载数组.LC0高16位地址到a5
	addi	a5,a5,%lo(.LC0)  #数组.LC0低16位地址加到a5，现在a5中包含了.LC0的完整地址
	ld	a4,0(a5)  #从数组加载双字到a4 1 2
	sd	a4,-48(s0)  # 将a4中的值存储到以s0为基址，偏移-48字节的位置
	ld	a4,8(a5)  #从数组加载下一个双字到a4 3 4
	sd	a4,-40(s0)   #将a4中的值存储到以s0为基址，偏移-40字节的位置
	lw	a5,16(a5)   #从数组加载一个字到a5 5
	sw	a5,-32(s0)   # 将a5中的值存储到以s0为基址，偏移-32字节的位置
	li	a5,5   #将立即数5加载到a5中
	sw	a5,-24(s0)   #将a5中的值存储到以s0为基址，偏移-24字节的位置
	sw	zero,-20(s0)   #将0寄存器存储到以s0为基址，偏移-20字节的位置
	j	.L2   #跳转到循环开始
 
.L3:
        #打印数组元素
	lw	a5,-20(s0)   #获取计数器值到a5
	slli	a5,a5,2   #将a5*4得到待打印数的数组偏移
	addi	a5,a5,-16   #偏移量减16，得到在栈的偏移
	add	a5,a5,s0   #加上栈底地址，得到要访问数据的地址
	lw	a5,-32(a5)   #加载数据（32位）
	mv	a1,a5   #将数据存到a1
	lui	a5,%hi(.LC1)   #加载格式字符串.LC1的高16位地址到a5 
	addi	a0,a5,%lo(.LC1)   #将.LC1的低16位地址加到a5上，得到完整地址，并存储到a0
	call	printf   #调用printf打印数据
	lw	a5,-20(s0)   #重新加载计数器值
	addiw	a5,a5,1   #计数器加1
	sw	a5,-20(s0)   #将计数器值存到栈上
 
.L2:
	lw	a5,-20(s0)   #a5=0
	mv	a4,a5   #a4=0
	lw	a5,-24(s0)   #a5=5 a5作为循环计数器
	sext.w	a4,a4 
	sext.w	a5,a5   #符号扩展
	blt	a4,a5,.L3   #判断循环条件，如果a4<a5，则跳转到L3进行输出 
        
      #循环结束，完成输出后进行栈恢复
	li	a5,0   #恢复a5为0
	mv	a0,a5   #恢复a0为0
	ld	ra,40(sp)   #恢复返回地址
	ld	s0,32(sp)   #恢复栈
	addi	sp,sp,48 
	jr	ra   #返回函数main的调用位置
        
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits