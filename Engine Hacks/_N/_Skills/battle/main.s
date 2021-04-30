.thumb

D_REIN_DOWN_NUM = (2)
ARENA_ADDR = (0x0203a4d0)

@ 0802ad3c
@イクリプス等の直前(自分の数値と相手の数値の計算後)
@ステータス画面では呼ばれない
@相手の数値に影響を与える処理群


    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1
    mov r5, #0

    ldr r0, =ARENA_ADDR
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne Return

    bl BindingNecklace
    mov r5, r0  @recalc済

    mov	r0, r4
    mov r1, #0
    bl HAS_NIHIL
    cmp r0, #1
    beq jumpDown
    bl Lull
    bl Rein
    bl LunaPlus
jumpDown:

    mov	r0, r6
    mov r1, #0
    bl HAS_NIHIL
    cmp r0, #1
    beq jumpUp
    bl Shisen_B
    bl DragonFungPlus
    bl SureStrikePlus
    bl AstraPlus
jumpUp:

    bl WarSkill
    bl godBless
    bl ChagingLance

Return:
    ldr r5, [r4, #76]
    ldr r0, =0x0802ad44
    mov r15, r0
endZero:
    mov r0, #0
    mov r1, r4
    add r1, #90
    strh r0, [r1] @威力
    
    mov r0, #0x7F
    mov r1, r6
    add r1, #92
    strh r0, [r1] @防御
    pop {r4, r5, r6}
    pop {r0}
    bx r0
.align
.ltorg

AstraPlus:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_ASTRA_PLUS
        cmp r0, #0
        beq endAstra
        mov r1, r4
        add r1, #94
        ldrh r1, [r1]
        asr r1, #1
    
        mov r2, r4
        add r2, #90
        ldrh r0, [r2]
        add r0, r1
        strh r0, [r2]
    endAstra:
        pop {pc}

SureStrikePlus:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_SURE_STRIKE_PLUS
        cmp r0, #0
        beq endSure
        mov r0, #100
        mov r1, r4
        add r1, #100
        strh r0, [r1]
    endSure:
        pop {pc}

DragonFungPlus:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_DRAGON_FUNG_PLUS
        cmp r0, #0
        beq endDragon
        mov r1, r4
        add r1, #90
        ldrh r1, [r1]
    
        lsl r0, r1, #3
        add r0, r1
        add r0, r1
        add r0, r1
        add r0, r1
        add r0, r1
        mov r1, #10
        swi #6      @*13/10
        mov r1, r4
        add r1, #90
        strh r0, [r1]
    endDragon:
        pop {pc}

LunaPlus:
        push {lr}
        mov r0, r6
        mov r1, #0
        bl HAS_LUNA_PLUS
        cmp r0, #0
        beq endLuna
        mov r1, r4
        add r1, #92
        ldrh r1, [r1]

        lsl r0, r1, #2
        add r0, r1
        add r0, r1
        add r0, r1
        mov r1, #10
        swi #6      @*7/10
        mov r1, r4
        add r1, #92
        strh r0, [r1]
    endLuna:
        pop {pc}

BindingNecklace:
        push {lr}

        mov r0, r4
        mov r1, r6
        bl  CanBindingNecklace
        mov r5, r0

        mov r0, r6
        mov r1, r4
        bl  CanBindingNecklace
        add r5, r0
        cmp r5, #0
        beq falseBindingNecklace    @誰も発動していないので自分弱化なし
        cmp r5, #2
        beq bothBindingNecklace
        cmp r0, #1
        beq reverseBindingNecklace  @相手が発動

        mov r0, r4
        mov r1, r6
        bl  BindingNecklaceEffect
        b   falseBindingNecklace    @自分のみ発動なので自分弱化なし
    bothBindingNecklace:
        bl  DoubleBindingEffect
        b   trueBindingNecklace     @両方発動なので、自分は弱化
    reverseBindingNecklace:
        mov r0, r6
        mov r1, r4
        bl  BindingNecklaceEffect
        b   trueBindingNecklace     @相手が発動しているので自分は弱化
        nop

    falseBindingNecklace:
        mov  r0, #0             @自分弱化なし
        .short 0xE000
    trueBindingNecklace:
        mov r0, #1              @自分弱化済み
        pop {pc}

BindingNecklaceEffect:
@A側もB側も両方この1処理で行う
@
        push {lr}
        ldr r2, =0x0203a4e8
        cmp r2, r4
        bne endBindingEffect    @r4が攻撃側なら、既に実施済みなので見る価値無し

        bl BindingNecklace_impl

    endBindingEffect:
        pop {pc}

UNIT_SIZE = (128)
MEMCPY_R1toR0_FUNC = (0x080d6908)
@biding_necklace_gain = (2) beforeで行う
biding_necklace_loss = (2)

BindingNecklace_impl:
@r1(r5)をrecalcしてr0(r4)を強化
@
        push {r4, r5, lr}
        sub sp, #UNIT_SIZE
        mov r4, r0
        mov r5, r1

        mov r1, r5
        mov r0, sp
        mov r2, #UNIT_SIZE
        ldr r3, =MEMCPY_R1toR0_FUNC
        mov lr, r3
        .short 0xF800

@@@@@@@@攻撃奪取
        mov r0, r5
        mov r1, r4
        bl recalcAtk

        mov r2, #90
        mov r0, sp
        ldrh r0, [r0, r2]
        ldrh r1, [r5, r2]
        sub r0, r1
        .short 0xda00     @bge
        mov r0, #0

        ldrh r1, [r4, r2]
        add r1, r0
@        add r1, #biding_necklace_gain
        strh r1, [r4, r2]
@@@@@@@@攻撃減少
        mov r1, r5
        add r1, #90
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
@@@@@@@@攻速奪取
        mov r0, r5
        mov r1, r4
        bl recalcSpd

        mov r2, #94
        mov r0, sp
        ldrh r0, [r0, r2]
        ldrh r1, [r5, r2]
        sub r0, r1
        .short 0xda00     @bge
        mov r0, #0

        ldrh r1, [r4, r2]
        add r1, r0
@        add r1, #biding_necklace_gain
        strh r1, [r4, r2]
@@@@@@@@攻速減少
        mov r1, r5
        add r1, #94
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
@@@@@@@@防御奪取
        mov r0, r5
        mov r1, r4
        bl recalcDef
        mov r2, #92
        mov r0, sp
        ldrh r0, [r0, r2]
        ldrh r1, [r5, r2]
        sub r0, r1
        .short 0xda00     @bge
        mov r0, #0

        ldrh r1, [r4, r2]
        add r1, r0
@        add r1, #biding_necklace_gain
        strh r1, [r4, r2]
@@@@@@@@防御減少
        mov r1, r5
        add r1, #92
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
@@@@@@@@金剛/明鏡補正
        mov r0, r4
        bl IS_MAGIC
        cmp r0, #1
        beq magicBindingImpl
@@@@@@@@発動者が物理
        mov r0, r5
        bl IS_MAGIC
        cmp r0, #0
        beq endBindingImpl  @相手も物理なら終了

        bl GainSteady
        mov r2, #92
        ldrh r1, [r4, r2]
        sub r1, r0          @魔法相手に金剛は無意味
        .short 0xda00   @bge
        mov r1, #0
        strh r1, [r4, r2]

        bl GainWarding
        mov r2, #92
        ldrh r1, [r4, r2]
        add r1, r0          @魔法相手に明鏡は有効
        strh r1, [r4, r2]

        b endBindingImpl
    magicBindingImpl:
@@@@@@@@発動者が魔法
        mov r0, r5
        bl IS_MAGIC
        cmp r0, #1
        beq endBindingImpl  @相手も魔法なら終了

        bl GainSteady
        mov r2, #92
        ldrh r1, [r4, r2]
        add r1, r0          @魔法相手に金剛は有効
        strh r1, [r4, r2]

        bl GainWarding
        mov r2, #92
        ldrh r1, [r4, r2]
        sub r1, r0          @魔法相手に明鏡は無意味
        .short 0xda00   @bge
        mov r1, #0
        strh r1, [r4, r2]
    endBindingImpl:
        add sp, #UNIT_SIZE
        pop {r4, r5, pc}


DoubleBindingEffect:
@A側もB側も両方この1処理で行う
@
        push {lr}
        ldr r0, =0x0203a4e8
        cmp r0, r4
        bne endBinding_impl  @r4が攻撃側なら、既に実施済みなので見る価値無し
        bl DoubleBinding_impl

        eor r4, r6
        eor r6, r4
        eor r4, r6
        bl DoubleBinding_impl
        eor r4, r6
        eor r6, r4
        eor r4, r6

    endBinding_impl:
        pop {pc}

DoubleBinding_impl:
@両方下がるなら別に下げなくてもいい気もするが
        push {lr}
        mov r0, r4
        mov r1, r6
        bl recalcAtk

        mov r0, r4
        mov r1, r6
        bl recalcSpd

        mov r0, r4
        mov r1, r6
        bl recalcDef

        mov r1, r4
        add r1, #90
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し

        mov r1, r4
        add r1, #92
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し

        mov r1, r4
        add r1, #94
        ldrh r0, [r1]
        sub r0, #biding_necklace_loss
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し

        pop {pc}

.align
.ltorg
GainSteady:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_NIHIL
        cmp r0, #1
        beq falseGainSteady

        ldr r0, =0x0203a4e8
        cmp r0, r5
        bne reverseSteady

        mov r0, r5
        mov r1, #0
        bl HAS_ARMORED_BLOW
        cmp r0, #0
        beq falseGainSteady
        mov r0, #10
        b endGainSteady
    reverseSteady:
        mov r0, r5
        mov r1, #0
        bl HAS_STEADY_STANCE
        cmp r0, #0
        beq falseGainSteady
        mov r0, #6
        b endGainSteady
    falseGainSteady:
        mov r0, #0
    endGainSteady:
        pop {pc}

GainWarding:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_NIHIL
        cmp r0, #1
        beq falseGainWarding

        ldr r0, =0x0203a4e8
        cmp r0, r5
        bne reverseWarding

        mov r0, r5
        mov r1, #0
        bl HAS_WARDING_BLOW
        cmp r0, #0
        beq falseGainWarding
        mov r0, #10
        b endGainWarding
    reverseWarding:
        mov r0, r5
        mov r1, #0
        bl HAS_WARDING_STANCE
        cmp r0, #0
        beq falseGainWarding
        mov r0, #6
        b endGainWarding
    falseGainWarding:
        mov r0, #0
    endGainWarding:
        pop {pc}

@r4 temp enemy
@r5 loop count
Rein:   @牽制   2マス以内の相手ユニットは戦闘中攻撃攻速-2
        push {r5, r6, lr}

        ldrb r5, [r6, #0xB]
        mov r0, #0xC0
        and r5, r0      @r5に部隊表ID
        
    loopRein:
        add r5, #1
        mov r0, r5
        bl Get_Status
        mov r6, r0
        cmp r0, #0
        beq endRein        @リスト末尾
        ldr r0, [r6]
        cmp r0, #0
        beq loopRein        @死亡判定1
        ldrb r0, [r6, #19]
        cmp r0, #0
        beq loopRein        @死亡判定2

        ldr r0, [r6, #0xC]
        bl GetExistFlagR1
        and r0, r1
        bne loopRein        @居ないフラグ+救出中
        
        mov r0, #2  @2マス以内
        mov r1, r6
        mov r2, r4
        bl CheckXY
        cmp r0, #0
        beq loopRein

        mov r0, r6
        mov r1, #0
        bl HAS_REIN
        cmp r0, #0
        beq loopRein

    trueRein:
        mov r1, r4
        add r1, #90
        ldrh r0, [r1]
        sub r0, #D_REIN_DOWN_NUM
        bge jumpAtkRein
        mov r0, #0
    jumpAtkRein:
        strh r0, [r1] @威力
        
        mov r1, r4
        add r1, #94
        ldrh r0, [r1]
        sub r0, #D_REIN_DOWN_NUM
        bge jumpSpdRein
        mov r0, #0
    jumpSpdRein:
        strh r0, [r1] @速さ
    endRein:
        pop {r5, r6, pc}

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
        bx lr

WarSkill:
        push {lr}

        bl GetAttackerAddr
        ldr r2, [r0]
        ldrb r2, [r2, #11]
        ldrb r0, [r4, #11]
        cmp r0, r2
        bne endWar

        mov r0, r4
        bl GET_COMBAT_ART
        bl GetWarList
        cmp r0, #0
        beq endWar
        mov r3, r0
    
        mov r1, #90
        ldrh r0, [r4, r1]
        mov r2, #0
        ldsb r2, [r3, r2]
        add r0, r2
        cmp r0, #0
        bge jumpWar1
        mov r0, #0
    jumpWar1:
        strh r0, [r4, r1] @力
    
    endWar:
        pop {pc}

GetAttackerAddr:
    ldr r0, =0x03004df0
    bx lr

judgeLull:
@r4を下げるためにr6のスキル発動を見る
@
        push {r5, lr}
        mov r5, #0

        mov r0, r6
        mov r1, #0
        bl HasLull
        cmp r0, #0
        .short 0xd000       @beq
        add r5, #0b0001

        mov r0, r6
        mov r1, #0
        bl CanUnbound
        cmp r0, #0
        .short 0xd000       @beq
        add r5, #0b0010

        mov r0, r5
        pop {r5, pc}

Lull:
@r4を下げる
@
        push {lr}
        bl judgeLull
        cmp r0, #1
        beq trueLull
        cmp r0, #2
        beq trueUnbound
        cmp r0, #3
        beq trueDouble
        b endLull
@@@@@@@@凪
    trueLull:
        mov r0, r4
        mov r1, r6
        bl recalcAtk_wrapper
        mov r0, #2
        bl DownAtk
@@@@@@@@凪-攻速
        mov r0, r4
        mov r1, r6
        bl recalcSpd_wrapper
        mov r1, r4
        add r1, #94
        ldrh r0, [r1]
        sub r0, #2
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
        b endLull
@@@@@@@@孤絶
    trueUnbound:
        mov r0, r4
        mov r1, r6
        bl recalcAtk_wrapper
        mov r0, #2
        bl DownAtk
@@@@@@@@孤絶-防御
        mov r0, r4
        mov r1, r6
        bl recalcDef_wrapper
        mov r1, r4
        add r1, #92
        ldrh r0, [r1]
        sub r0, #2
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
        b endLull
@@@@@@@@両方
    trueDouble:
        mov r0, r4
        mov r1, r6
        bl recalcAtk_wrapper
        mov r0, #4
        bl DownAtk
@@@@@@@@両方-防御
        mov r0, r4
        mov r1, r6
        bl recalcDef_wrapper
        mov r1, r4
        add r1, #92
        ldrh r0, [r1]
        sub r0, #2
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
@@@@@@@@両方-攻速
        mov r0, r4
        mov r1, r6
        bl recalcSpd_wrapper
        mov r1, r4
        add r1, #94
        ldrh r0, [r1]
        sub r0, #2
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @書き戻し
        b endLull
        nop
    endLull:
        pop {pc}

down_fort_num = (2)

DownAtk:
        push {lr}
        mov r2, r0

        mov r1, r4
        add r1, #90
        ldrh r0, [r1]
        sub r0, r2
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @威力

        pop {pc}

CanBindingNecklace:
        push {r4, lr}
        mov r4, r0
        bl HAS_BINDING_NECKLACE
        cmp r0, #0
        beq falseCanBindingNecklace
        mov r0, r4
        bl  CheckSolo
        .short 0xE000
    falseCanBindingNecklace:
        mov r0, #0
        pop {r4, pc}
CanUnbound:
        push {r4, lr}
        mov r4, r0
        mov r1, #0
        bl  HAS_UNBOUND
        cmp r0, #0
        beq endCanUnbound
        mov r0, r4
        bl  CheckSolo
    endCanUnbound:
        pop {r4, pc}
CheckSolo:
        push {r4, r5, r6, lr}
        mov r4, r0
        ldrb r6, [r4, #0xB]
        mov r0, #0xC0
        and r6, r0	@r6に部隊表ID
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
        mov r0, #1
        .short 0xE000
    falseSolo:
        mov r0, #0
        pop {r4, r5, r6, pc}


Shisen_B:   @相手強化
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasShisen
        cmp r0, #0
        beq endShisen
        
        mov r1, r6
        add r1, #90
        ldrh r0, [r1]
        add r0, #5
        strh r0, [r1] @相手
    endShisen:
        pop {pc}

godBless:
    push {lr}
    mov r0, r4
        ldr r1, addr+4 @光の加護
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne endBless
    
    mov r0, r6
        ldr r1, addr+8 @暗黒の加護
    	mov lr, r1
    	.short 0xF800
    cmp r0, #0
    beq endBless

    mov r1, #90
    ldrh r0, [r4, r1] @威力
    asr r0, r0, #1
    strh r0, [r4, r1] @威力

    mov r0, #1
    .short 0xE000
endBless:
    mov r0, #0
    pop {pc}

ChagingLance:
        push {lr}
        bl GET_ATTACKER_ADDR
        ldr r0, [r0]
        ldrb r0, [r0, #0xB]
        ldrb r1, [r4, #0xB]
        cmp r0, r1
        bne endCharge       @攻めてない

        mov r0, #74
        ldrh r0, [r4, r0]
        bl GET_ITEM_EFFECT

        mov r1, r0
        bl GET_CHARGING_EFFECT_ID
        cmp r0, r1
        bne endCharge
        
        mov r0, r4
        bl GetWalked
        cmp r0, #8
        ble jumpCharge
        mov r0, #8
    jumpCharge:

        bl MUL_CHARGING_COEF
        mov r1, #90
        ldrh r2, [r4, r1]
        add r2, r0
        strh r2, [r4, r1] @自分
    endCharge:
        pop {pc}

GetWalked:
        mov r1, r0
        ldr r2, =0x0202be44
        ldrb r0, [r1, #16]
        ldrb r3, [r2, #0]
        sub r0, r0, r3
        bge jump1Walked
        neg r0, r0  @絶対値取得
    jump1Walked:

        ldrb r1, [r1, #17]
        ldrb r2, [r2, #2]
        sub r2, r1, r2
        bge jump2Walked
        neg r2, r2  @絶対値取得
    jump2Walked:
        add r0, r0, r2
        bx lr
GetDistance:
    ldr r0, =0x0203a4d2
    bx lr

Get_Status:
    ldr r1, =0x08019108
    mov pc, r1

GetExistFlagR1:
    ldr r1, =0x1002C    @居ないフラグ+救出されている
    bx lr

SHISEN_ADR = (addr+0)
HAS_NIHIL:
    ldr r2, (addr+12)
    mov pc, r2
LULL_ADR = (addr+16)
COMBAT_TBL = (addr+20)
COMBAT_TBL_SIZE = (addr+24)
@FLY_E_ADR = (addr+28)
@ARMOR_E_ADR = (addr+32)
@HORSE_E_ADR = (addr+36)
@MONSTER_E_ADR = (addr+40)
@HAS_ATROCITY_ADR = (addr+44)

GET_ITEM_EFFECT:
    ldr r1, =0x080174e4
    mov pc, r1
GET_ATTACKER_ADDR:
    ldr r0, =0x03004df0
    bx lr
GetWarList:
    ldr r1, COMBAT_TBL_SIZE
    mul r0, r1
    ldr r1, COMBAT_TBL
    add r0, r1
    bx lr

HasShisen:
    ldr r2, SHISEN_ADR
    mov pc, r2

recalcAtk_wrapper:
    cmp r5, #0
    beq recalcAtk
    bx lr
recalcAtk:
        push {r4, lr}
        mov r4, r0
        ldr r2, =0x0802aa28
        mov lr, r2
        .short 0xF800

        mov r0, r4
        mov r1, #0
        bl HAS_FORT
        cmp r0, #0
        beq endAtk

        mov r1, r4
        add r1, #90
        ldrh r0, [r1]
        sub r0, #down_fort_num
        .short 0xda00     @bge
        mov r0, #0
        strh r0, [r1] @威力
    endAtk:
        pop {r4, pc}

recalcSpd_wrapper:
    cmp r5, #0
    beq recalcSpd
    bx lr
recalcSpd:
    ldr r2, =0x0802aae4
    mov pc, r2

recalcDef_wrapper:
    cmp r5, #0
    beq recalcDef
    bx lr
recalcDef:
    ldr r2, =0x0802a9b0
    mov pc, r2

HasLull:
    ldr r2, LULL_ADR
    mov pc, r2

MUL_CHARGING_COEF:
    ldr r1, (addr+48)
    mul r0, r1
    bx lr
.align
GET_CHARGING_EFFECT_ID:
    ldr r0, (addr+52)
    bx lr

HAS_REIN:
    ldr r2, (addr+56)
    mov pc, r2

GET_COMBAT_ART:
 ldr r2, (addr+60)
 mov pc, r2
HAS_FORT:
    ldr r2, (addr+64)
    mov pc, r2
HAS_UNBOUND:
    ldr r2, (addr+68)
    mov pc, r2
HAS_BINDING_NECKLACE:
    ldr r2, (addr+72)
    mov pc, r2
IS_MAGIC:
    ldr r2, (addr+76)
    mov pc, r2
HAS_ARMORED_BLOW:
    ldr r2, (addr+80)
    mov pc, r2
HAS_STEADY_STANCE:
    ldr r2, (addr+84)
    mov pc, r2
HAS_WARDING_BLOW:
    ldr r2, (addr+88)
    mov pc, r2
HAS_WARDING_STANCE:
    ldr r2, (addr+92)
    mov pc, r2
HAS_LUNA_PLUS:
    ldr r2, (addr+96)
    mov pc, r2
HAS_DRAGON_FUNG_PLUS:
    ldr r2, (addr+100)
    mov pc, r2
HAS_SURE_STRIKE_PLUS:
    ldr r2, (addr+104)
    mov pc, r2
HAS_ASTRA_PLUS:
    ldr r2, (addr+108)
    mov pc, r2
.ltorg
.align
addr:

