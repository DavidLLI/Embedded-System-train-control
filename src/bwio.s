	.file	"bwio.c"
	.text
	.align	2
	.global	bwsetfifo
	.type	bwsetfifo, %function
bwsetfifo:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	@ lr needed for prologue
	ldr	ip, .L12
	beq	.L6
	cmp	r0, #1
	add	ip, ip, #65536
	mvn	r0, #0
	bxne	lr
.L6:
	ldr	r3, [ip, #0]
	cmp	r1, #0
	orr	r2, r3, #16
	mov	r0, #0
	biceq	r2, r3, #16
	str	r2, [ip, #0]
	bx	lr
.L13:
	.align	2
.L12:
	.word	-2138308600
	.size	bwsetfifo, .-bwsetfifo
	.align	2
	.global	bwsetspeed
	.type	bwsetspeed, %function
bwsetspeed:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	str	lr, [sp, #-4]!
	ldreq	ip, .L24
	ldreq	lr, .L24+4
	beq	.L18
	cmp	r0, #1
	beq	.L23
.L15:
	mvn	r0, #0
	ldr	pc, [sp], #4
.L23:
	ldr	lr, .L24+8
	ldr	ip, .L24+12
.L18:
	cmp	r1, #2400
	beq	.L19
	ldr	r3, .L24+16
	cmp	r1, r3
	bne	.L15
	mov	r2, #0
	mov	r3, #3
	mov	r0, r2
	str	r2, [lr, #0]
	str	r3, [ip, #0]
	ldr	pc, [sp], #4
.L19:
	mov	r2, #0
	mov	r3, #144
	mov	r0, r2
	str	r2, [lr, #0]
	str	r3, [ip, #0]
	ldr	pc, [sp], #4
.L25:
	.align	2
.L24:
	.word	-2138308592
	.word	-2138308596
	.word	-2138243060
	.word	-2138243056
	.word	115200
	.size	bwsetspeed, .-bwsetspeed
	.align	2
	.global	bwputc
	.type	bwputc, %function
bwputc:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	@ lr needed for prologue
	and	r1, r1, #255
	ldreq	r3, .L37
	ldreq	r2, .L37+4
	beq	.L31
	cmp	r0, #1
	mvnne	r0, #0
	bxne	lr
	ldr	r3, .L37+8
	ldr	r2, .L37+12
.L31:
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #5
	and	r0, r3, #1
	cmp	r0, #0
.L32:
	bne	.L32
	str	r1, [r2, #0]
	bx	lr
.L38:
	.align	2
.L37:
	.word	-2138308584
	.word	-2138308608
	.word	-2138243048
	.word	-2138243072
	.size	bwputc, .-bwputc
	.align	2
	.global	c2x
	.type	c2x, %function
c2x:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r0, r0, #255
	cmp	r0, #9
	add	r3, r0, #48
	add	r0, r0, #87
	and	r3, r3, #255
	andhi	r3, r0, #255
	mov	r0, r3
	@ lr needed for prologue
	bx	lr
	.size	c2x, .-c2x
	.align	2
	.global	bwputx
	.type	bwputx, %function
bwputx:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	and	r3, r1, #255
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r6, r0
	mov	r0, r3, lsr #4
	mov	r4, r1
	bl	c2x(PLT)
	mov	r5, r0
	and	r0, r4, #15
	bl	c2x(PLT)
	mov	r1, r5
	mov	r4, r0
	mov	r0, r6
	bl	bwputc(PLT)
	mov	r0, r6
	mov	r1, r4
	ldmfd	sp!, {r4, r5, r6, lr}
	b	bwputc(PLT)
	.size	bwputx, .-bwputx
	.align	2
	.global	bwputr
	.type	bwputr, %function
bwputr:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	sub	sp, sp, #4
	add	r6, sp, #4
	str	r1, [r6, #-4]!
	mov	r5, r0
	mov	r4, #3
.L47:
	ldrb	r1, [r6, r4]	@ zero_extendqisi2
	mov	r0, r5
	sub	r4, r4, #1
	bl	bwputx(PLT)
	cmn	r4, #1
	bne	.L47
	mov	r0, r5
	mov	r1, #32
	bl	bwputc(PLT)
	add	sp, sp, #4
	ldmfd	sp!, {r4, r5, r6, pc}
	.size	bwputr, .-bwputr
	.align	2
	.global	bwputstr
	.type	bwputstr, %function
bwputstr:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	mov	r3, r1
	ldrb	r1, [r1, #0]	@ zero_extendqisi2
	mov	r4, r0
	cmp	r1, #0
	bne	.L61
.L53:
	mov	r0, #0
	ldmfd	sp!, {r4, r5, pc}
.L61:
	mov	r5, r3
	b	.L55
.L56:
	ldrb	r1, [r5, #1]!	@ zero_extendqisi2
	cmp	r1, #0
	beq	.L53
.L55:
	mov	r0, r4
	bl	bwputc(PLT)
	cmp	r0, #0
	bge	.L56
	mvn	r0, #0
	ldmfd	sp!, {r4, r5, pc}
	.size	bwputstr, .-bwputstr
	.align	2
	.global	bwputw
	.type	bwputw, %function
bwputw:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldrb	ip, [r3, #0]	@ zero_extendqisi2
	mov	r7, r3
	cmp	ip, #0
	mov	r6, r0
	and	r5, r2, #255
	add	r8, r3, #1
	bne	.L82
.L63:
	cmp	r1, #0
	sub	r4, r1, #1
	ble	.L69
.L76:
	sub	r4, r4, #1
	mov	r0, r6
	mov	r1, r5
	bl	bwputc(PLT)
	add	r3, r4, #1
	cmp	r3, #0
	bgt	.L76
	ldrb	ip, [r7, #0]	@ zero_extendqisi2
.L69:
	and	r1, ip, #255
	cmp	r1, #0
	ldmeqfd	sp!, {r4, r5, r6, r7, r8, pc}
	mov	r4, r8
.L74:
	mov	r0, r6
	bl	bwputc(PLT)
	ldrb	r1, [r4], #1	@ zero_extendqisi2
	cmp	r1, #0
	ldmeqfd	sp!, {r4, r5, r6, r7, r8, pc}
	mov	r0, r6
	bl	bwputc(PLT)
	ldrb	r1, [r4], #1	@ zero_extendqisi2
	cmp	r1, #0
	bne	.L74
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L82:
	cmp	r1, #0
	movgt	r0, r1
	movgt	r2, #0
	ble	.L63
.L66:
	ldrb	r3, [r2, r8]	@ zero_extendqisi2
	sub	r0, r0, #1
	cmp	r3, #0
	add	r2, r2, #1
	beq	.L67
	cmp	r1, r2
	bne	.L66
.L67:
	mov	r1, r0
	b	.L63
	.size	bwputw, .-bwputw
	.align	2
	.global	bwgetc
	.type	bwgetc, %function
bwgetc:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	@ lr needed for prologue
	ldreq	r3, .L94
	ldreq	r0, .L94+4
	beq	.L88
	cmp	r0, #1
	mvnne	r0, #0
	bxne	lr
	ldr	r3, .L94+8
	ldr	r0, .L94+12
.L88:
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #6
	and	r3, r3, #1
	cmp	r3, #0
.L89:
	beq	.L89
	ldrb	r0, [r0, #0]	@ zero_extendqisi2
	bx	lr
.L95:
	.align	2
.L94:
	.word	-2138308584
	.word	-2138308608
	.word	-2138243048
	.word	-2138243072
	.size	bwgetc, .-bwgetc
	.align	2
	.global	bwa2d
	.type	bwa2d, %function
bwa2d:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r0, r0, #255
	sub	r2, r0, #48
	and	r3, r2, #255
	cmp	r3, #9
	@ lr needed for prologue
	sub	r1, r0, #97
	bls	.L99
	cmp	r1, #5
	sub	r3, r0, #65
	sub	r2, r0, #87
	bhi	.L105
.L99:
	mov	r0, r2
	bx	lr
.L105:
	cmp	r3, #5
	mvn	r2, #0
	subls	r2, r0, #55
	b	.L99
	.size	bwa2d, .-bwa2d
	.align	2
	.global	bwa2i
	.type	bwa2i, %function
bwa2i:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, lr}
	mov	r8, r1
	ldr	r1, [r1, #0]
	mov	r7, r2
	mov	r9, r3
	and	r4, r0, #255
	mov	r6, #0
	b	.L107
.L108:
	cmp	r0, r7
	add	r1, r5, #1
	bgt	.L109
	mla	r6, r7, r6, r0
	ldrb	r4, [r1, #-1]	@ zero_extendqisi2
.L107:
	mov	r0, r4
	mov	r5, r1
	bl	bwa2d(PLT)
	cmp	r0, #0
	bge	.L108
.L109:
	mov	r0, r4
	str	r5, [r8, #0]
	str	r6, [r9, #0]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, pc}
	.size	bwa2i, .-bwa2i
	.global	__udivsi3
	.global	__umodsi3
	.align	2
	.global	bwui2a
	.type	bwui2a, %function
bwui2a:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, r1
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, lr}
	mov	r5, r0
	mov	r7, r1
	mov	r9, r2
	movcc	r6, #1
	movcc	r8, #0
	bcc	.L134
	mov	r6, #1
.L116:
	mul	r6, r7, r6
	mov	r0, r5
	mov	r1, r6
	bl	__udivsi3(PLT)
	cmp	r7, r0
	bls	.L116
	cmp	r6, #0
	movne	r8, #0
	bne	.L134
.L118:
	mov	r3, #0
	strb	r3, [r9, #0]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, pc}
.L120:
	cmp	r4, #9
	movgt	r3, #87
	movle	r3, #48
	add	r3, r3, r4
	cmp	r6, #0
	strb	r3, [r9], #1
	add	r8, r8, #1
	beq	.L118
.L134:
	mov	r1, r6
	mov	r0, r5
	bl	__udivsi3(PLT)
	mov	r1, r6
	mov	r4, r0
	mov	r0, r5
	bl	__umodsi3(PLT)
	mov	r1, r7
	mov	r5, r0
	mov	r0, r6
	bl	__udivsi3(PLT)
	cmp	r4, #0
	cmple	r8, #0
	mov	r6, r0
	bne	.L120
	cmp	r0, #0
	bne	.L134
	cmp	r4, #9
	movgt	r3, #87
	movle	r3, #48
	add	r3, r3, r4
	cmp	r6, #0
	strb	r3, [r9], #1
	add	r8, r8, #1
	bne	.L134
	b	.L118
	.size	bwui2a, .-bwui2a
	.align	2
	.global	bwi2a
	.type	bwi2a, %function
bwi2a:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	mov	r2, r1
	movlt	r3, #45
	mov	r1, #10
	strltb	r3, [r2], #1
	rsblt	r0, r0, #0
	@ lr needed for prologue
	b	bwui2a(PLT)
	.size	bwi2a, .-bwi2a
	.align	2
	.global	bwformat
	.type	bwformat, %function
bwformat:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	mov	r6, r0
	mov	r5, r2
	add	r7, sp, #4
	str	r1, [sp, #0]
.L166:
	ldr	r2, [sp, #0]
	mov	r3, r2
	ldrb	r1, [r3], #1	@ zero_extendqisi2
	cmp	r1, #0
	str	r3, [sp, #0]
	beq	.L157
	cmp	r1, #37
	bne	.L163
	mov	r4, #0
	str	r4, [sp, #16]
	ldrb	r0, [r2, #1]	@ zero_extendqisi2
	add	r3, r2, #2
	cmp	r0, #48
	str	r3, [sp, #0]
	beq	.L145
	bcc	.L147
	cmp	r0, #57
	movls	r1, sp
	movls	r2, #10
	addls	r3, sp, #16
	blls	bwa2i(PLT)
.L147:
	cmp	r0, #115
	beq	.L152
.L168:
	bhi	.L155
	cmp	r0, #99
	beq	.L150
	bhi	.L156
	cmp	r0, #0
	bne	.L167
.L157:
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L167:
	cmp	r0, #37
	bne	.L166
	mov	r1, r0
.L163:
	mov	r0, r6
	bl	bwputc(PLT)
	b	.L166
.L155:
	cmp	r0, #117
	beq	.L153
	cmp	r0, #120
	bne	.L166
	ldr	r0, [r5, #0]
	mov	r1, #16
	b	.L164
.L145:
	ldrb	r0, [r2, #2]	@ zero_extendqisi2
	add	r3, r2, #3
	cmp	r0, #115
	mov	r4, #1
	str	r3, [sp, #0]
	bne	.L168
.L152:
	ldr	r3, [r5, #0]
	mov	r0, r6
	ldr	r1, [sp, #16]
	mov	r2, #0
	bl	bwputw(PLT)
	add	r3, r5, #4
	mov	r5, r3
	b	.L166
.L156:
	cmp	r0, #100
	bne	.L166
	ldr	r0, [r5, #0]
	mov	r1, r7
	bl	bwi2a(PLT)
	b	.L165
.L153:
	ldr	r0, [r5, #0]
	mov	r1, #10
.L164:
	mov	r2, r7
	bl	bwui2a(PLT)
.L165:
	mov	r3, r7
	mov	r0, r6
	mov	r2, r4
	ldr	r1, [sp, #16]
	bl	bwputw(PLT)
	add	r3, r5, #4
	mov	r5, r3
	b	.L166
.L150:
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	r0, r6
	bl	bwputc(PLT)
	add	r3, r5, #4
	mov	r5, r3
	b	.L166
	.size	bwformat, .-bwformat
	.align	2
	.global	bwprintf
	.type	bwprintf, %function
bwprintf:
	@ args = 4, pretend = 12, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 1
	stmfd	sp!, {r1, r2, r3}
	str	lr, [sp, #-4]!
	ldr	r1, [sp, #4]
	add	r2, sp, #8
	bl	bwformat(PLT)
	ldr	lr, [sp], #4
	add	sp, sp, #12
	bx	lr
	.size	bwprintf, .-bwprintf
	.ident	"GCC: (GNU) 4.0.2"
