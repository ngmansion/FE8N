PULSE_ID = (0x09) @奥義の鼓動

.thumb
@ 0802ad3c
@イクリプス等の直前(自分の数値と相手の数値の計算後)
@ステータス画面では呼ばれない
@相手の数値に影響を与える処理群


    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1

    mov	r0, r6
        ldr r1, NIHIL_ADR
        mov lr, r1
        .short 0xF800
    cmp r0, #1
    beq next

    bl Lull
    bl Shisen_B
    bl QuickenedPulse
    
next:
    bl godBless
	
Return:
    ldr r5, [r4, #76]
    ldr r0, =0x0802ad44
    mov r15, r0
endZero:
    mov r0, #0
    mov r1, r4
    add r1, #90
    strh r0, [r1] @威力
    
    mov r0, #0x7F
    mov r1, r6
    add r1, #92
    strh r0, [r1] @防御
    pop {r4, r5, r6}
    pop {r0}
    bx r0

Lull:
        push {lr}

        mov r0, r4
        mov r1, #0
        bl HasLull
        cmp r0, #0
        beq endLull
        mov r0, r6
        mov r1, r4
        bl recalcAtk
        mov r0, r6
        mov r1, r4
        bl recalcSpd
        
        mov r1, r6
        add r1, #90
        ldrh r0, [r1]
        sub r0, #2
        bge jumpAtk
        mov r0, #0
    jumpAtk:
        strh r0, [r1] @威力
        
        mov r1, r6
        add r1, #94
        ldrh r0, [r1]
        sub r0, #2
        bge jumpSpd
        mov r0, #0
    jumpSpd:
        strh r0, [r1] @速さ

    endLull:
        pop {pc}


Shisen_B:	@相手強化
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasShisen
        cmp r0, #0
        beq endShisen
        
        mov r1, r6
        add r1, #90
        ldrh r0, [r1]
        add r0, #10
        strh r0, [r1] @相手
    endShisen:
        pop {pc}

QuickenedPulse:
	push {lr}
	mov r0, #48
	ldrb r1, [r4, r0]
	cmp r1, #PULSE_ID
	bne endPulse
	
	mov r1, r4
	add r1, #100
	mov r0, #100
	strh r0, [r1]
endPulse:
	pop {pc}

godBless:
    push {lr}
    mov r0, r4
        ldr r1, adr+4 @光の加護
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne endBless
    
    mov r0, r6
        ldr r1, adr+8 @暗黒の加護
    	mov lr, r1
    	.short 0xF800
    cmp r0, #0
    beq endBless

    mov r1, #90
    ldrh r0, [r4, r1] @威力
    asr r0, r0, #1
    strh r0, [r4, r1] @威力

    mov r0, #1
    .short 0xE000
endBless:
    mov r0, #0
    pop {pc}

SHISEN_ADR = (adr+0)
NIHIL_ADR = (adr+12)
LULL_ADR = (adr+16)

HasShisen:
    ldr r2, SHISEN_ADR
    mov pc, r2

recalcAtk:
    ldr r2, =0x0802aa28
    mov pc, r2
recalcSpd:
    ldr r2, =0x0802aae4
    mov pc, r2

HasLull:
    ldr r2, LULL_ADR
    mov pc, r2

.ltorg
.align
adr:

