@thumb
    push {r4, r5, lr}
    mov r4, r0
    lsl r1, r1, #24
    lsr r1, r1, #24
;書チェック
    bl extendSkill
    cmp r0, #1
    beq oui
    mov r2, r5
;ユニットチェック
	
	
	bl 
	
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
    pop {r4, r5, pc}
@align 4
@ltorg

extendSkill:
    ldr r3, [adr+4]
    mov pc, r3

adr: