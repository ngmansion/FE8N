.thumb
SKL_TBL = (adr+16)
GET_SKILL_FUNC = (adr+36)
WP_LV_SKL_TABLE = (adr+40)
ICON_LIST_SIZE = (adr+44)
CHECK_ITEM_FUNC = (adr+48)
ICON_NUM_LIMIT = (16) @上限数*2

MAX_SKILL_NUM = (255)

@.org	0x08089268
	
	push	{r4, r5, r6, r7, lr}
@画像
	mov	r4, #0

	bl getEquipmentPositionData
	ldr r0, [r0]
	
	ldr	r6, =0x00007060
	mov	r5, r6	
	ldr	r1, =0x000002c2
	add	r2, r0, r1
	add	r6, #8
	mov	r3, r6
	ldr	r6, =0x00000302
	add	r1, r0, r6
loopE:
	add	r0, r4, r5
	strh	r0, [r2, #0]
	add	r0, r4, r3
	strh	r0, [r1, #0]
	add	r2, #2
	add	r1, #2
	add	r4, #1
	cmp	r4, #7
	ble	loopE
@アイコン
	bl getIconPositionData
	mov r6, r0
	ldr r6, [r6]
	ldr	r7, =0x02003B00	@help memory
@r6,r7は以後、共通変数として用いる
	mov	r5, #0
	str	r5, [r7]
	str	r5, [r7, #4]
	str	r5, [r7, #8]
	str	r5, [r7, #12]

	bl SkillBook

@	bl WpLv	@武器レベル

	bl Unit

	bl Class

	bl Ability

	bl Weapon

	bl Item
	
	pop	{r4, r5, r6, r7, pc}

SkillBook:
		push {lr}
		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #0
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書1

		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #1
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書2
	@ここからEXPAND_SKILL

		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #2
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書3

		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #3
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書4

		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #4
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書5

		ldr r4, =0x02003BFC
		ldr r0, [r4, #12]
		
		mov r1, #5
		bl get_Skill
		mov r4, r0
		bl	SKILL3 @スキル書6

	@ここまでEXPAND_SKILL
		pop {pc}

Unit:
		push {lr}
		ldr	r4, =0x02003BFC
		ldr	r4, [r4, #12]
		ldr	r4, [r4]
		add	r4, #0x26
		ldrb	r4, [r4]
		bl	SKILL3 @下級スキル

		ldr	r4, =0x02003BFC
		ldr	r4, [r4, #12]
		ldr	r0, [r4, #4] @class
		ldr	r0, [r0, #40]
		lsl	r0, r0, #23
		bpl jumpUnit1 @上級職のみ
		ldr	r4, [r4]
		add	r4, #0x27
		ldrb	r4, [r4]
		bl	SKILL3 @上級スキル
jumpUnit1:

		ldr	r4, =0x02003BFC
		ldr	r4, [r4, #12]
		ldrb	r0, [r4, #0xB]
		lsr	r0, r0, #6
		beq jumpUnit2 @自軍外のみ
		ldr	r4, [r4]
		add	r4, #0x31
		ldrb	r4, [r4]
		bl	SKILL3 @自軍外スキル
jumpUnit2:
		ldr	r5, adr	@UNIT
		ldr	r4, =0x02003BFC
		ldr	r4, [r4, #12]
		ldr	r4, [r4]
		ldrb	r4, [r4, #4]
		bl	SKILL	@表示のみ

		ldr	r5, SKL_TBL	@UNIT2
		ldr r4, =0x02003BFC
		ldr r4, [r4, #12]
		ldr r4, [r4]
		ldrb r4, [r4, #4]
		mov r3, #1@CLASS
		bl SKILL4
		pop {pc}

Ability:
		push {lr}

		ldr	r5, adr+12	@ABILITY
		ldr	r4, =0x02003BFC
		ldr	r0, [r4, #12]
		ldr	r4, [r0, #4]	@兵種
		ldr	r4, [r4, #40]
		mov	r2, #0x80
		lsl	r2, r2, #17	@兵種EXP0
		mvn	r2, r2
		and	r4, r2
		ldr	r0, [r0]	@個人
		ldr	r0, [r0, #40]
		orr	r4, r0
		bl	SKILL2	@表示のみ

		pop {pc}

Class:
		push {lr}

		ldr	r5, adr+4	@CLASS
		ldr	r4, =0x02003BFC
		ldr	r4, [r4, #12]
		ldr	r4, [r4, #4]
		ldrb	r4, [r4, #4]
		bl	SKILL	@表示のみ

		ldr	r5, SKL_TBL	@CLASS2
		ldr r4, =0x02003BFC
		ldr r4, [r4, #12]
		ldr r4, [r4, #4]
		ldrb r4, [r4, #4]
		mov r3, #2@CLASS
		bl SKILL4

		pop {pc}

Weapon:
		push {lr}

		ldr r5, adr+8	@WEAPON
		ldr	r4, =0x0203a530
		ldrb	r4, [r4]
		cmp r4, #0
		beq endWeapon
		bl	SKILL	@表示のみ

		ldr r5, SKL_TBL @weapon2
		ldr r4, =0x0203a530
		ldrb r4, [r4]
		mov r3, #3 @weapon2
		bl SKILL4
endWeapon:
		pop {pc}

Item:
		push {lr}
		ldr r5, SKL_TBL
		add r5, #16	@アイテムリストのオフセット

		mov r4, #1
	forItem:
		cmp r4, #128
		bge endItem
			ldr	r0, =0x02003BFC
			ldr	r0, [r0, #12]
			ldr r1, ICON_LIST_SIZE
			mul r1, r4
			ldr r1, [r5, r1]
			bl checkItemList
			cmp r0, #0
			beq jumpItem

			bl	SKILL3 
		jumpItem:
			add r4, #1
			b forItem
	endItem:
		pop {pc}


WpLv:
	push {lr}
	mov r3, r8
	push {r3}
	
	mov r3, #0
	mov r8, r3
loopWpLv:
	bl InWpLv

	mov r3, #1
	add r8, r3
	mov r3, r8
	cmp r3, #9
	blt loopWpLv
	
	pop {r3}
	mov r8, r3
	pop {pc}

InWpLv:
	push {lr}
	
	ldr r0, =0x02003BFC
	ldr r0, [r0, #12]
	add	r0, #40
	add	r0, r8
	ldrb	r0, [r0]
	bl Get_WpLv
InWpLv1:
	cmp r0, #0
	beq endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x00
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
InWpLv2:
	cmp r0, #1
	ble endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x08
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
InWpLv3:
	cmp r0, #2
	ble endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x10
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
InWpLv4:
	cmp r0, #3
	ble endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x18
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
InWpLv5:
	cmp r0, #4
	ble endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x20
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
	
InWpLv6:
	cmp r0, #5
	ble endWpLv
	push {r0}
	ldr r4, WP_LV_SKL_TABLE
	add r4, #0x28
	add r4, r8
	ldrb r4, [r4]
	bl SKILL3
	pop {r0}
endWpLv:
	pop {pc}
	

SKILL: @旧仕様
	push	{lr}
	b	test
restart:
	mov	r0, r4
	mov	r2, #0x10
loop:
	ldrb	r1, [r5, r2]
	cmp	r1,	#0
	beq jump
	cmp	r0, r1
	beq	skiller
	add	r2, #1
	cmp	r2, #0x20
	beq	jump @LISTlimit
	b loop

skiller:
	ldrh	r1, [r5, #2]
	strh	r1, [r7]
	ldrh	r1, [r5]
	mov	r2, #0xA0
	ldrb	r3, [r5, #4]
	cmp	r3, #0xFF
	bne	nonitem
	sub	r2, #0x20
nonitem:
	lsl	r2, r2, #7
	mov	r0, r6
	bl	icon

	ldr r0, adr+28 @ICON_GAP
	ldr r0, [r0]
	add r6, r6, r0
	add	r7, #2	@HELP memory increment
	
jump:
	add	r5, #0x20
test:
	ldr	r0, [r5]
	ldr r1, =0xFFFFFFFF
	cmp	r0, r1
	bne	doublecount
	pop	{pc}

doublecount: @二重表示防止
	ldrh r0, [r5, #2]
	ldr r2, =0x02003B00
loopyloopy:
	cmp r2, r7
	beq limitter
	ldrh r1, [r2]
	cmp r0, r1
	beq jump @被っていたら無視
	add r2, #2
	b loopyloopy

limitter:
	lsl r0, r7, #24
	lsr r0, r0, #24
	cmp r0, #ICON_NUM_LIMIT @アイコン上限
	bne restart
	pop {pc}

icon:
	ldr	r3, =0x08003608
	mov	pc, r3



SKILL2: @ability仕様
	push	{lr}
	cmp	r4, #0
	bne	test2
	pop	{pc}

restart2:
	mov	r0, r4
	mov	r2, #0x10
loop2:
	ldr	r1, [r5, r2]
	cmp	r1,	#0
	beq	jump2
	and r1, r0
	bne	skiller2
	add	r2, #4
	cmp	r2, #0x20
	beq	jump2 @LISTlimit
	b	loop2

skiller2:
	ldrh	r1, [r5, #2]
	strh	r1, [r7]
	ldrh	r1, [r5]
	mov	r2, #0xA0
	ldrb	r3, [r5, #4]
	cmp	r3, #0xFF
	bne	nonitem2
	sub	r2, #0x20
nonitem2:
	lsl	r2, r2, #7
	mov	r0, r6
	bl	icon

	ldr r0, adr+28 @ICON_GAP
	ldr r0, [r0]
	add r6, r6, r0
	add	r7, #2	@HELP memory increment
	
jump2:
	add	r5, #0x20
test2:
	ldr	r0, [r5]
	ldr r1, =0xFFFFFFFF
	cmp	r0, r1
	bne	doublecount2
	pop	{pc}

doublecount2:
	ldrh r0, [r5, #2]
	ldr r2, =0x02003B00
loopyloopy2:
	cmp r2, r7
	beq limitter2
	ldrh r1, [r2]
	cmp r0, r1
	beq jump2
	add r2, #2
	b loopyloopy2
limitter2:
	lsl r0, r7, #24
	lsr r0, r0, #24
	cmp r0, #ICON_NUM_LIMIT @アイコン上限
	bne restart2
	pop {pc}
	
	
SKILL3: @新仕様1
	push {r4, r5, lr}
	ldr	r5, SKL_TBL	@skl_icon_table
	cmp r4, #0
	bne test3
end3:
	b endSKILL3
test3:
	cmp r4, #MAX_SKILL_NUM
	bge end3
	ldr r0, ICON_LIST_SIZE
	mul r0, r4
	add r5, r5, r0
	ldrh r0, [r5]
	cmp r0, #0
	beq end3

	ldr r2, =0x02003B00
loopyloopy3:
	cmp r2, r7
	beq limitter3
	ldrh r1, [r2]
	cmp r0, r1
	beq end3
	add r2, #2
	b loopyloopy3
limitter3:
	lsl r0, r7, #24
	lsr r0, r0, #24
	cmp r0, #ICON_NUM_LIMIT @アイコン上限
	beq end3

	ldrb r0, [r5, #3]
	mov r1, #1
	tst r0, r1
	bne end3

	ldrh r0, [r5]
	cmp r0, #0
	beq end3 @ヘルプが無ければ終了
	strh r0, [r7]
	add r1, r4, #1
	add r1, #255
	mov r2, #0xA0
	ldrb r3, [r5, #2]
	cmp r3, #0xFF
	bne nonitem3
	sub r2, #0x20
nonitem3:
	lsl r2, r2, #7
	mov r0, r6
	bl icon

	ldr r0, adr+28 @ICON_GAP
	ldr r0, [r0]
	add r6, r6, r0
	add r7, #2	@HELP memory increment
endSKILL3:
	pop {r4, r5, pc}


SKILL4:
	push {r3, r4, lr} @r4=判定ID
	cmp r4, #0
	beq end4
	mov r4, #0 @以後r4はカウンタ
	lsl r3, r3, #2 @リスト始点をずらす
	b next4
	
loopstart4:
	ldr r0, [r5, r3] @リストポインタロード
	cmp r0, #0
	beq next4
@ダブりチェック
	ldrh r0, [r5]
	ldr r2, =0x02003B00
loopyloopy4:
	cmp r2, r7
	beq list_checker
	ldrh r1, [r2]
	cmp r0, r1
	beq next4
	add r2, #2
	b loopyloopy4
	
list_checker:
	ldr r2, [r5, r3] @リストポインタロード
	ldr r1, [sp, #4]  @IDをロード
list_loop:
	ldrb r0, [r2]
	cmp r0, #0
	beq next4
	cmp r0, r1
	beq limitter4 @IDが一致
	add r2, #1
	b list_loop

limitter4: @上限チェック
	lsl r1, r7, #24
	lsr r1, r1, #24
	cmp r1, #ICON_NUM_LIMIT @アイコン上限
	beq end4

	ldrb r0, [r5, #3]
	mov r1, #1
	tst r0, r1
	bne next4

	ldrh r0, [r5]
	cmp r0, #0
	beq next4 @ヘルプが無ければ次へ
	strh r0, [r7] @ヘルプストア
	add r1, r4, #1
	add r1, #255
	mov r2, #0xA0
	ldrb r0, [r5, #2]
	cmp r0, #0xFF
	bne nonitem4
	sub r2, #0x20
nonitem4:
	lsl r2, r2, #7
	mov r0, r6
	bl icon
	ldr r3, [sp]  @r3復帰
	lsl r3, r3, #2 @リスト始点をずらす

	ldr r0, adr+28	@ICON_GAP
	ldr r0, [r0]
	add r6, r6, r0
	add r7, #2	@HELP memory increment
next4:
	ldr r0, ICON_LIST_SIZE
	add r5, r0
	add r4, #1
	cmp r4, #MAX_SKILL_NUM
	ble loopstart4
end4:
	pop {r3, r4, pc}

getEquipmentPositionData:
	ldr r0, adr+20
	bx lr
getIconPositionData:
	ldr r0, adr+24 @ICON_POSITION =0x020040ee @icon position(0x02004130)
	bx lr
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1

get_Skill:
	ldr r2, GET_SKILL_FUNC
	mov pc, r2
checkItemList:
	ldr r3, CHECK_ITEM_FUNC
	mov pc, r3
.align
.ltorg
adr:
