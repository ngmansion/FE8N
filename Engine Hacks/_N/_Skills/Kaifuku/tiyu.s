

.thumb
    push {r4, lr}
    mov r4, r0
    mov r0, r5
    bl hasSkill
    mov r2, r0
    mov r0, r4
    ldr r1, =0x08019f44
    ldr r1, [r1]
    add r0, r0, r1
    ldrb r0, [r0]
    lsl r0, r0, #24
    asr r0, r0, #24
    orr r2, r0
    
	mov	r0, r5
	add	r0, #48
	ldrb	r0, [r0]	@状態異常ロード
	bl judgeBadEffect
    cmp r0, #1
    beq normal
	mov r0, #0 @良い状態異常なら強制無効化
    b endTiyu
normal:
    mov r0, r2
endTiyu:
    pop {r4, pc}

hasSkill:
    push {r4, r5, lr}
    mov r4, #0
    mov r5, r0
        ldr r1, adr @治癒
        mov lr, r1
        .short 0xF800
    mov r4, r0
    
    mov r0, r5
        ldr r1, adr+4 @地の祝福
        mov lr, r1
        .short 0xF800
    orr r4, r0
    mov r0, r4
    pop {r4, r5, pc}


ATK_ID = (0x5)
PULSE_ID = (0x09)	@奥義の鼓動ID

judgeBadEffect:
    cmp r0, #0
    beq falseBadEffect
	mov	r1, #15
	and	r1, r0
	cmp	r1, #ATK_ID
	blt trueBadEffect
	cmp	r1, #PULSE_ID
	bgt	trueBadEffect
falseBadEffect:
    mov r0, #0
    b endBadEffect
trueBadEffect:
    mov r0, #1
endBadEffect:
    bx lr

.align
.ltorg
adr:



