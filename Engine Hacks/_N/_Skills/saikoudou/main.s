ATK = (0x0203a4e8)
DEF = (0x0203a568)

TARGET_UNIT = (0x03004df0)
WEAPON_SP_ADDR = (0x080172f0)

ATTACK_FLG_OFFSET = (69)    @書き込み先(AI2カウンタ)

DEFEATED = (0b01000000) @迅雷済みフラグ

DEFEAT_FLAG           = (3)
RAGING_STORM_FLAG     = (2)
COMBAT_HIT            = (1)
FIRST_ATTACKED_FLAG   = (0)

COMMAND_RESCUE = (9)

@0801cea8
.thumb
    push {r4, r5, lr}
    mov r5, r0
    ldr r4, =TARGET_UNIT
    ldr r4, [r4]
@    ldr r4, =ATK
    
    mov r0, r4
    ldrb	r1, [r0, #0x13]
    cmp r1, #0
    beq FALSE   @自分のHPゼロなら何もせずに終了
    
    mov r0, r4
    ldrb r1, [r0, #11]
    mov r2, #192
    and r2, r1
    bne FALSE @自軍以外は終了(そもそも通らない)
    ldr r0, [r4, #12]
    ldr r1, =0x80000000
    tst r0, r1
    bne clearFALSE          @再移動済み

    bl JudgeAhead
    cmp r0, #0
    .short 0xD000
    b CantoHurry             @全力移動

    ldr r0, =0x0203a954
    ldrb r0, [r0, #17]
    cmp r0, #1
    beq WaitSkills         @待機選択なら終了



    ldr r0, [r4, #12]
    ldr r1, =0x0801cf04
    ldr r1, [r1]
    and r0, r1
    cmp r0, #0
    bne FALSE               @死亡・待機(or再行動済)・??状態

    ldr r0, =0x0203a954
    ldrb r0, [r0, #17]
    cmp r0, #17
    beq clearFALSE          @制圧選択なら終了

    mov r0, r4
    ldr r1, =DEF
    bl kaifuku

    mov r0, r4          @r4 is not ATK, DEF
    ldr r1, =DEF
    bl RagingStormWrapper
    cmp r0, #1
    beq Sound
@疾風迅雷・神風招来判定
    mov r0, r4
    add r0, #ATTACK_FLG_OFFSET
    ldrb r1, [r0]

    mov r2, #DEFEATED
    and r2, r1
    bne next    @再行動済み

    mov r0, r4          @r4 is not ATK, DEF
    ldr r1, =DEF
    bl RagingStorm
    cmp r0, #1
    beq getReMove

    mov r0, #DEFEAT_FLAG
    mov r1, #0
    bl IS_TEMP_SKILL_FLAG
    cmp r0, #1
    beq pattern1
    b pattern2

WaitSkills:
    mov r0, r4
    bl WAIT_SKILLS

clearFALSE:
    bl clear_defeat
FALSE:
    bl ClearTempFlag

    ldr r4, =TARGET_UNIT
    ldr r3, =0x0801cefc
    mov pc, r3

pattern1:
@再行動なし撃破
@
    bl shippuJinrai
    cmp r0, #1
    beq getReMove
    b next

pattern2:
@再行動なし未撃破
@
    
    bl jinpuShourai    @神風招来
    cmp r0, #1
    beq getReMove

    bl ChangeFate
    cmp r0, #1
    beq getReMove
    b next

getReMove:
@一回目撃破(再行動済みフラグ)をオン
    mov r0, #ATTACK_FLG_OFFSET
    ldrb r1, [r4, r0]

    mov r2, #DEFEATED
    orr r1, r2

    strb r1, [r4, r0] @撃破済み setStartingTurnでクリア
    
    b Sound     @再行動
nop
nop

next:
    bl clear_defeat
    bl ClearTempFlag
@スキル再移動による再移動化
    bl JudgeCantoPlus
    cmp r0, #1
    beq CantoPlus

    ldr r2, =TARGET_UNIT
    ldr r3, [r2]
    mov r4, r2
    ldr r0, =0x0801ceb0 @通常の再移動判定
    mov pc, r0

CantoHurry:
    ldr r0, [r4, #12]
    ldr r1, =0x40000000
    orr r0, r1
    str r0, [r4, #12]

    ldrb r0, [r4, #29]
    add r0, #2
    strb r0, [r4, #29]
CantoPlus:

    ldr r4, =TARGET_UNIT
    ldr r3, =0x0801cece
    mov pc, r3

Sound:	
    bl clear_defeat
    bl ClearTempFlag
@再行動
    ldr	r0, =0x0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	end
    mov	r0, #97
    ldr	r2, =0x080d4ef4
    mov	lr, r2
    .short 0xf800
end:
    mov r0, #0
    pop {r4, r5}
    pop {r1}
    bx r1


clear_defeat:
        ldr r0, [r4, #12]
        ldr r1, =0x80000000
        bic r0, r1
        str r0, [r4, #12]       @全力移動
@@@@
        ldr r0, [r4, #12]
        ldr r1, =0x40000000
        tst r0, r1
        beq jumpClear
        bic r0, r1
        str r0, [r4, #12]       @全力移動
        ldrb r0, [r4, #29]
        sub r0, #2
        strb r0, [r4, #29]       @全力移動
    jumpClear:
@@@@
@再行動済みは消さない

        bx lr

ClearTempFlag:      @CombatArms/setFlag.sにもあるので注意
        push {lr}
        mov r0, #0xFF
        ldr r1, =ATK
        bl TURN_OFF_TEMP_SKILL_FLAG
        mov r0, #0xFF
        ldr r1, =DEF
        bl TURN_OFF_TEMP_SKILL_FLAG
        
        pop {pc}

RagingStormWrapper:
        ldr r1, addr+44
        cmp r1, #0
        beq RagingStorm
        mov r0, #0
        bx lr
@
@狂嵐
@
RagingStorm:
        push {r4, lr}
        mov r4, r0
        ldr r1, =ATK            @フラグを取る為
        ldrb r0, [r0, #0xB]
        ldrb r1, [r1, #0xB]
        cmp r0, r1
        bne falseStorm

        mov r0, #RAGING_STORM_FLAG
        mov r1, #0
        bl IS_TEMP_SKILL_FLAG   @battle/downでセット
        cmp r0, #0
        beq falseStorm      @フラグなし
        mov r0, #RAGING_STORM_FLAG
        mov r1, #0
        bl TURN_OFF_TEMP_SKILL_FLAG

        mov	r0, r4
        ldr	r1, [r0, #12]	@行動済み等の状態
        ldr	r2, =0xfffffbbd
        and	r1, r2
        str	r1, [r0, #12]
        
        mov	r0, #1
        .short 0xE000
    falseStorm:
        mov	r0, #0
        pop	{r4, pc}

@疾風迅雷
@
shippuJinrai:
        push {lr}
        ldr r0, =0x0203a4d2
        ldrb r0, [r0]    @距離
        cmp r0, #1
        bne falseJinrai
        mov r0, r4
        mov r1, #0
            ldr r2, hasGaleforce
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq falseJinrai
        mov	r0, r4
        ldr	r1, [r0, #12]	@行動済み等の状態
        ldr	r2, =0xfffffbbd
        and	r1, r2
        str	r1, [r0, #12]
        
        mov	r0, #1
        .short 0xE000
    falseJinrai:
        mov	r0, #0
        pop	{pc}

@神風招来
@
jinpuShourai:
        push {lr}
        ldr r0, =DEF
        ldr r1, [r0, #4]
        cmp r1, #0          @相手がいない
        beq falseShourai    @

        mov r0, r4
        ldr r1, =ATK
        ldrb r0, [r0, #0xB]
        ldrb r2, [r1, #0xB]
        cmp r0, r2
        bne falseShourai
        add r1, #0x48
        ldrh r0, [r1]
            ldr r2, =WEAPON_SP_ADDR
            mov lr, r2
            .short 0xF800
        cmp r0, #4      @杖
        bne falseShourai

        mov r0, r4
        mov r1, #0
            ldr r2, hasGaleCause
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq falseShourai

        mov r0, r4
        ldr r1, [r0, #12]   @行動済み等の状態
        ldr r2, =0xfffffbbd
        and r1, r2
        str r1, [r0, #12]
        
        mov r0, #1
        .short 0xE000
    falseShourai:
        mov r0, #0
        pop {pc}

ChangeFate:
        push {lr}

        ldr r0, =0x0203a954
        ldrb r0, [r0, #17]
        cmp r0, #COMMAND_RESCUE
        bne falseFate         @救出以外なら終了

        mov r0, r4
        mov r1, #0
        bl HAS_CHANGE_FATE
        cmp r0, #0
        beq falseFate

        mov r0, r4
        ldr r1, [r0, #12]   @行動済み等の状態
        ldr r2, =0xfffffbbd
        and r1, r2
        str r1, [r0, #12]
        
        mov r0, #1
        .short 0xE000
    falseFate:
        mov r0, #0
        pop {pc}

@生命吸収
kaifuku:
        push {lr}
        mov r0, r4
            ldr r2, addr+8
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq non_hp

        mov r0, #DEFEAT_FLAG
        mov r1, #0
        bl IS_TEMP_SKILL_FLAG
        cmp r0, #0
        beq non_hp  @撃破フラグがオフ

        mov	r2, r4
        ldrb r0, [r2, #19] @現在19
        ldrb r1, [r2, #18] @最大18
        asr r1, r1, #1
        add r0, r0, r1

        ldrb r1, [r2, #18] @最大18
        cmp r0, r1
        ble jump_hp
        mov r0, r1
    jump_hp:
        strb r0, [r2, #19] @現在19

        mov r0, #0x89
        mov r1, #0xB8
            ldr r2, =0x08014B50 @音
            mov lr, r2
            .short 0xF800
        mov	r0, #1
        .short 0xE000
    non_hp:
        mov	r0, #0
        pop	{pc}

JudgeAhead:
        push {lr}
        ldr r1, =0x0203a954
        ldrb r0, [r1, #17]
        cmp r0, #1
        bne falseAhead      @待機じゃない
        ldrb r0, [r1, #16]
        cmp r0, #0
        bne falseAhead      @移動済み

        mov	r0, r4
        mov r1, #0
        bl HAS_FULL_SPEED_AHEAD
        .short 0xE000

    falseAhead:
        mov r0, #0
        pop {pc}

JudgeCantoPlus:
        push {lr}
        mov r0, r4
        mov r1, #0
            ldr r2, addr+12 @再移動
            mov lr, r2
            .short 0xF800
        pop {pc}

HAS_FULL_SPEED_AHEAD:
    ldr r2, addr+0
    mov pc, r2
hasGaleforce = (addr+4)
hasLifetaker = (addr+8)
hasCantoPlus = (addr+12)
hasGaleCause = (addr+16)

WAIT_SKILLS:
    ldr r2, addr+20
    mov pc, r2

GET_RAIGING_STORM:
    ldr r0, addr+24
    bx lr

HAS_CHANGE_FATE:
    ldr r2, addr+28
    mov pc, r2
GET_COMBAT_ART:
    ldr r1, addr+32
    mov pc, r1
IS_TEMP_SKILL_FLAG:
    ldr r2, addr+36
    mov pc, r2
TURN_OFF_TEMP_SKILL_FLAG:
    ldr r2, addr+40
    mov pc, r2
GET_RAGING_STORM_NERF_CONFIG:
    ldr r0, addr+44
    bx lr
.align
.ltorg
addr:
