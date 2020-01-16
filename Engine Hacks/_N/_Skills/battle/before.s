DEFENDER_DAMAGE = (10)


FLY_E2_ID = (0x2D)	@てつのゆみ
ARMOR_E2_ID = (0x26)	@ハンマー
HORSE_E2_ID = (0x1B)	@ホースキラー
MONSTER_E2_ID = (0xAA)	@竜石

BL_GETITEMEFFECTIVE = (0x08017478)



.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@ 0802a90c
@ステータス画面にも影響がある
@相手が存在するとは限らない(ダミーかもしれない)
.thumb
@闘技場チェック
	bl GetAlinaAdr
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne RETURN
@相手が必要ない処理

    ldr r0, [r5, #4]
    cmp r0, #0
    beq gotSkill	@相手いない
	mov	r0, r5

	bl HasMikiri
	
	cmp r0, #0
	bne endNoEnemy	@見切り持ちなら終了
gotSkill:
	bl Shishi
	bl Konshin
	bl Savior	@護り手
	bl Ace
	bl shisen_A
	bl Solo
	bl Fort
    bl Bond
    bl BladeSession
endNoEnemy:

@相手の存在をチェック
    ldr r0, [r5, #4]
    cmp r0, #0
    beq endNeedEnemy	@相手いない

	bl WarSkill
	bl shisen_B
	
    mov	r0, r5
	bl HasMikiri
    cmp r0, #0
    bne endNeedEnemy
    
    bl EffectiveBonus
    bl kishin
    bl kongou
    bl Hien
    bl koroshi
    bl DistantDef
    bl CloseDef
    bl ShieldSession

    bl WaryFighter
endNeedEnemy:

@マイナス処理
    bl Heartseeker
    bl Daunt

RETURN:
    pop {r4, r5}
    pop {r0}
    bx r0

ShieldSession:
        push {r5, r6, r7, lr}

        mov r1, r4
        ldrb r1, [r1, #11]
        bl GetAttackerAddr
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        cmp r0, r1
        beq endShieldSession	@攻撃者と一致

        mov r0, r4
        mov r1, r5
        bl HasShieldSession
        cmp r0, #0
        beq endShieldSession
    
        mov r7, #0
        ldrb r0, [r4, #0xB]
        lsl r0, r0, #24
        bmi isRedShieldSession
        mov r6, #0x80
    
        bl ShieldSession_impl
        b calcShieldSession
    isRedShieldSession:
        mov r6, #0x00
        bl ShieldSession_impl
        mov r6, #0x40
        bl ShieldSession_impl
    calcShieldSession:
        mov r0, #6
        mov r1, #2
        mul r1, r7
        sub r0, r1
        bgt jumpShieldSession
        mov r0, #0
    jumpShieldSession:
        mov r1, #92
        ldrh r2, [r4, r1]
        add r2, r0
        strh r2, [r4, r1]
    endShieldSession:
        pop {r5, r6, r7, pc}

ShieldSession_impl:
        push {lr}
    loopShieldSession:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq resultShieldSession  @リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopShieldSession @死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopShieldSession @死亡判定2
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1
        tst r0, r1
        bne loopShieldSession
        mov r1, #0x2
        tst r0, r1
        beq loopShieldSession  @未行動

        mov r0, #2  @2マス指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopShieldSession
        add r7, #1
        b loopShieldSession
    resultShieldSession:
        pop {pc}

BladeSession:
        push {r5, r6, r7, lr}
        bl BladeSessionOne  @自己強化
        bl BladeSessionAll  @周囲強化
        pop {r5, r6, r7, pc}

BladeSessionAll:
        push {lr}
        ldrb r6, [r4, #0xB]
        mov r0, #0xC0
        and r6, r0  @r6に部隊表ID
       
    loopBladeSessionAll:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq falseBladeSessionAll  @リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopBladeSessionAll @死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopBladeSessionAll @死亡判定2
        ldrb r0, [r4, #0xB]
        ldrb r1, [r5, #0xB]
        cmp r0, r1
        beq loopBladeSessionAll @自分
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1
        tst r0, r1
        bne loopBladeSessionAll @居ない
        mov r1, #0x2
        tst r0, r1
        beq loopBladeSessionAll  @未行動
        mov r0, r5
        mov r1, #0
        bl HasBladeSession
        cmp r0, #0
        beq loopBladeSessionAll
  
        mov r0, #2  @2マス指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        bne trueBladeSessionAll
        b loopBladeSessionAll
    trueBladeSessionAll:
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #3
        strh r0, [r4, r1]
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #3
        strh r0, [r4, r1]
    falseBladeSessionAll:
        pop {pc}

BladeSessionOne:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasBladeSession
        cmp r0, #0
        beq falseBladeSession

        ldrb r6, [r4, #0xB]
        mov r0, #0xC0
        and r6, r0  @r6に部隊表ID

        mov r7, #0
    loopBladeSession:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq resultBladeSession  @リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopBladeSession @死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopBladeSession @死亡判定2
        ldrb r0, [r4, #0xB]
        ldrb r1, [r5, #0xB]
        cmp r0, r1
        beq loopBladeSession @自分
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1
        tst r0, r1
        bne loopBladeSession
        mov r1, #0x2
        tst r0, r1
        beq loopBladeSession  @未行動
  
        mov r0, #2  @2マス指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopBladeSession
        add r7, #1
        b loopBladeSession
    resultBladeSession:
        mov r2, #3
        mul r2, r7
        cmp r2, #9
        ble limitBladeSession
        mov r2, #9
    limitBladeSession:
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, r2
        strh r0, [r4, r1] @自分
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, r2
        strh r0, [r4, r1] @自分
    falseBladeSession:
        pop {pc}

WaryFighter:
        push {lr}
        ldrb r1, [r4, #0xb]
        bl GetAttackerAddr
        ldr r0, [r0]
        ldrb r0, [r0, #0xb]
        cmp r0, r1
        beq falseWaryFighter
        mov r0, r4
        mov r1, r5
        bl HasWaryFighter
        cmp r0, #0
        beq falseWaryFighter
        mov r0, #0
        mov r1, #98 @回避
        strh r0, [r4, r1]

        mov r0, #1
        b endWaryFighter
    falseWaryFighter:
        mov r0, #0
    endWaryFighter:
        pop {pc}

Daunt:
@青は赤に対して効く
@赤は青と緑に対して効く
@緑は赤に対して効く
	push {r4, r5, r6, r7, lr}

    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bmi isRedDaunt
    mov r6, #0x80
    bl Daunt_impl
    b endDaunt
isRedDaunt:
    mov r6, #0x00
    bl Daunt_impl
    mov r6, #0x40
    bl Daunt_impl
endDaunt:
	pop {r4, r5, r6, r7, pc}

Daunt_impl:
        push {lr}
        mov r7, #0
    loopDaunt:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq resultDaunt	@リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopDaunt	@死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopDaunt	@死亡判定2
    
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1	@居ないフラグ+救出されている
        and r0, r1
        bne loopDaunt
    
        mov r0, #3  @範囲指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopDaunt @近くにいない
    
        mov r0, r5
        mov r1, r4
        bl HasDaunt
        cmp r0, #0
        beq loopDaunt    @相手が恐怖未所持
    
        add r7, #1
        b loopDaunt
    
    resultDaunt:
        mov r2, #15 @マイナス15
        mul r2, r7
    
        mov r1, #98 @回避
        ldrh r0, [r4, r1]
        sub r0, r2
        bgt limitDaunt1
        mov r0, #0
    limitDaunt1:
        strh r0, [r4, r1]

        mov r1, #102 @必殺
        ldrh r0, [r4, r1]
        sub r0, r2
        bgt limitDaunt2
        mov r0, #0
    limitDaunt2:
        strh r0, [r4, r1]
        pop {pc}

Heartseeker:
@青は赤に対して効く
@赤は青と緑に対して効く
@緑は赤に対して効く
	push {r4, r5, r6, r7, lr}

    ldrb r0, [r4, #0xB]
    lsl r0, r0, #24
    bmi isRedHeartseeker
    mov r6, #0x80
    bl Heartseeker_impl
    b endHeartseeker
isRedHeartseeker:
    mov r6, #0x00
    bl Heartseeker_impl
    mov r6, #0x40
    bl Heartseeker_impl
endHeartseeker:
	pop {r4, r5, r6, r7, pc}

Heartseeker_impl:
        push {lr}
        mov r7, #0
    loopHeartseeker:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq resultHeartseeker	@リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopHeartseeker	@死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopHeartseeker	@死亡判定2
    
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1	@居ないフラグ+救出されている
        and r0, r1
        bne loopHeartseeker
    
        mov r0, #1  @1マス指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopHeartseeker @近くにいない
    
        mov r0, r5
        mov r1, r4
        bl HasHeartseeker
        cmp r0, #0
        beq loopHeartseeker    @相手が呪縛未所持
    
        add r7, #1
        b loopHeartseeker
    
    resultHeartseeker:
        mov r2, #20 @マイナス20
        mul r2, r7
    
        mov r1, #98 @回避
        ldrh r0, [r4, r1]
        sub r0, r2
        bgt limitHeartseeker
        mov r0, #0
    limitHeartseeker:
        strh r0, [r4, r1] @自分
        pop {pc}


WarSkill:
    push {lr}
	mov r0, #67
	ldrb r0, [r4, r0]
	mov r1, #0xFE
	and r0, r1
	cmp r0, r1
	bne endWar

    ldrb r0, [r4, #27]
    cmp r0, #0
    bne jumpWarSkill
    mov r1, #0x10
    ldr r0, [r4, #12]
    and r0, r1
    cmp r0, r1
    beq endWar @捕獲攻撃中なら終了
jumpWarSkill:

	mov r0, r4
	bl HasWarSkill
	cmp r0, #0
	beq endWar
	
    bl GetDistance
    ldrb r0, [r0]
    cmp r0, #1
    bne distantWar  @遠距離は弱体化

	mov r1, #90
	ldrh r0, [r4, r1]
	add r0, #6
	strh r0, [r4, r1] @自分

	mov r1, #96
	ldrh r0, [r4, r1]
	add r0, #10
	strh r0, [r4, r1] @自分
    b endWar
distantWar:
	mov r1, #90
	ldrh r0, [r4, r1]
	add r0, #3
	strh r0, [r4, r1] @自分

endWar:
	pop {pc}

Bond:
	push {r4, r5, r6, r7, lr}
	ldrb r6, [r4, #0xB]
	mov r0, #0xC0
	and r6, r0	@r6に部隊表ID
	
	mov r0, r4
    mov r1, #0
	bl HasBond
	cmp r0, #0
	beq falseBond
	mov r7, #0
loopBond:
	add r6, #1
	mov r0, r6
	bl Get_Status
	mov r5, r0
	cmp r0, #0
	beq resultBond	@リスト末尾
	ldr r0, [r5]
	cmp r0, #0
	beq loopBond	@死亡判定1
	ldrb r0, [r5, #19]
	cmp r0, #0
	beq loopBond	@死亡判定2
	ldrb r0, [r4, #0xB]
	ldrb r1, [r5, #0xB]
	cmp r0, r1
	beq loopBond	@自分
	ldr r0, [r5, #0xC]
	bl GetExistFlagR1
	and r0, r1
	bne loopBond

jumpBond:
	mov r0, #1  @1マス指定
	mov r1, r4
	mov r2, r5
	bl CheckXY
	cmp r0, #0
	beq loopBond
    add r7, #1
	b loopBond
resultBond:
    mov r2, #3
    mul r2, r7
    cmp r2, #7
    ble limitBond
    mov r2, #7
limitBond:
	mov r1, #90
	ldrh r0, [r4, r1]
	add r0, r2
	strh r0, [r4, r1] @自分
	mov r1, #92
	ldrh r0, [r4, r1]
	add r0, r2
	strh r0, [r4, r1] @自分
falseBond:
	pop {r4, r5, r6, r7, pc}

Fort:
	push {lr}
	mov r0, r4

	bl HasFort

	cmp r0, #0
	beq falseFort

	mov r1, r4
	add r1, #90
	ldrh r0, [r1]
	sub r0, #2
	bge jumpFort
	mov r0, #0
jumpFort:
	strh r0, [r1] @自分
	
	mov r1, r4
	add r1, #92
	ldrh r0, [r1]
	add r0, #4
	strh r0, [r1] @自分
	
	mov r0, #1
	b endFort
falseFort:
	mov r0, #0
endFort:
	pop {pc}

shisen_A:	@自分死線
    push {lr}
    mov r0, r4
    
    bl HasShisen
    
    cmp r0, #0
    beq falseShisen
    
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] @自分
    mov r1, r4
    mov r0, #94
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #94
    strh r0, [r1] @自分
    mov r0, #1
    b endShisen
falseShisen:
    mov r0, #0
endShisen:
    pop {pc}

shisen_B:	@相手死線
    push {lr}
    mov r0, r5
    bl HasShisen
    cmp r0, #0
    beq falseShisen
    mov r0, r4
    bl HasMikiri
    cmp r0, #0
    bne falseShisen	@見切り持ちなら終了
    
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] @自分
    mov r0, #1
    b endShisen


Solo:
	push {r4, r5, r6, lr}
	ldrb r6, [r4, #0xB]
	mov r0, #0xC0
	and r6, r0	@r6に部隊表ID
	
	mov r0, r4
	bl HasSolo
	cmp r0, #0
	beq falseSolo
	
loopSolo:
	add r6, #1
	mov r0, r6
	bl Get_Status
	mov r5, r0
	cmp r0, #0
	beq trueSolo	@リスト末尾
	ldr r0, [r5]
	cmp r0, #0
	beq loopSolo	@死亡判定1
	ldrb r0, [r5, #19]
	cmp r0, #0
	beq loopSolo	@死亡判定2
	ldrb r0, [r4, #0xB]
	ldrb r1, [r5, #0xB]
	cmp r0, r1
	beq loopSolo	@自分
	ldr r0, [r5, #0xC]
	bl GetExistFlagR1
	and r0, r1
	bne loopSolo	@居ないフラグ+救出中
	
    mov r0, #2  @2マス以内
    mov r1, r4
    mov r2, r5
	bl CheckXY
	cmp r0, #1
	beq falseSolo
	b loopSolo
trueSolo:
	mov r1, #90
	ldrh r0, [r4, r1]
	add r0, #3
	strh r0, [r4, r1] @自分
	mov r1, #94
	ldrh r0, [r4, r1]
	add r0, #3
	strh r0, [r4, r1] @自分
falseSolo:
	pop {r4, r5, r6, pc}

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



Ace:
	push {lr}
	mov r0, r4
	bl HasAce
	cmp	r0, #0
	beq	endAce

	ldrb	r0, [r4, #0x13]	@NOW
	ldrb	r1, [r4, #0x12]	@MAX
	lsl	r0, r0, #1
	cmp	r0, r1
	bgt	endAce
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #8
    strh r0, [r4, r1] @自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #8
    strh r0, [r4, r1] @自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #8
    strh r0, [r4, r1] @自分
	
endAce:
	pop {pc}
	

EffectiveBonus:
    push {lr}
	mov r0, #67
	ldrb r0, [r4, r0]
	mov r1, #0xFE
	and r0, r1
	cmp r0, r1
	bne endEffective
	
	mov r1, r4
	add r1, #72
	ldrh r0, [r1]
	cmp r0, #0
	beq endEffective
	mov r1, r5
	ldr r2, =0x08016994 @特効判定
	_blr r2
	cmp r0, #1
	beq endEffective
	
	mov r0, r4
	mov r1, r5
	ldr r2, =0x08016a30 @魔物特効
	_blr r2
	cmp r0, #1
	beq endEffective
@Grounder
	mov r0, #FLY_E2_ID
	ldr r1, FLY_E_ADR

	bl effective_impl
	cmp r0, #1
	beq getEffective
@HelmSplitter
	mov r0, #ARMOR_E2_ID
	ldr r1, ARMOR_E_ADR

	bl effective_impl
	cmp r0, #1
	beq getEffective
@@@@@
	mov r0, #HORSE_E2_ID
	ldr r1, HORSE_E_ADR
	bl effective_impl
	cmp r0, #1
	beq getEffective
@@@@@
	mov r0, #MONSTER_E2_ID
	ldr r1, MONSTER_E_ADR
	bl effective_impl
	cmp r0, #1
	beq getEffective
@無惨
    mov r0, r4
    mov r1, r5
    bl HasAtrocity
	cmp r0, #1
	beq getEffective

	b endEffective
getEffective:
	mov r1, r4
	add r1, #72
	ldrh r0, [r1]
	ldr r1, =0x08017384
    _blr r1
	
	mov	r1, r4
	add	r1, #84
	ldrb	r1, [r1, #0]	@武器相性
	lsl	r1, r1, #24
	asr	r1, r1, #24
	add	r1, r1, r0
	mov	r2, r4
	add	r2, #90
	ldrh	r0, [r2]
	add r0, r0, r1
	strh	r0, [r2]
	
endEffective:
	pop {pc}

effective_impl:
@r0に特効リストを利用する武器のID
@r1にとび先
    push {r4, r5, r6, lr}

	eor r4, r0
	eor r0, r4
	eor r4, r0
	
	_blr r1
	cmp r0, #0
	beq falseEffective_impl
	mov r0, r4
	bl GetItemEffective
@r4に装備武器
@r5に相手アドレス
@r6に特効リスト
	mov r6, r0
    mov r3, r4
    mov r1, r6
    mov r4, r5
    ldr r2, [r4, #4]
    ldrb r2, [r2, #4]	@r2に相手兵種ID
    ldr r5, =0x080161B8
    ldr r5, [r5]	@r5にアイテムリスト先頭アドレス
    ldr r0, =0x080169c8
    mov pc, r0
falseEffective_impl:
    mov r0, #0
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1

Savior:
        push {lr}
        
        mov r0, r4
        mov r1, #0
        bl HasSavior
        cmp r0, #0
        beq endSavior
        
        ldr r0, [r4, #12]
        mov r1, #0x10
        and r0, r1
        beq endSavior

        ldrb r0, [r4, #27]
        cmp r0, #0
        beq endSavior

        ldrb r1, [r4, #0xB]
        lsr r0, r0, #30
        lsr r1, r1, #30
        cmp r0, r1
        bne endSavior
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #DEFENDER_DAMAGE
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endSavior:
        mov r0, #0
        pop {pc}

DistantDef:
        push {lr}
        ldr r0, Range_Adr
        ldrb r0, [r0] @距離
        cmp r0, #1
        ble endDistantDef
        
        mov r1, r4
        ldrb r1, [r1, #11]
        bl GetAttackerAddr
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        cmp r0, r1
        beq endDistantDef	@攻撃者と一致
        
        mov r0, r4
        ldr r1, adr+40	@遠距離防御
        _blr r1
        cmp r0, #0
        beq endDistantDef
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endDistantDef:
        mov r0, #0
        pop {pc}
        

CloseDef:
        push {lr}
        ldr r0, Range_Adr
        ldrb r0, [r0] @距離
        cmp r0, #1
        bne endCloseDef
        
        mov r1, r4
        ldrb r1, [r1, #11]
        bl GetAttackerAddr
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        cmp r0, r1
        beq endCloseDef	@攻撃者と一致
        
        mov r0, r4
        ldr r1, adr+36 @近距離防御
        _blr r1
        cmp r0, #0
        beq endCloseDef
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endCloseDef:
        mov r0, #0
        pop {pc}

koroshi:
    push {lr}
    bl breaker_impl
    cmp r0, #0
    beq falseKoroshi
gotKoroshi:
    bl setKoroshi
    mov r0, #1
    b endKoroshi
falseKoroshi:
    mov r0, #0
endKoroshi:
	pop {pc}
	
setKoroshi:
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #96
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] @自分
    
    mov r1, #98
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] @自分
    bx lr
	
	
    
Shishi:
	push {lr}
	mov r0, r4
    mov r1, #0
	ldr r2, SHISHI_ADR
	_blr r2
	cmp r0, #0
	beq falseShishi
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
falseShishi:
	mov r0, #0
	pop {pc}

Konshin:
    push {lr}
    mov r0, r4
    ldr r1, KONSHIN_ADR
    _blr r1
    cmp r0, #0
    beq falseKonshin
    
	ldrb r1, [r4, #18] @最大HP
	ldrb r0, [r4, #19] @現在HP
	cmp r0, r1
	blt falseKonshin @現在が最大よりも小さい場合
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
falseKonshin:
	mov r0, #0
	pop {pc}
    
kishin:
    push {lr}
    mov r0, r4
    ldr r1, adr+8	@鬼神
    _blr r1
    cmp r0, #0
    beq falseKishin
    
    bl GetAttackerAddr
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne falseKishin
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #5 @威力
    strh r0, [r4, r1] @自分

    mov r1, #102
    ldrh r0, [r4, r1]
    add r0, #15 @必殺
    strh r0, [r4, r1] @自分
    mov r0, #1
    b endKishin
falseKishin:
	mov r0, #0
endKishin:
	pop {pc}

    
    

kongou:
    push {lr}
    mov r0, r4
    ldr r1, adr+12 @金剛
    _blr r1
    cmp r0, #0
    beq falseKongou
    
    bl GetAttackerAddr
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne falseKongou
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #10
    strh r0, [r4, r1]
    mov r0, #1
    b endKongou
falseKongou:
	mov r0, #0
endKongou:
	pop {pc}
	
	
	
	
	
Hien:
    push {lr}
    mov r0, r4
    ldr r1, HIEN_ADR
    _blr r1
    cmp r0, #0
    beq falseHien
    
    bl GetAttackerAddr
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne falseHien
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #5
    strh r0, [r4, r1]
    
    mov r1, #98
    ldrh r0, [r4, r1]
    add r0, #30
    strh r0, [r4, r1]
    
    mov r0, #1
    b endHien
falseHien:
	mov r0, #0
endHien:
	pop {pc}


breaker_impl:
    push {lr}
    mov r0, r5
    add r0, #74
    ldrh r0, [r0]
    ldr r1, Equipment_Adr
    _blr r1
    cmp r0, #0
    beq sword
    cmp r0, #1
    beq lance
    cmp r0, #2
    beq axe
    cmp r0, #3
    beq bow
    cmp r0, #4
    beq falseBreaker
    cmp r0, #7
    ble magic
    b falseBreaker
sword:
    mov r0, r4
    ldr r1, adr+16
    _blr r1
    b endBreaker
lance:
    mov r0, r4
    ldr r1, adr+20
    _blr r1
    b endBreaker
axe:
    mov r0, r4
    ldr r1, adr+24
    _blr r1
    b endBreaker
bow:
    mov r0, r4
    ldr r1, adr+28
    _blr r1
    b endBreaker
magic:
    mov r0, r4
    ldr r1, adr+32
    _blr r1
    b endBreaker
falseBreaker:
    mov r0, #0
endBreaker:
    pop {pc}
.align
Range_Adr:
.long 0x0203a4d2
Equipment_Adr:
.long 0x080172f0

SAVIOR_ADR = (adr+44)


SHISHI_ADR = (adr+4)

BLADE_SESSION_ADDR = (adr+48)
SHIELD_SESSION_ADDR = (adr+52)
@AXE_F_ADR = (adr+56)
@BOW_F_ADR = (adr+60)

WARYFIGHTER_ADR = (adr+64)

FLY_E_ADR = (adr+68)
ARMOR_E_ADR = (adr+72)
HORSE_E_ADR = (adr+76)
MONSTER_E_ADR = (adr+80)
HIEN_ADR = (adr+84)
ACE_ADR = (adr+88)
KONSHIN_ADR = (adr+92)
SOLO_ADR = (adr+96)
SHISEN_ADR = (adr+100)
FORT_ADR = (adr+104)
WAR_ADR = (adr+108)
HEARTSEEKER_ADR = (adr+112)
DAUNT_ADR = (adr+116)
HAS_BOND_ADR = (adr+120)
HAS_ATROCITY_ADR = (adr+124)

HasBladeSession:
    ldr r2, BLADE_SESSION_ADDR
	mov pc, r2
HasShieldSession:
    ldr r2, SHIELD_SESSION_ADDR
	mov pc, r2
GetAttackerAddr:
    ldr r0, =0x03004df0
    bx lr
HasWaryFighter:
    ldr r2, WARYFIGHTER_ADR
	mov pc, r2
HasDaunt:
    ldr r2, DAUNT_ADR
	mov pc, r2
HasHeartseeker:
    ldr r2, HEARTSEEKER_ADR
	mov pc, r2
HasSavior:
	ldr r2, SAVIOR_ADR
	mov pc, r2
HasMikiri:
	ldr r1, adr	@見切り
	mov pc, r1
HasAce:
	ldr r3, ACE_ADR
	mov pc, r3
HasSolo:
	ldr r3, SOLO_ADR
	mov pc, r3
HasShisen:
	ldr r3, SHISEN_ADR
	mov pc, r3
HasFort:
	ldr r3, FORT_ADR
	mov pc, r3
HasWarSkill:
	ldr r3, WAR_ADR
	mov pc, r3
HasBond:
	ldr r3, HAS_BOND_ADR
	mov pc, r3
HasAtrocity:
    ldr r2, HAS_ATROCITY_ADR
    mov pc, r2

GetItemEffective:
	ldr r1, =BL_GETITEMEFFECTIVE
	mov pc, r1
GetAlinaAdr:
	ldr r0, =0x0203a4d0
	bx lr
GetDistance:
    ldr r0, =0x0203a4d2
    bx lr
GetExistFlagR1:
	ldr r1, =0x1002C	@居ないフラグ+救出されている
	bx lr
.align
.ltorg
adr:

