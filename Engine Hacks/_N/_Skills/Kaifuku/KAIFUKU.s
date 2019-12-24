.thumb
@org	$08019f28
    push {r4, lr}
    mov r4, r0
    bl main
    mov r3, r0

    ldr r1, =0x08019f34
    ldr r1, [r1]
    add r0, r4, r1
    ldrb r0, [r0]
    lsl r0, r0, #24
    asr r0, r0, #24
    add r0, r0, r3
    pop {r4, pc}

main:
    push {r4, r5, lr}
    mov r4, #0

    mov r0, r5
    bl Heal
    add r4, r0

    mov r0, r5
    bl DivineHeal
    add r4, r0

    mov r0, r5
    bl BreathofLife
    add r4, r0

end:
    mov r0, r4
    pop {r4, r5, pc}

DivineHeal:
        push {r4, r5, r6, lr}
        mov r6, r0
        mov r5, r0
        mov r1, #0
        bl hasDivineHeal
        cmp r0, #0
        beq endDivine
        mov r4, #0
		ldrb r0, [r6, #0xB]
		mov r1, #0xC0
		and r0, r1
        b loopStartDivine

    loopDivine:
		ldrb r0, [r5, #0xB]
	loopStartDivine:
		add r0, #1
		bl Get_Status
		mov r5, r0
		cmp r5, #0
		beq resultDivine

		ldr r0, [r5]
		cmp r0, #0
		beq loopDivine	@死亡判定1
		
		ldr r0, [r5, #0xC]
		mov r1, #0x0C
		and r0, r1
		bne loopDivine	@死亡判定2

	    ldrb r0, [r5, #19] @現在19
		cmp r0, #0
		beq loopDivine	@死亡判定3

	    ldrb r0, [r5, #0xB]
	    ldrb r1, [r6, #0xB]
		cmp r0, r1
		beq loopDivine	@自分

		mov r0, #10	@within 10
		mov r1, r5
		mov r2, r6
		bl CheckXY
		cmp r0, #0
		beq loopDivine	@no exist

        add r4, #1
        b loopDivine
    resultDivine:
        mov r0, #10
        mul r0, r4
    endDivine:
        pop {r4, r5, r6, pc}

BreathofLife:
        push {lr}
        mov r1, #0
        bl hasBreathofLife
        cmp r0, #0
        beq endBreathofLife
        mov r0, #20 @パーセント
    endBreathofLife:
        pop {pc}

Heal:
        push {lr}
        mov r1, #0
        bl hasHeal
        cmp r0, #0
        beq endHeal
        mov r0, #20 @20percent
    endHeal:
        pop {pc}

CheckXY:
@r1とr2がr0マス以内に居るならr0=TRUE
@同座標ならTRUE
@
    push {r4, r5, r6}
	mov r4, r1
	mov r5, r2
    mov r6, r0
	mov r2, #16
	ldsb r2, [r4, r2]
	mov r0, #16
	ldsb r0, [r5, r0]
	sub r1, r2, r0
	cmp r1, #0
	bge jump1CheckXY
	sub r1, r0, r2

jump1CheckXY:
	mov r3, #17
	ldsb r3, [r4, r3]
	mov	r2, #17
	ldsb r2, [r5, r2]
	sub r0, r3, r2
	cmp r0, #0
	bge jump2CheckXY
	sub r0, r2, r3

jump2CheckXY:
	add	r0, r1, r0
	cmp	r0, r6
	bgt	falseCheckXY	@r6マス以内に居ない
	mov r0, #1
	b endCheckXY
falseCheckXY:
	mov r0, #0
endCheckXY:
    pop {r4, r5, r6}
	bx lr

Get_Status:
	ldr r1, =0x08019108
	mov pc, r1
hasBreathofLife:
        ldr r2, addr+8
        mov pc, r2
hasDivineHeal:
        ldr r2, addr+4 @回復
        mov pc, r2
hasHeal:
        ldr r2, addr @回復
        mov pc, r2

.align
.ltorg
addr:
