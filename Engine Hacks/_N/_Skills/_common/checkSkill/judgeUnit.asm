@define SKL_TBL adr+0

@thumb
;I	r0 = ベースアドレス
;	r1 = スキルID
;O	-
    push {r4, lr}
    mov r4, r0
	mov r2, r1
unit:
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
    ldr r3, [SKL_TBL]
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
    mov r0, #0
    @dcw $E000
oui:
    mov r0, #1
    pop {r4, pc}
@align 4
@ltorg

adr: