	.file	"kernel.c"
	.global	__udivsi3
	.global	__umodsi3
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Idle percent: %d.%d\012\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 99972
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #99328
	sub	sp, sp, #676
	ldr	sl, .L27
.L26:
	add	sl, pc, sl
	ldr	r3, .L27+4
	sub	r2, fp, #28
	str	r0, [r2, r3]
	ldr	r3, .L27+8
	sub	r2, fp, #28
	str	r1, [r2, r3]
	MRC	p15, 0, r1, c1, c0, 0
	ORR	r1, r1, #0x1
	ORR	r1, r1, #(0x1 << 2)
	ORR	r1, r1, #(0x1 << 12)
	MCR	p15, 0, r1, c1, c0, 0
	mov	r3, #0
	str	r3, [fp, #-64]
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L2
.L3:
	ldr	r3, [fp, #-60]
	ldr	r2, .L27+12
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	ldr	r2, .L27+16
	mov	r3, r3, asl #3
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L2:
	ldr	r3, [fp, #-60]
	cmp	r3, #31
	ble	.L3
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L5
.L6:
	ldr	r2, [fp, #-56]
	ldr	r1, .L27+20
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
	ldr	r1, .L27+24
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
	ldr	r1, .L27+28
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
.L5:
	ldr	r3, [fp, #-56]
	cmp	r3, #87
	ble	.L6
	ldr	r3, .L27+32
	sub	r1, fp, #28
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L27+32
	sub	r1, fp, #28
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #4]
	.ltorg
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L8
.L9:
	ldr	r2, [fp, #-52]
	ldr	r1, .L27+36
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
	ldr	r1, .L27+36
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
	ldr	r1, .L27+36
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
	ldr	r1, .L27+40
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
	ldr	r1, .L27+40
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
	ldr	r1, .L27+40
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
	ldr	r2, .L27+44
	mov	r3, r3, asl #2
	sub	r1, fp, #28
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L8:
	ldr	r3, [fp, #-52]
	cmp	r3, #87
	ble	.L9
	mov	r0, #1
	mov	r1, #0
	bl	setfifo(PLT)
	sub	r1, fp, #320
	sub	r3, fp, #3824
	sub	r3, r3, #12
	sub	r3, r3, #4
	sub	r2, fp, #64
	mov	r0, r1
	mov	r1, r3
	bl	initialize(PLT)
	ldr	r3, .L27+48
	str	r3, [fp, #-48]
	ldr	r3, .L27+52
	str	r3, [fp, #-44]
	ldr	r3, .L27+56
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	ldr	r2, .L27+60
	mov	r3, #0
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r2, .L27+64
	mov	r3, #0
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r2, .L27+68
	mov	r3, #1
	sub	r1, fp, #28
	str	r3, [r1, r2]
.L11:
	sub	r3, fp, #320
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L12
	ldr	r3, .L27+68
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #7
	bne	.L12
	ldr	r3, .L27+64
	sub	r1, fp, #28
	ldr	r2, [r1, r3]
	ldr	r3, .L27+72
	umull	r1, r3, r2, r3
	mov	r2, r3, lsr #3
	ldr	r3, .L27+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	mov	r0, r2
	mov	r1, r3
	bl	__udivsi3(PLT)
	mov	r3, r0
	mov	r4, r3
	ldr	r3, .L27+64
	sub	r1, fp, #28
	ldr	r2, [r1, r3]
	ldr	r3, .L27+72
	umull	r1, r3, r2, r3
	mov	r2, r3, lsr #3
	ldr	r3, .L27+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	mov	r0, r2
	mov	r1, r3
	bl	__umodsi3(PLT)
	mov	r3, r0
	mov	ip, r3
	mov	r0, #1
	ldr	r3, .L27+76
	add	r3, sl, r3
	mov	r1, r3
	mov	r2, r4
	mov	r3, ip
	bl	bwprintf(PLT)
	mov	r3, #0
	sub	r2, fp, #98304
	str	r3, [r2, #-1696]
	b	.L1
.L12:
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L15
	ldr	r2, [fp, #-48]
	ldr	r3, .L27+80
	str	r3, [r2, #0]
.L15:
	sub	r3, fp, #99328
	sub	r3, r3, #28
	sub	r3, r3, #628
	ldr	r0, [fp, #-36]
	mov	r1, r3
	bl	activate(PLT)
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L17
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	rsb	r3, r3, #5056
	add	r3, r3, #23
	ldr	r2, .L27+84
	sub	r1, fp, #28
	str	r3, [r1, r2]
	ldr	r3, .L27+84
	sub	r2, fp, #28
	ldr	r1, [r2, r3]
	ldr	r3, .L27+88
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #1
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	mov	r2, r3
	ldr	r3, .L27+64
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r2, r3
	ldr	r3, .L27+64
	sub	r1, fp, #28
	str	r2, [r1, r3]
.L17:
	ldr	r3, .L27+92
	mov	r2, #4
	sub	r1, fp, #28
	add	r3, r1, r3
	add	r2, r3, r2
	ldr	r3, [fp, #-36]
	str	r3, [r2, #0]
	ldr	r3, .L27+92
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #9
	bne	.L19
	ldr	r3, .L27+60
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r3, #1
	ldr	r3, .L27+60
	sub	r1, fp, #28
	str	r2, [r1, r3]
	b	.L21
.L19:
	ldr	r3, .L27+92
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #0
	bne	.L22
	ldr	r3, .L27+68
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	add	r2, r3, #1
	ldr	r3, .L27+68
	sub	r1, fp, #28
	str	r2, [r1, r3]
	b	.L21
.L22:
	ldr	r3, .L27+92
	sub	r2, fp, #28
	ldr	r3, [r2, r3]
	cmp	r3, #4
	bne	.L21
	ldr	r3, .L27+68
	sub	r1, fp, #28
	ldr	r3, [r1, r3]
	sub	r2, r3, #1
	ldr	r3, .L27+68
	sub	r1, fp, #28
	str	r2, [r1, r3]
.L21:
	sub	r3, fp, #320
	mov	r0, r3
	ldr	r1, [fp, #-36]
	bl	pq_movetoend(PLT)
	sub	r6, fp, #320
	sub	r4, fp, #3824
	sub	r4, r4, #12
	sub	r4, r4, #4
	ldr	r5, .L27+92
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
	ldr	r4, .L27+92
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
	ldr	r6, .L27+92
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
	b	.L11
.L1:
	sub	r3, fp, #98304
	ldr	r0, [r3, #-1696]
	sub	sp, fp, #28
	ldmfd	sp, {r4, r5, r6, sl, fp, sp, pc}
.L28:
	.align	2
.L27:
	.word	_GLOBAL_OFFSET_TABLE_-(.L26+8)
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
	.word	.LC0(GOTOFF)
	.word	5079
	.word	-99960
	.word	1717986919
	.word	-99956
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
