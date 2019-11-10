.thumb
@0002a834
STR_ADR = (67)	@書き込み先(AI1カウンタ)
FLAG = (0xFE)	@フラグ

    cmp r0, #0
    beq cancel @射程外
    
    ldr r0, =0x03004df0
    ldr r0, [r0]
    ldrb r0, [r0, #11]
    ldrb r1, [r5, #11]
    cmp r0, r1
    beq normal @攻撃者じゃ無い
    
    ldr r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne normal @闘技場チェック

	ldr r0, =0x0203a4e8
		ldr r1, adr+4 @風薙ぎ
		mov lr, r1
		.short 0xF800
	beq normal @スキル無し

	mov r0, r5
	ldr r1, adr+0 @見切り
	mov lr, r1
	.short 0xF800
	cmp r0, #1
	beq normal @見切り

	ldr r0, =0x0203a4e8
	add r0, #STR_ADR
	ldrb r0, [r0]
	mov r1, #FLAG
	and r0, r1
	cmp r0, r1
	beq cancel
normal:
    mov r1, r8
    ldrb r0, [r1, #0]
    cmp r0, #255
    bne end @アイテム無し？？
cancel:
    ldr r0, =0x0802a840	@反撃不可
    mov pc, r0
end:
    ldr r0, =0x0802a84a
    mov pc, r0
.ltorg
adr:
