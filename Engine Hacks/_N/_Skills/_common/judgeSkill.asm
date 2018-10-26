@thumb
    push {r4,r5, lr}
    mov r4, r0
    mov r2, r1
    lsl r2, r2, #24
    lsr r2, r2, #24
    mov r5, r2
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
;ユニットチェック
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
    ldr r3, [adr]
    ;ldr r3, =$11111111 ; goadload での [adr] は信用できない
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
    b exit
oui:
	mov		r0,r4	 ; RAM上へのユニットポインタ
	mov		r1,r5	 ; 持っているスキルID
	ldr		r2, [adr+4]  ; record_skillanime_id 保持しているとされたスキルを記録 その後発動すれば、エフェクト付きで表示する.
;    ldr r2, =$22222222  ; goadload での [adr+4] は信用できない
	mov r14, r2
	@dcw $F800

    mov r0, #1
exit:
    pop {r4,r5, pc}
@ltorg
adr: