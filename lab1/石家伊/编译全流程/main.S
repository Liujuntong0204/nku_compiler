	.file	"main.c"
	.text
	.globl	start
	.bss
	.align 8
	.type	start, @object
	.size	start, 8
start:
	.zero	8
	.globl	stop
	.align 8
	.type	stop, @object
	.size	stop, 8
stop:
	.zero	8
	.globl	duration
	.align 8
	.type	duration, @object
	.size	duration, 8
duration:
	.zero	8
	.section	.rodata
.LC0:
	.string	"\350\277\231\346\230\257\344\270\200\344\270\252\345\256\217\345\256\232\344\271\211\357\275\236"
.LC1:
	.string	"%d"
.LC2:
	.string	"%d\n"
.LC4:
	.string	"\347\250\213\345\272\217\350\277\220\350\241\214\346\227\266\351\227\264\344\270\272\357\274\232"
.LC5:
	.string	"%f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	clock@PLT
	movq	%rax, start(%rip)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, -28(%rbp)
	movl	$1, -24(%rbp)
	movl	$1, -20(%rbp)
	movl	$2000, -16(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L2
.L3:
	movl	-24(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-28(%rbp), %eax
	addl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-12(%rbp), %eax
	movl	%eax, -28(%rbp)
	addl	$1, -20(%rbp)
.L2:
	movl	-32(%rbp), %eax
	cmpl	%eax, -20(%rbp)
	jl	.L3
	call	clock@PLT
	movq	%rax, stop(%rip)
	movq	stop(%rip), %rax
	movq	start(%rip), %rdx
	subq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC3(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, duration(%rip)
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	duration(%rip), %rax
	movq	%rax, %xmm0
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
