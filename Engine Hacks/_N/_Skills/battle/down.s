WAR_OFFSET = (67)	@書き込み先(AI1カウンタ)
ATTACK_FLG_OFFSET = (69)    @書き込み先(AI2カウンタ)


@初撃フラグ化
@KNOCK_BACK_FLAG    = (0b00000100) @叩き込みフラグ
@HITANDRUN_FLAG     = (0b00001000) @一撃離脱フラグ
@LUNGE_FLAG    = (0b00010000) @切り込みフラグ

COMBAT_HIT                 = (0b00100000) @戦技発動フラグ
FIRST_ATTACKED_FLAG   = (0b00010000)

.thumb

@ 0802bfd8

    cmp	r6, #0
    bne	START
    ldr	r0, =0x0802bfec
    mov	pc, r0
START:
    mov	r0, r6
    mov	r1, r4
        ldr	r2, =0x0802c134
        mov	lr, r2
        .short 0xF800
@攻め側スキル→受け
    ldrb r0, [r7, #19]
    cmp r0, #0
    beq negative	@自分のHP0
    
    mov	r0, r7
    bl WarSkill_back
    
    mov	r0, r7
    mov	r1, r6
    bl Fury
    
    mov	r0, r7
    mov	r1, r6
    bl DoubleLion	@HP満タンの時だけなので最後
    
    mov	r0, r7
    mov	r1, r6
    bl SavageBlow

    bl Lunge
    bl HitAndRun
    bl KnockBack

    ldrb r0, [r6, #19]
    cmp r0, #0
    beq negative	@相手のHP0

    mov	r0, r7
    mov	r1, r6
    bl Jadoku

    mov	r0, r7
    mov	r1, r6
    bl Counter



negative:
@受け側スキル→攻め
    ldrb r0, [r6, #19]
    cmp r0, #0
    beq END	@自分のHP0
    
    mov	r0, r6
    mov	r1, r7
    bl Fury
    
    mov	r0, r6
    mov	r1, r7
    bl DoubleLion	@HP満タンの時だけなので最後
    

END:
    pop	{r4, r5, r6, r7}
    pop	{r0}
    bx	r0



KnockBack:
        push {lr}

        mov r2, r5
        add r2, #ATTACK_FLG_OFFSET
        ldrb r0, [r2]
        mov r1, #COMBAT_HIT
        tst r0, r1
        beq endKnockBack      @持ってないので終了

        bl GET_KNOCK_BACK
        mov r2, r5
        add r2, #WAR_OFFSET
        ldrb r1, [r2]
        cmp r0, r1
        bne endKnockBack

        ldr r1, [r6]
        ldr r2, [r6, #4]
        ldr r1, [r1, #40]
        ldr r2, [r2, #40]
        orr r1, r2
        ldr r2, =0x8200
        tst r1, r2
        bne endKnockBack      @敵将or輸送隊なら終了

        mov r0, r6
        bl FodesFunc
        cmp r0, #1
        beq endKnockBack      @無効敵なら終了

        ldrb r0, [r7, #16]
        ldrb r2, [r6, #16]   @相手
        sub r0, r2
        neg r0, r0
        add r0, r2

        ldrb r1, [r7, #17]
        ldrb r3, [r6, #17]   @相手
        sub r1, r3
        neg r1, r1
        add r1, r3
        
        mov r2, r6
        bl CanLocate
        cmp r0, #0
        beq endKnockBack    @立てない

        ldrb r0, [r7, #16]
        ldrb r2, [r6, #16]   @相手
        sub r0, r2
        neg r0, r0
        add r0, r2

        ldrb r1, [r7, #17]
        ldrb r3, [r6, #17]   @相手
        sub r1, r3
        neg r1, r1
        add r1, r3

        strb r0, [r6, #16]   @相手
        strb r1, [r6, #17]   @相手

    endKnockBack:
        pop {pc}


HitAndRun:
        push {lr}

        mov r2, r5
        add r2, #ATTACK_FLG_OFFSET
        ldrb r0, [r2]
        mov r1, #COMBAT_HIT
        tst r0, r1
        beq endHitAndRun      @持ってないので終了

        bl GET_HIT_AND_RUN
        mov r2, r5
        add r2, #WAR_OFFSET
        ldrb r1, [r2]
        cmp r0, r1
        bne endHitAndRun

        ldrb r0, [r6, #16]   @相手
        ldrb r2, [r7, #16]
        sub r0, r2
        neg r0, r0
        add r0, r2

        ldrb r1, [r6, #17]   @相手
        ldrb r3, [r7, #17]
        sub r1, r3
        neg r1, r1
        add r1, r3

        mov r2, r7
        bl CanLocate
        cmp r0, #0
        beq endHitAndRun    @立てない

        ldrb r0, [r6, #16]   @相手
        ldrb r2, [r7, #16]
        sub r0, r2
        neg r0, r0
        add r0, r2

        ldrb r1, [r6, #17]   @相手
        ldrb r3, [r7, #17]
        sub r1, r3
        neg r1, r1
        add r1, r3

        ldr r2, =0x0203A954
        strb r0, [r2, #14]
        strb r1, [r2, #15]
    endHitAndRun:
        pop {pc}


Lunge:
        push {lr}

        mov r2, r5
        add r2, #ATTACK_FLG_OFFSET
        ldrb r0, [r2]
        mov r1, #COMBAT_HIT
        tst r0, r1
        beq endLunge      @持ってないので終了

        bl GET_LUNGE
        mov r2, r5
        add r2, #WAR_OFFSET
        ldrb r1, [r2]
        cmp r0, r1
        bne endLunge

        ldr r1, [r6]
        ldr r2, [r6, #4]
        ldr r1, [r1, #40]
        ldr r2, [r2, #40]
        orr r1, r2
        ldr r2, =0x8200
        tst r1, r2
        bne endLunge      @敵将or輸送隊なら終了

        mov r0, r6
        bl FodesFunc
        cmp r0, #1
        beq endLunge      @無効敵なら終了

        ldrb r0, [r6, #16]   @相手
        ldrb r1, [r6, #17]   @相手
        mov r2, r7
        bl CanLocateMinus
        cmp r0, #0
        beq endLunge    @立てない

        ldrb r0, [r7, #16]
        ldrb r1, [r7, #17]
        mov r2, r6
        bl CanLocateMinus
        cmp r0, #0
        beq endLunge    @立てない

        ldrb r0, [r6, #16]   @相手
        ldrb r1, [r6, #17]   @相手
        ldrb r2, [r7, #16]
        ldrb r3, [r7, #17]
        strb r2, [r6, #16]   @相手
        strb r3, [r6, #17]   @相手
        ldr r2, =0x0203A954
        strb r0, [r2, #14]
        strb r1, [r2, #15]
    endLunge:
        pop {pc}



DoubleLion:
    push	{r4, lr}
    mov	r4, r0
    
    bl hasDoubleLion
    cmp	r0, #0
    beq falseDouble
    
    ldrb r1, [r4, #18]	@最大HP
    ldrb r0, [r4, #19]	@現在HP
    cmp r0, r1
    blt falseDouble
    sub r0, #1
    strb	r0, [r4, #19]
    mov	r0, #1
    b	retDouble
falseDouble:
    mov	r0, #0
retDouble:
    pop	{r4, pc}

WarSkill_back:
    mov r1, r0

    ldrb r0, [r1, #11]
    mov r2, #0xC0
    and r2, r0
    bne war_end @自軍以外は終了

    add r1, #WAR_OFFSET
    mov r0, #0
    strb r0, [r1]
war_end:
    bx lr

Counter:
    push	{r4, lr}
    mov r4, r0
    mov r3, r1
@	ldrb r0, [r4, #0x13]
@	cmp r0, #0
@	beq falseCounter		@撃破なら終了
@	ldrb r0, [r3, #0x13]
@	cmp r0, #0
@	beq falseCounter		@撃破なら終了
    
    ldr r0, =0x0203a568
    add r0, #72
    ldrh r0, [r0]
    cmp r0, #0
    bne falseCounter		@武器所持なら終了
    
    
    ldrb r0, [r3, #0xB]
    lsl r0, r0, #24
    bmi isRedCounter

    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bmi startCounter
    b falseCounter	@相手チェック失敗
    
isRedCounter:
    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bpl startCounter
    b falseCounter	@相手チェック失敗
    
startCounter:
    mov r0, r3
    mov r1, r4
        ldr r2, ADR+12
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq falseCounter	@相手応撃未所持なら終了
    
    ldr r1, =0x0203a4d0
    ldrb	r1, [r1, #4]
    cmp r1, #0
    beq falseCounter	@ノーダメージなら終了
@on
    ldrb r0, [r4, #19] @現在19
    sub r0, r1
    bgt hpOkCounter
    mov r0, #1
hpOkCounter:
    strb r0, [r4, #19] @現在19
    
    mov r0, #0xD2	@妥当な音のIDが分からん
    mov r1, #0xB8
        ldr r2, =0x08014B50 @音
        mov lr, r2
        .short 0xF800
    mov	r0, #1
    .short 0xE000
falseCounter:
    mov	r0, #0
    pop	{r4, pc}

SavageBlow:
    push	{r4, r5, lr}
    mov r3, r0
    mov r4, r1

    ldrb r0, [r3, #0xB]
    lsl r0, r0, #24
    bmi isRed2

    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bmi startSavage
    b falseSavage	@相手チェック失敗
    
isRed2:
    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bpl startSavage
    b falseSavage	@相手チェック失敗
    
startSavage:
    mov r0, r3
    mov r1, r4
    ldrb r2, [r1, #19]
    cmp r2, #0
    bne jumpSavege
    mov r1, #0	@相手のHP0なら見切り貫通
jumpSavege:
        ldr r2, HAS_SAVAGE_FUNC
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq falseSavage	@死の吐息未所持なら終了

        ldrb r0, [r4, #0xB]
        mov r1, #0xC0
        and r0, r1
        b loopStartSavage

     loopSavage:
        ldrb r0, [r5, #0xB]
    loopStartSavage:
        add r0, #1
        bl Get_Status
        mov r5, r0
        cmp r5, #0
        beq resultSavage

        ldr r0, [r5]
        cmp r0, #0
        beq loopSavage	@死亡判定1
        ldrb r0, [r5, #19] @現在19
        cmp r0, #0
        beq loopSavage	@死亡判定2
        
        ldr r0, [r5, #0xC]
        ldr r1, =0x1002C
        and r0, r1
        bne loopSavage	@居ない判定+救出中

        mov r0, #2	@within 2
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopSavage	@no exist

        ldrb r0, [r5, #19] @現在19
        sub r0, #10
        bgt hpOk2
        mov r0, #1
    hpOk2:
        strb r0, [r5, #19] @現在19
        b loopSavage

resultSavage:
    mov r0, #0xB7	@妥当な音のIDが分からん
    mov r1, #0xB8
        ldr r2, =0x08014B50 @音
        mov lr, r2
        .short 0xF800
    mov	r0, #1
    .short 0xE000
falseSavage:
    mov	r0, #0
    pop	{r4, r5, pc}

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

Jadoku:
    push	{r4, lr}
    mov r3, r0
    mov r4, r1

    ldrb r0, [r3, #0xB]
    lsl r0, r0, #24
    bmi isRed

    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bmi startJadoku
    b falseJadoku	@相手チェック失敗
    
isRed:
    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bpl startJadoku
    b falseJadoku	@相手チェック失敗
    
startJadoku:
    mov r0, r3
    mov r1, r4
        ldr r2, ADR+8
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq falseJadoku	@蛇毒未所持なら終了

@蛇毒on
    ldrb r0, [r4, #19] @現在19
    sub r0, #10
    bgt hpOk
    mov r0, #1
hpOk:
    strb r0, [r4, #19] @現在19
    
    mov r0, #0xB7	@妥当な音のIDが分からん
    mov r1, #0xB8
        ldr r2, =0x08014B50 @音
        mov lr, r2
        .short 0xF800
    mov	r0, #1
    .short 0xE000
falseJadoku:
    mov	r0, #0
    pop	{r4, pc}
    
Fury:
    push	{r4, lr}
    mov	r4, r0
        ldr	r2, ADR+4
        mov	lr, r2
        .short 0xF800
    cmp	r0, #0
    beq falseFury
    ldrb r0, [r4, #19] @現在HP
    sub	r0, #3
    bgt jumpFury
    mov	r0, #1
jumpFury:
    strb	r0, [r4, #19]
    mov	r0, #1
    b	retFury
falseFury:
    mov	r0, #0
retFury:
    pop	{r4, pc}

CanLocate:
@
@r0 = Width
@r1 = Height
@r2 = Unit
@
@[out]r0=0(踏破不可)
@
@refer to 08025398
@
        push {r4, r5, r6, lr}
        mov r4, r0
        mov r5, r1
        mov r6, r2

        ldr r1, =0x0202e4d4
        ldr r1, [r1, #0]
        lsl r2, r5, #2
        add r1, r2, r1
        ldr r1, [r1, #0]
        add r1, r1, r4
        ldrb r1, [r1, #0]
        cmp r1, #0
        bne falseLocate     @人がいる

jumpLocate:
        ldr r1, =0x0202e4d8
        ldr r1, [r1, #0]
        lsl r2, r5, #2
        add r1, r2, r1
        ldr r1, [r1, #0]
        add r1, r1, r4
        ldrb r1, [r1, #0]
        mov r0, r6
            ldr r2, =0x08019174
            mov lr, r2
            .short 0xF800
        .short 0xE000
    falseLocate:
        mov r0, #0
        pop {r4, r5, r6, pc}
CanLocateMinus:
        push {r4, r5, r6, lr}
        mov r4, r0
        mov r5, r1
        mov r6, r2
        b jumpLocate

hasDoubleLion:
    ldr r2, (ADR+16)
    mov pc, r2

HAS_SAVAGE_FUNC = (ADR+20)

FodesFunc:
    ldr r1, (ADR+24)
    mov pc, r1

GET_LUNGE:
    ldr r0, (ADR+28)
    bx lr

GET_HIT_AND_RUN:
    ldr r0, (ADR+32)
    bx lr

GET_KNOCK_BACK:
    ldr r0, (ADR+36)
    bx lr

.align
.ltorg
ADR:
