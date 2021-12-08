.section .text
.cpu cortex-m4
.globl main



main:
	mov		r5,#0x64
	mov		r4,#0
	B		loop

loop:
	add 	r5,r5,#1
	add		r4,r4,#1
	.end
