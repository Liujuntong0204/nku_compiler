	.file	"test3.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
 
#字符串常量
.LC0:
	.string	"\350\257\267\350\276\223\345\205\245\347\254\254\344\270\200\344\270\252\346\265\256\347\202\271\346\225\260: "        
	.align	3
 
.LC1:
	.string	"%f"
	.align	3
 
.LC2:
	.string	"\350\257\267\350\276\223\345\205\245\347\254\254\344\272\214\344\270\252\346\265\256\347\202\271\346\225\260: "
	.align	3
 
.LC3:
	.string	"%.2f \345\244\247\344\272\216 %.2f\n"
	.align	3
 
.LC4:
	.string	"%.2f \344\270\215\345\244\247\344\272\216 %.2f\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
        
main:
	lui	a0,%hi(.LC0) 
	addi	sp,sp,-32   #预留栈空间
	addi	a0,a0,%lo(.LC0)    #加载字符串"请输入第一个浮点数: "地址
	sd	ra,24(sp)    #返回地址
	sd	s0,16(sp)    #栈帧调整
	call	printf    #打印"请输入第一个浮点数: "
	lui	s0,%hi(.LC1) 
	addi	a1,sp,8
	addi	a0,s0,%lo(.LC1)    #字符串"%f"
	call	__isoc99_scanf    #调用scanf函数读取用户输入的浮点数，存储到栈上（sp+8）
	lui	a0,%hi(.LC2) 
	addi	a0,a0,%lo(.LC2)    #加载字符串"请输入第二个浮点数: "地址
	call	printf    #打印"请输入第二个浮点数: "
	addi	a1,sp,12
	addi	a0,s0,%lo(.LC1)    #字符串"%f"
	call	__isoc99_scanf    #调用scanf函数读取用户输入的浮点数，存储到栈上（sp+12）
 
	flw	fa5,8(sp)    #从栈上加载第一个浮点数到浮点寄存器fa5
	flw	fa4,12(sp)    #从栈上加载第二个浮点数到浮点寄存器fa4
	fgt.s	a5,fa5,fa4    #比较两个浮点数，结果存储在整数寄存器a5中（如果fa5 > fa4，则a5非零）
	fcvt.d.s	fa4,fa4    #将单精度浮点数转为双精度浮点数
	fcvt.d.s	fa5,fa5    #将单精度浮点数转为双精度浮点数
	fmv.x.d	a2,fa4
	fmv.x.d	a1,fa5    #存储到整数寄存器
	beq	a5,zero,.L6    #如果a5为0，则跳转L6
	lui	a0,%hi(.LC3) 
	addi	a0,a0,%lo(.LC3)    #大于，加载"%.2f 大于 %.2f\n"
	call	printf    #打印结果
 
.L4:
   #结束
   #恢复寄存器以及栈，跳转返回地址
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
.L6:
	lui	a0,%hi(.LC4) 
	addi	a0,a0,%lo(.LC4)     #不大于，加载"%.2f 不大于 %.2f\n"
	call	printf    #打印结果
	j	.L4    #跳转结束
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits