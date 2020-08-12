

.thumb
@0x01858c

	ldr	r1, =0x08018664
	ldr r1, [r1]
	mov	r0, #255
	and	r0, r6
	lsl	r0, r0, #2
	add	r0, r0, r1
	ldr	r4, [r0]
	mov	r5, r4
    bl Jinrai_back
    bl Pulse_back
RETURN:
    ldr r0, =0x0801859a
    mov pc, r0

DEFEAT      = (0b10000000) @撃破フラグ
DEFEATED    = (0b01000000) @迅雷済みフラグ
COMBAT_HIT       = (0b00100000) @戦技発動フラグ
FIRST       = (0b00010000) @初撃フラグ

Jinrai_back:
@DEFEATEDだけ消せばよいが、一応他も消す
        ldrb r0, [r4, #11]
        mov r2, #0xC0
        tst r2, r0
        bne endJinrai @自軍以外は終了

        mov r1, r4
        add r1, #69
        ldrb r0, [r1]

        mov r2, #0xFF
        bic r0, r2
        strb r0, [r1]
        b endJinrai

        mov r2, #DEFEATED
        bic r0, r2

        mov r2, #COMBAT_HIT
        bic r0, r2

        mov r2, #FIRST
        bic r0, r2
        strb r0, [r1]
    endJinrai:
        bx lr
    
    
PULSE_ID = (0x29)
PULSE_ADR = (ADR+0)	@奥義の鼓動

Pulse_back:
	push {lr}
	mov r1, r4
	
	add r1, #48
	ldrb r1, [r1]
	cmp r1, #0	@なんの状態異常でもない
	bne	teki
	
    mov r0, r4
        ldr r3, PULSE_ADR @奥義の鼓動
        mov lr, r3
        .short 0xF800
    cmp r0, #0
    beq teki
	mov r0, #PULSE_ID
	mov r1, #48
    strb r0, [r4, r1]
teki:
    pop {pc}
    
    
    
.align
.ltorg
ADR:
