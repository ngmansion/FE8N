.thumb

ATK                     = (0x0203a4e8)
RAGING_STORM_FLAG     = (2)
COMBAT_HIT            = (1)
FIRST_ATTACKED_FLAG   = (0)

main:
        push {r4, r5, r6, lr}
        mov r4, r0
        mov r5, r1
        mov r6, r2
        bl JudgeAddition
        cmp r0, #0
        beq return
        bl Blitzkrieg
        cmp r0, #1
        beq return
        bl DoubleLion
        cmp r0, #1
        beq return
        bl SwiftStrikes
        cmp r0, #1
        beq return
        bl Adept
    return:
        pop {r4, r5, r6, pc}

ARENA_ADDR = (0x0203a4d0)

JudgeAddition:
        push {lr}
        ldr r0, =ARENA_ADDR
        ldrh r0, [r0]
        mov r1, #0x20
        and r0, r1
        bne inactive            @闘技場は無効

        ldr r0, [r4, #76]
        mov r1, #0x80
        and r0, r1
        bne inactive            @反撃不可武器は無効

        mov r0, r4
        add r0, #74
        ldrh r0, [r0]
        bl GET_WEAPON_ABILITY
        cmp r0, #3
        beq inactive            @イクリプスは無効
        mov r0, #1
        .short 0xE000
    inactive:
        mov r0, #0
        pop {pc}

DoubleLion: @戦闘予測だと、減少分しか
        push {lr}
        bl SwitchLion
        ldrb r1, [r0, #18]      @最大HP
        ldrb r0, [r0, #19]      @現在HP
        cmp r0, r1
        blt falseDouble

        mov r0, r4
        mov r1, r5
        bl HAS_DOUBLE_LION
        .short 0xE000
    falseDouble:
        mov r0, #0
        pop {pc}

SwitchLion:
        push {lr}
        cmp r6, #0
        beq jumpSwitch
        ldrb r0, [r4, #0xB]
            ldr r1, =0x08019108
            mov lr, r1
            .short 0xF800
        .short 0xE000
    jumpSwitch:
        mov r0, r4
        pop {pc}

SwiftStrikes:
        push {lr}
        mov r0, #FIRST_ATTACKED_FLAG
        mov r1, #0
        bl IS_TEMP_SKILL_FLAG
        cmp r0, #1
        beq falseSwift      @初撃済フラグオンならジャンプ
        mov r0, r4
        mov r1, r5
        bl HAS_SWIFT_STRIKES
        .short 0xE000
    falseSwift:
        mov r0, #0
        pop {pc}

Blitzkrieg:
        push {lr}
        mov r0, r4
        mov r1, r5
        bl HAS_BLITZKRIEG
        cmp r0, #1
        beq endBlitz
        mov r0, r5
        mov r1, r4
        bl HAS_BLITZKRIEG
    endBlitz:
        pop {pc}

Adept:
        push {lr}
        mov r0, r4
        mov r1, r5
        bl HAS_ADEPT
        cmp r0, #0
        beq endAdept
        ldrb r0, [r4, #22]         @はやさ
        mov r1, #0
        bl RANDOM

    endAdept:
        pop {pc}

RANDOM:
    ldr r3, =0x0802a490
    mov pc, r3


GET_WEAPON_ABILITY:
    ldr r1, =0x080174cc
    mov pc, r1

HAS_SWIFT_STRIKES:
    ldr r2, addr
    mov pc, r2
HAS_DOUBLE_LION:
    ldr r2, addr+4
    mov pc, r2
HAS_BLITZKRIEG:
    ldr r2, addr+8
    mov pc, r2
HAS_ADEPT:
    ldr r2, addr+12
    mov pc, r2
IS_TEMP_SKILL_FLAG:
    ldr r2, addr+16
    mov pc, r2

.align
.ltorg
addr:

