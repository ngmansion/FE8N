.thumb

ATK                     = (0x0203a4e8)

main:
        push {r5, lr}
        mov r5, r0
        ldr r0, =0x0203a4d0
        ldrh r1, [r0, #0]
        mov r0, #2
        and r0, r1
        cmp r0, #0
        bne enemyEND        @戦闘予測時はスキップ
        mov r0, r5
        ldr r1, =ATK
        cmp r0, r1
        bne enemyEND        @防御側ならジャンプ
        ldrb r0, [r5, #0xB]
        mov r1, #0xC0
        tst r0, r1
        beq enemyEND        @プレイヤーならジャンプ
        mov r0, #0
        bl SET_COMBAT_ART
        mov r0, r5
        bl GetCombatArtAtRandom
        bl SET_COMBAT_ART
    enemyEND:
        pop {r5, pc}

max_skill_num = 8

GetCombatArtAtRandom:      @GetSomethingCombatArt
        push {r5, r6, r7, lr}
        mov r5, r0

        mov r0, r5
        ldr r1, WAR_CONFIG
        mov r2, #max_skill_num
        bl GATHER_COMBAT_ENEMY
        mov r7, r0

        mov r6, #0
    loopCombat:
        cmp r6, r7
        bge falseCombat

        ldr r0, WAR_CONFIG
        ldrb r0, [r0, r6]
        bl GetCombatArtsHitRate
        bl RONDOM_NUMBER
        cmp r0, #1
        beq trueCombat
    continue:
        add r6, #1
        b loopCombat
    falseCombat:
        mov r0, #0
        .short 0xE000
    trueCombat:
        mov r0, r6
        pop {r5, r6, r7, pc}

GetCombatArtsHitRate:
        push {lr}
        mov r1, r0
        bl ENEMY_COMBAT_RATE
        sub r1, #1
        ldrb r0, [r0, r1]

        ldr r1, [r5]
        ldrb r1, [r1, #6]
        cmp r1, #0
        beq endRate        @ネームド(顔つき)じゃないならジャンプ
        nop
    endRate:
        pop {pc}


RONDOM_NUMBER:
    ldr r1, =0x08000c78
    mov pc, r1

WAR_CONFIG = ADDR+0
GATHER_COMBAT_ENEMY:
    ldr r2, ADDR+4
    mov pc, r2
SET_COMBAT_ART:
    ldr r1, ADDR+8
    mov pc, r1
ENEMY_COMBAT_RATE:
    ldr r0, ADDR+12
    bx lr

.align
.ltorg
ADDR:

