	.file	"suma_1-5.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	movl	b(%rip), %eax
	addl	a(%rip), %eax
	movl	%eax, c(%rip)
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.comm	c,4,4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	5
	.globl	a
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	7
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
