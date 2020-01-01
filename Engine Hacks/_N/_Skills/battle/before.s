SAVIOR_DAMAGE = (10)





FLY_E2_ID = (0x2D)	@てつのゆみ
ARMOR_E2_ID = (0x26)	@ハンマー
HORSE_E2_ID = (0x1B)	@ホースキラー
MONSTER_E2_ID = (0xAA)	@竜石

BL_GETITEMEFFECTIVE = (0x08017478)



.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@0x02a90c
@ステータス画面にも影響がある
@相手が存在するとは限らない(ダミーかもしれない)
.thumb
@闘技場チェック
	bl Faire
	
	bl getAlinaAdr
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne RETURN
@相手が必要ない処理

    ldr r0, [r5, #4]
    cmp r0, #0
    beq gotSkill	@相手いない
	mov	r0, r5

	bl hasMikiri
	
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

endNoEnemy:
@相手の存在をチェック
    ldr r0, [r5, #4]
    cmp r0, #0
    beq endNeedEnemy	@相手いない

	bl WarSkill
	bl shisen_B
	
    mov	r0, r5
	bl hasMikiri
    cmp r0, #0
    bne endNeedEnemy
    
    bl EffectiveBonus
    bl kishin
    bl kongou
    bl Hien
    bl koroshi
    bl DistantDef
    bl CloseDef
    
endNeedEnemy:
RETURN:
    pop {r4, r5}
    pop {r0}
    bx r0


WarSkill:
    push {lr}
	mov r0, #67
	ldrb r0, [r4, r0]
	mov r1, #0xFE
	and r0, r1
	cmp r0, r1
	bne endWar

    mov r1, #0x10
    ldr r0, [r4, #12]
    and r0, r1
    cmp r0, r1
    beq endWar @救出中なら終了

	mov r0, r4
	bl hasWarSkill
	cmp r0, #0
	beq endWar
	
    bl getDistance
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
	bl hasBond
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
	bl getExistFlagR1
	and r0, r1
	bne loopBond

jumpBond:
	mov r0, #1  @1マス指定
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

	bl hasFort

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
    
    bl hasShisen
    
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
    bl hasShisen
    cmp r0, #0
    beq falseShisen
    mov r0, r4
    bl hasMikiri
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
	bl hasSolo
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
	bl getExistFlagR1
	and r0, r1
	bne loopSolo	@居ないフラグ+救出中
	
    mov r0, #2  @2マス以内
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
@r5とr4がr0マス以内に居るならr0=TRUE
@同座標ならTRUE
@
    push {r6}
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
    pop {r6}
	bx lr

Get_Status:
	ldr r1, =0x08019108
	mov pc, r1



Ace:
	push {lr}
	mov r0, r4
	bl hasAce
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
    bl hasAtrocity
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
	bl getItemEffective
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

Faire:
    push {lr}
    bl faire_impl
    cmp r0, #0
    beq endFaire
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @自分
endFaire:
	pop {pc}

    Savior:
        push {lr}
        
        mov r0, r4
        ldr r1, SAVIOR_ADR
        _blr r1
        cmp r0, #0
        beq endSavior
        
        ldr r0, [r4, #12]
        mov r1, #0x10
        and r0, r1
        beq endSavior
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #SAVIOR_DAMAGE
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
        
        mov r0, r4
        ldrb r0, [r0, #11]
        ldr r1, Attacker_Adr
        ldr r1, [r1]
        ldrb r1, [r1, #11]
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
        
        mov r0, r4
        ldrb r0, [r0, #11]
        ldr r1, Attacker_Adr
        ldr r1, [r1]
        ldrb r1, [r1, #11]
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
	ldr r1, SHISHI_ADR
	_blr r1
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
    
    ldr r0, Attacker_Adr
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
    
    ldr r0, Attacker_Adr
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
    
    ldr r0, Attacker_Adr
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
	

faire_impl:
    push {lr}
    mov r0, r4
    add r0, #72
    ldrh r0, [r0]
    cmp r0, #0
    beq faire_merge
    ldr r1, Equipment_Adr
    _blr r1
    mov r1, r0
    
    mov r0, #0
    cmp r1, #0
    beq faire_sword
    cmp r1, #1
    beq faire_lance
    cmp r1, #2
    beq faire_axe
    cmp r1, #3
    beq faire_bow
    cmp r1, #4
    beq faire_merge
    cmp r1, #5
    beq faire_anima
    cmp r1, #6
    beq faire_light
    cmp r1, #7
    beq faire_dark
    b faire_merge
faire_sword:
    mov r0, r4
    ldr r1, SWORD_F_ADR
    _blr r1
    b faire_merge
faire_lance:
    mov r0, r4
    ldr r1, LANCE_F_ADR
    _blr r1
    b faire_merge
faire_axe:
    mov r0, r4
    ldr r1, AXE_F_ADR
    _blr r1
    b faire_merge
faire_bow:
    mov r0, r4
    ldr r1, BOW_F_ADR
    _blr r1
    b faire_merge
faire_anima:
    mov r0, r4
    ldr r1, ANIMA_F_ADR
    _blr r1
    b faire_merge
faire_light:
    mov r0, r4
    ldr r1, LIGHT_F_ADR
    _blr r1
    b faire_merge
faire_dark:
    mov r0, r4
    ldr r1, DARK_F_ADR
    _blr r1
    b faire_merge
    nop
faire_merge:
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
Attacker_Adr:
.long 0x03004df0
Equipment_Adr:
.long 0x080172f0

SAVIOR_ADR = (adr+44)


SHISHI_ADR = (adr+4)

SWORD_F_ADR = (adr+48)
LANCE_F_ADR = (adr+52)
AXE_F_ADR = (adr+56)
BOW_F_ADR = (adr+60)
ANIMA_F_ADR = (adr+64)

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
LIGHT_F_ADR = (adr+112)
DARK_F_ADR = (adr+116)
HAS_BOND_ADR = (adr+120)
HAS_ATROCITY_ADR = (adr+124)

hasMikiri:
	ldr r1, adr	@見切り
	mov pc, r1
hasAce:
	ldr r3, ACE_ADR
	mov pc, r3
hasSolo:
	ldr r3, SOLO_ADR
	mov pc, r3
hasShisen:
	ldr r3, SHISEN_ADR
	mov pc, r3
hasFort:
	ldr r3, FORT_ADR
	mov pc, r3
hasWarSkill:
	ldr r3, WAR_ADR
	mov pc, r3
hasBond:
	ldr r3, HAS_BOND_ADR
	mov pc, r3
hasAtrocity:
    ldr r2, HAS_ATROCITY_ADR
    mov pc, r2

getItemEffective:
	ldr r1, =BL_GETITEMEFFECTIVE
	mov pc, r1
getAlinaAdr:
	ldr r0, =0x0203a4d0
	bx lr
getDistance:
    ldr r0, =0x0203a4d2
    bx lr
getExistFlagR1:
	ldr r1, =0x1002C	@居ないフラグ+救出されている
	bx lr
.align
.ltorg
adr:

