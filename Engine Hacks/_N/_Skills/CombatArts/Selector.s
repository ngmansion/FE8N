.thumb
@ 08050008

INVALID_COMBAT_ID = (0x00)

push {r4, r5, r6, lr}
mov r5, r0
bl main
mov r2, r5
add r2, #97
ldr r0, =0x08050010
mov pc, r0

main:
        push {lr}
        bl VanishCharacter
        ldr r1, ARROW_CONFIG
        ldrb r0, [r1]
        cmp r0, #0
        beq false
        bl CheckHelp
        cmp r0, #0
        beq false

        bl Left
        cmp r0, #1
        beq true
        bl Right
        cmp r0, #1
        beq true
    false:
        pop {pc}
    true:
        bl DrawRangeMap
        bl Sound
        pop {pc}

key_right = (16)
key_left = (32)

Left:
        push {lr}
        ldr r1, =0x085775cc
        ldr r3, [r1, #0]
        ldrh r0, [r3, #6]
        mov r1, #key_left
        and r0, r1
        cmp r0, #0
        beq falseMove

        bl Decrease
        pop {pc}

Right:
        push {lr}
        ldr r1, =0x085775cc
        ldr r3, [r1, #0]
        ldrh r0, [r3, #6]
        mov r1, #key_right
        and r0, r1
        cmp r0, #0
        beq falseMove

        bl Increase
        pop {pc}

    falseMove:
        mov r0, #0
        pop {pc}

Increase:
    ldr r1, ARROW_CONFIG
    ldrb r0, [r1]
    cmp r0, #7
    bge falseCount
    ldr r3, WAR_CONFIG
    sub r3, #1

    add r0, #1
    ldrb r2, [r3, r0]
    cmp r2, #0
    beq falseCount  @右が0なら増やさない

    strb r0, [r1]
    b trueCount

Decrease:
    ldr r1, ARROW_CONFIG
    ldrb r0, [r1]
    cmp r0, #1
    ble falseCount
    ldr r1, ARROW_CONFIG
    ldrb r0, [r1]
    sub r0, #1
    strb r0, [r1]
    b trueCount
falseCount:
    mov r0, #0
    bx lr
trueCount:
    mov r0, #1
    bx lr

SHORT_RANGE = 0x02
LONG_BOW = 0x10
JAVELIN = 0x20

IRON_SWORD_ID = 0x0101
LONG_BOW_ID = 0x0134
JAVELIN_ID = 0x012D

DrawRangeMap:
        push {lr}

        ldr r1, ARROW_CONFIG
        ldrb r0, [r1]
        sub r0, #1
        ldr r1, WAR_CONFIG
        ldrb r0, [r0, r1]
        cmp r0, #INVALID_COMBAT_ID
        beq normal_draw_range_map

        bl GET_COMBAT_ARTS_TYPE
        mov r1, #SHORT_RANGE
        tst r0, r1
        bne short_range_map
        mov r1, #LONG_BOW
        tst r0, r1
        bne long_bow_range
        mov r1, #JAVELIN
        tst r0, r1
        bne javelin_range
        b normal_draw_range_map    @どこにもヒットしないのでデフォルト

    short_range_map:
        mov r0, #1
        b set_DrawRangeMap
    long_bow_range:
        mov r0, #6
        b set_DrawRangeMap
    javelin_range:
        mov r0, #2
        b set_DrawRangeMap

    set_DrawRangeMap:
        bl draw_special_range
        b endDrawRangeMap
    normal_draw_range_map:
        bl DrawWeaponRangeMap
    endDrawRangeMap:
        pop {pc}


DrawWeaponRangeMap:
@選択中武器の射程表示
        push {r4, r5, lr}
    @0804FCDEの処理
    @
        mov r0, r4
        add r0, #97
        ldrb r0, [r0, #0]
        lsl r0, r0, #2
        mov r1, r4
        add r1, #52
        add r1, r1, r0
        ldr r1, [r1, #0]
    @08022d4cの処理
    @
        mov r5, r1
        add r5, #60
        ldr r0, =0x08022d5a
        mov pc, r0

draw_special_range:
@1 てつけん
@2 ゆみ
@3 てやり
@4 3-3
@5 1,3
@6 ながゆみ
@7 ストーン

@08022d4cの処理
        push    {r4, r5, r6, lr}
        mov r6, r0
@        mov r5, r1
@        add r5, #60
@        mov r0, #0
@        ldsb    r0, [r5, r0]
@        ldr r2, =0x0801e3a4    @ステータス上書き
@        mov lr, r2
@        .short 0xF800
        ldr r0, =0x0202e4dc
        ldr r0, [r0, #0]
        mov r1, #1
        neg r1, r1
        ldr r2, =0x080194bc
        mov lr, r2
        .short 0xF800
        ldr r0, =0x0202e4e0
        ldr r0, [r0, #0]
        mov r1, #0
        ldr r2, =0x080194bc
        mov lr, r2
        .short 0xF800
        ldr r4, =0x03004df0
        ldr r0, [r4, #0]
        mov r1, r6
        ldr r0, [r4, #0]
        ldr r2, =0x0801b13c
        mov lr, r2
        .short 0xF800
        mov r0, #2
        ldr r2, =0x0801d6fc
        mov lr, r2
        .short 0xF800
        mov r0, #0
        pop {r4, r5, r6}
        pop {r1}
        bx  r1


CheckHelp:  @ヘルプ中は動けなくする
        ldr r2, =0x0203E7AA
        ldrb r0, [r2]
        ldrb r1, [r2, #1]
        cmp r0, #0
        bne falseHelp
        cmp r1, #0
        beq trueHelp
        cmp r1, #6
        beq trueHelp
        b falseHelp
    trueHelp:
        mov r0, #1
        .short 0xE000
    falseHelp:
        mov r0, #0
        bx lr




Sound:
mov r0, #102
ldr r1, =0x080d4ef4
mov pc, r1

ARROW_CONFIG = (ADDR+0)
WAR_CONFIG = (ADDR+4)
VanishCharacter:
ldr r0, ADDR+8
mov pc, r0

GET_COMBAT_ARTS_TYPE:
ldr r2, ADDR+12
mov pc, r2


.align
.ltorg
ADDR:
