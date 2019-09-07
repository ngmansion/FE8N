.thumb
@;0002af60
@;追撃不可処理
	
.equ STR_ADR, (67)	@書き込み先(AI1カウンタ)
.equ FLAG, (0xFE)	@フラグ
	
	ldr r0, =0x0203a4d0
	ldrh r0, [r0]
	mov r1, #0x20
	and r0, r1
	bne normal	@闘技場チェック
	
	ldr r0, [r4]
	add r0, #STR_ADR
	ldrb r0, [r0]
@	ldr r0, [r0, #76]	@;ルナ開始
	mov r1, #FLAG
	and r0, r1
	cmp r0, r1
	beq cancel
normal:
	ldr r0, [r4]
	add r0, #74
	ldrh r0, [r0]
		ldr r1, =0x080174cc
		mov lr, r1
		.short 0xF800
	ldr r1, =0x0802af6a
	mov pc, r1
	
@追撃不可
cancel:
	ldr r0, =0x0802af80
	mov pc, r0
.ltorg

