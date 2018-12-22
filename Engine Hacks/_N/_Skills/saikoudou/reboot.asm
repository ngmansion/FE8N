@define PULSE_ID 0x3C

@define PULSE_ADR ADR+0 ;奥義の鼓動

@thumb
    ldr r0, [r1]
    cmp r0, #0
    beq end
    ldr r0, [r1, #12]
    and r0, r4
    str r0, [r1, #12]
    bl jinrai
    bl pulse
end:
    ldr r0, =$0801854c
    mov pc, r0
    
jinrai:
    add r1, #69
    ldrb r0, [r1]
    cmp r0, #0xFF
    bne jump
    mov r0, #0
    strb r0, [r1]
jump:
    sub r1, #69
    bx lr
    
pulse:
	push {r1, r2, r3, r4, lr}
	mov r4, r1
	
	add r1, #48
	ldrb r1, [r1]
	cmp r1, 0	;なんの状態異常でもない
	bne	teki
	
    mov r0, r4
        @align 4
        ldr r3, [PULSE_ADR] ;奥義の鼓動
        mov lr, r3
        @dcw $F800
    cmp r0, #0
    beq teki
	mov r0, PULSE_ID
	mov r1, #48
    strb r0, [r4, r1]
teki:
    pop {r1, r2, r3, r4, pc}
@align 4
@ltorg
ADR: