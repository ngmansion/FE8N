.thumb
mov r0, r5
bl Boon
cmp r0, #1
beq Got_Effect

mov r2, r5
add r2, #48
ldrb r1, [r2, #0]	@状態異常ロード
mov r0, #15
and r0, r1
cmp r0, #0
beq Not_Effect
ldr r0, =0x08025958
mov pc, r0

Got_Effect:
ldr r0, =0x0802596a
mov pc, r0

Not_Effect:
ldr r0, =0x0802597e
mov pc, r0


Boon:
        push {r4, r5, r6, r7, lr}
        mov r7, #0  @フラグリセット

        mov r0, r5
        mov r1, #0
        bl hasBoon
        cmp r0, #0
        beq endBoon
    @周囲回復処理(自分はスキップ)
    	ldrb r6, [r5, #0xB]
	    mov r0, #0xC0
	    and r6, r0	@r6に部隊表ID
    loopBoon:
	    add r6, #1
	    mov r0, r6
	    bl Get_Status

        mov r4, r0
        cmp r0, #0
        beq endBoon	@リスト末尾
        ldr r0, [r4]
        cmp r0, #0
        beq loopBoon	@死亡判定1
        ldrb r0, [r4, #19]
        cmp r0, #0
        beq loopBoon	@死亡判定2
        ldrb r0, [r4, #0xB]
        ldrb r1, [r5, #0xB]
        cmp r0, r1
        beq loopBoon	@自分
        ldr r0, [r4, #0xC]
        ldr r1, =0x1000C
        and r0, r1
        bne loopBoon	@死亡フラグまたは非出撃フラグ
	    mov	r0, r4
	    add	r0, #48
	    ldrb r0, [r0]   @状態異常ロード
        bl judgeBadEffect
        cmp r0, #0
        beq loopBoon    @状態異常回復不要

        mov r0, #2
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopBoon    @2マス以上離れている

        mov r1, #0
	    mov	r0, r4
	    add	r0, #48
	    strb r1, [r0]   @状態異常ストア

        mov r7, #1
        b loopBoon

    endBoon:
        mov r0, r7
        pop {r4, r5, r6, r7, pc}





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

CheckXY:
@r1とr2がr0マス以内に居るならr0=TRUE
@同座標ならTRUE
@
        push {r0}
        ldrb r0, [r1, #16]
        ldrb r3, [r2, #16]
        sub r3, r0, r3
        bge jump1CheckXY
        neg r3, r3  @絶対値取得
    jump1CheckXY:

        ldrb r1, [r1, #17]
        ldrb r2, [r2, #17]
        sub r2, r1, r2
        bge jump2CheckXY
        neg r2, r2  @絶対値取得
    jump2CheckXY:

        add r2, r2, r3
        pop {r0}
        cmp r2, r0
        bgt falseCheckXY    @r0マス以内に居ない
        mov r0, #1
        b endCheckXY

    falseCheckXY:
        mov r0, #0
    endCheckXY:
        bx lr

Get_Status:
ldr r1, =0x08019108
mov pc, r1

hasBoon:
ldr r2, addr
mov pc, r2

.align
.ltorg
addr:


