	.text
	.file	"main.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function main
.LCPI0_0:
	.quad	0x412e848000000000              # double 1.0E+6
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -16(%rbp)
	callq	clock@PLT
	movq	%rax, start
	movabsq	$.L.str, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$.L.str.1, %rdi
	leaq	-12(%rbp), %rsi
	movb	$0, %al
	callq	__isoc99_scanf@PLT
	movl	$2, -4(%rbp)
	movl	$1, -8(%rbp)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB0_3
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_1
.LBB0_3:
	movl	-12(%rbp), %esi
	movl	-8(%rbp), %edx
	movabsq	$.L.str.2, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$.L.str.3, %rdi
	movl	$1234, %esi                     # imm = 0x4D2
	movb	$0, %al
	callq	printf@PLT
	callq	clock@PLT
	movq	%rax, stop
	movq	stop, %rax
	subq	start, %rax
	cvtsi2sd	%rax, %xmm0
	movsd	.LCPI0_0(%rip), %xmm1           # xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, duration
	movabsq	$.L.str.4, %rdi
	movb	$0, %al
	callq	printf@PLT
	movsd	duration, %xmm0                 # xmm0 = mem[0],zero
	movabsq	$.L.str.5, %rdi
	movb	$1, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	start,@object                   # @start
	.bss
	.globl	start
	.p2align	3
start:
	.quad	0                               # 0x0
	.size	start, 8

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\350\257\267\350\276\223\345\205\245\344\270\200\344\270\252\346\225\264\346\225\260n: "
	.size	.L.str, 25

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"%d\347\232\204\351\230\266\344\271\230\346\230\257: %d\n"
	.size	.L.str.2, 20

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"\345\256\217\345\256\232\344\271\211\351\252\214\350\257\201\357\274\232%d\n"
	.size	.L.str.3, 22

	.type	stop,@object                    # @stop
	.bss
	.globl	stop
	.p2align	3
stop:
	.quad	0                               # 0x0
	.size	stop, 8

	.type	duration,@object                # @duration
	.globl	duration
	.p2align	3
duration:
	.quad	0x0000000000000000              # double 0
	.size	duration, 8

	.type	.L.str.4,@object                # @.str.4
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.4:
	.asciz	"\347\250\213\345\272\217\350\277\220\350\241\214\346\227\266\351\227\264\344\270\272\357\274\232"
	.size	.L.str.4, 25

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"%f\n"
	.size	.L.str.5, 4

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
