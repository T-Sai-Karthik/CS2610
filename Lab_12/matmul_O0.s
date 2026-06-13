	.file	"matmul.c"
	.text
	.type	init_matrix, @function
init_matrix:
.LFB5039:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movsd	%xmm0, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %ecx
	movslq	%ecx, %rax
	imulq	$2021161081, %rax, %rax
	shrq	$32, %rax
	sarl	$3, %eax
	movl	%ecx, %edx
	sarl	$31, %edx
	subl	%edx, %eax
	movl	%eax, %edx
	sall	$4, %edx
	addl	%eax, %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	addl	$1, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	mulsd	-40(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L2:
	movl	-20(%rbp), %eax
	imull	%eax, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L3
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5039:
	.size	init_matrix, .-init_matrix
	.type	checksum, @function
checksum:
.LFB5040:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L5
.L6:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addl	$1, -12(%rbp)
.L5:
	movl	-20(%rbp), %eax
	imull	%eax, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L6
	movsd	-8(%rbp), %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5040:
	.size	checksum, .-checksum
	.type	read_tsc, @function
read_tsc:
.LFB5041:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	rdtsc
	salq	$32, %rdx
	orq	%rdx, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5041:
	.size	read_tsc, .-read_tsc
	.type	matmul, @function
matmul:
.LFB5042:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L12
.L17:
	movl	$0, -16(%rbp)
	jmp	.L13
.L16:
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L14
.L15:
	movl	-20(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm1
	movl	-12(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addl	$1, -12(%rbp)
.L14:
	movl	-12(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L15
	movl	-20(%rbp), %eax
	imull	-36(%rbp), %eax
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movsd	-8(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -16(%rbp)
.L13:
	movl	-16(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L16
	addl	$1, -20(%rbp)
.L12:
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L17
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5042:
	.size	matmul, .-matmul
	.section	.rodata
.LC1:
	.string	"usage: %s <N>\n"
.LC2:
	.string	"N must be positive\n"
.LC3:
	.string	"allocation failed for N=%d\n"
.LC6:
	.string	"checksum=%f\n"
.LC7:
	.string	"cycles=%llu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5043:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	cmpl	$1, -52(%rbp)
	jg	.L19
	movq	-64(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC1(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L20
.L19:
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, -44(%rbp)
	jg	.L21
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L20
.L21:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-44(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -40(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-44(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -32(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-44(%rbp), %eax
	cltq
	imulq	%rdx, %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L22
	cmpq	$0, -32(%rbp)
	je	.L22
	cmpq	$0, -24(%rbp)
	jne	.L23
.L22:
	movq	stderr(%rip), %rax
	movl	-44(%rbp), %edx
	leaq	.LC3(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$1, %eax
	jmp	.L20
.L23:
	movq	.LC4(%rip), %rcx
	movq	-40(%rbp), %rdx
	movl	-44(%rbp), %eax
	movq	%rcx, %xmm0
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	init_matrix
	movq	.LC5(%rip), %rcx
	movq	-32(%rbp), %rdx
	movl	-44(%rbp), %eax
	movq	%rcx, %xmm0
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	init_matrix
	call	read_tsc
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	matmul
	call	read_tsc
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rdx
	movl	-44(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	checksum
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	subq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5043:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1071644672
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
