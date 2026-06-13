	.file	"transpose.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC11:
	.string	"checksum=%f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB42:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	cmpl	$1, %edi
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	jle	.L33
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	testl	%eax, %eax
	movq	%rax, %r15
	movl	%eax, %r14d
	jle	.L34
	movslq	%eax, %rbx
	movl	$8, %esi
	movq	%rbx, %r13
	imulq	%rbx, %r13
	movq	%r13, %rdi
	call	calloc@PLT
	movq	%r13, %rdi
	movl	$8, %esi
	movq	%rax, %r12
	call	calloc@PLT
	testq	%r12, %r12
	movq	%rax, %r13
	je	.L6
	testq	%rax, %rax
	je	.L6
	movl	%r15d, %r8d
	imull	%r15d, %r8d
	leal	-1(%r8), %r9d
	cmpl	$6, %r9d
	jbe	.L19
	movl	$8, %ecx
	movl	%r8d, %edx
	vmovdqa	.LC0(%rip), %ymm3
	movq	%r12, %rax
	vmovd	%ecx, %xmm6
	movl	$2021161081, %ecx
	shrl	$3, %edx
	vmovd	%ecx, %xmm4
	movl	$1, %ecx
	salq	$6, %rdx
	vpbroadcastd	%xmm6, %ymm6
	vmovd	%ecx, %xmm5
	addq	%r12, %rdx
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm5, %ymm5
	.p2align 4,,10
	.p2align 3
.L8:
	vmovdqa	%ymm3, %ymm0
	addq	$64, %rax
	vpaddd	%ymm6, %ymm3, %ymm3
	vpmuldq	%ymm4, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm2
	vpmuldq	%ymm4, %ymm2, %ymm2
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm2, %ymm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpslld	$4, %ymm1, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm5, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vmovupd	%ymm1, -64(%rax)
	vcvtdq2pd	%xmm0, %ymm0
	vmovupd	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L8
	movl	%r8d, %ecx
	andl	$-8, %ecx
	cmpl	%ecx, %r8d
	movl	%ecx, %eax
	je	.L35
	vzeroupper
.L7:
	movl	%r8d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %esi
	cmpl	$2, %esi
	jbe	.L10
	vmovd	%ecx, %xmm7
	movl	$2021161081, %edi
	leaq	(%r12,%rax,8), %rax
	vmovd	%edi, %xmm2
	vpshufd	$0, %xmm7, %xmm0
	movl	$1, %edi
	vpaddd	.LC5(%rip), %xmm0, %xmm0
	vpshufd	$0, %xmm2, %xmm2
	vpmuldq	%xmm2, %xmm0, %xmm1
	vpsrlq	$32, %xmm0, %xmm3
	vpmuldq	%xmm2, %xmm3, %xmm2
	vpshufd	$245, %xmm1, %xmm1
	vpblendd	$10, %xmm2, %xmm1, %xmm1
	vpsrad	$3, %xmm1, %xmm1
	vpslld	$4, %xmm1, %xmm2
	vpaddd	%xmm1, %xmm2, %xmm1
	vpsubd	%xmm1, %xmm0, %xmm0
	vmovd	%edi, %xmm1
	vpshufd	$0, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm1
	vpshufd	$238, %xmm0, %xmm0
	vmovupd	%xmm1, (%rax)
	vcvtdq2pd	%xmm0, %xmm0
	vmovupd	%xmm0, 16(%rax)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %ecx
	andl	$3, %edx
	je	.L9
.L10:
	movl	%ecx, %eax
	movl	$17, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	movslq	%ecx, %r10
	cltd
	leaq	0(,%r10,8), %rsi
	idivl	%edi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cmpl	%eax, %r8d
	vcvtsi2sdl	%edx, %xmm0, %xmm1
	vmovsd	%xmm1, (%r12,%r10,8)
	jle	.L9
	cltd
	idivl	%edi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cmpl	%eax, %r8d
	vcvtsi2sdl	%edx, %xmm0, %xmm1
	vmovsd	%xmm1, 8(%r12,%rsi)
	jle	.L9
	cltd
	idivl	%edi
	addl	$1, %edx
	vcvtsi2sdl	%edx, %xmm0, %xmm0
	vmovsd	%xmm0, 16(%r12,%rsi)
.L9:
	leal	-1(%r15), %eax
	movq	%r13, %r11
	movq	%r13, %rdi
	xorl	%r10d, %r10d
	salq	$3, %rax
	leaq	0(,%rbx,8), %rsi
	movq	$-8, %rbx
	leaq	8(%r12,%rax), %rcx
	subq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L13:
	leaq	(%rbx,%rcx), %rax
	movq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L14:
	vmovsd	(%rax), %xmm0
	addq	$8, %rax
	vmovsd	%xmm0, (%rdx)
	addq	%rsi, %rdx
	cmpq	%rax, %rcx
	jne	.L14
	addl	$1, %r10d
	addq	$8, %rdi
	addq	%rsi, %rcx
	cmpl	%r10d, %r14d
	jne	.L13
	cmpl	$2, %r9d
	jbe	.L16
	movl	%r8d, %eax
	vxorpd	%xmm0, %xmm0, %xmm0
	shrl	$2, %eax
	salq	$5, %rax
	addq	%r13, %rax
	.p2align 4,,10
	.p2align 3
.L17:
	vaddsd	(%r11), %xmm0, %xmm0
	addq	$32, %r11
	vaddsd	-24(%r11), %xmm0, %xmm0
	vaddsd	-16(%r11), %xmm0, %xmm0
	vaddsd	-8(%r11), %xmm0, %xmm0
	cmpq	%r11, %rax
	jne	.L17
	movl	%r8d, %eax
	andl	$-4, %eax
	testb	$3, %r8b
	je	.L18
	movslq	%eax, %rdx
	vaddsd	0(%r13,%rdx,8), %xmm0, %xmm0
	leaq	0(,%rdx,8), %rcx
	leal	1(%rax), %edx
	cmpl	%r8d, %edx
	jge	.L18
	addl	$2, %eax
	vaddsd	8(%r13,%rcx), %xmm0, %xmm0
	cmpl	%eax, %r8d
	jle	.L18
	vaddsd	16(%r13,%rcx), %xmm0, %xmm0
.L18:
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L33:
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
.L19:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L7
.L34:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L35:
	vzeroupper
	jmp	.L9
.L16:
	vxorpd	%xmm0, %xmm0, %xmm0
	vaddsd	0(%r13), %xmm0, %xmm0
	jmp	.L18
.L6:
	movq	stderr(%rip), %rdi
	movl	%r14d, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE42:
	.size	main, .-main
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.set	.LC5,.LC0
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
