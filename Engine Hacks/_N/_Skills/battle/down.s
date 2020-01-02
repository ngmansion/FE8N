STR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFF)	@フラグ
WAR_FLAG2 = (0xFE)	@フラグ
PULSE_ID = (0x09) @奥義の鼓動
PULSE_START = (0x39)


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
	mov	r1, r6
    bl RagingStorm  @アイムール
	
	mov	r0, r7
	bl WarSkill_back
	mov	r0, r7
	ldr r1, =0x0203a4e8
	bl QuickenedPulse_back
	
	mov	r0, r7
	mov	r1, r6
	bl Fury
	
	mov	r0, r7
	mov	r1, r6
	bl DoubleLion	@HP満タンの時だけなので最後
	
	mov	r0, r7
	mov	r1, r6
	bl SavageBlow

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
	ldr r1, =0x0203a568
	bl QuickenedPulse_back
	
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


@DEFEAT   = (0b10000000) @撃破フラグ
@DEFEATED = (0b01000000) @迅雷済みフラグ
STORM    = (0b00100000) @狂嵐フラグ

@アイムール
RagingStorm:
        push {r4, lr}
		mov r4, r0
		
		ldrb r0, [r4, #11]
		mov r2, #0xC0
		and r2, r0
		bne falseStorm @自軍以外は終了


    @スキルを持っているか
        mov r0, r4	@r1は既にセット済み
        bl hasRagingStorm
        cmp r0, #0
        beq falseStorm
    @戦技を発動中か
        mov r0, #67
        ldrb r0, [r4, r0]
        mov r1, #0xFE
        and r0, r1
        cmp r0, r1
        bne falseStorm

		mov r0, r4
		add r0, #69
		ldrb r1, [r0]

		mov r2, #STORM
		orr r1, r2

		strb r1, [r0] @狂嵐発動

        mov r0, #1
        b endStorm
    falseStorm:
        mov r0, #0
    endStorm:
        pop {r4, pc}

DoubleLion:
	push	{r4, lr}
	mov	r4, r0
	
	mov	r0, r1
	bl hasNihil
	cmp	r0, #1
	beq	falseDouble
	
	mov	r0, r4
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


QuickenedPulse_back:
@装備ありで0ならリセット
@装備関係なく、鼓動なら減算
	mov r2, r0
	add r2, #48
	ldrb r0, [r2]
	cmp r0, #PULSE_ID
	beq zeroQuickenedPulse	@鼓動発動中
	mov r1, #0x0F
	and r1, r0
	cmp r1, #PULSE_ID
	bne endPusle	@鼓動ではない
@減算
	sub r0, #0x10
	b setPulse
	
zeroQuickenedPulse:
	add r1, #72
	ldrh r1, [r1]
	cmp r1, #0
	beq endPusle @装備なしなら終了
@リセット
	mov r0, #PULSE_START
setPulse:
	strb r0, [r2]
endPusle:
	bx lr

WarSkill_back:
	mov r1, r0
	add r1, #STR_ADR
	ldrb r0, [r1]
	cmp r0, #WAR_FLAG
	beq war_jump
	cmp r0, #WAR_FLAG2
	bne war_end
war_jump:
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
        ldr r2, ADR+12
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq falseCounter	@相手応撃未所持なら終了
    
    mov r0, r4
    bl hasNihil
    cmp r0, #0
    bne falseCounter	@自分見切り持ちなら終了
    
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
        ldr r2, ADR+8
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq falseJadoku	@蛇毒未所持なら終了
    
    mov r0, r4
    bl hasNihil
    cmp r0, #0
    bne falseJadoku	@見切り持ちなら終了
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
	mov	r0, r1
	bl hasNihil
	cmp	r0, #0
	bne	false
	mov	r0, r4
		ldr	r1, ADR+4
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	beq false
	ldrb r0, [r4, #19] @現在HP
	sub	r0, #3
	bgt jump
	mov	r0, #1
jump:
	strb	r0, [r4, #19]
	mov	r0, #1
	b	ret
false:
	mov	r0, #0
ret:
	pop	{r4, pc}

hasNihil:
	ldr	r1, ADR+0
	mov pc, r1

DOUBLE_LION_ADR = (ADR+16)
HAS_SAVAGE_FUNC = (ADR+20)
HAS_RASINGSTORM = (ADR+24)

hasDoubleLion:
	ldr r1, DOUBLE_LION_ADR
	mov pc, r1

hasRagingStorm:
ldr r2, HAS_RASINGSTORM
mov pc, r2

.align
.ltorg
ADR:
