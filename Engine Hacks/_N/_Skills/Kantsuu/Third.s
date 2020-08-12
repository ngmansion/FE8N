.thumb
@org	0x0802B3D8

ATTACK_FLG_OFFSET   = (69)              @書き込み先(AI2カウンタ)
FIRST_ATTACKED_FLAG = (0b00010000)



	ldr	r2, [r6, #0]
	ldr	r0, [r2, #0]
	lsl	r0, r0, #13
	lsr	r0, r0, #13
	mov	r1, #128
	lsl	r1, r1, #9
	and	r0, r1
	beq	start	@奥義なしで開始
	b	retrun
start:
	bl MasterySkill
	bl WarSkill
	b retrun

MasterySkill:
		push {lr}

		mov r0, r8
		mov r1, #0
		bl HasNihil
		cmp r0, #1
		beq endMasterySkill @見切り持ち
		
		bl Pierce
		cmp r0, #1
		beq endMasterySkill
		bl Dragon
		cmp r0, #1
		beq endMasterySkill
		bl Meido
		cmp r0, #1
		beq endMasterySkill
		bl Revenge
		cmp r0, #1
		beq endMasterySkill
		bl Flower
		cmp r0, #1
		beq endMasterySkill
		bl StanMastery
		cmp r0, #1
		beq endMasterySkill
		bl StoneMastery
		cmp r0, #1
		beq endMasterySkill
		nop
	endMasterySkill:
		pop {pc}

WarSkill:
		push {lr}

		mov r0, r8
		mov r1, #0
		bl HasNihil
		cmp r0, #1
		beq endWarSkill @見切り持ち

        mov r0, r7
        add r0, #ATTACK_FLG_OFFSET
        ldrb r0, [r0]
        mov r1, #FIRST_ATTACKED_FLAG
        and r0, r1
        bne endWarSkill                 @初撃済フラグオンならジャンプ

		bl FallenStar

		mov	r0, r8
		bl FodesFunc
		beq	endWarSkill
		mov r0, r8
		ldr r1, [r0]
		ldr	r1, [r1, #40]
		ldr r2, [r0, #4]
		ldr	r2, [r2, #40]
		orr	r1, r2
		lsl	r1, r1, #16
		bmi	endWarSkill		@敵将に無効

		bl Stan
		cmp r0, #1
		beq endWarSkill
		bl Stone
		cmp r0, #1
		beq endWarSkill
		bl MagicBind
		cmp r0, #1
		beq endWarSkill
		nop
	endWarSkill:
		pop {pc}
	
Revenge:
	push {lr}
    mov r0, r7
	mov r1, #0
    bl HasVengeance
    cmp r0, #0
    beq endRevenge
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endRevenge

	ldrb r1, [r7, #18]
	ldrb r0, [r7, #19]
	sub r0, r1, r0
	asr	r0, r0, #1

    ldrh r1, [r5, #6]
    add r1, r0
    strh r1, [r5, #6]

    mov r0, r7
    ldr r1, HAS_VENGEANCE_FUNC
    bl SetAtkSkillAnimation
	mov r0, #1
endRevenge:
	pop {pc}

Pierce:
    push {lr}
    ldr r0, =0x0203a4d2
    ldrb r0, [r0]
    cmp r0, #1
    bgt falsePierce       @近距離じゃなければ終了

    mov r0, r7
    mov r1, #0
    bl HAS_PIERCE_FUNC
    cmp r0, #0
    beq falsePierce
@奥義目印
    ldrb r0, [r7, #8]       @レベル
    mov r1, #0
    bl random
    cmp r0, #0
    beq falsePierce

    mov r4, #0              @防御or耐魔0

    mov r0, r7
    ldr r1, HAS_PIERCE
    bl SetAtkSkillAnimation
    mov r0, #1
    .short 0xE000
falsePierce:
    mov r0, #0
    pop {pc}

Dragon:
    push {lr}
    mov r0, r7
    mov r1, #0
    bl HasDragon
    cmp r0, #0
    beq endDragon
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endDragon

    ldrh r0, [r5, #6]
    asr r1, r0, #1
    add r1, r0
    strh r1, [r5, #6]

    mov r0, r7
    ldr r1, HAS_DRAGON_FUNC
    bl SetAtkSkillAnimation
    mov r0, #1
endDragon:
    pop {pc}

Meido:
	push {lr}
@	cmp	r3, #0xAA
@	beq	magicMeido
@	bl	Gecko
@	ldrb	r0, [r7, #26]
@	b	jump
@   ボディリングは無視
    mov r0, r7
	mov r1, #0
    bl HasColossus
    cmp r0, #0
    beq endMeido
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endMeido

	ldr	r0, [r7]
	ldrb	r0, [r0, #19]
	ldr	r1, [r7, #4]
	ldrb	r1, [r1, #17]
	add	r0, r0, r1

    ldrh r1, [r5, #6]
    add r1, r0
    strh r1, [r5, #6]

    mov r0, r7
    ldr r1, HAS_COLOSSUS_FUNC
    bl SetAtkSkillAnimation
	mov r0, #1
endMeido:
	pop {pc}
	
Flower:
	push {lr}
    mov r0, r7
	mov r1, #0
    bl HasIgnis
    cmp r0, #0
    beq endFlower
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endFlower

	mov	r0, #0x50
	ldrb	r0, [r7, r0]	@物理判定
	cmp	r0, #7
	beq	addStrength
	cmp	r0, #6
	beq	addStrength
	cmp	r0, #5
	beq	addStrength
	ldrb r0, [r7, #0x1A]
	asr	r0, r0, #1
	b mergeFlower
addStrength:
	ldrb r0, [r7, #0x14]
	asr	r0, r0, #1
mergeFlower:
    ldrh r1, [r5, #6]
    add r1, r0
    strh r1, [r5, #6]

    mov r0, r7
    ldr r1, HAS_IGNIS_FUNC
    bl SetAtkSkillAnimation
	mov r0, #1
endFlower:
	pop {pc}


FallenStar:
		push {lr}
		mov r0, #48
		ldrb r0, [r7, r0]
		cmp r0, #0
		bne endFallenStar       @何らかの状態異常なら終了

		mov r0, r7
		mov r1, #0
		bl HasFallenStar
		cmp r0, #0
		beq endFallenStar
		
		mov	r1, r7
		add	r1, #111
		mov	r0, #0x18		@@状態異常(5攻撃,6守備,7必殺,8回避)
		strb	r0, [r1, #0]
	endFallenStar:
		pop {pc}

MagicBind:
	push {lr}

    mov r0, r7
	mov r1, #0
    bl HasMagicBind
    cmp r0, #0
    beq endWar
	
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x23		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b	Effect


Stan:
	push {lr}

    mov r0, r7
	mov r1, #0
    bl HasStan
    cmp r0, #0
    beq endWar
	
trueStan:
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x24		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b	Effect

StanMastery:
	push {lr}

    mov r0, r7
	mov r1, #0
    bl HAS_STAN_MASTERY
    cmp r0, #0
    beq endWar

    ldrb r0, [r7, #21]       @技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endWar

	bl GET_STAN_MASTERY
	mov r1, r0
    mov r0, r7
    bl SET_SKILLANIME_ATK_FUNC
		mov	r0, r8
		bl FodesFunc
		beq	endWar
		mov r0, r8
		ldr r1, [r0]
		ldr	r1, [r1, #40]
		ldr r2, [r0, #4]
		ldr	r2, [r2, #40]
		orr	r1, r2
		lsl	r1, r1, #16
		bmi	endWar		@敵将に無効
	b	trueStan


Stone:
	push {lr}

    mov r0, r7
    mov r1, #0
	bl HasScream
    cmp r0, #0
    beq endWar
trueStone:
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x1B		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b Effect

StoneMastery:
	push {lr}

    mov r0, r7
    mov r1, #0
	bl HAS_STONE_MASTERY
    cmp r0, #0
    beq endWar

    ldrb r0, [r7, #21]       @技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endWar

	bl GET_STONE_MASTERY
	mov r1, r0
    mov r0, r7
    bl SET_SKILLANIME_ATK_FUNC
		mov	r0, r8
		bl FodesFunc
		beq	endWar
		mov r0, r8
		ldr r1, [r0]
		ldr	r1, [r1, #40]
		ldr r2, [r0, #4]
		ldr	r2, [r2, #40]
		orr	r1, r2
		lsl	r1, r1, #16
		bmi	endWar		@敵将に無効
	b trueStone
	
Effect:	@状態異常特殊エフェクト
@@	ldr	r3, =0x0203A604
	ldr	r3, [r6]
	ldr	r2, [r3]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #64
	orr	r0, r1
	str	r0, [r3, #0]
noEffect:
	mov	r3, r8
	mov	r0, #48
	ldrb	r0, [r3, r0]
	mov	r1, #15
	and	r1, r0
	cmp	r1, #11
	beq	ouiStone
	cmp	r1, #13
	bne	endWar
ouiStone:
	ldr	r0, [r3, #12]
	mov	r1, #3
	neg	r1, r1
	and	r0, r1
	str	r0, [r3, #12]
endWar:
	pop {pc}


random:
	ldr	r3, =0x0802a490
	mov	pc, r3

retrun:
	ldr	r1, =0x0802b3ea
	mov	pc, r1

HAS_DRAGON_FUNC = (adr+0)
HAS_COLOSSUS_FUNC = (adr+4)
HAS_VENGEANCE_FUNC = (adr+8)
HAS_STUN_FUNC = (adr+12)
HAS_SCREAM_FUNC = (adr+16)
HAS_IGNIS_FUNC = (adr+20)
NIHIL = (adr+24)	@見切りアドレス
@SET_SKILLANIME_ATK_FUNC = (adr+28)
HAS_MAGIC_BIND_FUNC = (adr+32)
HAS_FALLENSTAR_FUNC = (adr+36)
FODES_FUNC = (adr+40)
HAS_PIERCE = (adr+44)

HasNihil:
	ldr r2, NIHIL
	mov pc, r2

HasScream:
	ldr r2, HAS_SCREAM_FUNC
	mov pc, r2

HasStan:
	ldr r2, HAS_STUN_FUNC
	mov pc, r2

HasMagicBind:
	ldr r2, HAS_MAGIC_BIND_FUNC
	mov pc, r2

HasIgnis:
	ldr r2, HAS_IGNIS_FUNC
	mov pc, r2

HasColossus:
	ldr r2, HAS_COLOSSUS_FUNC
	mov pc, r2

HasDragon:
    ldr r2, HAS_DRAGON_FUNC
    mov pc, r2

HasVengeance:
    ldr r2, HAS_VENGEANCE_FUNC
    mov pc, r2

SetAtkSkillAnimation:
    ldr r1, [r1, #12]
    ldr r2, (adr+28)
    mov pc, r2

SET_SKILLANIME_ATK_FUNC:
    ldr r2, (adr+28)
    mov pc, r2

HasFallenStar:
ldr r2, HAS_FALLENSTAR_FUNC
mov pc, r2

FodesFunc:
ldr r2, FODES_FUNC
mov pc, r2

HAS_PIERCE_FUNC:
ldr r2, HAS_PIERCE
mov pc, r2

HAS_STAN_MASTERY:
ldr r2, (adr+48)
mov pc, r2

GET_STAN_MASTERY:
ldr r0, (adr+48)
ldr r0, [r0, #12]
bx lr

HAS_STONE_MASTERY:
ldr r2, (adr+52)
mov pc, r2

GET_STONE_MASTERY:
ldr r0, (adr+52)
ldr r0, [r0, #12]
bx lr

.align
.ltorg
adr:

