.thumb
STR_ADR = (67)	@書き込み先(AI1カウンタ)

ALINA_ADR = (0x0203a4d0)

@org	0802b004
    push {r4, lr}
    mov r4, #0
    ldr r0, [r0, #76]
    mov r1, #32
    and r0, r1
    cmp r0, #0
    bne Brave @x勇者武器持ってるなら

    bl Addition
    cmp r0, #0
    beq endBrave
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

endBrave:
    mov r0, r4
    pop {r4}
    pop {pc}

Addition:
    push {lr}
    bl JudgeAddition
    cmp r0, #0
    beq endAddition

    bl dengeki
    cmp r0, #1
    beq endAddition

    bl renzoku
    cmp r0, #1
    beq endAddition

    bl DoubleLion
    b endAddition
endAddition:
    pop {pc}

JudgeAddition:
        push {lr}
        ldr r0, =ALINA_ADR
        ldrh r0, [r0]
        mov r1, #0x20
        and r0, r1
        bne inactive	@闘技場は無効

        ldr r0, [r6, #76]
        mov r1, #0x80
        and r0, r1
        bne inactive	@反撃不可武器は無効

		mov r0, r6
		add r0, #74
		ldrh r0, [r0]
		bl GetWeaponAbility
		cmp r0, #3
		beq inactive	@イクリプスは無効
        mov r0, #1
        b active

    inactive:
        mov r0, #0
    active:
        pop {pc}

DoubleLion:
	push {lr}

	mov r0, r6
    mov r1, r8
	bl HasDoubleLion
	cmp r0, #0
	beq endDouble

	ldrb r1, [r6, #18]	@最大HP
	ldrb r0, [r6, #19]	@現在HP
	cmp r0, r1
	blt endDouble
	mov r0, #1
endDouble:
    pop {pc}

renzoku:
    push {lr}
    mov r0, r6

    mov r1, r8
    bl HasAdept
	cmp r0, #0
	beq endRenzoku

	mov r0, #1
endRenzoku:
    pop {pc}

dengeki:
    push {lr}

    ldr r0, =0x0203a4e8
    ldr r1, =0x0203a568
        ldr r3, ADDRESS+4 @bolt
        mov lr, r3
        .short 0xF800
    pop {pc}

GetWeaponAbility:
	ldr r1, =0x080174cc
	mov pc, r1


DOUBLE_LION_ADR = ADDRESS+8

HasAdept:
    ldr r2, ADDRESS @連続
    mov pc, r2

HasDoubleLion:
	ldr r2, DOUBLE_LION_ADR
	mov pc, r2
.align
.ltorg
ADDRESS:

