@thumb
    mov r3, r0
;クラスチェック
@align 4
    ldr r2, [adr]
    ldr r1, [r3, #4]
    ldrb r1, [r1, #4]
loop:
    ldrb r0, [r2]
    cmp r0, #0
    beq unit
    cmp r0, r1
    beq oui
    add r2, #1
    b loop
;ユニットチェック
unit:
    ldr r0, [r3]
    add r0, #0x26
    ldrb r0, [r0]
    
@align 4
    ldr r2, [adr+4]
    lsl r2, r2, #24
    lsr r2, r2, #24
    cmp r0, r2
    beq oui
;上級スキルチェック
    
    ldr r1, [r3, #4]
    ldr r1, [r1, #40]
    ldr r0, =$100
    and r0, r1
    beq manual
    ldr r0, [r3]
    add r0, #0x27
    ldrb r0, [r0]
    cmp r0, r2
    beq oui
;書チェック
manual:
    ldrh r1, [r3, #0x3A]
    mov r0, #0x3F
    and r0, r1
    cmp r0, r2
    beq oui
    
    lsr r1, r1, #6
    mov r0, #0x3F
    and r0, r1
    cmp r0, r2
    beq oui
non:
    mov r0, #0
    @dcw $E000
oui:
    mov r0, #1
    bx lr
@ltorg
adr: