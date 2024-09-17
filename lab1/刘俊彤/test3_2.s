	.file	"test3.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
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
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	__isoc99_scanf
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	addi	a5,s0,-24
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	__isoc99_scanf
	flw	fa4,-20(s0)
	flw	fa5,-24(s0)
	fgt.s	a5,fa4,fa5
	beq	a5,zero,.L7
	flw	fa5,-20(s0)
	fcvt.d.s	fa4,fa5
	flw	fa5,-24(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a2,fa5
	fmv.x.d	a1,fa4
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	j	.L4
.L7:
	flw	fa5,-20(s0)
	fcvt.d.s	fa4,fa5
	flw	fa5,-24(s0)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a2,fa5
	fmv.x.d	a1,fa4
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
.L4:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits
