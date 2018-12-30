@define PULSE_ID 0x39

@define DEFEAT (0xFF)
@define DEFEATED (0xFE)
@define DEFEAT2 (0x7F)
@define DEFEATED2 (0x7E)

@define PULSE_ADR ADR+0 ;奥義の鼓動

@thumb
;0x01858c
	ldr	r1, =$08018664
	ldr r1, [r1]
	mov	r0, #255
	and	r0, r6
	lsl	r0, r0, #2
	add	r0, r0, r1
	ldr	r4, [r0]
	mov	r5, r4

    bl jinrai
    bl pulse
RETURN:
    ldr r0, =$0801859a
    mov pc, r0
    
    
jinrai:
	mov r1, r4
    add r1, #69
    ldrb r0, [r1]
    cmp r0, DEFEATED
    beq not_jump
    cmp r0, DEFEATED2
    bne jump
not_jump:
    mov r0, #0
    strb r0, [r1]
jump:
    bx lr
    
    
pulse:
	push {lr}
	mov r1, r4
	
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
    pop {pc}
    
    
    
@align 4
@ltorg
ADR: