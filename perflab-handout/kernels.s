	.file	"kernels.c"
	.text
	.p2align 4
	.globl	naive_rotate
	.type	naive_rotate, @function
naive_rotate:
.LFB39:
	.cfi_startproc
	endbr64
	movl	%edi, %r11d
	testl	%edi, %edi
	jle	.L1
	movslq	%edi, %rax
	movq	%rsi, %r8
	xorl	%r9d, %r9d
	leaq	(%rax,%rax,2), %rdi
	leal	-1(%r11), %eax
	movl	%eax, %ecx
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rdi
	imull	%r11d, %ecx
	leaq	6(%rsi,%rax,2), %rsi
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %rcx
	leaq	(%rdx,%rcx,2), %r10
	.p2align 4,,10
	.p2align 3
.L3:
	movq	%r10, %rdx
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rax), %ecx
	addq	$6, %rax
	movl	%ecx, (%rdx)
	movzwl	-2(%rax), %ecx
	movw	%cx, 4(%rdx)
	subq	%rdi, %rdx
	cmpq	%rsi, %rax
	jne	.L4
	addl	$1, %r9d
	addq	%rdi, %r8
	addq	$6, %r10
	addq	%rdi, %rsi
	cmpl	%r9d, %r11d
	jne	.L3
.L1:
	ret
	.cfi_endproc
.LFE39:
	.size	naive_rotate, .-naive_rotate
	.p2align 4
	.globl	rotate
	.type	rotate, @function
rotate:
.LFB40:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L24
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %eax
	movl	%edi, %r11d
	xorl	%r10d, %r10d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leal	-1(%rdi), %r13d
	imull	%r13d, %eax
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xorl	%ebx, %ebx
	cltq
	leaq	(%rax,%rax,2), %rsi
	movl	%edi, %eax
	negl	%eax
	addq	%rsi, %rsi
	movq	%r14, -8(%rsp)
	addl	%eax, %eax
	leaq	(%rdx,%rsi), %rbp
	negq	%rsi
	cltq
	leaq	(%rax,%rax,2), %r9
	leal	-2(%rdi), %eax
	movl	%eax, %ecx
	imull	%edi, %eax
	addq	%r9, %r9
	shrl	%ecx
	movl	%ecx, %edx
	cltq
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%rax,%rax,2), %r8
	leal	2(%rcx,%rcx), %eax
	addq	%r8, %r8
	leaq	12(%r12,%rdx,4), %r15
	movl	%eax, %r14d
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%edx, %edx
	testl	%r13d, %r13d
	je	.L14
	movslq	%ebx, %rax
	movl	%r10d, -12(%rsp)
	movq	%rbp, %rdx
	leaq	(%rax,%rax,2), %rdi
	addq	%rdi, %rdi
	leaq	(%r12,%rdi), %rax
	addq	%r15, %rdi
	.p2align 4,,10
	.p2align 3
.L10:
	movl	(%rax), %ecx
	addq	$12, %rax
	movl	%ecx, (%rdx)
	movzwl	-8(%rax), %ecx
	movw	%cx, 4(%rdx)
	movl	-6(%rax), %r10d
	leaq	(%rdx,%r8), %rcx
	addq	%r9, %rdx
	movl	%r10d, (%rcx,%rsi)
	movzwl	-2(%rax), %r10d
	movw	%r10w, 4(%rcx,%rsi)
	cmpq	%rdi, %rax
	jne	.L10
	movl	-12(%rsp), %r10d
	movl	%r14d, %edx
.L14:
	addl	$1, %r10d
	addq	$6, %rbp
	addl	%r11d, %ebx
	cmpl	%r10d, %r11d
	jne	.L11
	movl	%r11d, %eax
	movq	-8(%rsp), %r14
	movl	%r11d, %r9d
	xorl	%r8d, %r8d
	negl	%eax
	xorl	%edi, %edi
	leaq	6(%r12), %rbx
	cltq
	leaq	(%rax,%rax,2), %rsi
	addq	%rsi, %rsi
	.p2align 4,,10
	.p2align 3
.L12:
	cmpl	%edx, %r10d
	jle	.L17
	movl	%r13d, %ecx
	movslq	%edx, %rbp
	movslq	%r8d, %rax
	subl	%edx, %ecx
	addq	%rax, %rbp
	movl	%ecx, %edx
	addq	%rbp, %rcx
	leaq	0(%rbp,%rbp,2), %rax
	imull	%r10d, %edx
	leaq	(%rcx,%rcx,2), %rcx
	leaq	(%r12,%rax,2), %rax
	leaq	(%rbx,%rcx,2), %rbp
	movslq	%edx, %rdx
	addq	%rdi, %rdx
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%r14,%rdx,2), %rdx
	.p2align 4,,10
	.p2align 3
.L15:
	movl	(%rax), %ecx
	addq	$6, %rax
	movl	%ecx, (%rdx)
	movzwl	-2(%rax), %ecx
	movw	%cx, 4(%rdx)
	addq	%rsi, %rdx
	cmpq	%rax, %rbp
	jne	.L15
	movl	%r10d, %edx
.L17:
	addq	$1, %rdi
	addl	%r11d, %r8d
	cmpq	%r9, %rdi
	jne	.L12
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L24:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE40:
	.size	rotate, .-rotate
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4
	.globl	naive_smooth
	.type	naive_smooth, @function
naive_smooth:
.LFB48:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, -72(%rsp)
	testl	%edi, %edi
	jle	.L25
	movq	%rdx, %rax
	movslq	%edi, %rdx
	leal	-1(%rdi), %ebx
	movl	%edi, %r13d
	leaq	(%rdx,%rdx,2), %rdx
	movl	%ebx, -40(%rsp)
	movq	%rax, -24(%rsp)
	leaq	(%rdx,%rdx), %rbx
	leaq	6(%rsi), %rax
	movq	%rbx, -8(%rsp)
	movl	$0, -16(%rsp)
	movq	%rax, -64(%rsp)
.L27:
	movl	-16(%rsp), %ebx
	xorl	%eax, %eax
	movl	$0, -44(%rsp)
	leal	-1(%rbx), %esi
	movl	%ebx, -12(%rsp)
	testl	%esi, %esi
	cmovns	%esi, %eax
	movl	-40(%rsp), %esi
	addl	$1, %ebx
	movl	%ebx, -16(%rsp)
	cmpl	%ebx, %esi
	movl	%eax, -32(%rsp)
	cmovle	%esi, %ebx
	imull	%r13d, %eax
	movl	%ebx, -28(%rsp)
	movl	%eax, -36(%rsp)
	movq	-24(%rsp), %rax
	movq	%rax, -56(%rsp)
	leal	1(%rbx), %eax
	movl	%eax, -76(%rsp)
	.p2align 4,,10
	.p2align 3
.L32:
	movl	-32(%rsp), %r9d
	movl	-28(%rsp), %eax
	cmpl	%eax, %r9d
	jg	.L28
	movl	-44(%rsp), %ecx
	xorl	%eax, %eax
	movl	-36(%rsp), %r10d
	leal	-1(%rcx), %ebx
	leal	1(%rcx), %ebp
	testl	%ebx, %ebx
	movl	%ebp, -48(%rsp)
	cmovs	%eax, %ebx
	movl	-40(%rsp), %eax
	cmpl	%ebp, %eax
	movslq	%ebx, %r15
	cmovle	%eax, %ebp
	xorl	%r11d, %r11d
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	xorl	%eax, %eax
	movl	%ebp, %r14d
	leal	1(%rbp), %r12d
	subl	%ebx, %r14d
	subl	%ebx, %r12d
	addq	%r15, %r14
	.p2align 4,,10
	.p2align 3
.L31:
	cmpl	%ebp, %ebx
	jg	.L29
	movslq	%r10d, %rdi
	movq	-72(%rsp), %r8
	leaq	(%r15,%rdi), %rdx
	addq	%r14, %rdi
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%rdi,%rdi,2), %rdi
	leaq	(%r8,%rdx,2), %rdx
	movq	-64(%rsp), %r8
	leaq	(%r8,%rdi,2), %r8
	.p2align 4,,10
	.p2align 3
