	.file	"test2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
        
    #addNumber函数
	.text 
	.align	1
	.globl	addNumbers
	.type	addNumbers, @function
 
addNumbers:
	addw	a0,a0,a1   #a0+a1，结果存回a0
	ret  #返回  返回值存储在a0寄存器中
	.size	addNumbers, .-addNumbers
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
 
.LC0:
	.string	"%d %d"  #字符串常量
	.align	3
 
.LC1:
	.string	"The sum of %d and %d is %d\n"  #字符串常量
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
 
main:
	addi	sp,sp,-32  #为局部变量和调用预留栈空间 
	lui	a0,%hi(.LC0)   #加载格式字符串"%d %d"的高位地址
	addi	a2,sp,12   #第二个输入整数的栈位置
	addi	a1,sp,8   #第一个输入整数的栈位置
	addi	a0,a0,%lo(.LC0)   #加载格式字符串"%d %d"的低位地址得到字符串完整地址
	sd	ra,24(sp)   #保存返回地址到栈上 
	call	__isoc99_scanf   #调用scanf读取输入到a1、a2位置
	lw	a1,8(sp)   #得到输入的第一个整数存到a1
	lw	a2,12(sp)   #得到输入的第二个整数存到a2
	lui	a0,%hi(.LC1)   #加载字符串"The sum of %d and %d is %d\n"的高位地址
	addi	a0,a0,%lo(.LC1)   #加载格式字符串的低位地址，得到完整地址
	addw	a3,a1,a2   #计算a1和a2的和，存到a3 内联函数
	call	printf   #调用printf打印计算结果
 
      #恢复寄存器以及栈
	ld	ra,24(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits