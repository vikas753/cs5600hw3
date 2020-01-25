	.file	"sort.c"
	.text
.Ltext0:
	.globl	length
	.type	length, @function
length:
.LFB6:
	.file 1 "sort.c"
	.loc 1 11 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	.loc 1 13 12
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 13 5
	jmp	.L2
.L3:
	.loc 1 13 24 discriminator 3
	addq	$1, -8(%rbp)
.L2:
	.loc 1 13 20 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	.loc 1 13 5 discriminator 1
	testb	%al, %al
	jne	.L3
	.loc 1 14 14
	movq	-8(%rbp), %rax
	subq	-24(%rbp), %rax
	.loc 1 15 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	length, .-length
	.section	.rodata
.LC0:
	.string	"Usage: ./sort input output \n"
.LC1:
	.string	"write in main"
	.text
	.globl	UsageWrite
	.type	UsageWrite, @function
UsageWrite:
.LFB7:
	.loc 1 20 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 1 21 11
	leaq	.LC0(%rip), %rax
	movq	%rax, -8(%rbp)
	.loc 1 22 42
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	length
	.loc 1 22 14
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	.loc 1 22 9
	movl	%eax, -12(%rbp)
	.loc 1 23 8
	cmpl	$0, -12(%rbp)
	jns	.L6
	.loc 1 26 9
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
.L6:
	.loc 1 28 5
	movl	$1, %edi
	call	_exit@PLT
	.cfi_endproc
.LFE7:
	.size	UsageWrite, .-UsageWrite
	.section	.rodata
.LC2:
	.string	"argv1 : %s\n"
.LC3:
	.string	"size : %ld \n"
.LC4:
	.string	" InputFd : %ld\n "
	.align 8
.LC5:
	.string	" read result of InputFD , inputfd "
.LC6:
	.string	"%ld\n"
.LC7:
	.string	" write result of OutputFD "
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.loc 1 34 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$264, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -260(%rbp)
	movq	%rsi, -272(%rbp)
	.loc 1 35 7
	cmpl	$2, -260(%rbp)
	jg	.L8
	.loc 1 37 7
	movl	$0, %eax
	call	UsageWrite
.L8:
	.loc 1 40 33
	movq	-272(%rbp), %rax
	addq	$8, %rax
	.loc 1 40 5
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 42 28
	movq	-272(%rbp), %rax
	addq	$8, %rax
	.loc 1 42 19
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -68(%rbp)
	.loc 1 45 7
	cmpl	$0, -68(%rbp)
	je	.L9
