	.file	"contextSwitch.c"
	.text
	.align	2
	.global	activate
	.type	activate, %function
activate:
	@ args = 0, pretend = 0, frame = 52
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #52
	str	r0, [fp, #-60]
	str	r1, [fp, #-64]
	mov	r3, #0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #24]
	str	r3, [fp, #-36]
	msr spsr, r3
	str	r3, [fp, #-36]
	stmfd	sp!, {r4-r9}
	stmfd	sp!, {fp}
	msr CPSR_c, #0xdf
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #20]
	str	r3, [fp, #-40]
	mov sp, r3
	str	r3, [fp, #-40]
	ldmfd	sp, {sp, lr}
	mov ip, lr
	msr cpsr, #0xd3
	mov lr, ip
	ldr	r3, .L7
	str	r3, [fp, #-28]
	ldr	r3, .L7+4
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #28]
	str	r3, [fp, #-44]
	mov r0, r3
	str	r3, [fp, #-44]
	msr CPSR_c, #0xdf
	ldmfd	sp!, {r1-r12, lr}
	msr cpsr, #0xd3
	movs pc, lr
	__SWI_HANDLER:
	stmfd sp!, {r0}
	mrs r0, CPSR
	cmp r0, #0xd2
	ldmfd sp!, {r0}
	msr CPSR_c, #0xdf
	stmfd sp!, {r1-r12, lr}
	msr cpsr, #0xd3
	bne __SWI_MODE__
	msr CPSR_c, #0xd2
	mov ip, lr
	msr CPSR_c, #0xd3
	mov lr, ip
	__SWI_MODE__:
	ldmfd sp!, {fp}
	mov r3, r0
	str	r3, [fp, #-32]
	ldr	r3, .L7+8
	str	r3, [fp, #-20]
	ldr	r3, .L7+12
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-16]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-52]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-60]
	str	r2, [r3, #28]
	mov r3, r4
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #8]
	mov r3, r5
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #12]
	mov r3, r6
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #16]
	mov r3, r7
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #20]
	mov r3, r8
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #24]
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	bne	.L2
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	beq	.L4
.L2:
	ldr	r2, [fp, #-64]
	mov	r3, #9
	str	r3, [r2, #0]
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #8]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #12]
	b	.L5
.L4:
	ldr r2, [lr, #-4]
	ldr	r3, [fp, #-64]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-64]
	ldr	r3, [r3, #0]
	bic	r2, r3, #-16777216
	ldr	r3, [fp, #-64]
	str	r2, [r3, #0]
.L5:
	mov ip, lr
	msr cpsr, #0xdf
	mov lr, ip
	mov ip, sp
	stmfd sp!, {ip, lr}
	mov ip, sp
	msr cpsr, #0xd3
	ldmfd sp!, {r4-r9}
	mov r3, ip
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-56]
	mrs r3, spsr
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-32]
	mov	r2, r3
	ldr	r3, [fp, #-60]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-56]
	mov	r2, r3
	ldr	r3, [fp, #-60]
	str	r2, [r3, #24]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L8:
	.align	2
.L7:
	.word	-2146762736
	.word	-2146697200
	.word	-2146762752
	.word	-2146697216
	.size	activate, .-activate
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #56
	ldr	sl, .L12
.L11:
	add	sl, pc, sl
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	str	r2, [fp, #-72]
	ldr	r3, [fp, #-68]
	str	r3, [fp, #-52]
	ldr	r2, [fp, #-52]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-52]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-52]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-52]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-52]
	mov	r3, #0
	str	r3, [r2, #16]
	ldr	r2, [fp, #-52]
	ldr	r3, .L12+4
	str	r3, [r2, #20]
	ldr	r2, [fp, #-52]
	mov	r3, #80
	str	r3, [r2, #24]
	ldr	r2, [fp, #-52]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, .L12+8
	ldr	r3, [sl, r3]
	mov	r2, #2195456
	add	r3, r3, r2
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #20]
	sub	r2, r3, #48
	ldr	r3, [fp, #-52]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-56]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, .L12+4
	str	r3, [r2, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-52]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-64]
	add	r2, r2, r3
	ldr	r3, [fp, #-52]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-64]
	add	r2, r2, r3
	ldr	r3, [fp, #-52]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-72]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #-72]
	str	r2, [r3, #0]
	mov	r3, #40
	str	r3, [fp, #-48]
	mov	r3, #56
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-60]
	ldr ip, =__SWI_HANDLER
	mov r3, ip
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-60]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-48]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-60]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	ldr	r3, .L12+12
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	mov	r3, #100663296
	str	r3, [r2, #0]
	ldr	r3, .L12+16
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-36]
	mov	r3, #524288
	str	r3, [r2, #0]
	ldr	r3, .L12+20
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, .L12+24
	str	r3, [r2, #0]
	ldr	r3, .L12+28
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-28]
	str	r2, [r3, #0]
	ldr	r3, .L12+32
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #0]
	orr	r2, r3, #16
	ldr	r3, [fp, #-24]
	str	r2, [r3, #0]
	ldr	r3, .L12+36
	str	r3, [fp, #-20]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L13:
	.align	2
.L12:
	.word	_GLOBAL_OFFSET_TABLE_-(.L11+8)
	.word	8384512
	.word	first(GOT)
	.word	-2146762736
	.word	-2146697200
	.word	-2139029376
	.word	5079
	.word	-2139029368
	.word	-2138243052
	.word	-2138308588
	.size	initialize, .-initialize
	.ident	"GCC: (GNU) 4.0.2"
