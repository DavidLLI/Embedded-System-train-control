	.file	"kernel.c"
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
	stmfd sp!, {r4-r9, fp}
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
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
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
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
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
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	swi #0
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
	swi #1
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
	swi #2
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
	swi #3
	ldmfd sp!, {r4-r9, fp}
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
	stmfd sp!, {r4-r9, fp}
	swi #4
	ldmfd sp!, {r4-r9, fp}
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
	ldr	sl, .L91
.L90:
	add	sl, pc, sl
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L89
.L70:
.L89:
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
	beq	.L71
	mov	r0, #1
	ldr	r3, .L91+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L71:
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
	beq	.L74
	ldr	r3, [fp, #-1040]
	cmp	r3, #1
	beq	.L75
	b	.L73
.L74:
	ldr	r3, [fp, #-32]
	cmp	r3, #20
	bgt	.L76
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
	bne	.L78
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
	b	.L80
.L78:
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
.L80:
	sub	r3, fp, #956
	mov	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L81
.L76:
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
.L81:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L70
.L75:
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-24]
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L83
.L84:
	ldr	r2, [fp, #-24]
	sub	r3, fp, #1024
	sub	r3, r3, #12
	add	r3, r3, #8
	mov	r0, r2
	mov	r1, r3
	bl	myStrcmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L85
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #32]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	bl	myItoa(PLT)
	b	.L87
.L85:
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #40]
	str	r3, [fp, #-24]
.L83:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L84
.L87:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L70
.L73:
	mov	r0, #1
	ldr	r3, .L91+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L70
.L92:
	.align	2
.L91:
	.word	_GLOBAL_OFFSET_TABLE_-(.L90+8)
	.word	.LC2(GOTOFF)
	.word	.LC3(GOTOFF)
	.size	nameServer, .-nameServer
	.section	.rodata
	.align	2
.LC4:
	.ascii	"\033[2J\000"
	.align	2
.LC6:
	.ascii	"\033[30;1H\033[Kerver before reveive.\012\015\000"
	.align	2
.LC7:
	.ascii	"\033[30;1H\033[Kerver after reveive.\012\015\000"
	.align	2
.LC8:
	.ascii	"\033[30;1H\033[Kplayer(), Send error.\012\015\000"
	.align	2
.LC9:
	.ascii	"\033[10;1H\033\000"
	.align	2
.LC10:
	.ascii	"\033[1;1H\033\000"
	.align	2
.LC11:
	.ascii	"Player %d\000"
	.align	2
.LC12:
	.ascii	"\033[30;1H\033[KServer: signup request, tid: %d, pi"
	.ascii	"d: %d\012\015\000"
	.align	2
.LC13:
	.ascii	"\033[30;1H\033[Kserver before reply.\012\015\000"
	.align	2
.LC14:
	.ascii	"\033[30;1H\033[KServer: play request, tid: %d, pid:"
	.ascii	" %d, choice: %d\012\015\000"
	.align	2
.LC15:
	.ascii	"\033[12;1H\033[K\000"
	.align	2
.LC16:
	.ascii	"\033[3;1H\033[K\000"
	.align	2
.LC17:
	.ascii	"ROCK\000"
	.align	2
.LC18:
	.ascii	"PAPER\000"
	.align	2
.LC19:
	.ascii	"SCISSORS\000"
	.align	2
.LC20:
	.ascii	"\033[15;1H\033[K\000"
	.align	2
.LC21:
	.ascii	"Server: play result, player tid %d and player tid %"
	.ascii	"d tie\012\015\000"
	.align	2
.LC22:
	.ascii	"Tie\000"
	.align	2
.LC23:
	.ascii	"Server: play result, player tid %d win and player t"
	.ascii	"id %d lose\012\015\000"
	.align	2
.LC24:
	.ascii	"Player 0 Win!\000"
	.align	2
.LC25:
	.ascii	"Server: play result, player tid %d lose and player "
	.ascii	"tid %d win\012\015\000"
	.align	2
.LC26:
	.ascii	"Player 1 Win!\000"
	.align	2
.LC5:
	.ascii	"RPS\000"
	.text
	.align	2
	.global	server
	.type	server, %function
server:
	@ args = 0, pretend = 0, frame = 368
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #372
	ldr	sl, .L127
.L126:
	add	sl, pc, sl
	mov	r0, #1
	ldr	r3, .L127+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, .L127+8
	add	r3, sl, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-44]
	sub	r3, fp, #44
	mov	r0, r3
	bl	RegisterAs(PLT)
	mov	r3, #0
	str	r3, [fp, #-40]
.L94:
	mov	r0, #1
	ldr	r3, .L127+12
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	sub	r3, fp, #372
	sub	r2, fp, #368
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Receive(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	mov	r0, #1
	ldr	r3, .L127+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-36]
	cmp	r3, #4
	beq	.L95
	mov	r0, #1
	ldr	r3, .L127+20
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L95:
	sub	r3, fp, #368
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	str	r2, [fp, #-380]
	ldr	r3, [fp, #-380]
	cmn	r3, #2
	beq	.L98
	ldr	r2, [fp, #-380]
	cmn	r2, #1
	beq	.L99
	b	.L97
.L98:
	ldr	r2, [fp, #-40]
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	mov	r3, r3, asl #4
	mov	r2, r3
	sub	r3, fp, #364
	add	r3, r3, r2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-40]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L100
	ldr	r2, [fp, #-372]
	ldr	r3, [fp, #-32]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #12]
	mov	r0, #1
	ldr	r3, .L127+24
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L102
.L100:
	ldr	r2, [fp, #-372]
	ldr	r3, [fp, #-32]
	str	r2, [r3, #0]
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #8]
	mov	r0, #1
	ldr	r3, .L127+28
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L102:
	mov	r0, #1
	ldr	r3, .L127+32
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-40]
	bl	bwprintf(PLT)
	ldr	r2, [fp, #-372]
	mov	r0, #1
	ldr	r3, .L127+36
	add	r3, sl, r3
	mov	r1, r3
	ldr	r3, [fp, #-40]
	bl	bwprintf(PLT)
	sub	r3, fp, #376
	ldr	r0, [fp, #-40]
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L127+40
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-372]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	mov	r0, #1
	ldr	r3, .L127+40
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L103
.L99:
	ldr	r1, [fp, #-24]
	ldr	r3, .L127+44
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-28]
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	mov	r3, r3, asl #4
	mov	r2, r3
	sub	r3, fp, #364
	add	r3, r3, r2
	str	r3, [fp, #-32]
	sub	r3, fp, #376
	mov	r0, #1
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-372]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	ldr	r3, [fp, #-40]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L104
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #4]
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #12]
	b	.L106
.L104:
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #8]
.L106:
	ldr	r3, [fp, #-40]
	sub	r3, r3, #1
	str	r3, [fp, #-40]
	b	.L103
.L97:
	ldr	r1, [fp, #-24]
	ldr	r3, .L127+44
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r2, r3, r2
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r3, r3, r1
	str	r3, [fp, #-20]
	ldr	r1, [fp, #-24]
	ldr	r3, .L127+44
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-372]
	ldr	r3, [fp, #-20]
	str	r3, [sp, #0]
	mov	r0, #1
	ldr	r3, .L127+48
	add	r3, sl, r3
	mov	r1, r3
	ldr	r3, [fp, #-28]
	bl	bwprintf(PLT)
	ldr	r2, [fp, #-28]
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	mov	r3, r3, asl #4
	mov	r2, r3
	sub	r3, fp, #364
	add	r3, r3, r2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-28]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L107
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #12]
	mov	r0, #1
	ldr	r3, .L127+52
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L109
.L107:
	mov	r0, #1
	ldr	r3, .L127+56
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L109:
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-384]
	ldr	r2, [fp, #-384]
	cmp	r2, #1
	beq	.L112
	ldr	r3, [fp, #-384]
	cmp	r3, #2
	beq	.L113
	ldr	r2, [fp, #-384]
	cmp	r2, #0
	beq	.L111
	b	.L110
.L111:
	mov	r0, #1
	ldr	r3, .L127+60
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L112:
	mov	r0, #1
	ldr	r3, .L127+64
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L113:
	mov	r0, #1
	ldr	r3, .L127+68
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L110:
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	blt	.L103
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	blt	.L103
	mov	r0, #1
	ldr	r3, .L127+72
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	cmp	r2, r3
	bne	.L116
	sub	r3, fp, #376
	mov	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	ldr	ip, [r3, #4]
	mov	r0, #1
	ldr	r3, .L127+76
	add	r3, sl, r3
	mov	r1, r3
	mov	r3, ip
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L127+80
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #0]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #4]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	b	.L118
.L116:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	rsb	r3, r3, r2
	cmn	r3, #1
	beq	.L119
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #8]
	cmp	r3, #3
	bne	.L121
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	cmp	r3, #0
	bne	.L121
.L119:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	ldr	ip, [r3, #4]
	mov	r0, #1
	ldr	r3, .L127+84
	add	r3, sl, r3
	mov	r1, r3
	mov	r3, ip
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L127+88
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	sub	r3, fp, #376
	mov	r0, #1
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #0]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	sub	r3, fp, #376
	mov	r0, #2
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #4]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	b	.L118
.L121:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	ldr	ip, [r3, #4]
	mov	r0, #1
	ldr	r3, .L127+92
	add	r3, sl, r3
	mov	r1, r3
	mov	r3, ip
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L127+96
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	sub	r3, fp, #376
	mov	r0, #2
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #0]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	sub	r3, fp, #376
	mov	r0, #1
	mov	r1, r3
	bl	myItoa(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #4]
	sub	r2, fp, #376
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
.L118:
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-32]
	mvn	r3, #0
	str	r3, [r2, #12]
.L103:
	ldr	r3, [fp, #-40]
	cmp	r3, #0
	beq	.L123
	b	.L94
.L123:
	bl	Exit(PLT)
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L128:
	.align	2
.L127:
	.word	_GLOBAL_OFFSET_TABLE_-(.L126+8)
	.word	.LC4(GOTOFF)
	.word	.LC5(GOTOFF)
	.word	.LC6(GOTOFF)
	.word	.LC7(GOTOFF)
	.word	.LC8(GOTOFF)
	.word	.LC9(GOTOFF)
	.word	.LC10(GOTOFF)
	.word	.LC11(GOTOFF)
	.word	.LC12(GOTOFF)
	.word	.LC13(GOTOFF)
	.word	1717986919
	.word	.LC14(GOTOFF)
	.word	.LC15(GOTOFF)
	.word	.LC16(GOTOFF)
	.word	.LC17(GOTOFF)
	.word	.LC18(GOTOFF)
	.word	.LC19(GOTOFF)
	.word	.LC20(GOTOFF)
	.word	.LC21(GOTOFF)
	.word	.LC22(GOTOFF)
	.word	.LC23(GOTOFF)
	.word	.LC24(GOTOFF)
	.word	.LC25(GOTOFF)
	.word	.LC26(GOTOFF)
	.size	server, .-server
	.section	.rodata
	.align	2
.LC27:
	.ascii	"Server id: %d\012\015\000"
	.align	2
.LC28:
	.ascii	"\033[30;1H\033[player before sent.\012\015\000"
	.align	2
.LC29:
	.ascii	"-2\000"
	.align	2
.LC30:
	.ascii	"\033[30;1H\033[player after sent.\012\015\000"
	.align	2
.LC31:
	.ascii	"\033[30;1H\033[Kplayer %d, Signup failed.\012\015\000"
	.align	2
.LC32:
	.ascii	"\033[30;1H\033[KPlayer id: %d, choice: %d, result: "
	.ascii	"tie\012\015\000"
	.align	2
.LC33:
	.ascii	"\033[30;1H\033[KPlayer id: %d, choice: %d, result: "
	.ascii	"win\012\015\000"
	.align	2
.LC34:
	.ascii	"\033[30;1H\033[KPlayer id: %d, choice: %d, result: "
	.ascii	"lose\012\015\000"
	.align	2
.LC35:
	.ascii	"\033[30;1H\033[KPlayer %d's turn, press enter to co"
	.ascii	"ntinue.\000"
	.align	2
.LC36:
	.ascii	"-1\000"
	.text
	.align	2
	.global	player
	.type	player, %function
player:
	@ args = 0, pretend = 0, frame = 44
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #48
	ldr	sl, .L148
.L147:
	add	sl, pc, sl
	ldr	r3, .L148+4
	str	r3, [fp, #-44]
	ldr	r3, .L148+8
	add	r3, sl, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-48]
	sub	r3, fp, #48
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L148+12
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-40]
	bl	bwprintf(PLT)
	mvn	r3, #0
	str	r3, [fp, #-36]
	mov	r0, #1
	ldr	r3, .L148+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	sub	ip, fp, #52
	mov	r3, #4
	str	r3, [sp, #0]
	ldr	r0, [fp, #-40]
	ldr	r3, .L148+20
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, #4
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	mov	r0, #1
	ldr	r3, .L148+24
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-32]
	cmp	r3, #4
	beq	.L130
	mov	r0, #1
	ldr	r3, .L148+28
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L130:
	sub	r3, fp, #52
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	cmp	r3, #0
	bge	.L132
	bl	MyTid(PLT)
	mov	r3, r0
	mov	r0, #1
	ldr	r2, .L148+32
	add	r2, sl, r2
	mov	r1, r2
	mov	r2, r3
	bl	bwprintf(PLT)
	b	.L146
.L132:
	sub	r3, fp, #52
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	b	.L146
.L134:
.L146:
	ldr	r3, [fp, #-44]
	ldr	r2, [r3, #0]
	ldr	r3, .L148+36
	smull	r0, r1, r3, r2
	mov	r3, r2, asr #31
	rsb	r1, r3, r1
	mov	r3, r1
	mov	r3, r3, asl #1
	add	r3, r3, r1
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	str	r3, [fp, #-24]
	sub	r3, fp, #56
	ldr	r0, [fp, #-24]
	mov	r1, r3
	bl	myItoa(PLT)
	sub	r2, fp, #56
	sub	ip, fp, #60
	mov	r3, #4
	str	r3, [sp, #0]
	ldr	r0, [fp, #-40]
	mov	r1, r2
	mov	r2, #4
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	cmp	r3, #4
	beq	.L135
	mov	r0, #1
	ldr	r3, .L148+28
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L135:
	sub	r3, fp, #60
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L137
	mov	r0, #1
	ldr	r3, .L148+40
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	bl	bwprintf(PLT)
	b	.L139
.L137:
	sub	r3, fp, #60
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	cmp	r3, #1
	bne	.L140
	mov	r0, #1
	ldr	r3, .L148+44
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	bl	bwprintf(PLT)
	b	.L139
.L140:
	sub	r3, fp, #60
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	cmp	r3, #2
	bne	.L139
	mov	r0, #1
	ldr	r3, .L148+48
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	bl	bwprintf(PLT)
.L139:
	mov	r0, #1
	ldr	r3, .L148+52
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-36]
	bl	bwprintf(PLT)
	mov	r0, #1
	bl	bwgetc(PLT)
	mov	r3, r0
	strb	r3, [fp, #-17]
	ldrb	r3, [fp, #-17]	@ zero_extendqisi2
	cmp	r3, #113
	bne	.L134
	sub	ip, fp, #52
	mov	r3, #4
	str	r3, [sp, #0]
	ldr	r0, [fp, #-40]
	ldr	r3, .L148+56
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, #4
	mov	r3, ip
	bl	Send(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	b	.L134
.L149:
	.align	2
.L148:
	.word	_GLOBAL_OFFSET_TABLE_-(.L147+8)
	.word	-2139029468
	.word	.LC5(GOTOFF)
	.word	.LC27(GOTOFF)
	.word	.LC28(GOTOFF)
	.word	.LC29(GOTOFF)
	.word	.LC30(GOTOFF)
	.word	.LC8(GOTOFF)
	.word	.LC31(GOTOFF)
	.word	1431655766
	.word	.LC32(GOTOFF)
	.word	.LC33(GOTOFF)
	.word	.LC34(GOTOFF)
	.word	.LC35(GOTOFF)
	.word	.LC36(GOTOFF)
	.size	player, .-player
	.section	.rodata
	.align	2
.LC37:
	.ascii	"Created name server: %d\012\015\000"
	.align	2
.LC38:
	.ascii	"server Created: %d\012\015\000"
	.align	2
.LC39:
	.ascii	"player 0 Created: %d\012\015\000"
	.align	2
.LC40:
	.ascii	"player 1 Created: %d\012\015\000"
	.text
	.align	2
	.global	first
	.type	first, %function
first:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	sl, .L153
.L152:
	add	sl, pc, sl
	ldr	r3, .L153+4
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	orr	r3, r3, #49920
	orr	r3, r3, #80
	ldr	r2, [fp, #-28]
	str	r3, [r2, #0]
	ldr	r3, .L153+8
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-24]
	str	r2, [r3, #0]
	mov	r0, #1
	ldr	r3, .L153+12
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L153+16
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #2
	ldr	r3, .L153+20
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L153+24
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #3
	ldr	r3, .L153+28
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L153+32
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #3
	ldr	r3, .L153+28
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L153+36
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L154:
	.align	2
.L153:
	.word	_GLOBAL_OFFSET_TABLE_-(.L152+8)
	.word	-2139029472
	.word	-2139029464
	.word	nameServer(GOT)
	.word	.LC37(GOTOFF)
	.word	server(GOT)
	.word	.LC38(GOTOFF)
	.word	player(GOT)
	.word	.LC39(GOTOFF)
	.word	.LC40(GOTOFF)
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
	b	.L156
.L157:
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
	beq	.L158
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-20]
.L160:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L158
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bne	.L162
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	b	.L164
.L162:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #36]
	str	r3, [fp, #-20]
	b	.L160
.L158:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L156:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L157
	mov	r3, #0
	str	r3, [fp, #-40]
.L164:
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
	beq	.L168
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
	b	.L171
.L168:
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
.L171:
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
	beq	.L178
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L175
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	b	.L177
.L175:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L177:
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
.L178:
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
	bne	.L180
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L180
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
	b	.L188
.L180:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L184
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
	b	.L188
.L184:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L186
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
	b	.L188
.L186:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L188:
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
	b	.L190
.L191:
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
	beq	.L192
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	.L194
.L192:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L190:
	ldr	r3, [fp, #-16]
	cmp	r3, #87
	ble	.L191
	mov	r3, #0
	str	r3, [fp, #-24]
.L194:
	ldr	r3, [fp, #-24]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	getTaskDes, .-getTaskDes
	.align	2
	.global	activate
	.type	activate, %function
activate:
	@ args = 0, pretend = 0, frame = 28
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #28
	str	r0, [fp, #-36]
	str	r1, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #24]
	str	r3, [fp, #-20]
	msr spsr, r3
	str	r3, [fp, #-20]
	stmfd	sp!, {fp}
	msr CPSR_c, #0xdf
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #20]
	str	r3, [fp, #-24]
	mov sp, r3
	str	r3, [fp, #-24]
	ldmfd	sp, {sp, lr}
	mov ip, lr
	msr cpsr, #0xd3
	mov lr, ip
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #28]
	str	r3, [fp, #-28]
	mov r0, r3
	str	r3, [fp, #-28]
	movs pc, lr
	__SWI_HANDLER:
	ldmfd sp!, {fp}
	mov r3, r4
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #8]
	mov r3, r5
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #12]
	mov r3, r6
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #16]
	mov r3, r7
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #20]
	mov r3, r8
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #24]
	ldr r2, [lr, #-4]
	ldr	r3, [fp, #-40]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #0]
	bic	r2, r3, #-16777216
	ldr	r3, [fp, #-40]
	str	r2, [r3, #0]
	mov ip, lr
	msr cpsr, #0xdf
	mov lr, ip
	mov ip, sp
	stmfd	sp!, {ip, lr}
	mov ip, sp
	msr cpsr, #0xd3
	mov r3, ip
	str	r3, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-32]
	mrs r3, spsr
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-36]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-32]
	mov	r2, r3
	ldr	r3, [fp, #-36]
	str	r2, [r3, #24]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	activate, .-activate
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ args = 0, pretend = 0, frame = 28
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #28
	ldr	sl, .L202
.L201:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	str	r1, [fp, #-40]
	str	r2, [fp, #-44]
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #16]
	ldr	r2, [fp, #-24]
	ldr	r3, .L202+4
	str	r3, [r2, #20]
	ldr	r2, [fp, #-24]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, .L202+8
	ldr	r3, [sl, r3]
	mov	r2, #2195456
	add	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, .L202+4
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-36]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-36]
	add	r2, r2, r3
	ldr	r3, [fp, #-24]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	mov	r3, #40
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-32]
	ldr ip, =__SWI_HANDLER
	mov r3, ip
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-20]
	str	r2, [r3, #0]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L203:
	.align	2
.L202:
	.word	_GLOBAL_OFFSET_TABLE_-(.L201+8)
	.word	8388352
	.word	first(GOT)
	.size	initialize, .-initialize
	.align	2
	.global	handle
	.type	handle, %function
handle:
	@ args = 32, pretend = 8, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #20
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	add	r1, fp, #4
	stmia	r1, {r2, r3}
	ldr	r3, [fp, #4]
	cmp	r3, #0
	bne	.L205
	ldr	r3, [fp, #32]
	ldr	r3, [r3, #0]
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #32]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r3, [fp, #12]
	mov	r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3, #12]
	ldr	r3, [fp, #8]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-24]
	str	r2, [r3, #16]
	ldr	r3, [fp, #32]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #12
	rsb	r3, r3, #8323072
	add	r3, r3, #65280
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-24]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, [fp, #16]
	add	r3, r3, #2195456
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
	ldr	r0, [fp, #-28]
	ldr	r1, [fp, #-24]
	bl	pq_insert(PLT)
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #32]
	ldr	r3, [r3, #0]
	str	r3, [r2, #28]
	ldr	r3, [fp, #32]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #32]
	str	r2, [r3, #0]
	b	.L214
.L205:
	ldr	r3, [fp, #4]
	sub	r3, r3, #1
	cmp	r3, #3
	addls	pc, pc, r3, asl #2
	b	.L214
	.p2align 2
.L213:
	b	.L209
	b	.L210
	b	.L211
	b	.L212
.L209:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [r2, #28]
	b	.L214
.L210:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #16]
	str	r3, [r2, #28]
	b	.L214
.L211:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_movetoend(PLT)
	b	.L214
.L212:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_delete(PLT)
.L214:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	handle, .-handle
	.align	2
	.global	memcpy
	.type	memcpy, %function
memcpy:
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
	b	.L216
.L217:
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
.L216:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L217
	ldr	r3, [fp, #-28]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	memcpy, .-memcpy
	.align	2
	.global	handle_msg_passing
	.type	handle_msg_passing, %function
handle_msg_passing:
	@ args = 44, pretend = 12, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #12
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #16
	sub	sp, sp, #96
	str	r0, [fp, #-104]
	add	r0, fp, #4
	stmia	r0, {r1, r2, r3}
	ldr	r3, [fp, #4]
	str	r3, [fp, #-108]
	ldr	r3, [fp, #-108]
	cmp	r3, #6
	beq	.L223
	ldr	r3, [fp, #-108]
	cmp	r3, #7
	beq	.L224
	ldr	r3, [fp, #-108]
	cmp	r3, #5
	beq	.L222
	b	.L248
.L222:
	ldr	r3, [fp, #12]
	str	r3, [fp, #-100]
	ldr	r3, [fp, #-100]
	cmp	r3, #0
	blt	.L225
	ldr	r3, [fp, #-100]
	cmp	r3, #87
	ble	.L227
.L225:
	ldr	r2, [fp, #8]
	mvn	r3, #0
	str	r3, [r2, #28]
	b	.L248
.L227:
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	cmp	r3, #1
	bne	.L228
	ldr	r2, [fp, #8]
	mvn	r3, #1
	str	r3, [r2, #28]
	b	.L248
.L228:
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	cmp	r3, #2
	bne	.L230
	ldr	r2, [fp, #8]
	mvn	r3, #2
	str	r3, [r2, #28]
	b	.L248
.L230:
	ldr	r3, [fp, #16]
	str	r3, [fp, #-96]
	ldr	r3, [fp, #20]
	str	r3, [fp, #-92]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-88]
	ldr	r2, [fp, #-88]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #44]
	add	r2, r2, r3
	ldr	r3, [fp, #24]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-88]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #44]
	add	r2, r2, r3
	ldr	r3, [fp, #28]
	str	r3, [r2, #8]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	cmp	r3, #4
	bne	.L232
	ldr	r2, [fp, #8]
	mov	r3, #5
	str	r3, [r2, #8]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r3, r2, r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-88]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r3, r2, r3
	ldr	r1, [r3, #4]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	mov	r0, r1
	ldr	r1, [fp, #-96]
	mov	r2, r3
	bl	memcpy(PLT)
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r2, r2, r3
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r2, r2, r3
	ldr	r3, [fp, #-92]
	str	r3, [r2, #28]
	b	.L248
.L232:
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-64]
	ldr	r2, [fp, #8]
	mov	r3, #3
	str	r3, [r2, #8]
	ldr	r3, [fp, #-100]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-60]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r2, r3, asl #2
	rsb	r2, r3, r2
	ldr	r3, [fp, #-60]
	add	r3, r2, r3
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r2, r2, r3
	ldr	r3, [fp, #-64]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r2, r3, asl #2
	rsb	r2, r3, r2
	ldr	r3, [fp, #-60]
	add	r3, r2, r3
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r2, r2, r3
	ldr	r3, [fp, #-96]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-100]
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r2, r3, asl #2
	rsb	r2, r3, r2
	ldr	r3, [fp, #-60]
	add	r3, r2, r3
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r2, r2, r3
	ldr	r3, [fp, #-92]
	str	r3, [r2, #8]
	ldr	r3, [fp, #-100]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r2, r2, r3
	ldr	r3, [r2, #0]
	add	r3, r3, #1
	str	r3, [r2, #0]
	b	.L248
.L223:
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-84]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L235
	ldr	r2, [fp, #8]
	mov	r3, #4
	str	r3, [r2, #8]
	ldr	r3, [fp, #12]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #16]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #20]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-44]
	ldr	r2, [fp, #-44]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r2, r2, r3
	ldr	r3, [fp, #-56]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-44]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r2, r2, r3
	ldr	r3, [fp, #-52]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-44]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #40]
	add	r2, r2, r3
	ldr	r3, [fp, #-48]
	str	r3, [r2, #8]
	b	.L248
.L235:
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	mov	r3, r2
	mov	r3, r3, asl #6
	add	r3, r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #12]
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-36]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-40]
	mov	r3, r2
	mov	r3, r3, asl #6
	add	r3, r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #16]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #20]
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-24]
	ldr	r1, [fp, #-28]
	ldr	r2, [fp, #-20]
	bl	memcpy(PLT)
	ldr	r1, [fp, #8]
	ldr	r2, [fp, #-40]
	mov	r3, r2
	mov	r3, r3, asl #6
	add	r3, r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	str	r3, [r1, #28]
	ldr	r2, [fp, #-36]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r2, r2, r3
	mov	r3, #5
	str	r3, [r2, #8]
	mov	r3, #1
	str	r3, [fp, #-16]
	b	.L238
.L239:
	ldr	r2, [fp, #-40]
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r2, r3, asl #2
	rsb	r2, r3, r2
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r3, r2, r3
	sub	r1, r3, #12
	ldr	r2, [fp, #-40]
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r2, r3, asl #2
	rsb	r2, r3, r2
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #32]
	add	r3, r2, r3
	mov	ip, r1
	ldmia	r3, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L238:
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r3, r2, r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L239
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r2, r2, r3
	ldr	r3, [r2, #0]
	sub	r3, r3, #1
	str	r3, [r2, #0]
	b	.L248
.L224:
	ldr	r3, [fp, #12]
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-80]
	cmp	r3, #0
	blt	.L241
	ldr	r3, [fp, #-80]
	cmp	r3, #87
	ble	.L243
.L241:
	ldr	r2, [fp, #8]
	mvn	r3, #0
	str	r3, [r2, #28]
	b	.L248
.L243:
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	cmp	r3, #1
	bne	.L244
	ldr	r2, [fp, #8]
	mvn	r3, #1
	str	r3, [r2, #28]
	b	.L248
.L244:
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	cmp	r3, #5
	beq	.L246
	ldr	r2, [fp, #8]
	mvn	r3, #2
	str	r3, [r2, #28]
	b	.L248
.L246:
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r2, r2, r3
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-104]
	add	r2, r2, r3
	ldr	r3, [fp, #20]
	str	r3, [r2, #28]
	ldr	r2, [fp, #8]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #44]
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	str	r3, [fp, #-76]
	ldr	r3, [fp, #16]
	str	r3, [fp, #-72]
	ldr	r2, [fp, #-80]
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #44]
	add	r3, r2, r3
	ldr	r3, [r3, #8]
	str	r3, [fp, #-68]
	ldr	r0, [fp, #-76]
	ldr	r1, [fp, #-72]
	ldr	r2, [fp, #-68]
	bl	memcpy(PLT)
.L248:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	handle_msg_passing, .-handle_msg_passing
	.section	.rodata
	.align	2
.LC41:
	.ascii	"No more task to be scheduled. Kernel is exiting.\012"
	.ascii	"\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 98172
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #97280
	sub	sp, sp, #924
	ldr	sl, .L264
.L263:
	add	sl, pc, sl
	ldr	r3, .L264+4
	sub	r2, fp, #28
	str	r0, [r2, r3]
	ldr	r3, .L264+8
	sub	r2, fp, #28
	str	r1, [r2, r3]
	mov	r3, #0
	str	r3, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L250
.L251:
	ldr	r3, [fp, #-44]
	ldr	r2, .L264+12
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-44]
	ldr	r2, .L264+16
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L250:
	ldr	r3, [fp, #-44]
	cmp	r3, #31
	ble	.L251
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L253
.L254:
	ldr	r2, [fp, #-40]
	ldr	r1, .L264+20
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #1
	str	r3, [r2, #0]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L253:
	ldr	r3, [fp, #-40]
	cmp	r3, #87
	ble	.L254
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L256
.L257:
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+24
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+24
	mov	r0, #4
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+24
	mov	r0, #8
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+28
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+28
	mov	r0, #4
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r1, .L264+28
	mov	r0, #8
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-36]
	ldr	r2, .L264+32
	mov	r3, r3, asl #2
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L256:
	ldr	r3, [fp, #-36]
	cmp	r3, #87
	ble	.L257
	mov	r0, #1
	mov	r1, #0
	bl	bwsetfifo(PLT)
	sub	r3, fp, #304
	sub	r2, fp, #3808
	sub	r2, r2, #12
	sub	r2, r2, #4
	sub	ip, fp, #48
	mov	r0, r3
	mov	r1, r2
	mov	r2, ip
	bl	initialize(PLT)
	.ltorg
.L259:
	sub	r3, fp, #304
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L260
	mov	r0, #1
	ldr	r3, .L264+36
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov	r3, #0
	sub	r2, fp, #94208
	str	r3, [r2, #-3992]
	b	.L249
.L260:
	.ltorg
	sub	r3, fp, #97280
	sub	r3, r3, #28
	sub	r3, r3, #880
	ldr	r0, [fp, #-32]
	mov	r1, r3
	bl	activate(PLT)
	ldr	r3, .L264+40
	mov	r2, #4
	sub	r1, fp, #28
	add	r3, r1, r3
	add	r2, r3, r2
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	.ltorg
	sub	r3, fp, #304
	mov	r0, r3
	ldr	r1, [fp, #-32]
	bl	pq_movetoend(PLT)
	sub	r6, fp, #304
	sub	r4, fp, #3808
	sub	r4, r4, #12
	sub	r4, r4, #4
	ldr	r5, .L264+40
	sub	r3, fp, #48
	str	r3, [sp, #20]
	mov	r2, #8
	sub	r1, fp, #28
	add	r3, r1, r5
	add	r3, r3, r2
	mov	lr, sp
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldr	r3, [ip, #0]
	str	r3, [lr, #0]
	sub	r2, fp, #28
	add	r3, r2, r5
	ldmia	r3, {r2, r3}
	mov	r0, r6
	mov	r1, r4
	bl	handle(PLT)
	sub	lr, fp, #3808
	sub	lr, lr, #12
	sub	lr, lr, #4
	ldr	r4, .L264+40
	sub	r3, fp, #95232
	sub	r3, r3, #28
	sub	r3, r3, #436
	str	r3, [sp, #16]
	sub	r3, fp, #97280
	sub	r3, r3, #28
	sub	r3, r3, #852
	str	r3, [sp, #20]
	sub	r3, fp, #96256
	sub	r3, r3, #28
	sub	r3, r3, #468
	str	r3, [sp, #24]
	sub	r3, fp, #97280
	sub	r3, r3, #28
	sub	r3, r3, #500
	str	r3, [sp, #28]
	mov	r2, #12
	sub	r1, fp, #28
	add	r3, r1, r4
	add	r3, r3, r2
	mov	ip, sp
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r2, fp, #28
	add	r3, r2, r4
	ldmia	r3, {r1, r2, r3}
	mov	r0, lr
	bl	handle_msg_passing(PLT)
	b	.L259
.L249:
	sub	r3, fp, #94208
	ldr	r0, [r3, #-3992]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, sl, fp, sp, pc}
.L265:
	.align	2
.L264:
	.word	_GLOBAL_OFFSET_TABLE_-(.L263+8)
	.word	-98164
	.word	-98168
	.word	-276
	.word	-272
	.word	-3796
	.word	-96724
	.word	-97780
	.word	-98132
	.word	.LC41(GOTOFF)
	.word	-98160
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
