	.file	"transpose.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC8:
	.string	"checksum=%f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB42:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	cmpl	$1, %edi
	jle	.L28
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rax, %r14
	movl	%eax, %r13d
	testl	%eax, %eax
	jle	.L29
	movslq	%eax, %rbx
	movl	$8, %esi
	movq	%rbx, %rbp
	imulq	%rbx, %rbp
	movq	%rbp, %rdi
	call	calloc@PLT
	movq	%rbp, %rdi
	movl	$8, %esi
	movq	%rax, %r12
	call	calloc@PLT
	movq	%rax, %rbp
	testq	%r12, %r12
	je	.L6
	testq	%rax, %rax
	je	.L6
	movl	%r14d, %edi
	imull	%r14d, %edi
	leal	-1(%rdi), %eax
	cmpl	$2, %eax
	jbe	.L17
	movdqa	.LC6(%rip), %xmm2
	pxor	%xmm4, %xmm4
	movl	%edi, %edx
	movdqa	.LC0(%rip), %xmm3
	movdqa	%xmm4, %xmm5
	shrl	$2, %edx
	movq	%r12, %rax
	movdqa	.LC5(%rip), %xmm7
	pcmpgtd	%xmm2, %xmm5
	salq	$5, %rdx
	movdqa	.LC7(%rip), %xmm6
	addq	%r12, %rdx
	.p2align 4,,10
	.p2align 3
.L8:
	movdqa	%xmm3, %xmm0
	movdqa	%xmm4, %xmm8
	movdqa	%xmm5, %xmm9
	addq	$32, %rax
	pcmpgtd	%xmm0, %xmm8
	pmuludq	%xmm0, %xmm9
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm2, %xmm1
	movdqa	%xmm5, %xmm10
	paddd	%xmm7, %xmm3
	pmuludq	%xmm2, %xmm8
	paddq	%xmm9, %xmm8
	movdqa	%xmm4, %xmm9
	psllq	$32, %xmm8
	paddq	%xmm8, %xmm1
	movdqa	%xmm0, %xmm8
	psrlq	$32, %xmm8
	pcmpgtd	%xmm8, %xmm9
	pmuludq	%xmm8, %xmm10
	pmuludq	%xmm2, %xmm8
	pmuludq	%xmm2, %xmm9
	paddq	%xmm10, %xmm9
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm8
	shufps	$221, %xmm8, %xmm1
	pshufd	$216, %xmm1, %xmm1
	psrad	$3, %xmm1
	movdqa	%xmm1, %xmm8
	pslld	$4, %xmm8
	paddd	%xmm8, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm6, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	pshufd	$238, %xmm0, %xmm0
	movups	%xmm1, -32(%rax)
	cvtdq2pd	%xmm0, %xmm0
	movups	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L8
	movl	%edi, %ecx
	andl	$-4, %ecx
	testb	$3, %dil
	je	.L9
.L7:
	movl	%ecx, %eax
	movl	$17, %esi
	pxor	%xmm0, %xmm0
	movslq	%ecx, %r9
	cltd
	leaq	0(,%r9,8), %r8
	idivl	%esi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, (%r12,%r9,8)
	cmpl	%edi, %eax
	jge	.L9
	cltd
	pxor	%xmm0, %xmm0
	idivl	%esi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 8(%r12,%r8)
	cmpl	%eax, %edi
	jle	.L9
	cltd
	pxor	%xmm0, %xmm0
	idivl	%esi
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 16(%r12,%r8)
.L9:
	leal	-1(%r14), %eax
	movq	%rbp, %r10
	movq	%rbp, %r8
	xorl	%r9d, %r9d
	salq	$3, %rax
	movq	$-8, %r11
	leaq	0(,%rbx,8), %rsi
	leaq	8(%r12,%rax), %rcx
	subq	%rax, %r11
	.p2align 4,,10
	.p2align 3
.L11:
	leaq	(%r11,%rcx), %rax
	movq	%r8, %rdx
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	(%rax), %xmm0
	addq	$8, %rax
	movsd	%xmm0, (%rdx)
	addq	%rsi, %rdx
	cmpq	%rcx, %rax
	jne	.L12
	addl	$1, %r9d
	addq	$8, %r8
	leaq	(%rax,%rsi), %rcx
	cmpl	%r9d, %r13d
	jne	.L11
	cmpl	$1, %edi
	je	.L18
	movl	%edi, %eax
	pxor	%xmm0, %xmm0
	shrl	%eax
	salq	$4, %rax
	addq	%rbp, %rax
	.p2align 4,,10
	.p2align 3
.L15:
	addsd	(%r10), %xmm0
	addq	$16, %r10
	addsd	-8(%r10), %xmm0
	cmpq	%rax, %r10
	jne	.L15
	testb	$1, %dil
	je	.L16
	movl	%edi, %eax
	andl	$-2, %eax
.L14:
	cltq
	addsd	0(%rbp,%rax,8), %xmm0
.L16:
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L28:
	.cfi_restore_state
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdx
	call	__fprintf_chk@PLT
.L3:
	movl	$1, %eax
	jmp	.L1
.L17:
	xorl	%ecx, %ecx
	jmp	.L7
.L29:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L18:
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	jmp	.L14
.L6:
	movq	stderr(%rip), %rdi
	movl	%r13d, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE42:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC5:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC6:
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.align 16
.LC7:
	.long	1
	.long	1
	.long	1
	.long	1
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
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
