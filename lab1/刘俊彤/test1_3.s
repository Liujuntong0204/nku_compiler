	.file	"test1.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"%d "
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	li	a5,1
	slli	a4,a5,33
	slli	a5,a5,34
	addi	sp,sp,-64
	addi	a5,a5,3
	addi	a4,a4,1
	sd	a5,16(sp)
	li	a5,5
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s2,32(sp)
	sd	ra,56(sp)
	sd	a4,8(sp)
	sw	a5,24(sp)
	addi	s0,sp,8
	addi	s2,sp,28
	lui	s1,%hi(.LC1)
.L2:
	lw	a1,0(s0)
	addi	a0,s1,%lo(.LC1)
	addi	s0,s0,4
	call	printf
	bne	s0,s2,.L2
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	ld	s2,32(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 12.2.0"
	.section	.note.GNU-stack,"",@progbits
