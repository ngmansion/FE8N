

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

DEFEATED    = (0b01000000) @迅雷済みフラグ

Jinrai_back:
@DEFEATEDだけ消す
        ldrb r0, [r4, #11]
        mov r2, #0xC0
        tst r2, r0
        bne endJinrai       @自軍以外は終了

        mov r1, r4
        add r1, #69
        ldrb r0, [r1]

        mov r2, #DEFEATED
        bic r0, r2

        strb r0, [r1]       @セットはmainで行う
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
