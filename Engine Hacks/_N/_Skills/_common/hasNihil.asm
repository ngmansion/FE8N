@thumb
    push {r4, lr}
    mov r4, r0
    ldr r0, [r4, #4]
    ldr r1, [r4, #0]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
    lsl r0, r0, #8
    bmi oui
@align 4
    ldr r2, [adr] ;ID
    lsl r2, r2, #24
    lsr r2, r2, #24
;書チェック
    ldrh r1, [r4, #0x3A]
    mov r0, #0x3F
    and r0, r1
    cmp r0, r2
    beq oui
    lsr r1, r1, #6
    mov r0, #0x3F
    and r0, r1
    cmp r0, r2
    beq oui
unit: ;ユニットチェック
    ldr r0, [r4]
    add r0, #0x26
    ldrb r0, [r0]
    cmp r0, r2
    beq oui
;上級スキルチェック
    ldr r1, [r4, #4]
    ldr r1, [r1, #40]
    ldr r0, =$100
    and r0, r1
    beq jump9
    ldr r0, [r4]
    add r0, #0x27
    ldrb r0, [r0]
    cmp r0, r2
    beq oui
jump9: ;自軍以外チェック
    ldrb r1, [r4, #0xB]
    mov r0, #0xC0
    and r0, r1
    beq jump0
    ldr r0, [r4]
    add r0, #0x31
    ldrb r0, [r0]
    cmp r0, r2
    beq oui
jump0: ;リストチェック
@align 4
    ldr r3, [adr+4]
    lsl r2, r2, #4
    add r3, r2, r3
;ユニット
    ldr r2, [r3, #4]
    cmp r2, #0
    beq jump1
    ldr r1, [r4]
    ldrb r1, [r1, #4]
loop1:
    ldrb r0, [r2]
    cmp r0, #0
    beq jump1
    cmp r0, r1
    beq oui
    add r2, #1
    b loop1
jump1:
;クラス
    ldr r2, [r3, #8]
    cmp r2, #0
    beq jump2
    ldr r1, [r4, #4]
    ldrb r1, [r1, #4]
loop2:
    ldrb r0, [r2]
    cmp r0, #0
    beq jump2
    cmp r0, r1
    beq oui
    add r2, #1
    b loop2
jump2:
;武器
    ldr r2, [r3, #12]
    cmp r2, #0
    beq jump3
    mov r1, #74
    ldrb r1, [r4, r1]
loop3:
    ldrb r0, [r2]
    cmp r0, #0
    beq jump3
    cmp r0, r1
    beq oui
    add r2, #1
    b loop3
jump3:
    mov r0, #0
    @dcw $E000
oui:
    mov r0, #1
    pop {r4, pc}
@ltorg
adr: