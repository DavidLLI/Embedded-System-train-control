	.file	"kernel.c"
	.text
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
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-20]
	mov r1, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-20]
	mov r2, r3
	str	r3, [fp, #-20]
	stmfd sp!, {fp}
	swi #0
	ldmfd sp!, {fp}
	mov r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
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
	stmfd sp!, {fp}
	swi #1
	ldmfd sp!, {fp}
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
	stmfd sp!, {fp}
	swi #2
	ldmfd sp!, {fp}
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
	stmfd sp!, {fp}
	swi #3
	ldmfd sp!, {fp}
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
	stmfd sp!, {fp}
	swi #4
	ldmfd sp!, {fp}
	ldmfd	sp, {fp, sp, pc}
	.size	Exit, .-Exit
	.section	.rodata
	.align	2
.LC0:
	.ascii	"1--MyTid: %d, MyParentTid: %d\012\015\000"
	.align	2
.LC1:
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
	ldr	sl, .L14
.L13:
	add	sl, pc, sl
	bl	MyTid(PLT)
	mov	r4, r0
	bl	MyParentTid(PLT)
	mov	ip, r0
	mov	r0, #1
	ldr	r3, .L14+4
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
	ldr	r3, .L14+8
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	ldmfd	sp, {r4, sl, fp, sp, pc}
.L15:
	.align	2
.L14:
	.word	_GLOBAL_OFFSET_TABLE_-(.L13+8)
	.word	.LC0(GOTOFF)
	.word	.LC1(GOTOFF)
	.size	user, .-user
	.section	.rodata
	.align	2
.LC2:
	.ascii	"Created: %d\012\015\000"
	.align	2
.LC3:
	.ascii	"FirstUserTask: exiting\012\015\000"
	.text
	.align	2
	.global	first
	.type	first, %function
first:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	sl, .L19
.L18:
	add	sl, pc, sl
	mov	r0, #2
	ldr	r3, .L19+4
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L19+8
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #2
	ldr	r3, .L19+4
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L19+8
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L19+4
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L19+8
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L19+4
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L19+8
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L19+12
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	bl	Exit(PLT)
	ldmfd	sp, {r3, sl, fp, sp, pc}
.L20:
	.align	2
.L19:
	.word	_GLOBAL_OFFSET_TABLE_-(.L18+8)
	.word	user(GOT)
	.word	.LC2(GOTOFF)
	.word	.LC3(GOTOFF)
	.size	first, .-first
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
	ldr	sl, .L24
.L23:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	str	r1, [fp, #-40]
	str	r2, [fp, #-44]
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-32]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #12]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #16]
	ldr	r2, [fp, #-32]
	ldr	r3, .L24+4
	str	r3, [r2, #20]
	ldr	r2, [fp, #-32]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, .L24+8
	ldr	r3, [sl, r3]
	mov	r2, #2195456
	add	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, .L24+4
	str	r3, [r2, #0]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-32]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	mov	r3, #40
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
	ldr ip, =__SWI_HANDLER
	mov r3, ip
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	add	r2, r3, #2195456
	ldr	r3, [fp, #-24]
	str	r2, [r3, #0]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L25:
	.align	2
.L24:
	.word	_GLOBAL_OFFSET_TABLE_-(.L23+8)
	.word	8388352
	.word	first(GOT)
	.size	initialize, .-initialize
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
	b	.L27
.L28:
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
	beq	.L29
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-20]
.L31:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L29
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bne	.L33
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	b	.L35
.L33:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #36]
	str	r3, [fp, #-20]
	b	.L31
.L29:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L27:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L28
	mov	r3, #0
	str	r3, [fp, #-40]
.L35:
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
	beq	.L39
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
	b	.L42
.L39:
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
.L42:
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
	beq	.L49
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L46
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	b	.L48
.L46:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L48:
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
.L49:
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
	bne	.L51
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L51
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
	b	.L59
.L51:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L55
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
	b	.L59
.L55:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L57
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
	b	.L59
.L57:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L59:
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
	b	.L61
.L62:
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
	beq	.L63
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	.L65
.L63:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L61:
	ldr	r3, [fp, #-16]
	cmp	r3, #87
	ble	.L62
	mov	r3, #0
	str	r3, [fp, #-24]
.L65:
	ldr	r3, [fp, #-24]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	getTaskDes, .-getTaskDes
	.align	2
	.global	activate
	.type	activate, %function
activate:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #40
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #24]
	str	r3, [fp, #-44]
	msr spsr, r3
	str	r3, [fp, #-44]
	stmfd	sp!, {fp}
	msr CPSR_c, #0xdf
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #20]
	str	r3, [fp, #-40]
	mov sp, r3
	str	r3, [fp, #-40]
	ldmfd	sp, {sp, lr}
	mov ip, lr
	msr cpsr, #0xd3
	mov lr, ip
	ldr	r3, [fp, #-48]
	ldr	r3, [r3, #28]
	str	r3, [fp, #-36]
	mov r0, r3
	str	r3, [fp, #-36]
	movs pc, lr
	__SWI_HANDLER:
	ldmfd sp, {fp}
	mov	r3, #0
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-28]
	mov r3, r1
	str	r3, [fp, #-32]
	mov r3, r2
	str	r3, [fp, #-28]
	ldr r2, [lr, #-4]
	ldr	r3, [fp, #-52]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #0]
	bic	r2, r3, #-16777216
	ldr	r3, [fp, #-52]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L69
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #8]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #12]
.L69:
	mov ip, lr
	mov	r3, #0
	str	r3, [fp, #-24]
	mov r3, lr
	str	r3, [fp, #-24]
	msr cpsr, #0xdf
	mov lr, ip
	mov ip, sp
	stmfd	sp!, {ip, lr}
	mov	r3, #0
	str	r3, [fp, #-20]
	mov r3, sp
	str	r3, [fp, #-20]
	msr cpsr, #0xd3
	mov	r3, #0
	str	r3, [fp, #-16]
	mrs r3, spsr
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-48]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-48]
	str	r2, [r3, #24]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	activate, .-activate
	.section	.rodata
	.align	2
.LC4:
	.ascii	"id: %d\012\015\000"
	.text
	.align	2
	.global	handle
	.type	handle, %function
handle:
	@ args = 20, pretend = 8, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #20
	ldr	sl, .L84
.L83:
	add	sl, pc, sl
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	add	r1, fp, #4
	stmia	r1, {r2, r3}
	ldr	r3, [fp, #4]
	cmp	r3, #0
	bne	.L73
	ldr	r3, [fp, #20]
	ldr	r3, [r3, #0]
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #20]
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	str	r2, [r3, #4]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #8]
	ldr	r3, [fp, #12]
	mov	r2, r3
	ldr	r3, [fp, #-28]
	str	r2, [r3, #12]
	ldr	r3, [fp, #8]
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-28]
	str	r2, [r3, #16]
	ldr	r3, [fp, #20]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #12
	rsb	r3, r3, #8323072
	add	r3, r3, #65280
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-28]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-28]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, [fp, #16]
	add	r3, r3, #2195456
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #20]
	mov	r2, r3
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-24]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3, #20]
	sub	r2, r3, #4
	ldr	r3, [fp, #-28]
	str	r2, [r3, #20]
	ldr	r0, [fp, #-32]
	ldr	r1, [fp, #-28]
	bl	pq_insert(PLT)
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #20]
	ldr	r3, [r3, #0]
	str	r3, [r2, #28]
	ldr	r3, [fp, #20]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, [fp, #20]
	str	r2, [r3, #0]
	b	.L82
.L73:
	ldr	r3, [fp, #4]
	sub	r3, r3, #1
	cmp	r3, #3
	addls	pc, pc, r3, asl #2
	b	.L82
	.p2align 2
.L81:
	b	.L77
	b	.L78
	b	.L79
	b	.L80
.L77:
	ldr	r3, [fp, #8]
	ldr	r2, [r3, #4]
	mov	r0, #1
	ldr	r3, .L84+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [r2, #28]
	b	.L82
.L78:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #16]
	str	r3, [r2, #28]
	b	.L82
.L79:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-32]
	mov	r1, r3
	bl	pq_movetoend(PLT)
	b	.L82
.L80:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-32]
	mov	r1, r3
	bl	pq_delete(PLT)
.L82:
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L85:
	.align	2
.L84:
	.word	_GLOBAL_OFFSET_TABLE_-(.L83+8)
	.word	.LC4(GOTOFF)
	.size	handle, .-handle
	.section	.rodata
	.align	2
.LC5:
	.ascii	"activate task %d.\012\015\000"
	.align	2
.LC6:
	.ascii	"No more task to be scheduled. Kernel is exiting.\012"
	.ascii	"\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 3820
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #3824
	sub	sp, sp, #8
	ldr	sl, .L98
.L97:
	add	sl, pc, sl
	str	r0, [fp, #-3828]
	str	r1, [fp, #-3832]
	mov	r3, #0
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-28]
	b	.L87
.L88:
	ldr	r3, [fp, #-28]
	ldr	r2, .L98+4
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	ldr	r2, .L98+8
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L87:
	ldr	r3, [fp, #-28]
	cmp	r3, #31
	ble	.L88
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L90
.L91:
	ldr	r2, [fp, #-24]
	ldr	r1, .L98+12
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	sub	r2, fp, #16
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #1
	str	r3, [r2, #0]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L90:
	ldr	r3, [fp, #-24]
	cmp	r3, #87
	ble	.L91
	mov	r0, #1
	mov	r1, #0
	bl	bwsetfifo(PLT)
	sub	r3, fp, #288
	sub	r2, fp, #3808
	sub	ip, fp, #32
	mov	r0, r3
	mov	r1, r2
	mov	r2, ip
	bl	initialize(PLT)
.L93:
	sub	r3, fp, #288
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	ldr	r2, [r3, #4]
	mov	r0, #1
	ldr	r3, .L98+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwprintf(PLT)
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bne	.L94
	mov	r0, #1
	ldr	r3, .L98+20
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov	r3, #0
	str	r3, [fp, #-3836]
	b	.L86
.L94:
	sub	r3, fp, #3824
	ldr	r0, [fp, #-20]
	mov	r1, r3
	bl	activate(PLT)
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-3820]
	sub	r3, fp, #288
	mov	r0, r3
	ldr	r1, [fp, #-20]
	bl	pq_movetoend(PLT)
	sub	ip, fp, #288
	sub	lr, fp, #3808
	sub	r3, fp, #32
	str	r3, [sp, #8]
	mov	r2, sp
	sub	r3, fp, #3808
	sub	r3, r3, #8
	ldmia	r3, {r0, r1}
	stmia	r2, {r0, r1}
	sub	r3, fp, #3824
	ldmia	r3, {r2, r3}
	mov	r0, ip
	mov	r1, lr
	bl	handle(PLT)
	b	.L93
.L86:
	ldr	r0, [fp, #-3836]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L99:
	.align	2
.L98:
	.word	_GLOBAL_OFFSET_TABLE_-(.L97+8)
	.word	-272
	.word	-268
	.word	-3792
	.word	.LC5(GOTOFF)
	.word	.LC6(GOTOFF)
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