.L30:
	movzwl	(%rdx), %edi
	addq	$6, %rdx
	addl	%edi, %eax
	movzwl	-4(%rdx), %edi
	addl	%edi, %esi
	movzwl	-2(%rdx), %edi
	addl	%edi, %ecx
	cmpq	%r8, %rdx
	jne	.L30
	addl	%r12d, %r11d
.L29:
	addl	$1, %r9d
	addl	%r13d, %r10d
	cmpl	%r9d, -76(%rsp)
	jne	.L31
	cltd
	movq	-56(%rsp), %rbx
	idivl	%r11d
	addq	$6, %rbx
	movw	%ax, -6(%rbx)
	movl	%esi, %eax
	cltd
	idivl	%r11d
	movw	%ax, -4(%rbx)
	movl	%ecx, %eax
	cltd
	idivl	%r11d
	movw	%ax, -2(%rbx)
	movq	%rbx, -56(%rsp)
	cmpl	-48(%rsp), %r13d
	je	.L37
	movl	-48(%rsp), %eax
	movl	%eax, -44(%rsp)
	jmp	.L32
.L37:
	movq	-8(%rsp), %rbx
	addq	%rbx, -24(%rsp)
	movl	-44(%rsp), %ebx
	cmpl	%ebx, -12(%rsp)
	jne	.L27
.L25:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	naive_smooth.cold, @function
naive_smooth.cold:
.LFSB48:
.L28:
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	ud2
	.cfi_endproc
.LFE48:
	.text
	.size	naive_smooth, .-naive_smooth
	.section	.text.unlikely
	.size	naive_smooth.cold, .-naive_smooth.cold
.LCOLDE0:
	.text
.LHOTE0:
	.p2align 4
	.globl	smooth
	.type	smooth, @function
smooth:
.LFB49:
	.cfi_startproc
	endbr64
	jmp	naive_smooth
	.cfi_endproc
.LFE49:
	.size	smooth, .-smooth
	.p2align 4
	.globl	register_rotate_functions
	.type	register_rotate_functions, @function
register_rotate_functions:
.LFB41:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	naive_rotate_descr(%rip), %rsi
	leaq	naive_rotate(%rip), %rdi
	call	add_rotate_function@PLT
	leaq	rotate_descr(%rip), %rsi
	leaq	rotate(%rip), %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	add_rotate_function@PLT
	.cfi_endproc
.LFE41:
	.size	register_rotate_functions, .-register_rotate_functions
	.p2align 4
	.globl	register_smooth_functions
	.type	register_smooth_functions, @function
register_smooth_functions:
.LFB50:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	smooth_descr(%rip), %rsi
	leaq	smooth(%rip), %rdi
	call	add_smooth_function@PLT
	leaq	naive_smooth_descr(%rip), %rsi
	leaq	naive_smooth(%rip), %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	add_smooth_function@PLT
	.cfi_endproc
.LFE50:
	.size	register_smooth_functions, .-register_smooth_functions
	.globl	smooth_descr
	.data
	.align 32
	.type	smooth_descr, @object
	.size	smooth_descr, 32
smooth_descr:
	.string	"smooth: Current working version"
	.globl	naive_smooth_descr
	.align 32
	.type	naive_smooth_descr, @object
	.size	naive_smooth_descr, 44
naive_smooth_descr:
	.string	"naive_smooth: Naive baseline implementation"
	.globl	rotate_descr
	.align 32
	.type	rotate_descr, @object
	.size	rotate_descr, 32
rotate_descr:
	.string	"rotate: Current working version"
	.globl	naive_rotate_descr
	.align 32
	.type	naive_rotate_descr, @object
	.size	naive_rotate_descr, 44
naive_rotate_descr:
	.string	"naive_rotate: Naive baseline implementation"
	.globl	team
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"linepi"
.LC2:
	.string	"mmagicode@gmail.com"
.LC3:
	.string	""
	.section	.data.rel.local,"aw"
	.align 32
	.type	team, @object
	.size	team, 40
team:
	.quad	.LC1
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.quad	.LC3
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
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
