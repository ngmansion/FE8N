.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _bldr reg, dest
	ldr \reg, =\dest
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.thumb
    ldr	r5, A_ALINA
    ldrh r0, [r5]
    mov r1, #0x20
    and r0, r1
    bne endwo @闘技場チェック

	mov r0, r8
	ldrb r0, [r0, #0xB]
		ldr r1, =0x08019108
		mov lr, r1
		.short 0xF800
	cmp r0, #0
	beq endwo	@壁

	mov r0, r8
		ldr r1, ADDRESS+8 @見切り
		_blr r1
	cmp r0, #0
	bne endwo
    
    bl cancel
    
    bl ikari
endwo:
    mov r1, #6
    ldsh r0, [r5, r1]
    mov r9, r0
    ldr r3, RETURN_ADR_2
    mov pc, r3
    
cancel:
    push {lr}
@除外条件
    mov r0, r7
		ldr r1, ADDRESS @キャンセル
		_blr r1
    cmp r0, #0
    beq false

@	ldr r0, A_EFFECT
@	ldr r0, [r0]
@	ldr r0, [r0]
@	lsl r0, r0, #29
@	bmi false @追撃時は無意味なので不発

@キャンセル発動条件
	mov r0, #94
	ldrh r0, [r7, r0]
	mov r1, r8
	add r1, #94
	ldrh r1, [r1]
	cmp r0, r1
	bgt false	@自分の方が速い
@キャンセル発動
	mov r1, r8
	add r1, #94
	strh r0, [r1]
	pop {pc}
    
    
ikari: @怒り
    push {lr}
    ldr r0, [r7, #76]
    mov r1, #0x90
    and r0, r1
    bne false @反撃不可武器と魔法剣は無視
    
    mov r0, r7
    add r0, #74
    ldrh r0, [r0]
		ldr r1, B_WEAPON_ABILITY
		_blr r1
    cmp r0, #3
    beq false @HP1武器は無視
	
	mov r0, r7
		ldr r1, ADDRESS+4 @怒り
		_blr r1
	cmp r0, #0
	beq false
	
	mov r0, r8
		ldr r1, ADDRESS+12 @強運
		_blr r1
	cmp r0, #0
	beq gotWarth	@強運なし
	
	mov r0, r7
		ldr r1, ADDRESS+8 @見切り
		_blr r1
	cmp r0, #0
	beq false	@強運無効化失敗
gotWarth:
    mov r0, #0x13
    ldrb r0, [r7, r0]	@現在HP
    mov r1, #0x12
    ldrb r1, [r7, r1]	@最大HP
    lsl r0, r0, #1
    cmp r0, r1
    bgt false @HP分岐
    

    ldrh r0, [r5, #12]
    add r0, #50
    strh r0, [r5, #12]
false:
    pop {pc}
random:
    ldr r3, RETURN_ADR
    mov pc, r3

.align
RETURN_ADR:
.long 0x0802a490
RETURN_ADR_2:
.long 0x0802b3ac
B_WEAPON_ABILITY:
.long 0x080174cc
A_EFFECT:
.long 0x0203a604
A_ALINA:
.long 0x0203a4d0

.ltorg
ADDRESS:
	