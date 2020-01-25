.thumb
    push {r4, lr}
    mov r4, r0
	mov r2, r1

    ldr r0, [r4]
    add r0, #0x26
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
@上級スキルチェック
    ldr r1, [r4, #4]
    ldr r1, [r1, #40]
    ldr r0, =0x100
    and r0, r1
    beq jumpUnit
    ldr r0, [r4]
    add r0, #0x27
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
jumpUnit: @自軍以外チェック
    ldrb r1, [r4, #0xB]
    mov r0, #0xC0
    and r0, r1
    beq nonUnit
    ldr r0, [r4]
    add r0, #0x31
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
nonUnit:
	mov r0, #0
    pop {r4, pc}
ouiUnit:
    mov r0, #1
endUnit:
    pop {r4, pc}
	