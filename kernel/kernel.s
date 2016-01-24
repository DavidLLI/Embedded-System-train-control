	.file	"kernel.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"before swi\012\015\000"
	.align	2
.LC1:
	.ascii	"after swi\012\015\000"
	.text
	.align	2
	.global	Create
	.type	Create, %function
Create:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	sl, .L4
.L3:
	add	sl, pc, sl
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov r1, r3
	str	r3, [fp, #-24]
	mov r2, r3
	str	r3, [fp, #-28]
	mov	r0, #1
	ldr	r3, .L4+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	swi #0
	mov	r0, #1
	ldr	r3, .L4+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L5:
	.align	2
.L4:
	.word	_GLOBAL_OFFSET_TABLE_-(.L3+8)
	.word	.LC0(GOTOFF)
	.word	.LC1(GOTOFF)
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
	swi #1
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
	swi #2
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
	swi #3
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
	swi #4
	ldmfd	sp, {fp, sp, pc}
	.size	Exit, .-Exit
	.global	task_id_counter
	.bss
	.align	2
	.type	task_id_counter, %object
	.size	task_id_counter, 4
task_id_counter:
	.space	4
	.section	.rodata
	.align	2
.LC2:
	.ascii	"MyTid: %d, MyParentTid: %d\012\015\000"
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
	ldr	sl, .L17
.L16:
	add	sl, pc, sl
	bl	MyTid(PLT)
	mov	r4, r0
	bl	MyParentTid(PLT)
	mov	ip, r0
	mov	r0, #1
	ldr	r3, .L17+4
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
	ldr	r3, .L17+4
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	bl	Exit(PLT)
	ldmfd	sp, {r4, sl, fp, sp, pc}
.L18:
	.align	2
.L17:
	.word	_GLOBAL_OFFSET_TABLE_-(.L16+8)
	.word	.LC2(GOTOFF)
	.size	user, .-user
	.section	.rodata
	.align	2
.LC3:
	.ascii	"Enter first()\012\015\000"
	.align	2
.LC4:
	.ascii	"Created: %d\012\015\000"
	.align	2
.LC5:
	.ascii	"\342\200\230FirstUserTask: exiting\012\015\000"
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
	ldr	sl, .L22
.L21:
	add	sl, pc, sl
	mov	r0, #1
	ldr	r3, .L22+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov	r0, #2
	ldr	r3, .L22+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L22+12
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #2
	ldr	r3, .L22+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L22+12
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L22+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L22+12
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L22+8
	ldr	r3, [sl, r3]
	mov	r1, r3
	bl	Create(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L22+12
	add	r3, sl, r3
	mov	r1, r3
	ldr	r2, [fp, #-20]
	bl	bwprintf(PLT)
	mov	r0, #1
	ldr	r3, .L22+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	bl	Exit(PLT)
	ldmfd	sp, {r3, sl, fp, sp, pc}
.L23:
	.align	2
.L22:
	.word	_GLOBAL_OFFSET_TABLE_-(.L21+8)
	.word	.LC3(GOTOFF)
	.word	user(GOT)
	.word	.LC4(GOTOFF)
	.word	.LC5(GOTOFF)
	.size	first, .-first
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #24
	ldr	sl, .L27
.L26:
	add	sl, pc, sl
	str	r0, [fp, #-36]
	str	r1, [fp, #-40]
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L27+4
	ldr	r3, [sl, r3]
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
	ldr	r3, .L27+8
	str	r3, [r2, #20]
	ldr	r2, [fp, #-32]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-32]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, .L27+12
	ldr	r3, [sl, r3]
	add	r3, r3, #2195456
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	stmfd r2!, {r2, r3}
	ldr	r3, [fp, #-32]
	str	r2, [r3, #20]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #4]
	ldr	r3, .L27+4
	ldr	r3, [sl, r3]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, .L27+4
	ldr	r3, [sl, r3]
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
.L28:
	.align	2
.L27:
	.word	_GLOBAL_OFFSET_TABLE_-(.L26+8)
	.word	task_id_counter(GOT)
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
	b	.L30
.L31:
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
	beq	.L32
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-20]
.L34:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L32
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bne	.L36
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-40]
	b	.L38
.L36:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #36]
	str	r3, [fp, #-20]
	b	.L34
.L32:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L30:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L31
	mov	r3, #0
	str	r3, [fp, #-40]
.L38:
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
	beq	.L42
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
	b	.L45
.L42:
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
.L45:
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
	beq	.L52
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L49
	ldr	r3, [fp, #-24]
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-28]
	add	r2, r2, r3
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #0]
	b	.L51
.L49:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L51:
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
.L52:
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
	bne	.L54
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L54
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
	b	.L62
.L54:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L58
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
	b	.L62
.L58:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	bne	.L60
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
	b	.L62
.L60:
	ldr	r3, [fp, #-32]
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #36]
	str	r3, [r2, #36]
.L62:
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
	b	.L64
.L65:
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
	beq	.L66
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #3
	mov	r2, r3
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	.L68
.L66:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L64:
	ldr	r3, [fp, #-16]
	cmp	r3, #87
	ble	.L65
	mov	r3, #0
	str	r3, [fp, #-24]
.L68:
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
	mov r3, r0
	str	r3, [fp, #-32]
	mov r3, r1
	str	r3, [fp, #-28]
	ldr r2, [lr, #-4]
	ldr	r3, [fp, #-52]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L72
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-32]
	str	r3, [r2, #8]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-28]
	str	r3, [r2, #12]
.L72:
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
.LC6:
	.ascii	"create\012\015\000"
	.align	2
.LC7:
	.ascii	"not create\012\015\000"
	.text
	.align	2
	.global	handle
	.type	handle, %function
handle:
	@ args = 16, pretend = 8, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #16
	ldr	sl, .L87
.L86:
	add	sl, pc, sl
	str	r0, [fp, #-28]
	str	r1, [fp, #-32]
	add	r1, fp, #4
	stmia	r1, {r2, r3}
	ldr	r3, [fp, #4]
	cmp	r3, #0
	bne	.L76
	mov	r0, #1
	ldr	r3, .L87+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	ldr	r3, .L87+8
	ldr	r3, [sl, r3]
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
	ldr	r3, .L87+8
	ldr	r3, [sl, r3]
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
	ldr	r2, [r3, #16]
	ldr	r3, [fp, #-24]
	str	r2, [r3, #16]
	ldr	r2, [fp, #-24]
	ldr	r3, .L87+12
	str	r3, [r2, #20]
	ldr	r2, [fp, #-24]
	mov	r3, #208
	str	r3, [r2, #24]
	ldr	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [r2, #28]
	ldr	r3, [fp, #16]
	add	r3, r3, #2195456
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	stmfd r2!, {r2, r3}
	ldr	r3, [fp, #-24]
	str	r2, [r3, #20]
	ldr	r0, [fp, #-28]
	ldr	r1, [fp, #-24]
	bl	pq_insert(PLT)
	ldr	r2, [fp, #8]
	ldr	r3, .L87+8
	ldr	r3, [sl, r3]
	ldr	r3, [r3, #0]
	str	r3, [r2, #28]
	ldr	r3, .L87+8
	ldr	r3, [sl, r3]
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, .L87+8
	ldr	r3, [sl, r3]
	str	r2, [r3, #0]
	b	.L85
.L76:
	mov	r0, #1
	ldr	r3, .L87+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	ldr	r3, [fp, #4]
	sub	r3, r3, #1
	cmp	r3, #3
	addls	pc, pc, r3, asl #2
	b	.L85
	.p2align 2
.L84:
	b	.L80
	b	.L81
	b	.L82
	b	.L83
.L80:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #4]
	str	r3, [r2, #28]
	b	.L85
.L81:
	ldr	r2, [fp, #8]
	ldr	r3, [fp, #8]
	ldr	r3, [r3, #16]
	str	r3, [r2, #28]
	b	.L85
.L82:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_movetoend(PLT)
	b	.L85
.L83:
	ldr	r3, [fp, #8]
	ldr	r0, [fp, #-28]
	mov	r1, r3
	bl	pq_delete(PLT)
.L85:
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L88:
	.align	2
.L87:
	.word	_GLOBAL_OFFSET_TABLE_-(.L86+8)
	.word	.LC6(GOTOFF)
	.word	task_id_counter(GOT)
	.word	8388352
	.word	.LC7(GOTOFF)
	.size	handle, .-handle
	.section	.rodata
	.align	2
.LC8:
	.ascii	"loop start.\012\015\000"
	.align	2
.LC9:
	.ascii	"schedule return.\012\015\000"
	.align	2
.LC10:
	.ascii	"No more task to be scheduled. Kernel is exiting.\012"
	.ascii	"\015\000"
	.align	2
.LC11:
	.ascii	"activate return.\012\015\000"
	.align	2
.LC12:
	.ascii	"handle return.\012\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 3816
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #3824
	ldr	sl, .L101
.L100:
	add	sl, pc, sl
	str	r0, [fp, #-3824]
	str	r1, [fp, #-3828]
	mov	r3, #0
	str	r3, [fp, #-28]
	b	.L90
.L91:
	ldr	r3, [fp, #-28]
	ldr	r2, .L101+4
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	ldr	r2, .L101+8
	mov	r3, r3, asl #3
	sub	r1, fp, #16
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L90:
	ldr	r3, [fp, #-28]
	cmp	r3, #31
	ble	.L91
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L93
.L94:
	ldr	r2, [fp, #-24]
	ldr	r1, .L101+12
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
.L93:
	ldr	r3, [fp, #-24]
	cmp	r3, #87
	ble	.L94
	sub	r2, fp, #284
	sub	r3, fp, #3792
	sub	r3, r3, #12
	mov	r0, r2
	mov	r1, r3
	bl	initialize(PLT)
	mov	r0, #1
	mov	r1, #0
	bl	bwsetfifo(PLT)
.L96:
	mov	r0, #1
	ldr	r3, .L101+16
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	sub	r3, fp, #284
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r0, #1
	ldr	r3, .L101+20
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bne	.L97
	mov	r0, #1
	ldr	r3, .L101+24
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov	r3, #0
	str	r3, [fp, #-3832]
	b	.L89
.L97:
	sub	r3, fp, #3808
	sub	r3, r3, #12
	ldr	r0, [fp, #-20]
	mov	r1, r3
	bl	activate(PLT)
	mov	r0, #1
	ldr	r3, .L101+28
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	sub	lr, fp, #284
	sub	ip, fp, #3792
	sub	ip, ip, #12
	mov	r2, sp
	sub	r3, fp, #3808
	sub	r3, r3, #4
	ldmia	r3, {r0, r1}
	stmia	r2, {r0, r1}
	sub	r3, fp, #3808
	sub	r3, r3, #12
	ldmia	r3, {r2, r3}
	mov	r0, lr
	mov	r1, ip
	bl	handle(PLT)
	mov	r0, #1
	ldr	r3, .L101+32
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	b	.L96
.L89:
	ldr	r0, [fp, #-3832]
	sub	sp, fp, #16
	ldmfd	sp, {sl, fp, sp, pc}
.L102:
	.align	2
.L101:
	.word	_GLOBAL_OFFSET_TABLE_-(.L100+8)
	.word	-268
	.word	-264
	.word	-3788
	.word	.LC8(GOTOFF)
	.word	.LC9(GOTOFF)
	.word	.LC10(GOTOFF)
	.word	.LC11(GOTOFF)
	.word	.LC12(GOTOFF)
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
