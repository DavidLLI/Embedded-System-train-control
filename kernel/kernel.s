	.file	"kernel.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 100332
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #100352
	sub	sp, sp, #12
	ldr	r3, .L23
	sub	r2, fp, #24
	str	r0, [r2, r3]
	ldr	r3, .L23+4
	sub	r2, fp, #24
	str	r1, [r2, r3]
	MRC	p15, 0, r1, c1, c0, 0
	ORR	r1, r1, #0x1
	ORR	r1, r1, #(0x1 << 2)
	ORR	r1, r1, #(0x1 << 12)
	MCR	p15, 0, r1, c1, c0, 0
	mov	r3, #0
	str	r3, [fp, #-68]
	mov	r3, #0
	str	r3, [fp, #-64]
	b	.L2
.L3:
	ldr	r3, [fp, #-64]
	ldr	r2, .L23+8
	mov	r3, r3, asl #3
	sub	r1, fp, #24
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-64]
	ldr	r2, .L23+12
	mov	r3, r3, asl #3
	sub	r1, fp, #24
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
.L2:
	ldr	r3, [fp, #-64]
	cmp	r3, #31
	ble	.L3
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L5
.L6:
	ldr	r2, [fp, #-60]
	ldr	r1, .L23+16
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #1
	str	r3, [r2, #0]
	ldr	r2, [fp, #-60]
	ldr	r1, .L23+16
	mov	r0, #36
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-60]
	ldr	r1, .L23+16
	mov	r0, #40
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L5:
	ldr	r3, [fp, #-60]
	cmp	r3, #87
	ble	.L6
	ldr	r3, .L23+20
	sub	r1, fp, #24
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L23+20
	sub	r1, fp, #24
	add	r2, r1, r3
	mov	r3, #0
	str	r3, [r2, #4]
	.ltorg
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L8
.L9:
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+24
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+24
	mov	r0, #4
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+24
	mov	r0, #8
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+28
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r2, r3, r1
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+28
	mov	r0, #4
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r2, [fp, #-56]
	ldr	r1, .L23+28
	mov	r0, #8
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	mov	r3, r3, asl #2
	sub	r2, fp, #24
	add	r3, r3, r2
	add	r3, r3, r1
	add	r2, r3, r0
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-56]
	ldr	r2, .L23+32
	mov	r3, r3, asl #2
	sub	r1, fp, #24
	add	r3, r3, r1
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L8:
	ldr	r3, [fp, #-56]
	cmp	r3, #87
	ble	.L9
	mov	r0, #0
	mov	r1, #0
	bl	setfifo(PLT)
	mov	r0, #1
	mov	r1, #0
	bl	setfifo(PLT)
	mov	r0, #0
	mov	r1, #2400
	bl	setspeed(PLT)
	ldr	r3, .L23+36
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-52]
	ldr	r3, [r3, #0]
	orr	r2, r3, #8
	ldr	r3, [fp, #-52]
	str	r2, [r3, #0]
	sub	r1, fp, #324
	sub	r3, fp, #4160
	sub	r3, r3, #24
	sub	r3, r3, #12
	sub	r2, fp, #68
	mov	r0, r1
	mov	r1, r3
	bl	initialize(PLT)
	ldr	r3, .L23+40
	str	r3, [fp, #-48]
	ldr	r3, .L23+44
	str	r3, [fp, #-44]
	ldr	r3, .L23+48
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #0]
	orr	r2, r3, #200
	ldr	r3, [fp, #-44]
	str	r2, [r3, #0]
	ldr	r2, .L23+52
	mov	r3, #0
	sub	r1, fp, #24
	str	r3, [r1, r2]
	ldr	r2, .L23+56
	mov	r3, #1
	sub	r1, fp, #24
	str	r3, [r1, r2]
	mov	r3, #0
	str	r3, [fp, #-36]
	ldr	r2, .L23+60
	mov	r3, #1
	sub	r1, fp, #24
	str	r3, [r1, r2]
.L11:
	sub	r3, fp, #324
	mov	r0, r3
	bl	schedule(PLT)
	mov	r3, r0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L12
	ldr	r2, [fp, #-48]
	ldr	r3, .L23+64
	str	r3, [r2, #0]
.L12:
	sub	r3, fp, #99328
	sub	r3, r3, #24
	sub	r3, r3, #988
	ldr	r0, [fp, #-32]
	mov	r1, r3
	bl	activate(PLT)
	ldr	r3, [fp, #-32]
	ldr	r3, [r3, #12]
	cmp	r3, #31
	bne	.L14
	ldr	r3, [fp, #-40]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	rsb	r3, r3, #5056
	add	r3, r3, #23
	ldr	r2, .L23+68
	sub	r1, fp, #24
	str	r3, [r1, r2]
	ldr	r3, .L23+68
	sub	r2, fp, #24
	ldr	r1, [r2, r3]
	ldr	r3, .L23+72
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #1
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	mov	r2, r3
	ldr	r3, .L23+52
	sub	r1, fp, #24
	ldr	r3, [r1, r3]
	add	r2, r2, r3
	ldr	r3, .L23+52
	sub	r1, fp, #24
	str	r2, [r1, r3]
.L14:
	ldr	r3, .L23+76
	mov	r2, #4
	sub	r1, fp, #24
	add	r3, r1, r3
	add	r2, r3, r2
	ldr	r3, [fp, #-32]
	str	r3, [r2, #0]
	ldr	r3, .L23+76
	sub	r2, fp, #24
	ldr	r1, [r2, r3]
	sub	r2, fp, #98304
	str	r1, [r2, #-2052]
	sub	r2, fp, #98304
	ldr	r2, [r2, #-2052]
	cmp	r2, #10
	beq	.L17
	sub	r3, fp, #98304
	ldr	r3, [r3, #-2052]
	cmp	r3, #11
	beq	.L18
	b	.L16
.L17:
	ldr	r3, .L23+76
	mov	r2, #4
	sub	r1, fp, #24
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r2, [r3, #0]
	ldr	r3, .L23+52
	sub	r1, fp, #24
	ldr	r3, [r1, r3]
	str	r3, [r2, #28]
	b	.L16
.L18:
	mov	r3, #1
	str	r3, [fp, #-36]
.L16:
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	bne	.L22
	sub	r3, fp, #324
	mov	r0, r3
	ldr	r1, [fp, #-32]
	bl	pq_movetoend(PLT)
	sub	r6, fp, #324
	sub	r4, fp, #4160
	sub	r4, r4, #24
	sub	r4, r4, #12
	ldr	r5, .L23+76
	sub	r3, fp, #68
	str	r3, [sp, #20]
	mov	r2, #8
	sub	r1, fp, #24
	add	r3, r1, r5
	add	r3, r3, r2
	mov	lr, sp
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldr	r3, [ip, #0]
	str	r3, [lr, #0]
	sub	r2, fp, #24
	add	r3, r2, r5
	ldmia	r3, {r2, r3}
	mov	r0, r6
	mov	r1, r4
	bl	handle(PLT)
	sub	lr, fp, #4160
	sub	lr, lr, #24
	sub	lr, lr, #12
	ldr	r4, .L23+76
	sub	r3, fp, #97280
	sub	r3, r3, #24
	sub	r3, r3, #532
	str	r3, [sp, #16]
	sub	r3, fp, #99328
	sub	r3, r3, #24
	sub	r3, r3, #948
	str	r3, [sp, #20]
	sub	r3, fp, #98304
	sub	r3, r3, #24
	sub	r3, r3, #564
	str	r3, [sp, #24]
	sub	r3, fp, #99328
	sub	r3, r3, #24
	sub	r3, r3, #596
	str	r3, [sp, #28]
	mov	r2, #12
	sub	r1, fp, #24
	add	r3, r1, r4
	add	r3, r3, r2
	mov	ip, sp
	ldmia	r3, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	sub	r2, fp, #24
	add	r3, r2, r4
	ldmia	r3, {r1, r2, r3}
	mov	r0, lr
	bl	handle_msg_passing(PLT)
	sub	r4, fp, #5888
	sub	r4, r4, #24
	sub	r4, r4, #44
	sub	r5, fp, #5888
	sub	r5, r5, #24
	sub	r5, r5, #52
	ldr	r6, .L23+76
	sub	r3, fp, #99328
	sub	r3, r3, #24
	sub	r3, r3, #960
	str	r3, [sp, #20]
	mov	r2, #8
	sub	r1, fp, #24
	add	r3, r1, r6
	add	r3, r3, r2
	mov	lr, sp
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldr	r3, [ip, #0]
	str	r3, [lr, #0]
	sub	r2, fp, #24
	add	r3, r2, r6
	ldmia	r3, {r2, r3}
	mov	r0, r4
	mov	r1, r5
	bl	handle_block(PLT)
	b	.L11
.L22:
	sub	sp, fp, #24
	ldmfd	sp, {r4, r5, r6, fp, sp, pc}
.L24:
	.align	2
.L23:
	.word	-100324
	.word	-100328
	.word	-300
	.word	-296
	.word	-4172
	.word	-5940
	.word	-98868
	.word	-99924
	.word	-100276
	.word	-2138308600
	.word	-2139029472
	.word	-2139029464
	.word	-2139029468
	.word	-100280
	.word	-100284
	.word	-100288
	.word	5079
	.word	-100320
	.word	1717986919
	.word	-100316
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.2"
