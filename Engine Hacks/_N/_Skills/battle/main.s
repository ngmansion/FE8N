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

    ldr r0, =ARENA_ADDR
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne Return

    mov	r0, r6
        ldr r1, NIHIL_ADR
        mov lr, r1
        .short 0xF800
    cmp r0, #1
    beq next

    bl Lull
    bl Shisen_B
    bl Rein
    
next:
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

@r4 temp enemy
@r5 loop count
Rein:   @牽制   2マス以内の相手ユニットは戦闘中攻撃攻速-2
        push {r4, r5, lr}

        ldrb r5, [r4, #0xB]
        mov r0, #0xC0
        and r5, r0      @r5に部隊表ID
        
    loopRein:
        add r5, #1
        mov r0, r5
        bl Get_Status
        mov r4, r0
        cmp r0, #0
        beq endRein        @リスト末尾
        ldr r0, [r4]
        cmp r0, #0
        beq loopRein        @死亡判定1
        ldrb r0, [r4, #19]
        cmp r0, #0
        beq loopRein        @死亡判定2

        ldr r0, [r4, #0xC]
        bl GetExistFlagR1
        and r0, r1
        bne loopRein        @居ないフラグ+救出中
        
        mov r0, #2  @2マス以内
        mov r1, r4
        mov r2, r6
        bl CheckXY
        cmp r0, #0
        beq loopRein

        mov r0, r4
        mov r1, #0
        bl HAS_REIN
        cmp r0, #0
        beq loopRein

    trueRein:
        mov r1, r6
        add r1, #90
        ldrh r0, [r1]
        sub r0, #D_REIN_DOWN_NUM
        bge jumpAtkRein
        mov r0, #0
    jumpAtkRein:
        strh r0, [r1] @威力
        
        mov r1, r6
        add r1, #94
        ldrh r0, [r1]
        sub r0, #D_REIN_DOWN_NUM
        bge jumpSpdRein
        mov r0, #0
    jumpSpdRein:
        strh r0, [r1] @速さ
    endRein:
        pop {r4, r5, pc}

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

Lull:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasLull
        cmp r0, #0
        beq endLull
        mov r0, r6
        mov r1, r4
        bl recalcAtk
        mov r0, r6
        mov r1, r4
        bl recalcSpd
        
        mov r1, r6
        add r1, #90
        ldrh r0, [r1]
        sub r0, #2
        bge jumpAtk
        mov r0, #0
    jumpAtk:
        strh r0, [r1] @威力
        
        mov r1, r6
        add r1, #94
        ldrh r0, [r1]
        sub r0, #2
        bge jumpSpd
        mov r0, #0
    jumpSpd:
        strh r0, [r1] @速さ

    endLull:
        pop {pc}


Shisen_B:	@相手強化
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
NIHIL_ADR = (addr+12)
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

recalcAtk:
    ldr r2, =0x0802aa28
    mov pc, r2
recalcSpd:
    ldr r2, =0x0802aae4
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

.ltorg
.align
addr:

