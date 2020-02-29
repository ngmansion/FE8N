


.thumb

bl BreathofLife
cmp r0, #1
beq Got_Effect

mov	r0, r5
bl	GetNowHpCustomized
mov	r4, r0
mov	r0, r5
bl	GET_MAX_HP    @$00018ea4=最大HP
cmp	r4, r0
beq	No_Effect

Got_Effect:
ldr r0, =0x08025916
mov pc, r0

No_Effect:
ldr r0, =0x0802593e
mov pc, r0

BreathofLife:
        push {r4, r5, r6, r7, lr}
        mov r7, #0  @フラグリセット

        mov r0, r5
        mov r1, #0
        bl hasBreathofLife
        cmp r0, #0
        beq endBreathofLife
    @周囲回復処理(自分はスキップ)
    	ldrb r6, [r5, #0xB]
	    mov r0, #0xC0
	    and r6, r0	@r6に部隊表ID
    loopBreathofLife:
	    add r6, #1
	    mov r0, r6
	    bl Get_Status

        mov r4, r0
        cmp r0, #0
        beq endBreathofLife	@リスト末尾
        ldr r0, [r4]
        cmp r0, #0
        beq loopBreathofLife	@死亡判定1
        ldrb r0, [r4, #19]
        cmp r0, #0
        beq loopBreathofLife	@死亡判定2
        ldrb r0, [r4, #0xB]
        ldrb r1, [r5, #0xB]
        cmp r0, r1
        beq loopBreathofLife	@自分
        ldr r0, [r4, #0xC]
        ldr r1, =0x1000C
        and r0, r1
        bne loopBreathofLife	@死亡フラグまたは非出撃フラグ
        ldrb r0, [r4, #19]
        ldrb r1, [r4, #18]
        cmp r0, r1
        bge loopBreathofLife    @この人は全快

        mov r0, #2
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopBreathofLife    @2マス以上離れている

        mov r0, r4
        bl Heal
        mov r7, #1
        b loopBreathofLife

    endBreathofLife:
        mov r0, r7
        pop {r4, r5, r6, r7, pc}


Heal:
        push {r4, r5, lr}
        mov	r4, r0
        bl	getMaxHp    @$00018ea4=最大HP
        mov r5, r0

        mov r1, #20     @回復パーセント
        mul r0, r1
        mov r1, #100
        swi #6      @(r0)/(r1)

        ldrb r1, [r4, #19]  @現在HP
        add r0, r1
        mov r2, r5  @最大HP
        cmp r0, r2
        blt jumpHeal    @最大HPより小さいなら
        mov r0, r2
    jumpHeal:
        strb r0, [r4, #19]  @現在HP
        pop {r4, r5, pc}

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
        bx lr

    falseCheckXY:
        mov r0, #0
    endCheckXY:
        bx lr

GetNowHpCustomized:
        push {r5, lr}
        mov r5, r0
        bl GET_MAX_HP
        ldrb r3, [r5, #19]
        cmp r3, r0
        ble endNowHp    @最大HPを超過していない
        strb r0, [r5, #19]  @現在HP上書き
        .short 0xE000
    endNowHp:
        mov r0, r3
        pop {r5, pc}

GET_MAX_HP:
ldr r1, =0x08018ea4
mov pc, r1

divFunc:
ldr r2, =0x080d65f8
mov pc, r2

Get_Status:
ldr r1, =0x08019108
mov pc, r1

hasBreathofLife:
ldr r2, addr
mov pc, r2

.align
.ltorg
addr:
