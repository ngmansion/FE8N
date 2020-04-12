
SWORD = (0)

TENKU_ADR = (adr+0)
YOUKO_ADR = (adr+4)
ASTRA_ADR = (adr+8)
IMPALE_ADR = (adr+12)
ECRIPSE_ADR = (adr+16)
JIHAD_ADR = (adr+20)
SET_SKILLANIME_ATK_FUNC = (adr+24)
HAS_NIHIL_FUNC = (adr+28)
HAS_RAPTURE =  (adr+36)

.thumb
@.org	0802b484
@武器レベルチェック

	ldr	r2, [r6, #0]
	ldr	r0, [r2, #0]
	lsl	r0, r0, #13
	lsr	r0, r0, #13
	mov	r1, #128
	lsl	r1, r1, #9
	and	r0, r1
	beq	start	@奥義なしで開始
	b	return
start:
    mov r0, r8
        ldr r2, HAS_NIHIL_FUNC
        mov lr, r2
        .short 0xF800
	cmp r0, #1
	beq return	@見切り持ちなので終了

	bl jihad_impl @ジハド
	cmp r0, #1
	beq return

	bl tenku_impl @天空・陽光
	cmp r0, #1
	beq return
	
	bl astra_impl @流星
	cmp r0, #1
	beq return
	
	bl RupturedSky  @破天
	cmp r0, #1
	beq return

	bl impale_impl @撃破
	cmp r0, #1
	beq return

	bl ecripse_impl @月食
	cmp r0, #1
	beq return
	

	b return

return:
	mov	r1, #4
	ldsh	r0, [r4, r1]
	cmp	r0, #127
	ble	nonmax
	mov	r0, #127
	strh	r0, [r4, #4]
nonmax:
    ldr r0, =0x0802b48e
    mov pc, r0


RupturedSky:
    push {lr}
@ユニットチェック
    mov r0, r7
        ldr r1, HAS_RAPTURE        @撃破
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseRapture
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseRapture

    mov r0, r8
    add r0, #90
    ldrh r0, [r0]

    mov r1, #3
    mul r0, r1
    mov r1, #10
    swi #6      @3割

    mov r1, #4
    ldsh r1, [r5, r1] @ ダメージ
    add r0, r0, r1
    strh r0, [r5, #4]
    
    mov r0, r7
    ldr r1, HAS_RAPTURE        @撃破
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    mov r0, #1
    .short 0xE000
falseRapture:
    mov r0, #0
    pop {pc}

jihad_impl:
@ジハド
@
@
    push {lr}

    ldr r0, =0x0203a4d2
    ldrb r0, [r0]
    cmp r0, #1
    bne falseJihad @近距離しか発動しない
@ユニットチェック
    mov r0, r7
        ldr r1, JIHAD_ADR	@ジハド
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseJihad
    
    ldrb r1, [r7, #0x13] @nowHP
    ldrb r0, [r7, #0x12] @maxHP
    sub r0, r1
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseJihad

@必殺減衰処理
    ldr r0, [r6]
    ldr r0, [r0]
    lsl r0, r0, #31
    bpl not_dec @無必殺はなし
    mov r0, #4
    ldsh r0, [r5, r0]
    cmp r0, #0
    ble not_dec @ノーダメ以下はなし
    mov r1, #3
    swi #6      @1/3
    strh r1, [r5, #4]
not_dec:
    mov r0, #4
    ldsh r0, [r5, r0] @ダメージ
    mov r1, #6
    ldsh r1, [r5, r1] @攻撃力
    add r0, r0, r1
    strh r0, [r5, #4] @ダメージ
    
    mov r0, r7
    ldr r1, JIHAD_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    b sol_crt
falseJihad:
    mov r0, #0
    pop {pc}


ecripse_impl:
@月食
@
@
    push {lr}
    ldr r0, [r7, #76]
    lsl r0, r0, #24
    bmi falseEcripse @反撃不可武器チェック
    mov r0, #4
    ldsh r0, [r5, r0]
    cmp r0, #0
    ble falseEcripse@ダメージがゼロなら発動しない

    mov r2, r8
    ldrb r1, [r2, #0x13] @nowHP
    cmp r0, r1
    bge falseEcripse @一撃なら不発
    ldrb r0, [r2, #0x12] @maxHP
    cmp r0, r1
    beq falseEcripse @体力最大なら不発
    
    ldr r0, [r2]
    ldr r1, [r2, #4]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
    ldr r1, =0x01008000
    and r0, r1
    bne falseEcripse @敵将チェック

    mov r0, r8
    bl CheckFodes
    cmp r0, #1
    beq falseEcripse    @フォデス効果

@ユニットチェック
    mov r0, r7
        ldr r1, ECRIPSE_ADR	@月食
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseEcripse

    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseEcripse

    mov r0, r8
    ldrb r0, [r0, #0x13] @nowHP
    sub r0, #1
    strh r0, [r5, #4]
    
    mov r0, r7
    ldr r1, ECRIPSE_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    b effect_crt
falseEcripse:
    mov r0, #0
    pop {pc}


impale_impl:
@撃破
@
@
    push {lr}
@ダメージがゼロなら発動しない
    mov r0, #4
    ldsh r0, [r5, r0]
    cmp r0, #0
    ble falseImpale
@ユニットチェック
    mov r0, r7
        ldr r1, IMPALE_ADR	@撃破
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseImpale
@奥義目印
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseImpale

    mov r0, #6
    ldsh r0, [r5, r0] @攻撃
    mov r1, #8
    ldsh r1, [r5, r1] @防御
    sub r0, r0, r1
    asr r0, r0, #1

    mov r1, #4
    ldsh r1, [r5, r1] @ ダメージ
    add r0, r0, r1
    strh r0, [r5, #4]
    
    mov r0, r7
    ldr r1, IMPALE_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    mov r0, #1
    .short 0xE000
falseImpale:
    mov r0, #0
    pop {pc}

    
astra_impl:
@流星
@
@
    push {lr}
    mov r0, r7
        ldr r1, ASTRA_ADR	@流星
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseAstra
ouiAstra:
	mov	r0, #4
	ldsh	r0, [r5, r0]
	cmp	r0, #0
	ble	falseAstra	@ダメージがゼロなら終了

	ldr	r0,	=0x0203a4d2
	ldrb	r0, [r0]
	cmp	r0, #1
	bne	falseAstra	@近距離じゃなければ終了
	mov r0, #0x50
	ldrb r0, [r7, r0]
	cmp r0, #SWORD
	bne falseAstra	@剣以外では発動しない

	ldrh	r0, [r5, #12]	@必殺
	cmp	r0, #0
	beq	falseAstra	@必殺率がゼロなら終了

    ldrb r0, [r7, #21]	@技
@	ldrb r0, [r7, #8]	@レベル
	mov	r1, #0
	bl	random	@発動乱数
	cmp	r0, #1
	bne	falseAstra
@必殺チェック
	mov	r0, #4
	ldsh	r2, [r5, r0]
	cmp	r2, #1
	beq	nobon
	asr	r0, r2, #1
	strh	r0, [r5, #4]
nobon:
	ldr	r0, [r6]
	ldr	r0, [r0]
	lsl r0, r0, #31
	bpl	waranai
@必殺の場合
	mov	r1, r2
	mov	r2, #0
loop:
	add	r2, #1
	sub	r1, #3
	bgt	loop
waranai:
	asr	r0, r2, #1
	cmp	r0, #0
	bne	nononon
	mov	r0, #1
nononon:
	bl	RYUSEI
    
    mov r0, r7
    ldr r1, ASTRA_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    b effect_crt
falseAstra:
    mov r0, #0
    pop {pc}


tenku_impl:
    push {lr}
    mov r0, #72
    ldrh r0, [r7, r0]
        ldr r1, =0x080174cc
        mov lr, r1
        .short 0xF800
    cmp r0, #2
    beq falseTenku @HP吸収武器では発動しない
@ユニットチェック
    mov r0, r7
        ldr r1, YOUKO_ADR	@陽光
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne YOUKOU
@必殺と重複しない
    ldr r0, [r6, #0]
    ldr r0, [r0, #0]
    lsl r0, r0, #31
    bmi falseTenku
@ユニットチェック
    mov r0, r7
        ldr r1, TENKU_ADR	@天空
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne TENKU
    b falseTenku
TENKU:
    ldr r0, =0x0203a4d2
    ldrb r0, [r0]    @距離
    cmp r0, #1
    bne falseTenku
    mov r0, r7
    add r0, #72
    ldrh r0, [r0, #0]
		ldr	r3, =0x08017448	@武器の射程
		mov	lr,r3
		.short	0xF800
    ldrb r1, [r1, #7]
    cmp r1, #2 @@斧
    bne jump
    cmp r0, #0x11
    bne falseTenku @@手斧チェック
jump:

    ldrb r0, [r7, #21]	@技
@    ldrb r0, [r7, #8]	@レベル
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseTenku
    
    mov r0, r8
    ldrb r0, [r0, #0x17] @守備

    lsl r1, r0, #31
    lsr r1, r1, #31
    asr r0, r0, #1 @半減
    add r0, r1

    mov r1, #4
    ldsh r1, [r5, r1] @ダメージ

    add r0, r0, r1
    strh r0, [r5, #4]
    
    mov r0, r7
    ldr r1, TENKU_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    b sol_crt


YOUKOU:
    ldrb r0, [r7, #21]	@技
    mov r1, #0
    bl random
    cmp r0, #0
    beq falseTenku

    mov r0, r8
    ldrb r0, [r0, #0x18] @魔防
    lsl r1, r0, #31
    lsr r1, r1, #31
    asr r0, r0, #1 @半減
    add r0, r1

    mov r1, #4
    ldsh r1, [r5, r1]

    add r0, r0, r1
    strh r0, [r5, #4]

    mov r0, r7
    ldr r1, YOUKO_ADR
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    b sol_ef
falseTenku:
    mov r0, #0
    pop {pc}


random:
	ldr	r3, =0x0802a490
	mov	pc, r3
	
RYUSEI:
	push	{r6, r7, lr}
	mov	r6, r0
	mov	r7, #0
ryuloop:
@奥義目印

	ldrh	r0, [r5, #10]	@命中
	mov	r1, #1
		ldr	r2, =0x0802a4c0
		mov	lr, r2
		.short	0xF800
	lsl	r0, r0, #24
	cmp	r0, #0
	beq	ryuend
	ldrh	r0, [r5, #12]	@必殺
		ldr	r1, =0x08000C78
		mov	lr, r1
		.short	0xF800
	mov	r1, #4
	ldsh	r1, [r5, r1]
	cmp	r0, #0
	beq	noncritical
	lsl	r0, r6, #1 
	add	r1, r1, r0
noncritical:
	add	r0, r6, r1 
	strh	r0, [r5, #4]
ryuend:
	add	r7, #1
	cmp	r7, #4
	bne	ryuloop
	pop	{r6, r7, pc}


effect_crt: @必殺
    ldr r3, [r6]
    ldr r2, [r3]
    lsl r1, r2, #13
    lsr r1, r1, #13
    ldr	r0, =0xFFF80000
    and r0, r2
    orr r0, r1
    
    mov r1, #1
    orr r0, r1
    str	r0, [r3, #0]
    mov r0, #1
    pop {pc}
    
sol_crt: @必殺吸収
    ldr r3, [r6]
    ldr r2, [r3]
    lsl r1, r2, #13
    lsr r1, r1, #13
    ldr	r0, =0xFFF80000
    and r0, r2
    orr r0, r1
    
    mov r1, #1
    orr r0, r1
    str r0, [r3]
sol_ef: @吸収
    ldr r3, [r6]
    ldr r2, [r3]
    lsl r1, r2, #13
    lsr r1, r1, #13
    ldr	r0, =0xFFF80000
    and r0, r2
    orr r0, r1

    mov r1, #128
    lsl r1, r1, #1
    orr r0, r1
    str r0, [r3, #0]

    mov r0, #1
    pop {pc}


CHECK_FODES_FUNC = (adr+32)

CheckFodes:
ldr r2, CHECK_FODES_FUNC
mov pc, r2

.align
.ltorg
adr:

