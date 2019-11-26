.thumb
STR_ADR = (67)	@書き込み先(AI1カウンタ)
FLAG = (0xFF)	@フラグ

ALINA_ADR = (0x0203a4d0)

DOUBLE_LION_ADR = ADDRESS+12

@@org	$0802b004
    push {r4, lr}
    mov r4, #0
    ldr r0, [r0, #76]
    mov r1, #32
    and r0, r1
    cmp r0, #0
    bne Brave @x勇者武器持ってるなら

    bl dengeki
    cmp r4, #0
    beq falseBrave
Brave:
    ldr r0, =0x0203a604
    ldr r3, [r0, #0]
    ldr r2, [r3, #0]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #16
    orr r1, r0
    ldr r0, =0xFFF80000
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]
    mov r4, #1				@攻撃回数加算
    b endBrave
falseBrave:
    bl addition
endBrave:
    mov r0, r4
    pop {r4}
    pop {pc}

addition:
    push {lr}
    cmp r4, #0
    bne endAddition
    bl renzoku
    cmp r4, #0
    bne endAddition
    bl DoubleLion
endAddition:
    pop {pc}

DoubleLion:
	push {lr}
	ldr r0, =ALINA_ADR
	ldrh r0, [r0]
	mov r1, #0x20
	and r0, r1
	bne endDouble	@闘技場は無効
	
	mov r0, r6
	bl hasDoubleLion
	cmp r0, #0
	beq endDouble
	mov r0, r8
		ldr r1, ADDRESS+8 @見切り
		mov lr, r1
		.short 0xF800
	cmp r0, #1
	beq endDouble
	ldrb r1, [r6, #18]	@最大HP
	ldrb r0, [r6, #19]	@現在HP
	cmp r0, r1
	blt endDouble
	add r4, #1				@攻撃回数加算
endDouble:
    pop {pc}

renzoku:
    push {lr}
    mov r0, r6
        ldr r1, ADDRESS @連続
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endRenzoku
	mov r0, r8
		ldr r1, ADDRESS+8 @見切り
		mov lr, r1
		.short 0xF800
	cmp r0, #1
	beq endRenzoku
got:
    mov r0, r6
	add r0, #STR_ADR
	ldrb r0, [r0]
	mov r1, #FLAG
	cmp r0, r1
	bne endRenzoku
	add r4, #1				@攻撃回数加算
endRenzoku:
    pop {pc}

dengeki:
    push {lr}
    ldr r0, =ALINA_ADR
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne end_bolt	@闘技場は無効

    ldr r0, =0x0203a4e8
    ldr r1, =0x0203a568
        ldr r3, ADDRESS+4 @bolt
        mov lr, r3
        .short 0xF800
    orr r4, r0
end_bolt:
    pop {pc}

hasDoubleLion:
	ldr r1, DOUBLE_LION_ADR
	mov pc, r1
.align
.ltorg
ADDRESS:

