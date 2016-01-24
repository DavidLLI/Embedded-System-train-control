	.file	"taskDescriptor.c"
	.text
	.align	2
	.global	Create
	.type	Create, %function
Create:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
	.size	Create, .-Create
	.align	2
	.global	MyTid
	.type	MyTid, %function
MyTid:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldmfd	sp, {fp, sp, pc}
	.size	MyTid, .-MyTid
	.align	2
	.global	MyParentTid
	.type	MyParentTid, %function
MyParentTid:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldmfd	sp, {fp, sp, pc}
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
	ldmfd	sp, {fp, sp, pc}
	.size	Exit, .-Exit
	.section	.rodata
	.align	2
.LC0:
	.ascii	"first task enter.\012\015\000"
	.align	2
.LC1:
	.ascii	"first task exit.\012\015\000"
	.text
	.align	2
	.global	first
	.type	first, %function
first:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	sl, .L14
.L13:
	add	sl, pc, sl
	mov	r0, #1
	ldr	r3, .L14+4
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	mov	r0, #1
	ldr	r3, .L14+8
	add	r3, sl, r3
	mov	r1, r3
	bl	bwputstr(PLT)
	ldmfd	sp, {sl, fp, sp, pc}
.L15:
	.align	2
.L14:
	.word	_GLOBAL_OFFSET_TABLE_-(.L13+8)
	.word	.LC0(GOTOFF)
	.word	.LC1(GOTOFF)
	.size	first, .-first
	.ident	"GCC: (GNU) 4.0.2"
