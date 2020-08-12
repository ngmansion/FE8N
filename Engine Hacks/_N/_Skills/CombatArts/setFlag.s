.thumb
@ 0802a2bc
	
WAR_OFFSET = (67)	@書き込み先(AI1カウンタ)
SOUND_ID = (97)
	
	
	ldr r0, =0x0802a2d8
	ldr r0, [r0]
	.short 0x2102
	.short 0x8001
	.short 0x9804
	.short 0x9000
	
	push {r2,r3}
	
	mov r0, r13
	ldr r0, [r0, #36]
	ldr r1, =0x08050803
	cmp r0, r1
	bne end	@武器選択直前ではない

    ldr r0, ADDR+4
	ldrb r0, [r0]
	cmp r0, #0
	beq reset
	cmp r0, #1
	beq reset
	
	bl GetSkill
	mov r2, r4
	add r2, #WAR_OFFSET
	strb r0, [r2]
@サウンド
	mov	r0, #SOUND_ID
	ldr	r1, =0x080d4ef4 @サウンド
	mov	lr, r1
	.short 0xf800
	b end
reset:
	mov r0, #0
	mov r2, r4
	add r2, #WAR_OFFSET
	strb r0, [r2]
end:
    bl arrow_reset_func

	pop {r2,r3}
	ldr r0, =0x0802a2c6
	mov pc, r0

GetSkill:
		ldr r2, ADDR+4
		ldrb r2, [r2]
		sub r2, #2
		ldr r1, ADDR
		ldrb r0, [r1, r2]
		bx lr



arrow_reset_func:
    ldr r0, ADDR
	mov r1, #0
    str r1, [r0]
    str r1, [r0, #4]
    str r1, [r0, #8]
    str r1, [r0, #12]
	bx lr

.align
.ltorg
ADDR:

