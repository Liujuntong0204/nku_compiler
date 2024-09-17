	.file	"test3.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
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
	addi	sp,sp,-32
	addi	a0,a0,%lo(.LC0)
	sd	ra,24(sp)
	sd	s0,16(sp)
	call	printf
	lui	s0,%hi(.LC1)
	addi	a1,sp,8
	addi	a0,s0,%lo(.LC1)
	call	__isoc99_scanf
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	addi	a1,sp,12
	addi	a0,s0,%lo(.LC1)
	call	__isoc99_scanf
	flw	fa5,8(sp)
	flw	fa4,12(sp)
	fgt.s	a5,fa5,fa4
	fcvt.d.s	fa4,fa4
	fcvt.d.s	fa5,fa5
	fmv.x.d	a2,fa4
	fmv.x.d	a1,fa5
	beq	a5,zero,.L6
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	printf
.L4:
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
.L6:
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	printf
	j	.L4
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits
