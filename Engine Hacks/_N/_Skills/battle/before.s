
@ 0802a90c
@ステータス画面にも影響がある
@相手が存在するとは限らない(ダミーかもしれない)
.thumb
    bl AvoidUp
    
@闘技場チェック
    bl GetArenaAddr
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne RETURN
@相手が必要ない処理

    ldr r0, [r5, #4]
    cmp r0, #0
    beq gotSkill	@相手いない
    mov r0, r5

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
    bl JointDrive

endNoEnemy:

@相手の存在をチェック
    ldr r0, [r5, #4]
    cmp r0, #0
    beq endNeedEnemy	@相手いない

    bl WarSkill

    mov	r0, r5
    bl HasMikiri
    cmp r0, #0
    bne endNeedEnemy
    
    bl OtherSideSkill
    bl koroshi
    bl Trample
    bl Catch

endNeedEnemy:

@マイナス処理
    mov r0, r4
    bl HasMikiri
    cmp r0, #1
    beq endDown
    bl Heartseeker
    bl Daunt
endDown:

RETURN:
    pop {r4, r5}
    pop {r0}
    bx r0

catch_gain = (3)

Catch:
        push {lr}

        ldrb r0, [r5, #19]
        ldrb r1, [r5, #18]
        cmp r0, r1
        blt endCatch  @HPが最大未満ならジャンプ

        mov r0, r4
        mov r1, #0
        bl HAS_CATCH
        cmp r0, #0
        beq endCatch

        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #catch_gain
        strh r0, [r4, r1]
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #catch_gain
        strh r0, [r4, r1]
    endCatch:
        pop {pc}

Trample:
        push {lr}
@        ldr r0, [r4]
@        ldr r1, [r4, #4]
@        ldr r0, [r0, #40]
@        ldr r1, [r1, #40]
@        orr r0, r1
@        mov r1, #0x1C
@        lsl r1, r1, #8  @0x1C00
@        tst r0, r1
@        beq endTrample  @自分が歩兵なら終了

        ldr r0, [r5]
        ldr r1, [r5, #4]
        ldr r0, [r0, #40]
        ldr r1, [r1, #40]
        orr r0, r1
        mov r1, #0x1C
        lsl r1, r1, #8  @0x1C00
        tst r0, r1
        bne endTrample  @相手が騎兵なら終了

        mov r0, r4
        mov r1, #0
        bl HasTrample
        cmp r0, #0
        beq endTrample

        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #5
        strh r0, [r4, r1]
    endTrample:
        pop {pc}

OtherSideSkill:
        push {lr}
        bl GetAttackerAddr
        ldr r0, [r0]
        ldrb r0, [r0, #0xB]
        
        ldrb r1, [r4, #0xB]
        cmp r0, r1
        bne DefSkill
        bl Kishin
        bl Hien
        bl Bracing
        bl WarMasterBlow
        bl DuelistBlow
        bl UncannyBlow
        bl Charge
        bl BladeSession
        pop {pc}
    DefSkill:
        bl DistantDef
        bl CloseDef
        bl ShieldSession
        bl ImpregnableWall
        bl KishinR
        bl HienR
        bl BracingR
        bl KishinBreath
        bl HienBreath
        pop {pc}

CriticalUp:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasCriticalUp
        cmp r0, #0
        beq falseCritical    
        mov r1, #102
        ldrh r0, [r4, r1]
        add r0, #15
        strh r0, [r4, r1] @自分
    falseCritical:
        pop {pc}
    
AvoidUp:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasAvoidUp
        cmp r0, #0
        beq falseAvoid    
        mov r1, #98
        ldrh r0, [r4, r1]
        add r0, #15
        strh r0, [r4, r1] @自分
    falseAvoid:
        pop {pc}

shield_session_spaces = 3   @3マス

ShieldSession:
        push {r5, r6, r7, lr}

        mov r0, r4
        mov r1, #0
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

        mov r0, #shield_session_spaces
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopShieldSession
        add r7, #1
        b loopShieldSession
    resultShieldSession:
        pop {pc}

@@@@@@@@
@@@@@@@@

blade_session_grants = 3
blade_session_spaces = 3
blade_session_limits = 7

BladeSession:
        push {r5, r6, r7, lr}
        bl BladeSessionOne  @自己強化
@        bl BladeSessionAll  @周囲強化
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
  
        mov r0, #blade_session_spaces
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #1
        beq trueBladeSessionAll
        b loopBladeSessionAll
    trueBladeSessionAll:
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #blade_session_grants
        strh r0, [r4, r1]
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #blade_session_grants
        strh r0, [r4, r1]
    falseBladeSessionAll:
        pop {pc}

BladeSessionOne:
        push {lr}
        mov r3, r8
        push {r3}
        mov r0, r4
        mov r1, #0
        bl HasBladeSession
        cmp r0, #0
        beq falseBladeSession

        ldrb r6, [r4, #0xB]
        mov r0, #0xC0
        and r6, r0  @r6に部隊表ID

        mov r8, r5  @r8に相手

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
  
        mov r0, #blade_session_spaces
        mov r1, r8
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopBladeSession
        add r7, #1
        b loopBladeSession
    resultBladeSession:
        mov r2, #blade_session_grants
        mul r2, r7
        cmp r2, #blade_session_limits
        ble limitBladeSession
        mov r2, #blade_session_limits
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
        pop {r3}
        mov r8, r3
        pop {pc}

@@@@@@@@
@@@@@@@@

joint_drive_grants = 4
joint_drive_spaces = 2
joint_drive_limits = 9

joint_count_atk     .req r8
joint_count_spd     .req r9

JointDrive:
        push {r5, r6, r7, lr}
        mov r0, r8
        mov r1, r9
        push {r0, r1}
        mov r7, #0
        mov joint_count_atk, r7
        mov joint_count_spd, r7

        ldrb r6, [r4, #0xB]
        mov r0, #0xC0
        and r6, r0  @r6に部隊表ID

    loopJointDrive:
        add r6, #1
        mov r0, r6
        bl Get_Status
        mov r5, r0
        cmp r0, #0
        beq resultJointDrive  @リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopJointDrive @死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopJointDrive @死亡判定2
        ldrb r0, [r4, #0xB]
        ldrb r1, [r5, #0xB]
        cmp r0, r1
        beq loopJointDrive @自分
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1
        tst r0, r1
        bne loopJointDrive
  
        mov r0, #joint_drive_spaces
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopJointDrive
        mov r7, #1

        mov r0, r5
        bl JointCount
        b loopJointDrive
    resultJointDrive:
        cmp r7, #0
        beq endJointDrive     @誰も居なかった
@@@@@@@@
        mov r0, r4
        bl JointCount
@@@@@@@@
        mov r0, joint_count_atk
        mov r2, #joint_drive_grants
        mul r2, r0
        cmp r2, #joint_drive_limits
        ble limitJointDriveAtk
        mov r2, #joint_drive_limits
    limitJointDriveAtk:
        mov r1, #90         @攻撃
        ldrh r0, [r4, r1]
        add r0, r2
        strh r0, [r4, r1]
@@@@@@@@
        mov r0, joint_count_spd
        mov r2, #joint_drive_grants
        mul r2, r0
        cmp r2, #joint_drive_limits
        ble limitJointDriveSpd
        mov r2, #joint_drive_limits
    limitJointDriveSpd:
        mov r1, #94         @攻速
        ldrh r0, [r4, r1]
        add r0, r2
        strh r0, [r4, r1]
    endJointDrive:
        pop {r0, r1}
        mov r8, r0
        mov r9, r1
        pop {r5, r6, r7, pc}


JointCount:
        push {r4, lr}
        mov r4, r0
        mov r0, r4
        mov r1, #0
        bl HAS_JOINT_DRIVE_ATK
        cmp r0, #0
        beq skipJointAtk
        mov r0, #1
        add joint_count_atk, r0
    skipJointAtk:

        mov r0, r4
        mov r1, #0
        bl HAS_JOINT_DRIVE_SPD
        cmp r0, #0
        beq skipJointSpd
        mov r0, #1
        add joint_count_spd, r0
    skipJointSpd:
        pop {r4, pc}

@@@@@@@@
@@@@@@@@

ImpregnableWall:
        push {lr}

        mov r0, r4
        mov r1, #0
        bl HAS_IMPREGNABLE_WALL
        cmp r0, #0
        beq falseImpregnableWall
        mov r0, #0
        mov r1, #98 @回避
        strh r0, [r4, r1]

        mov r0, #1
        .short 0xE000
    falseImpregnableWall:
        mov r0, #0
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
        beq resultDaunt @リスト末尾
        ldr r0, [r5]
        cmp r0, #0
        beq loopDaunt @死亡判定1
        ldrb r0, [r5, #19]
        cmp r0, #0
        beq loopDaunt @死亡判定2
    
        ldr r0, [r5, #0xC]
        bl GetExistFlagR1 @居ないフラグ+救出されている
        and r0, r1
        bne loopDaunt
    
        mov r0, #3  @範囲指定
        mov r1, r4
        mov r2, r5
        bl CheckXY
        cmp r0, #0
        beq loopDaunt @近くにいない
    
        mov r0, r5
        mov r1, #0
        bl HAS_DAUNT
        cmp r0, #0
        beq loopDaunt    @相手が恐怖未所持
    
@変更: 重複を無効化
@        add r7, #1
@        b loopDaunt
        mov r7, #1
    
    resultDaunt:
        bl GET_DAUNT_NUM
        mov r2, r0
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
        mov r1, #0
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

@攻撃はここではなく凪の後
        mov r1, #96
        ldrh r0, [r4, r1]
        mov r2, #1
        ldsb r2, [r3, r2]
        add r0, r2
        cmp r0, #0
        bge jumpWar2
        mov r0, #0
    jumpWar2:
        strh r0, [r4, r1] @命中
@@@@@@@@
        mov r1, #98
        ldrh r0, [r4, r1]
        mov r2, #3
        ldsb r2, [r3, r2]
        add r0, r2
        cmp r0, #0
        bge jumpWar3
        mov r0, #0
    jumpWar3:
        strh r0, [r4, r1] @回避
@@@@@@@@
        mov r1, #104
        ldrh r0, [r4, r1]
        add r0, r2
        cmp r0, #0
        bge jumpWarDodge
        mov r0, #0
    jumpWarDodge:
        strh r0, [r4, r1] @必殺回避
@@@@@@@@
        mov r1, #102
        ldrh r0, [r4, r1]
        mov r2, #2
        ldsb r2, [r3, r2]
        add r0, r2
        cmp r0, #0
        bge jumpWar4
        mov r0, #0
    jumpWar4:
        strh r0, [r4, r1] @必殺
    
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
        mov r1, #0
        bl HasFort
    
        cmp r0, #0
        beq falseFort
    
        mov r1, r4
        add r1, #90
        ldrh r0, [r1]
        sub r0, #2  @minus 2
        bge jumpFort
        mov r0, #0
    jumpFort:
        strh r0, [r1] @自分
        
        mov r1, r4
        add r1, #92
        ldrh r0, [r1]
        add r0, #4  @plus 4
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
        mov r1, #0
        bl HasShisen
        
        cmp r0, #0
        beq falseShisen
        
        mov r1, r4
        mov r0, #90
        ldrh r0, [r1, r0]
        add r0, #5
        add r1, #90
        strh r0, [r1] @自分
        mov r1, r4
        mov r0, #94
        ldrh r0, [r1, r0]
        add r0, #5
        add r1, #94
        strh r0, [r1] @自分
        mov r0, #1
        b endShisen
    falseShisen:
        mov r0, #0
    endShisen:
        pop {pc}

biding_necklace_gain = (2)
solo_gain = (3)
Solo:
        push {r4, r5, lr}
        mov r0, r4
        bl CheckSolo
        cmp r0, #0
        beq endSolo

        mov r0, r4
        mov r1, #0
        bl HasSolo
        cmp r0, #0
        beq skipSolo
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #solo_gain
        strh r0, [r4, r1] @自分
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #solo_gain
        strh r0, [r4, r1] @自分
    skipSolo:

        mov r0, r4
        mov r1, #0
        bl HAS_BINDING_NECKLACE
        cmp r0, #0
        beq skipBinding
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #biding_necklace_gain
        strh r0, [r4, r1] @自分
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #biding_necklace_gain
        strh r0, [r4, r1] @自分
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #biding_necklace_gain
        strh r0, [r4, r1] @自分
    skipBinding:

    endSolo:
        pop {r4, r5, pc}

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

Get_Status:
    ldr r1, =0x08019108
    mov pc, r1

.align
.ltorg

Ace:
        push {lr}
    
        ldrb	r0, [r4, #0x13]	@NOW
        ldrb	r1, [r4, #0x12]	@MAX
        lsl	r0, r0, #1
        cmp	r0, r1
        bgt	endAce
    
        mov r0, r4
        mov r1, #0
        bl HasAce
        cmp	r0, #0
        beq	endAce
    
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


DEFENDER_DAMAGE = (6)

Savior:
        push {lr}
        
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

        mov r0, r4
        mov r1, #0
        bl HasSavior
        cmp r0, #0
        beq endSavior
        
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
        ldr r0, Range_ADDR
        ldrb r0, [r0] @距離
        cmp r0, #1
        ble endDistantDef
        
        mov r0, r4
        mov r1, #0
        bl HasDistantDef
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
        ldr r0, Range_ADDR
        ldrb r0, [r0] @距離
        cmp r0, #1
        bne endCloseDef
        
        mov r0, r4
        mov r1, #0
        bl HasCloseDef
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
        mov r0, #83
        ldsb r0, [r4, r0]
        cmp r0, #0
        blt falseKoroshi

        bl breaker_impl
        cmp r0, #0
        beq falseKoroshi
    gotKoroshi:
        bl setKoroshi
        mov r0, #1
        .short 0xE000
    falseKoroshi:
        mov r0, #0
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
        bl HasShishi
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
        mov r1, #0
        bl HasKonshin
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

Charge:
        push {lr}
        bl GetDistance
        ldrb r0, [r0]
        cmp r0, #1
        bgt endCharge       @遠距離は無効
        mov r0, r4
        mov r1, #0
        bl HAS_CHARGE
        cmp r0, #0
        beq endCharge
        
        mov r0, r4
        bl GetWalked
        lsl r0, r0, #1
        cmp r0, #10
        ble jumpCharge
        mov r0, #10
    jumpCharge:
        mov r1, #90
        ldrh r2, [r4, r1]
        add r2, r0
        strh r2, [r4, r1] @自分
    endCharge:
        pop {pc}

Kishin:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasKishin
        cmp r0, #0
        beq endKishin
        
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #5 @威力
        strh r0, [r4, r1] @自分
    
    endKishin:
        pop {pc}
KishinR:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasKishinR
        cmp r0, #0
        beq endKishin
        
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #6 @威力
        strh r0, [r4, r1] @自分
        b endKishin
KishinBreath:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_FIERCE_BREATH
        cmp r0, #0
        beq endKishin
        
        mov r1, #90
        ldrh r0, [r4, r1]
        add r0, #4 @威力
        strh r0, [r4, r1] @自分
        b endKishin
Bracing:
        push {lr}
        mov r0, r5
        bl IS_MAGIC
        cmp r0, #1
        beq jumpBracing
        bl Kongou
        b endBracing
    jumpBracing:
        bl Meikyou
    endBracing:
        pop {pc}

BracingR:
        push {lr}
        mov r0, r5
        bl IS_MAGIC
        cmp r0, #1
        beq jumpBracingR
        bl KongouR
        b endBracingR
    jumpBracingR:
        bl MeikyouR
    endBracingR:
        pop {pc}

Kongou:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasKongou
        cmp r0, #0
        beq endKongou
    
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #10
        strh r0, [r4, r1]
    endKongou:
        pop {pc}
KongouR:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasKongouR
        cmp r0, #0
        beq endKongou
    
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        b endKongou

Meikyou:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasMeikyou
        cmp r0, #0
        beq endMeikyou
    
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #10
        strh r0, [r4, r1]
    endMeikyou:
        pop {pc}
MeikyouR:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasMeikyouR
        cmp r0, #0
        beq endMeikyou
    
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        b endMeikyou

Hien:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasHien
        cmp r0, #0
        beq endHien
        
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #5
        strh r0, [r4, r1]
        
    endHien:
        pop {pc}
HienR:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasHienR
        cmp r0, #0
        beq endHien
        
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        b endHien
HienBreath:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_DARTING_BREATH
        cmp r0, #0
        beq endHien
        
        mov r1, #94
        ldrh r0, [r4, r1]
        add r0, #4
        strh r0, [r4, r1]
        b endHien

WarMasterBlow:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_WAR_MASTER_BLOW
        cmp r0, #0
        beq endWarMasterBlow
        
        mov r1, #102
        ldrh r0, [r4, r1]
        add r0, #20 @必殺
        strh r0, [r4, r1] @自分
    endWarMasterBlow:
        pop {pc}
DuelistBlow:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_DUELIST_BLOW
        cmp r0, #0
        beq endDuelistBlow
        
        mov r1, #98
        ldrh r0, [r4, r1]
        add r0, #20
        strh r0, [r4, r1]
    endDuelistBlow:
        pop {pc}
UncannyBlow:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HAS_UNCANNY_BLOW
        cmp r0, #0
        beq endUncannyBlow
        
        mov r1, #96    @命中
        ldrh r0, [r4, r1]
        add r0, #30
        strh r0, [r4, r1] @自分
    endUncannyBlow:
        pop {pc}

breaker_impl:
        push {lr}
        mov r0, r5
        add r0, #74
        ldrh r0, [r0]
        bl GetWeaponSp
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
        mov r1, #0
        bl HasBreakerSw
        b endBreaker
    lance:
        mov r0, r4
        mov r1, #0
        bl HasBreakerSp
        b endBreaker
    axe:
        mov r0, r4
        mov r1, #0
        bl HasBreakerAx
        b endBreaker
    bow:
        mov r0, r4
        mov r1, #0
        bl HasBreakerBw
        b endBreaker
    magic:
        mov r0, r4
        mov r1, #0
        bl HasBreakerMg
        b endBreaker
    falseBreaker:
        mov r0, #0
    endBreaker:
        pop {pc}

.align
Range_ADDR:
.long 0x0203a4d2


SHISHI_ADDR = (addr+4)
SAVIOR_ADDR = (addr+44)
BLADE_SESSION_ADDR = (addr+48)
SHIELD_SESSION_ADDR = (addr+52)
HAS_AVOIDUP_ADDR = (addr+56)
HAS_CRITICALUP_ADDR = (addr+60)
HAS_CHARGE:
    ldr r2, addr+68
    mov pc, r2
@ARMOR_E_ADDR = (addr+72)
@HORSE_E_ADDR = (addr+76)
HasMeikyou:
    ldr r3, (addr+80)
    mov pc, r3
HIEN_ADDR = (addr+84)
ACE_ADDR = (addr+88)
KONSHIN_ADDR = (addr+92)
SOLO_ADDR = (addr+96)
SHISEN_ADDR = (addr+100)
FORT_ADDR = (addr+104)
TRAMPLE_ADDR = (addr+108)
HEARTSEEKER_ADDR = (addr+112)
DAUNT_ADDR = (addr+116)
HAS_BOND_ADDR = (addr+120)
HasMeikyouR:
    ldr r3, (addr+124)
    mov pc, r3
HAS_KISHIN_R = (addr+128)
HAS_KONGOU_R = (addr+132)
HAS_HIEN_R = (addr+136)
COMBAT_TBL = (addr+140)
COMBAT_TBL_SIZE = (addr+144)
GET_COMBAT_ART:
    ldr r2, (addr+148)
    mov pc, r2
HAS_FIERCE_BREATH:
    ldr r2, (addr+152)
    mov pc, r2
HAS_DARTING_BREATH:
    ldr r2, (addr+156)
    mov pc, r2
HAS_JOINT_DRIVE_ATK:
    ldr r2, (addr+160)
    mov pc, r2
HAS_JOINT_DRIVE_SPD:
    ldr r2, (addr+164)
    mov pc, r2
IS_MAGIC:
    ldr r2, (addr+168)
    mov pc, r2
HAS_BINDING_NECKLACE:
    ldr r2, (addr+172)
    mov pc, r2
HAS_CATCH:
    ldr r2, (addr+176)
    mov pc, r2
HAS_WAR_MASTER_BLOW:
    ldr r2, (addr+180)
    mov pc, r2
HAS_DUELIST_BLOW:
    ldr r2, (addr+184)
    mov pc, r2
HAS_UNCANNY_BLOW:
    ldr r2, (addr+188)
    mov pc, r2
GET_DAUNT_NUM:
    ldr r0, (addr+192)
    bx lr


GetWarList:
    ldr r1, COMBAT_TBL_SIZE
    mul r0, r1
    ldr r1, COMBAT_TBL
    add r0, r1
    bx lr

HasTrample:
    ldr r2, TRAMPLE_ADDR
    mov pc, r2

HasKishinR:
    ldr r2, HAS_KISHIN_R
    mov pc, r2
HasKongouR:
    ldr r2, HAS_KONGOU_R
    mov pc, r2
HasHienR:
    ldr r2, HAS_HIEN_R
    mov pc, r2
HasBreakerSw:
    ldr r2, addr+16
    mov pc, r2
HasBreakerSp:
    ldr r2, addr+20
    mov pc, r2
HasBreakerAx:
    ldr r2, addr+24
    mov pc, r2
HasBreakerBw:
    ldr r2, addr+28
    mov pc, r2
HasBreakerMg:
    ldr r2, addr+32
    mov pc, r2
HasHien:
    ldr r2, HIEN_ADDR
    mov pc, r2
HasKongou:
    ldr r2, addr+12
    mov pc, r2
HasKishin:
    ldr r2, addr+8
    mov pc, r2
HasKonshin:
    ldr r2, KONSHIN_ADDR
    mov pc, r2
HasShishi:
    ldr r2, SHISHI_ADDR
    mov pc, r2
HasDistantDef:
    ldr r2, (addr+40)
    mov pc, r2
HasCloseDef:
    ldr r2, (addr+36)
    mov pc, r2
HasCriticalUp:
    ldr r2, HAS_CRITICALUP_ADDR
    mov pc, r2
HasAvoidUp:
    ldr r2, HAS_AVOIDUP_ADDR
    mov pc, r2
HasBladeSession:
    ldr r2, BLADE_SESSION_ADDR
    mov pc, r2
HasShieldSession:
    ldr r2, SHIELD_SESSION_ADDR
    mov pc, r2
HAS_IMPREGNABLE_WALL:
    ldr r2, (addr+64)
    mov pc, r2
HAS_DAUNT:
    ldr r2, DAUNT_ADDR
    mov pc, r2
HasHeartseeker:
    ldr r2, HEARTSEEKER_ADDR
    mov pc, r2
HasSavior:
    ldr r2, SAVIOR_ADDR
    mov pc, r2
HasMikiri:
    ldr r1, addr    @見切り
    mov pc, r1
HasAce:
    ldr r3, ACE_ADDR
    mov pc, r3
HasSolo:
    ldr r3, SOLO_ADDR
    mov pc, r3
HasShisen:
    ldr r3, SHISEN_ADDR
    mov pc, r3
HasFort:
    ldr r3, FORT_ADDR
    mov pc, r3
HasBond:
    ldr r3, HAS_BOND_ADDR
    mov pc, r3

GetAttackerAddr:
    ldr r0, =0x03004df0
    bx lr
GetWeaponSp:
    ldr r1, =0x080172f0
    mov pc, r1
GetArenaAddr:
    ldr r0, =0x0203a4d0
    bx lr
GetDistance:
    ldr r0, =0x0203a4d2
    bx lr
GetExistFlagR1:
    ldr r1, =0x1002C    @居ないフラグ+救出されている
    bx lr
.align
.ltorg
addr:

