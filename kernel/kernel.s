	.file	"kernel.c"
	.text
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
	b	.L2
.L3:
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
	beq	.L4
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-20]
.L6:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L4
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bne	.L8
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	b	.L10
.L8:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #36]
	str	r3, [fp, #-20]
	b	.L6
.L4:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L2:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L3
	mov	r3, #0
	str	r3, [fp, #-40]
.L10:
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
	beq	.L14
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
	b	.L17
.L14:
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
.L17:
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
	beq	.L24
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L21
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	b	.L23
.L21:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L23:
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
.L24:
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
	bne	.L26
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L26
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
	b	.L34
.L26:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L30
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
	b	.L34
.L30:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L32
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
	b	.L34
.L32:
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
.L34:
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
	b	.L36
.L37:
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
	beq	.L38
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	.L40
.L38:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L36:
	ldr	r3, [fp, #-16]
	cmp	r3, #87
	ble	.L37
	mov	r3, #0
	str	r3, [fp, #-24]
.L40:
	ldr	r3, [fp, #-24]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	getTaskDes, .-getTaskDes
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
	b	.L44
.L45:
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
.L44:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L45
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
	bne	.L49
	mov	r3, #1
	str	r3, [fp, #-24]
.L49:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	beq	.L51
	mov	r3, #1
	str	r3, [fp, #-20]
	b	.L53
.L54:
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
.L53:
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L54
	ldr	r3, [fp, #-28]
	mov	r2, #0
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	b	.L56
.L51:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L57
.L58:
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
.L57:
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L58
.L56:
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
	b	.L61
.L62:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L61:
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L63
	ldr	r3, [fp, #-16]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L62
.L63:
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
	b	.L67
.L68:
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
.L67:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	blt	.L68
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
	bge	.L72
	ldr	r3, [fp, #-24]
	rsb	r3, r3, #0
	str	r3, [fp, #-24]
.L72:
	mov	r3, #0
	str	r3, [fp, #-20]
.L74:
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r0, r2, r3
	ldr	r1, [fp, #-24]
	ldr	r3, .L79
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
	ldr	r3, .L79
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bgt	.L74
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L76
	ldr	r3, [fp, #-20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	mov	r3, #45
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L76:
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
.L80:
	.align	2
.L79:
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
	stmfd sp!, {r4-r9, lr}
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
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
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
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
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
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	mov r5, r3
	str	r3, [fp, #-16]
	swi #0
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
	swi #1
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
	swi #2
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
	swi #3
	ldmfd sp!, {r4-r9, lr}
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
	stmfd sp!, {r4-r9, lr}
	swi #4
	ldmfd sp!, {r4-r9, lr}
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
	ldr	sl, .L102
.L101:
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
	beq	.L98
	mov	r0, #1
	ldr	r3, .L102+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L98:
	sub	r3, fp, #132
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L103:
	.align	2
.L102:
	.word	_GLOBAL_OFFSET_TABLE_-(.L101+8)
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
	ldr	sl, .L109
.L108:
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
	beq	.L105
	mov	r0, #1
	ldr	r3, .L109+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L105:
	sub	r3, fp, #132
	mov	r0, r3
	bl	myAtoi(PLT)
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L110:
	.align	2
.L109:
	.word	_GLOBAL_OFFSET_TABLE_-(.L108+8)
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
	stmfd sp!, {r4-r9, lr}
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-16]
	mov r4, r3
	str	r3, [fp, #-16]
	swi #8
	ldmfd sp!, {r4-r9, lr}
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
	ldr	sl, .L135
.L134:
	add	sl, pc, sl
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-36]
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L133
.L114:
.L133:
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
	beq	.L115
	mov	r0, #1
	ldr	r3, .L135+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
.L115:
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
	beq	.L118
	ldr	r3, [fp, #-1040]
	cmp	r3, #1
	beq	.L119
	b	.L117
.L118:
	ldr	r3, [fp, #-32]
	cmp	r3, #20
	bgt	.L120
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
	bne	.L122
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
	b	.L124
.L122:
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
.L124:
	sub	r3, fp, #956
	mov	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L125
.L120:
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
.L125:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L114
.L119:
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-24]
	sub	r3, fp, #956
	mvn	r0, #0
	mov	r1, r3
	bl	myItoa(PLT)
	b	.L127
.L128:
	ldr	r2, [fp, #-24]
	sub	r3, fp, #1024
	sub	r3, r3, #12
	add	r3, r3, #8
	mov	r0, r2
	mov	r1, r3
	bl	myStrcmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L129
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #32]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	bl	myItoa(PLT)
	b	.L131
.L129:
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #40]
	str	r3, [fp, #-24]
.L127:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L128
.L131:
	ldr	r3, [fp, #-924]
	sub	r2, fp, #956
	mov	r0, r3
	mov	r1, r2
	mov	r2, #32
	bl	Reply(PLT)
	b	.L114
.L117:
	mov	r0, #1
	ldr	r3, .L135+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	b	.L114
.L136:
	.align	2
.L135:
	.word	_GLOBAL_OFFSET_TABLE_-(.L134+8)
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
	ldr	sl, .L140
.L139:
	add	sl, pc, sl
	ldr	r3, .L140+4
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
.L141:
	.align	2
.L140:
	.word	_GLOBAL_OFFSET_TABLE_-(.L139+8)
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
	ldr	sl, .L145
.L144:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	ldr	r3, .L145+4
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
.L146:
	.align	2
.L145:
	.word	_GLOBAL_OFFSET_TABLE_-(.L144+8)
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
	ldr	sl, .L150
.L149:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	ldr	r3, .L150+4
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
.L151:
	.align	2
.L150:
	.word	_GLOBAL_OFFSET_TABLE_-(.L149+8)
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
	b	.L153
.L154:
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	bgt	.L155
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L153:
	ldr	r3, [fp, #-28]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bgt	.L154
.L155:
	ldr	r3, [fp, #-28]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L157
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
	b	.L159
.L157:
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-20]
	b	.L160
.L161:
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
.L160:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L161
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
.L159:
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
	ldr	sl, .L168
.L167:
	add	sl, pc, sl
	ldr	r3, .L168+4
	add	r3, sl, r3
	mov	r0, r3
	bl	WhoIs(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
.L165:
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
	b	.L165
.L169:
	.align	2
.L168:
	.word	_GLOBAL_OFFSET_TABLE_-(.L167+8)
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
	ldr	sl, .L191
.L190:
	add	sl, pc, sl
	ldr	r3, .L191+4
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
	b	.L189
.L171:
.L189:
	sub	r3, fp, #748
	sub	r2, fp, #744
	mov	r0, r3
	mov	r1, r2
	mov	r2, #8
	bl	Receive(PLT)
	ldr	r3, [fp, #-744]
	cmp	r3, #3
	bne	.L172
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
	beq	.L171
	ldr	r2, [fp, #-732]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	bgt	.L171
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L177
.L178:
	ldr	r3, [fp, #-24]
	ldr	r2, .L191+8
	mov	r3, r3, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-28]
	cmp	r2, r3
	bgt	.L179
	ldr	r3, [fp, #-24]
	ldr	r2, .L191+12
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
.L177:
	ldr	r2, [fp, #-736]
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	blt	.L178
.L179:
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-20]
	b	.L181
.L182:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	rsb	r0, r3, r2
	ldr	r3, [fp, #-24]
	ldr	r2, .L191+8
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, .L191+8
	mov	r3, r0, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	rsb	r0, r3, r2
	ldr	r3, [fp, #-24]
	ldr	r2, .L191+12
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, .L191+12
	mov	r3, r0, asl #3
	sub	r0, fp, #16
	add	r3, r3, r0
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L181:
	ldr	r2, [fp, #-736]
	ldr	r3, [fp, #-24]
	cmp	r3, r2
	blt	.L182
	ldr	r3, [fp, #-736]
	ldr	r2, [fp, #-20]
	rsb	r3, r2, r3
	str	r3, [fp, #-736]
	b	.L171
.L172:
	ldr	r1, [fp, #-744]
	str	r1, [fp, #-756]
	ldr	r3, [fp, #-756]
	cmp	r3, #1
	beq	.L186
	ldr	r0, [fp, #-756]
	cmp	r0, #2
	beq	.L187
	ldr	r1, [fp, #-756]
	cmp	r1, #0
	beq	.L185
	b	.L171
.L185:
	ldr	r3, [fp, #-748]
	sub	r2, fp, #28
	mov	r0, r3
	mov	r1, r2
	mov	r2, #4
	bl	Reply(PLT)
	b	.L171
.L186:
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
	b	.L171
.L187:
	ldr	ip, [fp, #-740]
	ldr	lr, [fp, #-748]
	sub	r3, fp, #732
	sub	r2, fp, #736
	mov	r0, r3
	mov	r1, r2
	mov	r2, ip
	mov	r3, lr
	bl	add_wtid(PLT)
	b	.L171
.L192:
	.align	2
.L191:
	.word	_GLOBAL_OFFSET_TABLE_-(.L190+8)
	.word	.LC4(GOTOFF)
	.word	-716
	.word	-712
	.size	clockServer, .-clockServer
	.align	2
	.global	idle
	.type	idle, %function
idle:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
.L194:
	b	.L194
	.size	idle, .-idle
	.section	.rodata
	.align	2
.LC5:
	.ascii	"Tid: %d delayed %d ticks for %d time(s)\012\015\000"
	.align	2
.LC6:
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
	ldr	sl, .L202
.L201:
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
	b	.L197
.L198:
	ldr	r3, [fp, #-36]
	mov	r0, r3
	bl	Delay(PLT)
	ldr	ip, [fp, #-36]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [sp, #0]
	mov	r0, #1
	ldr	r3, .L202+4
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	mov	r3, ip
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L197:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bgt	.L198
	mov	r0, #1
	ldr	r3, .L202+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L203:
	.align	2
.L202:
	.word	_GLOBAL_OFFSET_TABLE_-(.L201+8)
	.word	.LC5(GOTOFF)
	.word	.LC6(GOTOFF)
	.size	client, .-client
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
	ldr	sl, .L207
.L206:
	add	sl, pc, sl
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L207+4
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #1
	ldr	r3, .L207+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #2
	ldr	r3, .L207+12
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r0, #31
	ldr	r3, .L207+16
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	mov	r0, #3
	ldr	r3, .L207+20
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	mov	r0, #4
	ldr	r3, .L207+20
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-28]
	mov	r0, #5
	ldr	r3, .L207+20
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-24]
	mov	r0, #6
	ldr	r3, .L207+20
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
.L208:
	.align	2
.L207:
	.word	_GLOBAL_OFFSET_TABLE_-(.L206+8)
	.word	nameServer(GOT)
	.word	clockServer(GOT)
	.word	clockNotifier(GOT)
	.word	idle(GOT)
	.word	client(GOT)
	.size	first, .-first
	.align	2
	.global	activate
	.type	activate, %function
activate:
	@ args = 0, pretend = 0, frame = 60
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #60
	str	r0, [fp, #-68]
	str	r1, [fp, #-72]
	mov	r3, #0
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-68]
	ldr	r3, [r3, #24]
	str	r3, [fp, #-44]
	msr spsr, r3
	str	r3, [fp, #-44]
	stmfd	sp!, {r4-r9}
stmfd	sp!, {fp}

	msr CPSR_c, #0xdf
	ldr	r3, [fp, #-68]
	ldr	r3, [r3, #20]
	str	r3, [fp, #-48]
	mov sp, r3
	str	r3, [fp, #-48]
	ldmfd	sp, {sp, lr}
	mov ip, lr
	msr cpsr, #0xd3
	mov lr, ip
	ldr	r3, .L215
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-36]
	mov	r3, #524288
	str	r3, [r2, #0]
	ldr	r3, [fp, #-68]
	ldr	r3, [r3, #28]
	str	r3, [fp, #-52]
	mov r0, r3
	str	r3, [fp, #-52]
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
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-36]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L215+4
	str	r3, [fp, #-32]
	ldr	r3, .L215+8
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-60]
	ldr	r3, .L215+12
	str	r3, [fp, #-24]
	ldr	r3, .L215+16
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-24]
	mvn	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-20]
	mvn	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-68]
	str	r2, [r3, #28]
	mov r3, r4
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #8]
	mov r3, r5
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #12]
	mov r3, r6
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #16]
	mov r3, r7
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #20]
	mov r3, r8
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #24]
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	bne	.L210
	ldr	r3, [fp, #-60]
	cmp	r3, #0
	beq	.L212
.L210:
	ldr	r2, [fp, #-72]
	mov	r3, #9
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #8]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #12]
	ldr	r3, .L215+20
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, #1
	str	r3, [r2, #0]
	b	.L213
.L212:
	ldr r2, [lr, #-4]
	ldr	r3, [fp, #-72]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-72]
	ldr	r3, [r3, #0]
	bic	r2, r3, #-16777216
	ldr	r3, [fp, #-72]
	str	r2, [r3, #0]
.L213:
	mov ip, lr
	msr cpsr, #0xdf
	mov lr, ip
	mov ip, sp
	stmfd sp!, {ip, lr}
	mov ip, sp
	msr cpsr, #0xd3
	ldmfd sp!, {r4-r9}
	mov r3, ip
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-64]
	mrs r3, spsr
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-40]
	mov	r2, r3
	ldr	r3, [fp, #-68]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-64]
	mov	r2, r3
	ldr	r3, [fp, #-68]
	str	r2, [r3, #24]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L216:
	.align	2
.L215:
	.word	-2146697200
	.word	-2146762752
	.word	-2146697216
	.word	-2146762732
	.word	-2146697196
	.word	-2139029364
	.size	activate, .-activate
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ args = 0, pretend = 0, frame = 44
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #44
	ldr	sl, .L220
.L219:
	add	sl, pc, sl
	str	r0, [fp, #-52]
	str	r1, [fp, #-56]
	str	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-40]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-40]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-40]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-40]
	mov	r3, #0
	str	r3, [r2, #16]
	ldr	r2, [fp, #-40]
	ldr	r3, .L220+4
	str	r3, [r2, #20]
	ldr	r2, [fp, #-40]
	mov	r3, #80
	str	r3, [r2, #24]
	ldr	r2, [fp, #-40]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, .L220+8
	ldr	r3, [sl, r3]
	mov	r2, #2195456
	add	r3, r3, r2
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #20]
	sub	r2, r3, #48
	ldr	r3, [fp, #-40]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-44]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, .L220+4
	str	r3, [r2, #0]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-40]
	str	r2, [r3, #20]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-52]
	add	r2, r2, r3
	ldr	r3, [fp, #-40]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-52]
	add	r2, r2, r3
	ldr	r3, [fp, #-40]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #-60]
	str	r2, [r3, #0]
	mov	r3, #40
	str	r3, [fp, #-36]
	mov	r3, #56
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-48]
	ldr ip, =__SWI_HANDLER
	mov r3, ip
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-48]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-36]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-48]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-32]
	str	r2, [r3, #0]
	ldr	r3, .L220+12
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-28]
	mov	r3, #524288
	str	r3, [r2, #0]
	ldr	r3, .L220+16
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	ldr	r3, .L220+20
	str	r3, [r2, #0]
	ldr	r3, .L220+24
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-20]
	str	r2, [r3, #0]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L221:
	.align	2
.L220:
	.word	_GLOBAL_OFFSET_TABLE_-(.L219+8)
	.word	8384512
	.word	first(GOT)
	.word	-2146697200
	.word	-2139029376
	.word	5079
	.word	-2139029368
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
	cmp	r3, #4
	addls	pc, pc, r3, asl #2
	b	.L230
	.p2align 2
.L229:
	b	.L224
	b	.L225
	b	.L226
	b	.L227
	b	.L228
.L224:
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
	add	r3, r3, #61440
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-24]
	mov	r3, #80
	str	r3, [r2, #24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, [fp, #16]
	add	r3, r3, #2195456
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #20]
	sub	r2, r3, #52
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
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
	b	.L230
.L225:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [r2, #28]
	b	.L230
.L226:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #16]
	str	r3, [r2, #28]
	b	.L230
.L227:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_movetoend(PLT)
	b	.L230
.L228:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_delete(PLT)
.L230:
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
	b	.L232
.L233:
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
.L232:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	blt	.L233
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
	beq	.L239
	ldr	r3, [fp, #-108]
	cmp	r3, #7
	beq	.L240
	ldr	r3, [fp, #-108]
	cmp	r3, #5
	beq	.L238
	b	.L264
.L238:
	ldr	r3, [fp, #12]
	str	r3, [fp, #-100]
	ldr	r3, [fp, #-100]
	cmp	r3, #0
	blt	.L241
	ldr	r3, [fp, #-100]
	cmp	r3, #87
	ble	.L243
.L241:
	ldr	r2, [fp, #8]
	mvn	r3, #0
	str	r3, [r2, #28]
	b	.L264
.L243:
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
	bne	.L244
	ldr	r2, [fp, #8]
	mvn	r3, #1
	str	r3, [r2, #28]
	b	.L264
.L244:
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
	bne	.L246
	ldr	r2, [fp, #8]
	mvn	r3, #2
	str	r3, [r2, #28]
	b	.L264
.L246:
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
	bne	.L248
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
	b	.L264
.L248:
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
	b	.L264
.L239:
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
	bne	.L251
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
	b	.L264
.L251:
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
	b	.L254
.L255:
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
.L254:
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r3, r2, r3
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L255
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #36]
	add	r2, r2, r3
	ldr	r3, [r2, #0]
	sub	r3, r3, #1
	str	r3, [r2, #0]
	b	.L264
.L240:
	ldr	r3, [fp, #12]
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-80]
	cmp	r3, #0
	blt	.L257
	ldr	r3, [fp, #-80]
	cmp	r3, #87
	ble	.L259
.L257:
	ldr	r2, [fp, #8]
	mvn	r3, #0
	str	r3, [r2, #28]
	b	.L264
.L259:
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
	bne	.L260
	ldr	r2, [fp, #8]
	mvn	r3, #1
	str	r3, [r2, #28]
	b	.L264
.L260:
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
	beq	.L262
	ldr	r2, [fp, #8]
	mvn	r3, #2
	str	r3, [r2, #28]
	b	.L264
.L262:
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
.L264:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	handle_msg_passing, .-handle_msg_passing
	.align	2
	.global	handle_block
	.type	handle_block, %function
handle_block:
	@ args = 28, pretend = 8, frame = 28
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #28
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	add	r1, fp, #4
	stmia	r1, {r2, r3}
	ldr	r3, [fp, #4]
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-40]
	cmp	r3, #8
	beq	.L267
	ldr	r3, [fp, #-40]
	cmp	r3, #9
	beq	.L268
	b	.L287
.L267:
	ldr	r2, [fp, #8]
	mov	r3, #6
	str	r3, [r2, #8]
	ldr	r3, [fp, #8]
	ldr	r2, [r3, #4]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	str	r3, [fp, #-28]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	str	r2, [r3, #0]
	ldr	r2, [fp, #12]
	ldr	r3, [fp, #-28]
	str	r2, [r3, #4]
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #-28]
	str	r2, [r3, #8]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #0]
	cmp	r3, #0
	beq	.L269
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L269
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #12]
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-28]
	str	r2, [r3, #16]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #4]
	b	.L287
.L269:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #16]
	b	.L287
.L268:
	ldr	r3, [fp, #16]
	cmp	r3, #0
	beq	.L273
	mov	r3, #0
	str	r3, [fp, #-24]
	ldr	r3, .L288
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, #524288
	str	r3, [r2, #0]
.L273:
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-20]
.L275:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L287
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bne	.L277
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #8]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #8]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L279
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L279
	ldr	r2, [fp, #-36]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	mov	r3, #0
	str	r3, [r2, #4]
	b	.L282
.L279:
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L283
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #12]
	ldr	r3, [fp, #-36]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #12]
	mov	r3, #0
	str	r3, [r2, #16]
	b	.L282
.L283:
	ldr	r3, [fp, #-36]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L285
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #16]
	ldr	r3, [fp, #-36]
	str	r2, [r3, #4]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #16]
	mov	r3, #0
	str	r3, [r2, #12]
	b	.L282
.L285:
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #16]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #12]
	str	r3, [r2, #12]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #12]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #16]
	str	r3, [r2, #16]
.L282:
	ldr	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [r2, #16]
.L277:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #12]
	str	r3, [fp, #-20]
	b	.L275
.L287:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L289:
	.align	2
.L288:
	.word	-2146697196
	.size	handle_block, .-handle_block
	.global	__udivsi3
	.global	__umodsi3
	.section	.rodata
	.align	2
.LC7:
	.ascii	"Idle percent: %d.%d\012\015\000"
	.align	2
.LC8:
	.ascii	"No more task to be scheduled. Kernel is exiting.\012"
	.ascii	"\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 99968
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #99328
	sub	sp, sp, #672
	ldr	sl, .L319
.L318:
	add	sl, pc, sl
	ldr	r3, .L319+4
	sub	r2, fp, #28
	str	r0, [r2, r3]
	ldr	r3, .L319+8
	sub	r2, fp, #28
	str	r1, [r2, r3]
	MRC	p15, 0, r1, c1, c0, 0
	ORR	r1, r1, #0x1
	ORR     r1, r1, #(0x1 << 2)
	ORR     r1, r1, #(0x1 << 12)
	MCR     p15, 0, r1, c1, c0, 0
	mov	r3, #0
	str	r3, [fp, #-64]
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L291
.L292:
	ldr	r3, [fp, #-60]
	ldr	r2, .L319+12
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	ldr	r2, .L319+16
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L291:
	ldr	r3, [fp, #-60]
	cmp	r3, #31
	ble	.L292
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L294
.L295:
	ldr	r2, [fp, #-56]
	ldr	r1, .L319+20
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #1
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L319+24
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L319+28
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L294:
	ldr	r3, [fp, #-56]
	cmp	r3, #87
	ble	.L295
	ldr	r3, .L319+32
	sub	r1, fp, #28
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L319+32
	sub	r1, fp, #28
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #4]
	.ltorg
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L297
.L298:
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+36
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+36
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
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+36
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
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+40
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #28
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+40
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
	ldr	r2, [fp, #-52]
	ldr	r1, .L319+40
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
	ldr	r3, [fp, #-52]
	ldr	r2, .L319+44
	mov	r3, r3, asl #2
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L297:
	ldr	r3, [fp, #-52]
	cmp	r3, #87
	ble	.L298
	mov	r0, #1
	mov	r1, #0
	bl	bwsetfifo(PLT)
	sub	r1, fp, #320
	sub	r3, fp, #3824
	sub	r3, r3, #12
	sub	r3, r3, #4
	sub	r2, fp, #64
	mov	r0, r1
	mov	r1, r3
	bl	initialize(PLT)
	ldr	r3, .L319+48
	str	r3, [fp, #-48]
	ldr	r3, .L319+52
	str	r3, [fp, #-44]
	ldr	r3, .L319+56
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	ldr	r2, .L319+60
	mov	r3, #0
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r2, .L319+64
	mov	r3, #0
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r2, .L319+68
	mov	r3, #1
	sub	r1, fp, #28
	str	r3, [r1, r2]
.L300:
	sub	r3, fp, #320
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L301
	ldr	r3, .L319+68
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #4
	bne	.L301
	ldr	r3, .L319+64
	sub	r1, fp, #28
	ldr	r2, [r1, r3]
	ldr	r3, .L319+72
	umull	r1, r3, r2, r3
	mov	r2, r3, lsr #3
	ldr	r3, .L319+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	mov	r0, r2
	mov	r1, r3
	bl	__udivsi3(PLT)
	mov	r3, r0
	mov	r4, r3
	ldr	r3, .L319+64
	sub	r1, fp, #28
	ldr	r2, [r1, r3]
	ldr	r3, .L319+72
	umull	r1, r3, r2, r3
	mov	r2, r3, lsr #3
	ldr	r3, .L319+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	mov	r0, r2
	mov	r1, r3
	bl	__umodsi3(PLT)
	mov	r3, r0
	mov	ip, r3
	mov	r0, #1
	ldr	r3, .L319+76
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	b	.L304
.L301:
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	bne	.L305
	mov	r0, #1
	ldr	r3, .L319+80
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	b	.L304
.L305:
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L307
	ldr	r2, [fp, #-48]
	ldr	r3, .L319+84
	str	r3, [r2, #0]
.L307:
	sub	r3, fp, #99328
	sub	r3, r3, #28
	sub	r3, r3, #628
	ldr	r0, [fp, #-36]
	mov	r1, r3
	bl	activate(PLT)
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L309
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	rsb	r3, r3, #5056
	add	r3, r3, #23
	ldr	r2, .L319+88
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r3, .L319+88
	sub	r2, fp, #28
	ldr	r1, [r2, r3]
	ldr	r3, .L319+92
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #1
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	mov	r2, r3
	ldr	r3, .L319+64
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r2, r3
	ldr	r3, .L319+64
	sub	r1, fp, #28
	str	r2, [r1, r3]
.L309:
	ldr	r3, .L319+96
	mov	r2, #4
	sub	r1, fp, #28
	add	r3, r1, r3
	add	r2, r3, r2
	ldr	r3, [fp, #-36]
	str	r3, [r2, #0]
	ldr	r3, .L319+96
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #9
	bne	.L311
	ldr	r3, .L319+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r3, #1
	ldr	r3, .L319+60
	sub	r1, fp, #28
	str	r2, [r1, r3]
	b	.L313
.L311:
	ldr	r3, .L319+96
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #0
	bne	.L314
	ldr	r3, .L319+68
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r3, #1
	ldr	r3, .L319+68
	sub	r1, fp, #28
	str	r2, [r1, r3]
	b	.L313
.L314:
	ldr	r3, .L319+96
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #4
	bne	.L313
	ldr	r3, .L319+68
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	sub	r2, r3, #1
	ldr	r3, .L319+68
	sub	r1, fp, #28
	str	r2, [r1, r3]
.L313:
	sub	r3, fp, #320
	mov	r0, r3
	ldr	r1, [fp, #-36]
	bl	pq_movetoend(PLT)
	sub	r6, fp, #320
	sub	r4, fp, #3824
	sub	r4, r4, #12
	sub	r4, r4, #4
	ldr	r5, .L319+96
	sub	r3, fp, #64
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
	sub	lr, fp, #3824
	sub	lr, lr, #12
	sub	lr, lr, #4
	ldr	r4, .L319+96
	sub	r3, fp, #97280
	sub	r3, r3, #28
	sub	r3, r3, #172
	str	r3, [sp, #16]
	sub	r3, fp, #99328
	sub	r3, r3, #28
	sub	r3, r3, #588
	str	r3, [sp, #20]
	sub	r3, fp, #98304
	sub	r3, r3, #28
	sub	r3, r3, #204
	str	r3, [sp, #24]
	sub	r3, fp, #99328
	sub	r3, r3, #28
	sub	r3, r3, #236
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
	sub	r4, fp, #5568
	sub	r4, r4, #28
	sub	r4, r4, #4
	sub	r5, fp, #5568
	sub	r5, r5, #28
	sub	r5, r5, #12
	ldr	r6, .L319+96
	mov	r2, #8
	sub	r1, fp, #28
	add	r3, r1, r6
	add	r3, r3, r2
	mov	lr, sp
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldr	r3, [ip, #0]
	str	r3, [lr, #0]
	sub	r2, fp, #28
	add	r3, r2, r6
	ldmia	r3, {r2, r3}
	mov	r0, r4
	mov	r1, r5
	bl	handle_block(PLT)
	b	.L300
.L304:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, sl, fp, sp, pc}
.L320:
	.align	2
.L319:
	.word	_GLOBAL_OFFSET_TABLE_-(.L318+8)
	.word	-99964
	.word	-99968
	.word	-292
	.word	-288
	.word	-3812
	.word	-3780
	.word	-3776
	.word	-5580
	.word	-98508
	.word	-99564
	.word	-99916
	.word	-2139029472
	.word	-2139029464
	.word	-2139029468
	.word	-99920
	.word	-99924
	.word	-99928
	.word	-858993459
	.word	.LC7(GOTOFF)
	.word	.LC8(GOTOFF)
	.word	5079
	.word	-99960
	.word	1717986919
	.word	-99956
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
