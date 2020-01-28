.thumb
@0002a2bc
	
.equ STR_ADR, (67)	@書き込み先(AI1カウンタ)
.equ FLAG, (0xFF)	@フラグ
.equ SOUND_ID, (97)
	
	
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
	bne end	@;武器選択直前ではない
	
	mov r2, r4
	add r2, #STR_ADR
	
	ldr r1, =0x02024CC0
	ldrh r1, [r1, #4]
	lsl r1, r1, #22
	bpl nothing	@Lボタン押してるかどうか
	
	mov r0, #FLAG
	strb r0, [r2]
	
	mov	r0, #SOUND_ID
	ldr	r1, =0x080d4ef4 @サウンド
	mov	lr, r1
	.short 0xf800
	b end
nothing:
	mov r0, #0
	strb r0, [r2]
	
end:
	pop {r2,r3}
	ldr r0, =0x0802a2c6
	mov pc, r0
.ltorg