.LBB2:
	.loc 1 46 5
	movq	%rsp, %rax
	movq	%rax, %rbx
	.loc 1 48 16
	movq	-272(%rbp), %rax
	addq	$8, %rax
	.loc 1 48 7
	movq	(%rax), %rax
	leaq	-256(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat@PLT
	.loc 1 49 26
	movq	-208(%rbp), %rax
	.loc 1 49 11
	movl	%eax, -72(%rbp)
	.loc 1 50 7
	movl	-72(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 52 7
	movl	-72(%rbp), %eax
	.loc 1 52 12
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -80(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, -288(%rbp)
	movq	$0, -280(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, -304(%rbp)
	movq	$0, -296(%rbp)
	cltq
	movl	$16, %edx
	subq	$1, %rdx
	addq	%rdx, %rax
	movl	$16, %ecx
	movl	$0, %edx
	divq	%rcx
	imulq	$16, %rax, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$0, %rax
	movq	%rax, -88(%rbp)
	.loc 1 53 14
	movl	-72(%rbp), %eax
	movslq	%eax, %rdx
	movq	-88(%rbp), %rcx
	movl	-68(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	.loc 1 53 12
	movl	%eax, -72(%rbp)
	.loc 1 55 9
	cmpl	$-1, -72(%rbp)
	jne	.L10
	.loc 1 57 9
	movl	-68(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	.loc 1 58 9
	movl	-68(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 59 9
	leaq	.LC5(%rip), %rdi
	call	perror@PLT
	.loc 1 60 9
	movl	$1, %edi
	call	_exit@PLT
.L10:
	.loc 1 65 11
	movl	$0, -64(%rbp)
	.loc 1 66 29
	movl	-72(%rbp), %eax
	sarl	%eax
	movslq	%eax, %rdx
	.loc 1 66 11
	subq	$1, %rdx
	movq	%rdx, -96(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, %r14
	movl	$0, %r15d
	movslq	%eax, %rdx
	movq	%rdx, %r12
	movl	$0, %r13d
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %ecx
	movl	$0, %edx
	divq	%rcx
	imulq	$16, %rax, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -104(%rbp)
	.loc 1 67 11
	movl	$0, -60(%rbp)
.LBB3:
	.loc 1 68 15
	movl	$0, -56(%rbp)
	.loc 1 68 7
	jmp	.L11
.L13:
	.loc 1 70 26
	movq	-88(%rbp), %rdx
	movl	-56(%rbp), %eax
	cltq
	movzbl	(%rdx,%rax), %eax
	.loc 1 70 11
	cmpb	$10, %al
	jne	.L12
.LBB4:
	.loc 1 72 29
	movq	-88(%rbp), %rdx
	movl	-56(%rbp), %eax
	cltq
	movb	$0, (%rdx,%rax)
	.loc 1 73 48
	movl	-64(%rbp), %eax
	movslq	%eax, %rdx
	movq	-88(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	atoi@PLT
	movl	%eax, %ecx
	.loc 1 73 46
	movq	-104(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	%ecx, (%rax,%rdx,4)
	.loc 1 74 17
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
	.loc 1 75 24
	addl	$1, -60(%rbp)
.L12:
.LBE4:
	.loc 1 68 27 discriminator 2
	addl	$1, -56(%rbp)
.L11:
	.loc 1 68 7 discriminator 1
	movl	-56(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jl	.L13
.LBE3:
.LBB5:
	.loc 1 79 15
	movl	$0, -52(%rbp)
	.loc 1 79 7
	jmp	.L14
.L15:
	.loc 1 81 9 discriminator 3
	movq	-104(%rbp), %rax
	movl	-52(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 79 43 discriminator 3
	addl	$1, -52(%rbp)
.L14:
	.loc 1 79 7 discriminator 1
	movl	-52(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L15
.LBE5:
	.loc 1 85 31
	movq	-272(%rbp), %rax
	addq	$16, %rax
	.loc 1 85 22
	movq	(%rax), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -108(%rbp)
	.loc 1 87 9
	cmpl	$0, -108(%rbp)
	je	.L16
.LBB6:
	.loc 1 89 27
	movl	-72(%rbp), %eax
	movslq	%eax, %rdx
	movq	-88(%rbp), %rcx
	movl	-108(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	.loc 1 89 13
	movl	%eax, -112(%rbp)
	.loc 1 90 11
	cmpl	$-1, -112(%rbp)
	jne	.L18
	.loc 1 92 11
	movl	-68(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	.loc 1 93 11
	movl	-108(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	.loc 1 94 11
	leaq	.LC7(%rip), %rdi
	call	perror@PLT
	.loc 1 95 11
	movl	$1, %edi
	call	_exit@PLT
.L16:
.LBE6:
	.loc 1 100 9
	movl	$0, %eax
	call	UsageWrite
.L18:
	movq	%rbx, %rsp
.LBE2:
	jmp	.L19
.L9:
	.loc 1 105 7
	movl	$0, %eax
	call	UsageWrite
.L19:
	.loc 1 108 12
	movl	$2, %eax
	.loc 1 109 1
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/8/include/stddef.h"
	.file 4 "/usr/include/unistd.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/getopt_core.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 8 "/usr/include/stdio.h"
	.file 9 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h"
	.file 10 "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h"
	.file 11 "/usr/include/x86_64-linux-gnu/bits/stat.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x6b5
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF101
	.byte	0xc
	.long	.LASF102
	.long	.LASF103
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x4
	.long	.LASF7
	.byte	0x2
	.byte	0x8f
	.byte	0x19
	.long	0x42
	.uleb128 0x4
	.long	.LASF8
	.byte	0x2
	.byte	0x90
	.byte	0x19
	.long	0x3b
	.uleb128 0x4
	.long	.LASF9
	.byte	0x2
	.byte	0x91
	.byte	0x19
	.long	0x3b
	.uleb128 0x4
	.long	.LASF10
	.byte	0x2
	.byte	0x92
	.byte	0x19
	.long	0x42
	.uleb128 0x4
	.long	.LASF11
	.byte	0x2
	.byte	0x94
	.byte	0x1a
	.long	0x3b
	.uleb128 0x4
	.long	.LASF12
	.byte	0x2
	.byte	0x95
	.byte	0x1b
	.long	0x42
	.uleb128 0x4
	.long	.LASF13
	.byte	0x2
	.byte	0x96
	.byte	0x19
	.long	0x5e
	.uleb128 0x4
	.long	.LASF14
	.byte	0x2
	.byte	0x97
	.byte	0x1b
	.long	0x5e
	.uleb128 0x4
	.long	.LASF15
	.byte	0x2
	.byte	0x9e
	.byte	0x1a
	.long	0x5e
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x4
	.long	.LASF16
	.byte	0x2
	.byte	0xac
	.byte	0x1d
	.long	0x5e
	.uleb128 0x4
	.long	.LASF17
	.byte	0x2
	.byte	0xb1
	.byte	0x1c
	.long	0x5e
	.uleb128 0x4
	.long	.LASF18
	.byte	0x2
	.byte	0xc2
	.byte	0x21
	.long	0x5e
	.uleb128 0x6
	.byte	0x8
	.long	0xfd
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF19
	.uleb128 0x7
	.long	0xfd
	.uleb128 0x4
	.long	.LASF20
	.byte	0x3
	.byte	0xd8
	.byte	0x17
	.long	0x42
	.uleb128 0x8
	.long	.LASF21
	.byte	0x4
	.value	0x21f
	.byte	0xf
	.long	0x122
	.uleb128 0x6
	.byte	0x8
	.long	0xf7
	.uleb128 0x9
	.long	.LASF22
	.byte	0x5
	.byte	0x24
	.byte	0xe
	.long	0xf7
	.uleb128 0x9
	.long	.LASF23
	.byte	0x5
	.byte	0x32
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF24
	.byte	0x5
	.byte	0x37
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF25
	.byte	0x5
	.byte	0x3b
	.byte	0xc
	.long	0x57
	.uleb128 0xa
	.long	.LASF64
	.byte	0xd8
	.byte	0x6
	.byte	0x31
	.byte	0x8
	.long	0x2df
	.uleb128 0xb
	.long	.LASF26
	.byte	0x6
	.byte	0x33
	.byte	0x7
	.long	0x57
	.byte	0
	.uleb128 0xb
	.long	.LASF27
	.byte	0x6
	.byte	0x36
	.byte	0x9
	.long	0xf7
	.byte	0x8
	.uleb128 0xb
	.long	.LASF28
	.byte	0x6
	.byte	0x37
	.byte	0x9
	.long	0xf7
	.byte	0x10
	.uleb128 0xb
	.long	.LASF29
	.byte	0x6
	.byte	0x38
	.byte	0x9
	.long	0xf7
	.byte	0x18
	.uleb128 0xb
	.long	.LASF30
	.byte	0x6
	.byte	0x39
	.byte	0x9
	.long	0xf7
	.byte	0x20
	.uleb128 0xb
	.long	.LASF31
	.byte	0x6
	.byte	0x3a
	.byte	0x9
	.long	0xf7
	.byte	0x28
	.uleb128 0xb
	.long	.LASF32
	.byte	0x6
	.byte	0x3b
	.byte	0x9
	.long	0xf7
	.byte	0x30
	.uleb128 0xb
	.long	.LASF33
	.byte	0x6
	.byte	0x3c
	.byte	0x9
	.long	0xf7
	.byte	0x38
	.uleb128 0xb
	.long	.LASF34
	.byte	0x6
	.byte	0x3d
	.byte	0x9
	.long	0xf7
	.byte	0x40
	.uleb128 0xb
	.long	.LASF35
	.byte	0x6
	.byte	0x40
	.byte	0x9
	.long	0xf7
	.byte	0x48
	.uleb128 0xb
	.long	.LASF36
	.byte	0x6
	.byte	0x41
	.byte	0x9
	.long	0xf7
	.byte	0x50
	.uleb128 0xb
	.long	.LASF37
	.byte	0x6
	.byte	0x42
	.byte	0x9
	.long	0xf7
	.byte	0x58
	.uleb128 0xb
	.long	.LASF38
	.byte	0x6
	.byte	0x44
	.byte	0x16
	.long	0x2f8
	.byte	0x60
	.uleb128 0xb
	.long	.LASF39
	.byte	0x6
	.byte	0x46
	.byte	0x14
	.long	0x2fe
	.byte	0x68
	.uleb128 0xb
	.long	.LASF40
	.byte	0x6
	.byte	0x48
	.byte	0x7
	.long	0x57
	.byte	0x70
	.uleb128 0xb
	.long	.LASF41
	.byte	0x6
	.byte	0x49
	.byte	0x7
	.long	0x57
	.byte	0x74
	.uleb128 0xb
	.long	.LASF42
	.byte	0x6
	.byte	0x4a
	.byte	0xb
	.long	0xad
	.byte	0x78
	.uleb128 0xb
	.long	.LASF43
	.byte	0x6
	.byte	0x4d
	.byte	0x12
	.long	0x34
	.byte	0x80
	.uleb128 0xb
	.long	.LASF44
	.byte	0x6
	.byte	0x4e
	.byte	0xf
	.long	0x49
	.byte	0x82
	.uleb128 0xb
	.long	.LASF45
	.byte	0x6
	.byte	0x4f
	.byte	0x8
	.long	0x304
	.byte	0x83
	.uleb128 0xb
	.long	.LASF46
	.byte	0x6
	.byte	0x51
	.byte	0xf
	.long	0x314
	.byte	0x88
	.uleb128 0xb
	.long	.LASF47
	.byte	0x6
	.byte	0x59
	.byte	0xd
	.long	0xb9
	.byte	0x90
	.uleb128 0xb
	.long	.LASF48
	.byte	0x6
	.byte	0x5b
	.byte	0x17
	.long	0x31f
	.byte	0x98
	.uleb128 0xb
	.long	.LASF49
	.byte	0x6
	.byte	0x5c
	.byte	0x19
	.long	0x32a
	.byte	0xa0
	.uleb128 0xb
	.long	.LASF50
	.byte	0x6
	.byte	0x5d
	.byte	0x14
	.long	0x2fe
	.byte	0xa8
	.uleb128 0xb
	.long	.LASF51
	.byte	0x6
	.byte	0x5e
	.byte	0x9
	.long	0xd1
	.byte	0xb0
	.uleb128 0xb
	.long	.LASF52
	.byte	0x6
	.byte	0x5f
	.byte	0xa
	.long	0x109
	.byte	0xb8
	.uleb128 0xb
	.long	.LASF53
	.byte	0x6
	.byte	0x60
	.byte	0x7
	.long	0x57
	.byte	0xc0
	.uleb128 0xb
	.long	.LASF54
	.byte	0x6
	.byte	0x62
	.byte	0x8
	.long	0x330
	.byte	0xc4
	.byte	0
	.uleb128 0x4
	.long	.LASF55
	.byte	0x7
	.byte	0x7
	.byte	0x19
	.long	0x158
	.uleb128 0xc
	.long	.LASF104
	.byte	0x6
	.byte	0x2b
	.byte	0xe
	.uleb128 0xd
	.long	.LASF56
	.uleb128 0x6
	.byte	0x8
	.long	0x2f3
	.uleb128 0x6
	.byte	0x8
	.long	0x158
	.uleb128 0xe
	.long	0xfd
	.long	0x314
	.uleb128 0xf
	.long	0x42
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x2eb
	.uleb128 0xd
	.long	.LASF57
	.uleb128 0x6
	.byte	0x8
	.long	0x31a
	.uleb128 0xd
	.long	.LASF58
	.uleb128 0x6
	.byte	0x8
	.long	0x325
	.uleb128 0xe
	.long	0xfd
	.long	0x340
	.uleb128 0xf
	.long	0x42
	.byte	0x13
	.byte	0
	.uleb128 0x9
	.long	.LASF59
	.byte	0x8
	.byte	0x89
	.byte	0xe
	.long	0x34c
	.uleb128 0x6
	.byte	0x8
	.long	0x2df
	.uleb128 0x9
	.long	.LASF60
	.byte	0x8
	.byte	0x8a
	.byte	0xe
	.long	0x34c
	.uleb128 0x9
	.long	.LASF61
	.byte	0x8
	.byte	0x8b
	.byte	0xe
	.long	0x34c
	.uleb128 0x9
	.long	.LASF62
	.byte	0x9
	.byte	0x1a
	.byte	0xc
	.long	0x57
	.uleb128 0xe
	.long	0x38c
	.long	0x381
	.uleb128 0x10
	.byte	0
	.uleb128 0x7
	.long	0x376
	.uleb128 0x6
	.byte	0x8
	.long	0x104
	.uleb128 0x7
	.long	0x386
	.uleb128 0x9
	.long	.LASF63
	.byte	0x9
	.byte	0x1b
	.byte	0x1a
	.long	0x381
	.uleb128 0xa
	.long	.LASF65
	.byte	0x10
	.byte	0xa
	.byte	0x9
	.byte	0x8
	.long	0x3c5
	.uleb128 0xb
	.long	.LASF66
	.byte	0xa
	.byte	0xb
	.byte	0xc
	.long	0xc5
	.byte	0
	.uleb128 0xb
	.long	.LASF67
	.byte	0xa
	.byte	0xc
	.byte	0x15
	.long	0xeb
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF68
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF69
	.uleb128 0xa
	.long	.LASF70
	.byte	0x90
	.byte	0xb
	.byte	0x2e
	.byte	0x8
	.long	0x4a4
	.uleb128 0xb
	.long	.LASF71
	.byte	0xb
	.byte	0x30
	.byte	0xd
	.long	0x65
	.byte	0
	.uleb128 0xb
	.long	.LASF72
	.byte	0xb
	.byte	0x35
	.byte	0xd
	.long	0x89
	.byte	0x8
	.uleb128 0xb
	.long	.LASF73
	.byte	0xb
	.byte	0x3d
	.byte	0xf
	.long	0xa1
	.byte	0x10
	.uleb128 0xb
	.long	.LASF74
	.byte	0xb
	.byte	0x3e
	.byte	0xe
	.long	0x95
	.byte	0x18
	.uleb128 0xb
	.long	.LASF75
	.byte	0xb
	.byte	0x40
	.byte	0xd
	.long	0x71
	.byte	0x1c
	.uleb128 0xb
	.long	.LASF76
	.byte	0xb
	.byte	0x41
	.byte	0xd
	.long	0x7d
	.byte	0x20
	.uleb128 0xb
	.long	.LASF77
	.byte	0xb
	.byte	0x43
	.byte	0x9
	.long	0x57
	.byte	0x24
	.uleb128 0xb
	.long	.LASF78
	.byte	0xb
	.byte	0x45
	.byte	0xd
	.long	0x65
	.byte	0x28
	.uleb128 0xb
	.long	.LASF79
	.byte	0xb
	.byte	0x4a
	.byte	0xd
	.long	0xad
	.byte	0x30
	.uleb128 0xb
	.long	.LASF80
	.byte	0xb
	.byte	0x4e
	.byte	0x11
	.long	0xd3
	.byte	0x38
	.uleb128 0xb
	.long	.LASF81
	.byte	0xb
	.byte	0x50
	.byte	0x10
	.long	0xdf
	.byte	0x40
	.uleb128 0xb
	.long	.LASF82
	.byte	0xb
	.byte	0x5b
	.byte	0x15
	.long	0x39d
	.byte	0x48
	.uleb128 0xb
	.long	.LASF83
	.byte	0xb
	.byte	0x5c
	.byte	0x15
	.long	0x39d
	.byte	0x58
	.uleb128 0xb
	.long	.LASF84
	.byte	0xb
	.byte	0x5d
	.byte	0x15
	.long	0x39d
	.byte	0x68
	.uleb128 0xb
	.long	.LASF85
	.byte	0xb
	.byte	0x6a
	.byte	0x17
	.long	0x4a4
	.byte	0x78
	.byte	0
	.uleb128 0xe
	.long	0xeb
	.long	0x4b4
	.uleb128 0xf
	.long	0x42
	.byte	0x2
	.byte	0
	.uleb128 0x11
	.long	.LASF105
	.byte	0x1
	.byte	0x21
	.byte	0x1
	.long	0x57
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x615
	.uleb128 0x12
	.long	.LASF86
	.byte	0x1
	.byte	0x21
	.byte	0xa
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -276
	.uleb128 0x12
	.long	.LASF87
	.byte	0x1
	.byte	0x21
	.byte	0x16
	.long	0x122
	.uleb128 0x3
	.byte	0x91
	.sleb128 -288
	.uleb128 0x13
	.long	.LASF88
	.byte	0x1
	.byte	0x2a
	.byte	0x9
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x14
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x13
	.long	.LASF89
	.byte	0x1
	.byte	0x2f
	.byte	0x13
	.long	0x3d3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -272
	.uleb128 0x13
	.long	.LASF90
	.byte	0x1
	.byte	0x31
	.byte	0xb
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x13
	.long	.LASF91
	.byte	0x1
	.byte	0x34
	.byte	0xc
	.long	0x615
	.uleb128 0x4
	.byte	0x91
	.sleb128 -104
	.byte	0x6
	.uleb128 0x13
	.long	.LASF92
	.byte	0x1
	.byte	0x41
	.byte	0xb
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x13
	.long	.LASF93
	.byte	0x1
	.byte	0x42
	.byte	0xb
	.long	0x629
	.uleb128 0x4
	.byte	0x91
	.sleb128 -120
	.byte	0x6
	.uleb128 0x13
	.long	.LASF94
	.byte	0x1
	.byte	0x43
	.byte	0xb
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x13
	.long	.LASF95
	.byte	0x1
	.byte	0x55
	.byte	0xb
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -124
	.uleb128 0x15
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.long	0x5cd
	.uleb128 0x16
	.string	"i"
	.byte	0x1
	.byte	0x44
	.byte	0xf
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x14
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.uleb128 0x17
	.long	.LASF106
	.byte	0x1
	.byte	0x49
	.byte	0x30
	.long	0x57
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.long	0x5f1
	.uleb128 0x16
	.string	"i"
	.byte	0x1
	.byte	0x4f
	.byte	0xf
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.byte	0
	.uleb128 0x14
	.quad	.LBB6
	.quad	.LBE6-.LBB6
	.uleb128 0x13
	.long	.LASF96
	.byte	0x1
	.byte	0x59
	.byte	0xd
	.long	0x57
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xe
	.long	0xfd
	.long	0x629
	.uleb128 0x19
	.long	0x42
	.uleb128 0x4
	.byte	0x91
	.sleb128 -96
	.byte	0x6
	.byte	0
	.uleb128 0xe
	.long	0x57
	.long	0x63d
	.uleb128 0x19
	.long	0x42
	.uleb128 0x4
	.byte	0x91
	.sleb128 -112
	.byte	0x6
	.byte	0
	.uleb128 0x1a
	.long	.LASF98
	.byte	0x1
	.byte	0x13
	.byte	0x5
	.long	0x57
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x67d
	.uleb128 0x13
	.long	.LASF97
	.byte	0x1
	.byte	0x15
	.byte	0xb
	.long	0xf7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x16
	.string	"rv"
	.byte	0x1
	.byte	0x16
	.byte	0x9
	.long	0x57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0x1b
	.long	.LASF99
	.byte	0x1
	.byte	0xa
	.byte	0x1
	.long	0x57
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x12
	.long	.LASF100
	.byte	0x1
	.byte	0xa
	.byte	0xe
	.long	0xf7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x16
	.string	"z"
	.byte	0x1
	.byte	0xc
	.byte	0xb
	.long	0xf7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF78:
	.string	"st_rdev"
.LASF67:
	.string	"tv_nsec"
.LASF22:
	.string	"optarg"
.LASF79:
	.string	"st_size"
.LASF100:
	.string	"text"
.LASF97:
	.string	"usage"
.LASF66:
	.string	"tv_sec"
.LASF62:
	.string	"sys_nerr"
.LASF37:
	.string	"_IO_save_end"
.LASF11:
	.string	"__mode_t"
.LASF20:
	.string	"size_t"
.LASF96:
	.string	"resultWrite"
.LASF47:
	.string	"_offset"
.LASF93:
	.string	"IntegerArray"
.LASF95:
	.string	"OutputFD"
.LASF105:
	.string	"main"
.LASF31:
	.string	"_IO_write_ptr"
.LASF26:
	.string	"_flags"
.LASF18:
	.string	"__syscall_slong_t"
.LASF71:
	.string	"st_dev"
.LASF94:
	.string	"IntegerArrayIterator"
.LASF33:
	.string	"_IO_buf_base"
.LASF73:
	.string	"st_nlink"
.LASF5:
	.string	"short int"
.LASF38:
	.string	"_markers"
.LASF28:
	.string	"_IO_read_end"
.LASF51:
	.string	"_freeres_buf"
.LASF7:
	.string	"__dev_t"
.LASF102:
	.string	"sort.c"
.LASF91:
	.string	"read_buf_final"
.LASF98:
	.string	"UsageWrite"
.LASF80:
	.string	"st_blksize"
.LASF61:
	.string	"stderr"
.LASF69:
	.string	"long long int"
.LASF68:
	.string	"long long unsigned int"
.LASF76:
	.string	"st_gid"
.LASF46:
	.string	"_lock"
.LASF6:
	.string	"long int"
.LASF12:
	.string	"__nlink_t"
.LASF43:
	.string	"_cur_column"
.LASF84:
	.string	"st_ctim"
.LASF106:
	.string	"atoi"
.LASF87:
	.string	"argv"
.LASF0:
	.string	"unsigned char"
.LASF44:
	.string	"_vtable_offset"
.LASF42:
	.string	"_old_offset"
.LASF99:
	.string	"length"
.LASF70:
	.string	"stat"
.LASF72:
	.string	"st_ino"
.LASF88:
	.string	"InputFD"
.LASF41:
	.string	"_flags2"
.LASF86:
	.string	"argc"
.LASF4:
	.string	"signed char"
.LASF48:
	.string	"_codecvt"
.LASF103:
	.string	"/home/vvikas1996/Documents/cs5600hw3"
.LASF92:
	.string	"start_offset"
.LASF2:
	.string	"unsigned int"
.LASF56:
	.string	"_IO_marker"
.LASF45:
	.string	"_shortbuf"
.LASF77:
	.string	"__pad0"
.LASF30:
	.string	"_IO_write_base"
.LASF54:
	.string	"_unused2"
.LASF24:
	.string	"opterr"
.LASF16:
	.string	"__blksize_t"
.LASF52:
	.string	"__pad5"
.LASF34:
	.string	"_IO_buf_end"
.LASF19:
	.string	"char"
.LASF64:
	.string	"_IO_FILE"
.LASF23:
	.string	"optind"
.LASF49:
	.string	"_wide_data"
.LASF50:
	.string	"_freeres_list"
.LASF14:
	.string	"__off64_t"
.LASF21:
	.string	"__environ"
.LASF81:
	.string	"st_blocks"
.LASF83:
	.string	"st_mtim"
.LASF10:
	.string	"__ino_t"
.LASF82:
	.string	"st_atim"
.LASF75:
	.string	"st_uid"
.LASF1:
	.string	"short unsigned int"
.LASF101:
	.string	"GNU C17 8.3.0 -mtune=generic -march=x86-64 -g"
.LASF3:
	.string	"long unsigned int"
.LASF32:
	.string	"_IO_write_end"
.LASF15:
	.string	"__time_t"
.LASF40:
	.string	"_fileno"
.LASF39:
	.string	"_chain"
.LASF90:
	.string	"size"
.LASF58:
	.string	"_IO_wide_data"
.LASF53:
	.string	"_mode"
.LASF89:
	.string	"FileStat"
.LASF13:
	.string	"__off_t"
.LASF36:
	.string	"_IO_backup_base"
.LASF59:
	.string	"stdin"
.LASF85:
	.string	"__glibc_reserved"
.LASF57:
	.string	"_IO_codecvt"
.LASF29:
	.string	"_IO_read_base"
.LASF65:
	.string	"timespec"
.LASF8:
	.string	"__uid_t"
.LASF35:
	.string	"_IO_save_base"
.LASF63:
	.string	"sys_errlist"
.LASF25:
	.string	"optopt"
.LASF74:
	.string	"st_mode"
.LASF55:
	.string	"FILE"
.LASF27:
	.string	"_IO_read_ptr"
.LASF17:
	.string	"__blkcnt_t"
.LASF60:
	.string	"stdout"
.LASF104:
	.string	"_IO_lock_t"
.LASF9:
	.string	"__gid_t"
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
