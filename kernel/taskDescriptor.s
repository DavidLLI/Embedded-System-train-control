	.file	"taskDescriptor.c"
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
	ldr	r3, [r3, #40]
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
	str	r3, [r2, #40]
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #36]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #40]
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
	str	r3, [r2, #36]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #40]
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
	ldr	r3, [r3, #40]
	str	r3, [r2, #0]
	b	.L23
.L21:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #36]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #40]
	str	r3, [r2, #40]
.L23:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #36]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #40]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	str	r3, [r2, #4]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #40]
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
	ldr	r3, [r3, #40]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #40]
	mov	r3, #0
	str	r3, [r2, #36]
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
	ldr	r3, [r3, #36]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #36]
	mov	r3, #0
	str	r3, [r2, #40]
	b	.L34
.L32:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #36]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #40]
	str	r3, [r2, #40]
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #40]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
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
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
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
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
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
	.ident	"GCC: (GNU) 4.0.2"
