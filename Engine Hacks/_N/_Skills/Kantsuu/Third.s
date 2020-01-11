.thumb
@org	0x08E4B3C0
@@月光処理を独立

STR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFF)	@フラグ
WAR_FLAG2 = (0xFE)	@フラグ

ORACLE_FLAG = (0xDD) 

HAS_DRAGON_FUNC = (adr+0)
HAS_COLOSSUS_FUNC = (adr+4)
HAS_VENGEANCE_FUNC = (adr+8)
HAS_STUN_FUNC = (adr+12)
HAS_SCREAM_FUNC = (adr+16)
HAS_IGNIS_FUNC = (adr+20)
NIHIL = (adr+24)	@見切りアドレス
SET_SKILLANIME_ATK_FUNC = (adr+28)
HAS_MAGIC_BIND_FUNC = (adr+32)
	
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
			ldr r2, NIHIL
			mov lr, r2
			.short 0xF800
		cmp r0, #1
		beq endMasterySkill @見切り持ち
		
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
		nop
	endMasterySkill:
		pop {pc}

WarSkill:
		push {lr}

		mov r0, r7
		add r0, #STR_ADR
		ldrb r0, [r0]
		mov r1, #WAR_FLAG
		cmp r0, r1
		bne endWarSkill

		bl FallenStar

		mov	r0, r8
		bl FodesFunc
		beq	endWarSkill
		ldr	r2, [r2]
		ldr	r2, [r2, #40]
		ldr	r1, [r1, #40]
		orr	r1, r2
		lsl	r1, r1, #16
		bmi	endWarSkill		@敵将に無効
		mov r0, r8
			ldr r1, NIHIL
			mov lr, r1
			.short 0xF800
		cmp r0, #1
		beq endWarSkill @見切り持ち

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
        ldr r1, HAS_VENGEANCE_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endRevenge
@奥義目印
    mov r1, #ORACLE_FLAG
    mov r10, r1
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endRevenge

	ldrb r1, [r7, #18]
	ldrb r0, [r7, #19]
	sub r0, r1, r0
	asr	r0, r0, #1
	add	r9, r0

    mov r0, r7
    ldr r1, HAS_VENGEANCE_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
	mov r0, #1
endRevenge:
	pop {pc}

Dragon:
	push {lr}
    mov r0, r7
        ldr r1, HAS_DRAGON_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endDragon
@奥義目印
    mov r1, #ORACLE_FLAG
    mov r10, r1
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq endDragon

	mov	r0, r9
	asr	r0, r0, #1
	add	r9, r0

    mov r0, r7
    ldr r1, HAS_DRAGON_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
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
        ldr r1, HAS_COLOSSUS_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endMeido
@奥義目印
    mov r1, #ORACLE_FLAG
    mov r10, r1
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
	add	r9, r0

    mov r0, r7
    ldr r1, HAS_COLOSSUS_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
	mov r0, #1
endMeido:
	pop {pc}
	
Flower:
	push {lr}
    mov r0, r7
        ldr r1, HAS_IGNIS_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endFlower
@奥義目印
    mov r1, #ORACLE_FLAG
    mov r10, r1
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
	add	r9, r0
	b mergeFlower
addStrength:
	ldrb r0, [r7, #0x14]
	asr	r0, r0, #1
	add	r9, r0
mergeFlower:
    mov r0, r7
    ldr r1, HAS_IGNIS_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
	mov r0, #1
endFlower:
	pop {pc}


FallenStar:
		push {lr}
    	mov r0, r7
		mov r1, r8
		bl hasFallenStar
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
	mov r1, r8
        ldr r2, HAS_MAGIC_BIND_FUNC
        mov lr, r2
        .short 0xF800
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
        ldr r1, HAS_STUN_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endWar
	
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x24		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b	Effect

Stone:
	push {lr}

    mov r0, r7
        ldr r1, HAS_SCREAM_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endWar
	
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x1B		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
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
	mov	r1, r9
	sub	r0, r1, r4
	strh	r0, [r5, #4]
	ldr	r1, =0x0802b3f0
	mov	pc, r1

HAS_FALLENSTAR_FUNC = (adr+36)
FODES_FUNC = (adr+40)

hasFallenStar:
ldr r2, HAS_FALLENSTAR_FUNC
mov pc, r2

FodesFunc:
ldr r2, FODES_FUNC
mov pc, r2

.align
.ltorg
adr:

