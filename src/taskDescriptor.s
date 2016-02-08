	.file	"taskDescriptor.c"
	.text
	.align	2
	.global	myMemCpy
	.type	myMemCpy, %function
myMemCpy:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	str	r2, [fp, #-36]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L2
.L3:
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r1, r2, r3
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	strb	r3, [r1, #0]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L2:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	myMemCpy, .-myMemCpy
	.align	2
	.global	myAtoi
	.type	myAtoi, %function
myAtoi:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-32]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #45
	bne	.L7
	mov	r3, #1
	str	r3, [fp, #-24]
.L7:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	beq	.L9
	mov	r3, #1
	str	r3, [fp, #-20]
	b	.L11
.L12:
	ldr	r2, [fp, #-28]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	mov	r1, r3
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	add	r3, r1, r3
	sub	r3, r3, #48
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L11:
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L12
	ldr	r3, [fp, #-28]
	mov	r2, #0
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	b	.L14
.L9:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L15
.L16:
	ldr	r2, [fp, #-28]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	mov	r1, r3
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	add	r3, r1, r3
	sub	r3, r3, #48
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L15:
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L16
.L14:
	ldr	r3, [fp, #-28]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	myAtoi, .-myAtoi
	.align	2
	.global	myStrcmp
	.type	myStrcmp, %function
myStrcmp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	b	.L19
.L20:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L19:
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L21
	ldr	r3, [fp, #-16]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L20
.L21:
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	rsb	r3, r3, r2
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	myStrcmp, .-myStrcmp
	.align	2
	.global	reverse
	.type	reverse, %function
reverse:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-32]
	sub	r3, r3, #1
	str	r3, [fp, #-20]
	b	.L25
.L26:
	ldr	r3, [fp, #-24]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]
	strb	r3, [fp, #-13]
	ldr	r3, [fp, #-24]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r1, r2, r3
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	strb	r3, [r1, #0]
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldrb	r3, [fp, #-13]
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	str	r3, [fp, #-20]
.L25:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	blt	.L26
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	reverse, .-reverse
	.align	2
	.global	myItoa
	.type	myItoa, %function
myItoa:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L30
	ldr	r3, [fp, #-24]
	rsb	r3, r3, #0
	str	r3, [fp, #-24]
.L30:
	mov	r3, #0
	str	r3, [fp, #-20]
.L32:
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r0, r2, r3
	ldr	r1, [fp, #-24]
	ldr	r3, .L37
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r2, r3, r2
	str	r2, [fp, #-32]
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #2
	ldr	r2, [fp, #-32]
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r1, r3, r1
	str	r1, [fp, #-32]
	ldr	r2, [fp, #-32]
	and	r3, r2, #255
	add	r3, r3, #48
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r0, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
	ldr	r1, [fp, #-24]
	ldr	r3, .L37
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bgt	.L32
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L34
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	mov	r3, #45
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L34:
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	mov	r3, #0
	strb	r3, [r2, #0]
	ldr	r0, [fp, #-28]
	ldr	r1, [fp, #-20]
	bl	reverse(PLT)
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L38:
	.align	2
.L37:
	.word	1717986919
	.size	myItoa, .-myItoa
	.align	2
	.global	Send
	.type	Send, %function
Send:
	@ args = 4, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	str	r3, [fp, #-36]
	stmfd sp!, {r4-r12}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-16]
	mov r6, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-16]
	mov r7, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #4]
	str	r3, [fp, #-16]
	mov r8, r3
	str	r3, [fp, #-16]
	swi #5
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	Send, .-Send
	.align	2
	.global	Receive
	.type	Receive, %function
Receive:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	stmfd sp!, {r4-r12}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-16]
	mov r6, r3
	str	r3, [fp, #-16]
	swi #6
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	Receive, .-Receive
	.align	2
	.global	Reply
	.type	Reply, %function
Reply:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	stmfd sp!, {r4-r12}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-16]
	mov r6, r3
	str	r3, [fp, #-16]
	swi #7
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	Reply, .-Reply
	.align	2
	.global	Create
	.type	Create, %function
Create:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #16
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	stmfd sp!, {r4-r12}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	swi #0
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	Create, .-Create
	.align	2
	.global	MyTid
	.type	MyTid, %function
MyTid:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	stmfd sp!, {r4-r12}
	swi #1
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mov	r0, r3
	ldmfd	sp, {r3, fp, sp, pc}
	.size	MyTid, .-MyTid
	.align	2
	.global	MyParentTid
	.type	MyParentTid, %function
MyParentTid:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	stmfd sp!, {r4-r12}
	swi #2
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mov	r0, r3
	ldmfd	sp, {r3, fp, sp, pc}
	.size	MyParentTid, .-MyParentTid
	.align	2
	.global	Pass
	.type	Pass, %function
Pass:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	stmfd sp!, {r4-r12}
	swi #3
	ldmfd sp!, {r4-r12}
	ldmfd	sp, {fp, sp, pc}
	.size	Pass, .-Pass
	.align	2
	.global	Exit
	.type	Exit, %function
Exit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	stmfd sp!, {r4-r12}
	swi #4
	ldmfd sp!, {r4-r12}
	ldmfd	sp, {fp, sp, pc}
	.size	Exit, .-Exit
	.section	.rodata
	.align	2
.LC0:
	.ascii	"RegisterAs(), Send error.\012\015\000"
	.text
	.align	2
	.global	RegisterAs
	.type	RegisterAs, %function
RegisterAs:
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #124
	ldr	sl, .L60
.L59:
	add	sl, pc, sl
	str	r0, [fp, #-136]
	mov	r3, #0
	str	r3, [fp, #-60]
	bl	MyTid(PLT)
	mov	r3, r0
	str	r3, [fp, #-56]
	sub	r3, fp, #60
	add	r3, r3, #8
	mov	r0, r3
	ldr	r1, [fp, #-136]
	mov	r2, #32
	bl	myMemCpy(PLT)
	sub	r3, fp, #100
	sub	r2, fp, #60
	mov	r0, r3
	mov	r1, r2
	mov	r2, #40
	bl	myMemCpy(PLT)
	sub	r2, fp, #100
	sub	ip, fp, #132
	mov	r3, #32
	str	r3, [sp, #0]
	mov	r0, #1
	mov	r1, r2
	mov	r2, #40
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmp	r3, #32
	beq	.L56
	mov	r0, #1
	ldr	r3, .L60+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L56:
	sub	r3, fp, #132
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L61:
	.align	2
.L60:
	.word	_GLOBAL_OFFSET_TABLE_-(.L59+8)
	.word	.LC0(GOTOFF)
	.size	RegisterAs, .-RegisterAs
	.section	.rodata
	.align	2
.LC1:
	.ascii	"WhoIs(), Send error.\012\015\000"
	.text
	.align	2
	.global	WhoIs
	.type	WhoIs, %function
WhoIs:
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #124
	ldr	sl, .L67
.L66:
	add	sl, pc, sl
	str	r0, [fp, #-136]
	mov	r3, #1
	str	r3, [fp, #-60]
	sub	r3, fp, #60
	add	r3, r3, #8
	mov	r0, r3
	ldr	r1, [fp, #-136]
	mov	r2, #32
	bl	myMemCpy(PLT)
	sub	r3, fp, #100
	sub	r2, fp, #60
	mov	r0, r3
	mov	r1, r2
	mov	r2, #40
	bl	myMemCpy(PLT)
	sub	r2, fp, #100
	sub	ip, fp, #132
	mov	r3, #32
	str	r3, [sp, #0]
	mov	r0, #1
	mov	r1, r2
	mov	r2, #40
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmp	r3, #32
	beq	.L63
	mov	r0, #1
	ldr	r3, .L67+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L63:
	sub	r3, fp, #132
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L68:
	.align	2
.L67:
	.word	_GLOBAL_OFFSET_TABLE_-(.L66+8)
	.word	.LC1(GOTOFF)
	.size	WhoIs, .-WhoIs
	.align	2
	.global	AwaitEvent
	.type	AwaitEvent, %function
AwaitEvent:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-24]
	stmfd sp!, {r4-r12}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	swi #8
	ldmfd sp!, {r4-r12}
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	AwaitEvent, .-AwaitEvent
	.section	.rodata
	.align	2
.LC2:
	.ascii	"nameServer(), reveive error.\012\015\000"
	.align	2
.LC3:
	.ascii	"Invalid request type\012\015\000"
	.text
	.align	2
	.global	nameServer
	.type	nameServer, %function
nameServer:
	@ args = 0, pretend = 0, frame = 1024
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #1024
	ldr	sl, .L93
.L92:
	add	sl, pc, sl
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L91
.L72:
.L91:
	sub	r3, fp, #924
	sub	r2, fp, #996
	mov	r0, r3
	mov	r1, r2
	mov	r2, #40
	bl	Receive(PLT)
	mov	r3, r0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	cmp	r3, #40
	beq	.L73
	mov	r0, #1
	ldr	r3, .L93+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L73:
	sub	r3, fp, #1024
	sub	r3, r3, #12
	sub	r2, fp, #996
	mov	r0, r3
	mov	r1, r2
	mov	r2, #40
	bl	myMemCpy(PLT)
	ldr	r3, [fp, #-1036]
	str	r3, [fp, #-1040]
	ldr	r3, [fp, #-1040]
	cmp	r3, #0
	beq	.L76
	ldr	r3, [fp, #-1040]
	cmp	r3, #1
	beq	.L77
	b	.L75
.L76:
	ldr	r3, [fp, #-32]
	cmp	r3, #20
	bgt	.L78
	ldr	r2, [fp, #-32]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	sub	r3, fp, #920
	add	r3, r3, r2
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-20]
	sub	r3, fp, #1024
	sub	r3, r3, #12
	add	r3, r3, #8
	mov	r0, r2
	mov	r1, r3
	mov	r2, #32
	bl	myMemCpy(PLT)
	ldr	r2, [fp, #-1032]
	ldr	r3, [fp, #-20]
	str	r2, [r3, #32]
	ldr	r3, [fp, #-40]
	cmp	r3, #0
	bne	.L80
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [r2, #36]
	ldr	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [r2, #40]
	b	.L82
.L80:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #40]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-36]
	str	r3, [r2, #36]
	ldr	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [r2, #40]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-36]
.L82:
	sub	r3, fp, #956
	mov	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L83
.L78:
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
.L83:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L72
.L77:
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-24]
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L85
.L86:
	ldr	r2, [fp, #-24]
	sub	r3, fp, #1024
	sub	r3, r3, #12
	add	r3, r3, #8
	mov	r0, r2
	mov	r1, r3
	bl	myStrcmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L87
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #32]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	bl	myItoa(PLT)
	b	.L89
.L87:
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #40]
	str	r3, [fp, #-24]
.L85:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L86
.L89:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L72
.L75:
	mov	r0, #1
	ldr	r3, .L93+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L72
.L94:
	.align	2
.L93:
	.word	_GLOBAL_OFFSET_TABLE_-(.L92+8)
	.word	.LC2(GOTOFF)
	.word	.LC3(GOTOFF)
	.size	nameServer, .-nameServer
	.section	.rodata
	.align	2
.LC4:
	.ascii	"ClockServer\000"
	.text
	.align	2
	.global	Time
	.type	Time, %function
Time:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	ldr	sl, .L98
.L97:
	add	sl, pc, sl
	ldr	r3, .L98+4
	add	r3, sl, r3
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-32]
	sub	r2, fp, #32
	sub	ip, fp, #24
	mov	r3, #4
	str	r3, [sp, #0]
	ldr	r0, [fp, #-20]
	mov	r1, r2
	mov	r2, #8
	mov	r3, ip
	bl	Send(PLT)
	ldr	r3, [fp, #-24]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L99:
	.align	2
.L98:
	.word	_GLOBAL_OFFSET_TABLE_-(.L97+8)
	.word	.LC4(GOTOFF)
	.size	Time, .-Time
	.align	2
	.global	Delay
	.type	Delay, %function
Delay:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	ldr	sl, .L103
.L102:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	ldr	r3, .L103+4
	add	r3, sl, r3
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #1
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-28]
	sub	r2, fp, #32
	sub	ip, fp, #21
	mov	r3, #1
	str	r3, [sp, #0]
	ldr	r0, [fp, #-20]
	mov	r1, r2
	mov	r2, #8
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L104:
	.align	2
.L103:
	.word	_GLOBAL_OFFSET_TABLE_-(.L102+8)
	.word	.LC4(GOTOFF)
	.size	Delay, .-Delay
	.align	2
	.global	DelayUntil
	.type	DelayUntil, %function
DelayUntil:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	ldr	sl, .L108
.L107:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	ldr	r3, .L108+4
	add	r3, sl, r3
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-28]
	sub	r2, fp, #32
	sub	ip, fp, #21
	mov	r3, #1
	str	r3, [sp, #0]
	ldr	r0, [fp, #-20]
	mov	r1, r2
	mov	r2, #8
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L109:
	.align	2
.L108:
	.word	_GLOBAL_OFFSET_TABLE_-(.L107+8)
	.word	.LC4(GOTOFF)
	.size	DelayUntil, .-DelayUntil
	.align	2
	.global	add_wtid
	.type	add_wtid, %function
add_wtid:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	str	r3, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L111
.L112:
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	bgt	.L113
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L111:
	ldr	r3, [fp, #-28]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bgt	.L112
.L113:
	ldr	r3, [fp, #-28]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L115
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-36]
	str	r3, [r2, #4]
	b	.L117
.L115:
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-20]
	b	.L118
.L119:
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r1, r2, r3
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	sub	r3, r3, #8
	ldr	r3, [r3, #0]
	str	r3, [r1, #0]
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r1, r2, r3
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	sub	r3, r3, #8
	ldr	r3, [r3, #4]
	str	r3, [r1, #4]
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	str	r3, [fp, #-20]
.L118:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L119
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-36]
	str	r3, [r2, #4]
.L117:
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #-28]
	str	r2, [r3, #0]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	add_wtid, .-add_wtid
	.align	2
	.global	clockNotifier
	.type	clockNotifier, %function
clockNotifier:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	ldr	sl, .L126
.L125:
	add	sl, pc, sl
	ldr	r3, .L126+4
	add	r3, sl, r3
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
.L123:
	mov	r0, #0
	bl	AwaitEvent(PLT)
	mov	r3, #3
	str	r3, [fp, #-28]
	sub	r2, fp, #28
	sub	ip, fp, #29
	mov	r3, #1
	str	r3, [sp, #0]
	ldr	r0, [fp, #-20]
	mov	r1, r2
	mov	r2, #8
	mov	r3, ip
	bl	Send(PLT)
	b	.L123
.L127:
	.align	2
.L126:
	.word	_GLOBAL_OFFSET_TABLE_-(.L125+8)
	.word	.LC4(GOTOFF)
	.size	clockNotifier, .-clockNotifier
	.align	2
	.global	clockServer
	.type	clockServer, %function
clockServer:
	@ args = 0, pretend = 0, frame = 740
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #740
	ldr	sl, .L149
.L148:
	add	sl, pc, sl
	ldr	r3, .L149+4
	add	r3, sl, r3
	mov	r0, r3
	bl	RegisterAs(PLT)
	mov	r3, #0
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-736]
	mov	r3, #0
	str	r3, [fp, #-748]
	mov	r3, #32
	strb	r3, [fp, #-749]
	b	.L147
.L129:
.L147:
	sub	r3, fp, #748
	sub	r2, fp, #744
	mov	r0, r3
	mov	r1, r2
	mov	r2, #8
	bl	Receive(PLT)
	ldr	r3, [fp, #-744]
	cmp	r3, #3
	bne	.L130
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-748]
	sub	r3, fp, #748
	sub	r3, r3, #1
	mov	r0, r2
	mov	r1, r3
	mov	r2, #1
	bl	Reply(PLT)
	ldr	r3, [fp, #-736]
	cmp	r3, #0
	beq	.L129
	ldr	r2, [fp, #-732]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	bgt	.L129
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L135
.L136:
	ldr	r3, [fp, #-24]
	ldr	r2, .L149+8
	mov	r3, r3, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	bgt	.L137
	ldr	r3, [fp, #-24]
	ldr	r2, .L149+12
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r2, [r3, #0]
	sub	r3, fp, #748
	sub	r3, r3, #1
	mov	r0, r2
	mov	r1, r3
	mov	r2, #1
	bl	Reply(PLT)
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L135:
	ldr	r2, [fp, #-736]
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	blt	.L136
.L137:
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-20]
	b	.L139
.L140:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	rsb	r0, r3, r2
	ldr	r3, [fp, #-24]
	ldr	r2, .L149+8
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, .L149+8
	mov	r3, r0, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	rsb	r0, r3, r2
	ldr	r3, [fp, #-24]
	ldr	r2, .L149+12
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, .L149+12
	mov	r3, r0, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L139:
	ldr	r2, [fp, #-736]
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	blt	.L140
	ldr	r3, [fp, #-736]
	ldr	r2, [fp, #-20]
	rsb	r3, r2, r3
	str	r3, [fp, #-736]
	b	.L129
.L130:
	ldr	r1, [fp, #-744]
	str	r1, [fp, #-756]
	ldr	r3, [fp, #-756]
	cmp	r3, #1
	beq	.L144
	ldr	r0, [fp, #-756]
	cmp	r0, #2
	beq	.L145
	ldr	r1, [fp, #-756]
	cmp	r1, #0
	beq	.L143
	b	.L129
.L143:
	ldr	r3, [fp, #-748]
	sub	r2, fp, #28
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	b	.L129
.L144:
	ldr	r2, [fp, #-740]
	ldr	r3, [fp, #-28]
	add	ip, r2, r3
	ldr	lr, [fp, #-748]
	sub	r3, fp, #732
	sub	r2, fp, #736
	mov	r0, r3
	mov	r1, r2
	mov	r2, ip
	mov	r3, lr
	bl	add_wtid(PLT)
	b	.L129
.L145:
	ldr	ip, [fp, #-740]
	ldr	lr, [fp, #-748]
	sub	r3, fp, #732
	sub	r2, fp, #736
	mov	r0, r3
	mov	r1, r2
	mov	r2, ip
	mov	r3, lr
	bl	add_wtid(PLT)
	b	.L129
.L150:
	.align	2
.L149:
	.word	_GLOBAL_OFFSET_TABLE_-(.L148+8)
	.word	.LC4(GOTOFF)
	.word	-716
	.word	-712
	.size	clockServer, .-clockServer
	.section	.rodata
	.align	2
.LC5:
	.ascii	"1--MyTid: %d, MyParentTid: %d\012\015\000"
	.align	2
.LC6:
	.ascii	"2--MyTid: %d, MyParentTid: %d\012\015\000"
	.text
	.align	2
	.global	user
	.type	user, %function
user:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	sl, .L154
.L153:
	add	sl, pc, sl
	bl	MyTid(PLT)
	mov	r4, r0
	bl	MyParentTid(PLT)
	mov	ip, r0
	mov	r0, #1
	ldr	r3, .L154+4
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	bl	Pass(PLT)
	bl	MyTid(PLT)
	mov	r4, r0
	bl	MyParentTid(PLT)
	mov	ip, r0
	mov	r0, #1
	ldr	r3, .L154+8
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	ldmfd	sp, {r4, sl, fp, sp, pc}
.L155:
	.align	2
.L154:
	.word	_GLOBAL_OFFSET_TABLE_-(.L153+8)
	.word	.LC5(GOTOFF)
	.word	.LC6(GOTOFF)
	.size	user, .-user
	.align	2
	.global	idle
	.type	idle, %function
idle:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
.L157:
	b	.L157
	.size	idle, .-idle
	.section	.rodata
	.align	2
.LC7:
	.ascii	"Tid: %d delayed %d ticks for %d time(s)\012\015\000"
	.align	2
.LC8:
	.ascii	"Client exiting\012\015\000"
	.text
	.align	2
	.global	client
	.type	client, %function
client:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	ldr	sl, .L165
.L164:
	add	sl, pc, sl
	mov	r3, #32
	strb	r3, [fp, #-25]
	sub	r2, fp, #25
	sub	ip, fp, #36
	mov	r3, #8
	str	r3, [sp, #0]
	mov	r0, #0
	mov	r1, r2
	mov	r2, #1
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, #0
	str	r3, [fp, #-24]
	bl	MyTid(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L160
.L161:
	ldr	r3, [fp, #-36]
	mov	r0, r3
	bl	Delay(PLT)
	ldr	ip, [fp, #-36]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [sp, #0]
	mov	r0, #1
	ldr	r3, .L165+4
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	mov	r3, ip
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L160:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bgt	.L161
	mov	r0, #1
	ldr	r3, .L165+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L166:
	.align	2
.L165:
	.word	_GLOBAL_OFFSET_TABLE_-(.L164+8)
	.word	.LC7(GOTOFF)
	.word	.LC8(GOTOFF)
	.size	client, .-client
	.section	.rodata
	.align	2
.LC9:
	.ascii	"first enter\012\015\000"
	.text
	.align	2
	.global	first
	.type	first, %function
first:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #64
	ldr	sl, .L170
.L169:
	add	sl, pc, sl
	mov	r0, #1
	ldr	r3, .L170+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L170+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L170+12
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #2
	ldr	r3, .L170+16
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #31
	ldr	r3, .L170+20
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	mov	r0, #3
	ldr	r3, .L170+24
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	mov	r0, #4
	ldr	r3, .L170+24
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-28]
	mov	r0, #5
	ldr	r3, .L170+24
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-24]
	mov	r0, #6
	ldr	r3, .L170+24
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	sub	r3, fp, #44
	sub	r2, fp, #45
	mov	r0, r3
	mov	r1, r2
	mov	r2, #1
	bl	Receive(PLT)
	sub	r3, fp, #44
	sub	r2, fp, #45
	mov	r0, r3
	mov	r1, r2
	mov	r2, #1
	bl	Receive(PLT)
	sub	r3, fp, #44
	sub	r2, fp, #45
	mov	r0, r3
	mov	r1, r2
	mov	r2, #1
	bl	Receive(PLT)
	sub	r3, fp, #44
	sub	r2, fp, #45
	mov	r0, r3
	mov	r1, r2
	mov	r2, #1
	bl	Receive(PLT)
	mov	r3, #10
	str	r3, [fp, #-56]
	mov	r3, #20
	str	r3, [fp, #-52]
	mov	r3, #23
	str	r3, [fp, #-64]
	mov	r3, #9
	str	r3, [fp, #-60]
	mov	r3, #33
	str	r3, [fp, #-72]
	mov	r3, #6
	str	r3, [fp, #-68]
	mov	r3, #71
	str	r3, [fp, #-80]
	mov	r3, #3
	str	r3, [fp, #-76]
	sub	r3, fp, #56
	ldr	r0, [fp, #-32]
	mov	r1, r3
	mov	r2, #8
	bl	Reply(PLT)
	sub	r3, fp, #64
	ldr	r0, [fp, #-28]
	mov	r1, r3
	mov	r2, #8
	bl	Reply(PLT)
	sub	r3, fp, #72
	ldr	r0, [fp, #-24]
	mov	r1, r3
	mov	r2, #8
	bl	Reply(PLT)
	sub	r3, fp, #80
	ldr	r0, [fp, #-20]
	mov	r1, r3
	mov	r2, #8
	bl	Reply(PLT)
	bl	Exit(PLT)
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L171:
	.align	2
.L170:
	.word	_GLOBAL_OFFSET_TABLE_-(.L169+8)
	.word	.LC9(GOTOFF)
	.word	nameServer(GOT)
	.word	clockServer(GOT)
	.word	clockNotifier(GOT)
	.word	idle(GOT)
	.word	client(GOT)
	.size	first, .-first
	.align	2
	.global	schedule
	.type	schedule, %function
schedule:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	str	r0, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L173
.L174:
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	ldmia	r3, {r3-r4}
	str	r3, [fp, #-32]
	str	r4, [fp, #-28]
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	beq	.L175
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-20]
.L177:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L175
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bne	.L179
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	b	.L181
.L179:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #36]
	str	r3, [fp, #-20]
	b	.L177
.L175:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L173:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L174
	mov	r3, #0
	str	r3, [fp, #-40]
.L181:
	ldr	r3, [fp, #-40]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {r4, fp, sp, pc}
	.size	schedule, .-schedule
	.align	2
	.global	pq_insert
	.type	pq_insert, %function
pq_insert:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #16
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #12]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L185
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #36]
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #32]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #36]
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-28]
	str	r3, [r2, #4]
	b	.L188
.L185:
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-28]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r2, r2, r3
	ldr	r3, [fp, #-28]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #32]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #36]
.L188:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	pq_insert, .-pq_insert
	.align	2
	.global	pq_movetoend
	.type	pq_movetoend, %function
pq_movetoend:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	beq	.L195
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L192
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	b	.L194
.L192:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L194:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #32]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #36]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #36]
.L195:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	pq_movetoend, .-pq_movetoend
	.align	2
	.global	pq_delete
	.type	pq_delete, %function
pq_delete:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r3, #2
	str	r3, [r2, #8]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L197
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L197
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	mov	r3, #0
	str	r3, [r2, #4]
	b	.L205
.L197:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L201
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #36]
	mov	r3, #0
	str	r3, [r2, #32]
	b	.L205
.L201:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L203
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #32]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	mov	r3, #0
	str	r3, [r2, #36]
	b	.L205
.L203:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #36]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #32]
	str	r3, [r2, #32]
.L205:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	pq_delete, .-pq_delete
	.align	2
	.global	getTaskDes
	.type	getTaskDes, %function
getTaskDes:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L207
.L208:
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	cmp	r3, #0
	beq	.L209
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	.L211
.L209:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L207:
	ldr	r3, [fp, #-16]
	cmp	r3, #87
	ble	.L208
	mov	r3, #0
	str	r3, [fp, #-24]
.L211:
	ldr	r3, [fp, #-24]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	getTaskDes, .-getTaskDes
	.section	.rodata
	.align	2
.LC10:
	.ascii	"first task enter.\012\015\000"
	.align	2
.LC11:
	.ascii	"first task exit.\012\015\000"
	.ident	"GCC: (GNU) 4.0.2"
