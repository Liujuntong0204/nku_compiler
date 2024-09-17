	.file	"test2.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	addNumbers
	.type	addNumbers, @function
addNumbers:
	addw	a0,a0,a1
	ret
	.size	addNumbers, .-addNumbers
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%d %d"
	.align	3
.LC1:
	.string	"The sum of %d and %d is %d\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	lui	a0,%hi(.LC0)
	addi	a2,sp,12
	addi	a1,sp,8
	addi	a0,a0,%lo(.LC0)
	sd	ra,24(sp)
	call	__isoc99_scanf
	lw	a1,8(sp)
	lw	a2,12(sp)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	addw	a3,a1,a2
	call	printf
	ld	ra,24(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits
