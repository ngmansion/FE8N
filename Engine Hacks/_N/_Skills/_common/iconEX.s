NULL = 0

.thumb
ICON_NUM_LIMIT = (16) @上限数*2

MAX_SKILL_NUM = (255)

@.org	0x08089268
	
	push {r4, r5, r6, r7, lr}
@画像
	bl Initialize

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
		mov r0, r4
		mov r1, #0
		bl get_Skill
		bl	SKILL0 @スキル書1

		mov r0, r4
		mov r1, #1
		bl get_Skill
		bl	SKILL0 @スキル書1
	@ここからEXPAND_SKILL

		mov r0, r4
		mov r1, #2
		bl get_Skill
		bl	SKILL0 @スキル書1

		mov r0, r4
		mov r1, #3
		bl get_Skill
		bl	SKILL0 @スキル書1

		mov r0, r4
		mov r1, #4
		bl get_Skill
		bl	SKILL0 @スキル書1

		mov r0, r4
		mov r1, #5
		bl get_Skill
		bl	SKILL0 @スキル書1

	@ここまでEXPAND_SKILL
		pop {pc}

Unit:
		push {lr}
		mov r0, r4
		bl UNITDATA_GetFirst
		bl SKILL0 @下級スキル

		mov r0, r4
		bl UNITDATA_GetSecond
		bl SKILL0 @上級スキル

		mov r0, r4
		bl UNITDATA_GetThird
		bl SKILL0 @自軍外スキル

		mov r0, r4
		bl UNITDATA_GetLuna
		bl SKILL0 @高難易度スキル

		ldr	r0, [r4]
		ldrb	r0, [r0, #4]
		ldr	r1, adr	@UNIT
		bl	SKILLbin        @表示のみ


		ldr r0, [r4]
		ldrb r0, [r0, #4]
		mov r1, #1          @Unit
		bl SKILL4
		pop {pc}

Ability:
		push {lr}
		ldr	r0, [r4, #4]	@兵種
		ldr	r0, [r0, #40]
		mov	r2, #0x80
		lsl	r2, r2, #17	@兵種EXP0
		bic	r0, r2
		ldr	r1, [r4]	@個人
		ldr	r1, [r1, #40]
		orr	r0, r1

		ldr	r1, adr+12	@ABILITY
		bl	SKILLabi       @表示のみ

		pop {pc}

Class:
		push {lr}

		ldr	r0, [r4, #4]
		ldrb	r0, [r0, #4]
		ldr	r1, adr+4	@CLASS
		bl	SKILLbin   @表示のみ

		ldr r0, [r4, #4]
		ldrb r0, [r0, #4]
		mov r1, #2      @CLASS
		bl SKILL4

		pop {pc}

Weapon:
        push {lr}

        mov r0, #72
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endWeapon
        ldr r1, adr+8       @WEAPON
        bl SKILLbin        @表示のみ

        mov r0, #72
        ldrb r0, [r4, r0]
        mov r1, #3 @weapon2
        bl SKILL4
endWeapon:
        pop {pc}

Item:
        push {lr}

        mov r0, #30
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endItem
        mov r1, #4 @Item
        bl SKILL4

        mov r0, #32
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endItem
        mov r1, #4 @Item
        bl SKILL4

        mov r0, #34
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endItem
        mov r1, #4 @Item
        bl SKILL4

        mov r0, #36
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endItem
        mov r1, #4 @Item
        bl SKILL4

        mov r0, #38
        ldrb r0, [r4, r0]
        cmp r0, #0
        beq endItem
        mov r1, #4 @Item
        bl SKILL4
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
	

SKILLbin: @旧仕様
@
@r0= ***ID
@r1= ***.bin
@
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        b testBin
    restartBin:
        mov r0, r4
        mov r2, #0x10           @IDリスト部分へずらす
    loopBin:
        ldrb r1, [r5, r2]
        cmp r1, #0
        beq jumpBin            @リスト終端
        cmp r0, r1
        beq skillerBin         @ID一致
        add r2, #1
        cmp r2, #0x20
        beq jumpBin            @LISTlimit
        b loopBin


    skillerBin:
        ldrh r0, [r5, #0]
        bl SKILL0
    jumpBin:
        add r5, #0x20
    testBin:
        ldr r0, [r5]
        ldr r1, =0xFFFFFFFF
        cmp r0, r1
        bne restartBin
        pop {r4, r5, pc}

icon:
    push {lr}
        ldr r0, =0x08003608
        mov lr, r0
        mov r0, r6          @Icon position
        .short 0xF800

    ldr r0, adr+28 @ICON_GAP
    ldr r0, [r0]
    add r6, r6, r0      @Icon position increment
    add r7, #2          @HELP memory increment
    pop {pc}


SKILLabi: @ability仕様
@
@r0= abilityBit
@r1= ABILITY.binのポインタ
@
        push {r4, r5, lr}
        cmp r0, #0
        beq falseAbi
        mov r4, r0
        mov r5, r1
        b testAbi


    restartAbi:
        mov r0, r4
        mov r2, #0x10
    loopAbi:
        ldr r1, [r5, r2]
        cmp r1, #0
        beq jumpAbi
        and r1, r0
        bne skillerAbi      @BitOn
        add r2, #4
        cmp r2, #0x20
        beq jumpAbi         @LISTlimit
        b loopAbi

    skillerAbi:
        ldrh r0, [r5, #0]
        bl SKILL0

    jumpAbi:
        add r5, #0x20
    testAbi:
        ldr r0, [r5]
        ldr r1, =0xFFFFFFFF
        cmp r0, r1
        bne restartAbi
    falseAbi:
        pop {r4, r5, pc}

SKILL4:
@
@ r0 = classID or WeaponID etc
@ r1 = 1=Unit 2=class 3=weapon
@
@
        push {r4, r5, lr}
        sub sp, #4
        cmp r0, #0
        beq end4

        str r0, [sp, #0]        @レジスタ足りない
        mov r4, #0
        mov r5, r1
        lsl r5, r5, #2 @リスト始点をずらす
    
    loopstart4:
        add r4, #1
        cmp r4, #255
        bge end4

        ldr r0, ICON_LIST_SIZE
        mul r0, r4
        ldr r1, SKL_TBL     @skl_icon_table
        add r0, r1
    
        ldr r2, [r0, r5]        @リストポインタロード
        ldr r1, =0xFFFFFFFF
        cmp r2, r1
        beq end4                        @リスト末尾
    
        cmp r2, #NULL
        beq loopstart4
    
    list_loop:
        ldr r1, [sp, #0]        @レジスタ足りない
        ldrb r0, [r2]
        cmp r0, #0
        beq loopstart4
        cmp r0, r1
        beq limitter4 @IDが一致
        add r2, #1
        b list_loop

    limitter4:
        mov r0, r4
        bl SKILL0
        b loopstart4
    end4:
        add sp, #4
        pop {r4, r5, pc}


SKILL0:
@
@r0=SkillID
@
@
@r7=
@
        push {r4, lr}
        cmp r0, #0
        beq FALSE
        mov r1, #0xFF
        and r0, r1
        cmp r0, #MAX_SKILL_NUM
        bge FALSE
        mov r4, r0

        ldr r3, SKL_TBL     @skl_icon_table
        ldr r1, ICON_LIST_SIZE
        mul r1, r4
        add r3, r3, r1

        ldrb r0, [r3, #3]
        mov r1, #1
        tst r0, r1
        bne FALSE               @無視フラグ

        ldrh r0, [r3]
        cmp r0, #0
        beq FALSE               @ヘルプ無し
    @ヘルプ重複検索
        ldr r2, =0x02003B00
    loopDedup:
        cmp r2, r7
        beq notDouble
        ldrh r1, [r2]
        cmp r0, r1
        beq FALSE               @ヘルプ重複
        add r2, #2
        b loopDedup

    notDouble:
        lsl r1, r7, #24
        lsr r1, r1, #24
        cmp r1, #ICON_NUM_LIMIT
        beq FALSE               @アイコン上限

        strh r0, [r7]       @ヘルプストア

        ldr r1, =0x100
        add r1, r4
        mov r2, #0xA0       @color

        ldrb r3, [r3, #2]
        cmp r3, #0xFF
        bne jump
        mov r2, #0x80
    jump:
        lsl r2, r2, #7
@        mov r0, r6
        bl icon


    FALSE:
        pop {r4, pc}




Initialize:
	push {lr}
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

    ldr r4, =0x02003BFC
    ldr r4, [r4, #12]
    ldr r4, =0x0203a4e8
    pop {pc}

getEquipmentPositionData:
	ldr r0, adr+20
	bx lr
getIconPositionData:
	ldr r0, adr+24 @ICON_POSITION =0x020040ee @icon position(0x02004130)
	bx lr
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1


SKL_TBL = (adr+16)

get_Skill:
	ldr r2, (adr+36)
	mov pc, r2

WP_LV_SKL_TABLE = (adr+40)
ICON_LIST_SIZE = (adr+44)

checkItemList:
	ldr r3, (adr+48)
	mov pc, r3

UNITDATA_GetFirst:
	ldr r1, (adr+52)
	mov pc, r1

UNITDATA_GetSecond:
	ldr r1, (adr+56)
	mov pc, r1

UNITDATA_GetThird:
	ldr r1, (adr+60)
	mov pc, r1

UNITDATA_GetLuna:
	ldr r1, (adr+64)
	mov pc, r1

.align
.ltorg
adr:
