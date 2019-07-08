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
    bne endwo @;闘技場チェック
    
    mov r0, r8
		ldr r1, ADDRESS+8 @;見切り
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
@;除外条件
    ldr r0, A_ATTACKER
    ldr r0, [r0]
    ldrb r0, [r0, #11]
    ldrb r1, [r7, #11]
    cmp r0, r1
    bne false @;攻撃者じゃ無い
    mov r0, r7
		ldr r1, ADDRESS @;キャンセル
		_blr r1
    cmp r0, #0
    beq false

    ldr r0, A_EFFECT
    ldr r0, [r0]
    ldr r0, [r0]
    lsl r0, r0, #29
@;   bmi false @;追撃チェック

@;キャンセル発動条件
	ldrb r0, [r7, #0x13] @;現在HP
	ldrb r1, [r7, #0x12] @;最大HP
	cmp r0, r1
	blt false

@;キャンセル発動
    mov r0, #0
    mov r1, r8
    add r1, #72
    strh r0, [r1]	@;相手装備消去
    strb r0, [r1, #10]	@;相手武器消滅防止
effect:
    ldr r0, A_EFFECT
    ldr r3, [r0]
    ldr r2, [r3]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #0x80
    lsl r0, r0, #7
    orr r1, r0
    ldr r0, =0xFFF80000
    and r0, r2
    orr r0, r1
    str r0, [r3] @;必的発動の処理（エフェクト用）
    pop {pc}
    
    
ikari: @;怒り
    push {lr}
    ldr r0, [r7, #76]
    mov r1, #0x90
    and r0, r1
    bne false @;反撃不可武器と魔法剣は無視
    
    mov r0, r7
    add r0, #74
    ldrh r0, [r0]
		ldr r1, B_WEAPON_ABILITY
		_blr r1
    cmp r0, #3
    beq false @;HP1武器は無視
    
    mov r0, #0x13
    ldsb r0, [r7, r0]
    cmp r0, #10
    bge false @;HP分岐
    
    mov r0, r7
		ldr r1, ADDRESS+4 @;怒り
		_blr r1
    cmp r0, #0
    beq false
    ldrh r0, [r5, #12]
    add r0, #50
    strh r0, [r5, #12]
false:
    pop {pc}
random:
    ldr r3, RETURN_ADR
    mov pc, r3


RETURN_ADR:
.long 0x0802a490
RETURN_ADR_2:
.long 0x0802b3ac
B_WEAPON_ABILITY:
.long 0x080174cc
A_EFFECT:
.long 0x0203a604
A_ATTACKER:
.long 0x03004df0
A_ALINA:
.long 0x0203a4d0

.ltorg
ADDRESS:
	