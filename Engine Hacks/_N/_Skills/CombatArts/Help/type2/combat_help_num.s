.thumb

@   0008bfe0

        push    {r4, r5, lr}
        mov r5, r0
        ldr r4, =0x0203e7a8

        bl GetSelectingCombatID
        cmp r0, #0
        beq notCombat
        b combat
notCombat:
        mov r0, r5
        bl $00016b3c
        ldr r3, =0x0808bfea
        mov pc, r3

    combat:
        push {r7}
        mov     r5, r0
        ldr     r4, =0x0203e7a8
        bl      GetRange
        cmp r0, #0x01
        beq jumpRange
        ldr     r0, =0x04C5
        .short 0xE001
@@@@@@@@直接攻撃
    jumpRange:
        bl      GET_RANGE_WORD_ID
        bl      $00009fa8
        mov     r3, r0
        mov     r0, r4
        mov     r1, #12
        mov     r2, #7
        bl      $000043b8
@@@@@@@@
        mov     r0, r5
        bl      GET_COMBAT_ATK
        mov     r3, r0
        mov     r0, r4
        mov     r1, #81
        bl      JudgeMinus
        bl      $000043dc
@@@@@@@@
        mov     r0, r5
        bl      GET_COMBAT_CRT
        mov     r3, r0
        mov     r0, r4
        mov     r1, #129
        bl      JudgeMinus
        bl      $000043dc
@@@@@@@@二段目
        add     r4, #8

        mov     r0, r5
        bl      GET_COMBAT_COST
        mov     r3, r0
        mov     r0, r4
        mov     r1, #32
        bl      JudgeMinus
        bl      $000043dc

        mov     r0, r5
        bl      GET_COMBAT_HIT
        mov     r3, r0
        mov     r0, r4
        mov     r1, #81
        bl      JudgeMinus
        bl      $000043dc

        mov     r0, r5
        bl      GET_COMBAT_AVO
        mov     r3, r0
        mov     r0, r4
        mov     r1, #129
        bl      JudgeMinus
        bl      $000043dc
        pop     {r7}
        pop     {r4, r5}
        pop     {r0}
        bx      r0

GetSelectingCombatID:
        push {r4, lr}
        mov r4, r0
        bl SelcectingBook        @スキル書
        cmp r0, #0
        bne endSelecting

        bl SelcectingStatus        @ステータス画面
        cmp r0, #0
        bne endSelecting

        bl SelcectingCombat      @戦技選択中
@        cmp r0, #0
@        bne endSelecting
    endSelecting:
        pop {r4, pc}

METIS_ID = (0x89)
SelcectingBook:
        push {r5, lr}
        mov r0, #0xFF
        and r0, r4
        cmp r0, #METIS_ID
        beq	falseOne

        mov r0, r4
        ldr r1, =0x080174E4     @アイテム効果
        mov lr, r1
        .short 0xF800
        cmp r0, #0x2E       @メティス効果
        bne falseOne

        mov r0, r4
        ldr r1, =0x08017384     @アイテム攻撃力
        mov lr, r1
        .short 0xF800
        bl DECODE_SKILL_BOOK
        mov r5, r0
        bl GET_COMBAT_ARTS_TYPE
        cmp r0, #0
        beq falseOne
        cmp r0, #3
        beq falseOne
        mov r0, r5
        .short 0xE000
    falseOne:
        mov r0, #0
        pop {r5, pc}

SelcectingStatus:
        push {lr}
        lsr r0, r4, #8
        cmp r0, #0xFD       @ダミーフラグ
        bne falseTwo
        bl GET_SELECTING_CONFIG
        ldrb r1, [r1]
        ldrb r0, [r0, r1]
        .short 0xE000
    falseTwo:
        mov r0, #0
        pop {pc}

SelcectingCombat:
        push {lr}
        bl GET_ARROW_CONFIG
        ldrb r0, [r0]
        cmp r0, #0
        beq falseThree
        cmp r0, #1
        beq falseThree

        sub r0, #2
        mov r4, r0
        bl GET_WAR_CONFIG
        ldrb r0, [r0, r4]
        .short 0xE000
    falseThree:
        mov r0, #0
        pop {pc}

GetRange:
        push {lr}

        bl GET_COMBAT_ARTS_TYPE
        cmp r0, #3
        beq AllRange        @奥義ならジャンプ
        cmp r0, #1
        beq AllRange        @全距離
    closeRange:
        mov r0, #0x01        @てつけん
        .short 0xE000
    AllRange:
        mov r0, #0xA6       @漆黒の悪夢
        pop {pc}

JudgeMinus:
        cmp r3, #0
        bge judgePlus
        neg r3, r3
        mov r2, #6
        .short 0xE000
    judgePlus:
        mov r2, #7
        bx lr

$00009fa8:
    ldr r1, =0x08009fa8
    mov pc, r1
$00016b3c:
    ldr r1, =0x08016b3c
    mov pc, r1
$00016a68:
    ldr r7, =0x08016a68
    mov pc, r7
$000043b8:
    ldr r7, =0x080043b8
    mov pc, r7
$000043dc:
    ldr r7, =0x080043dc
    mov pc, r7

GET_COMBAT_ARTS_TYPE:
    ldr r1, ADDR+0
    mov pc, r1
GET_COMBAT_AVO:
    ldr r1, ADDR+4
    mov pc, r1
GET_COMBAT_COST:
    ldr r1, ADDR+8
    mov pc, r1
GET_COMBAT_ATK:
    ldr r1, ADDR+12
    mov pc, r1
GET_COMBAT_HIT:
    ldr r1, ADDR+16
    mov pc, r1
GET_COMBAT_CRT:
    ldr r1, ADDR+20
    mov pc, r1
GET_WAR_CONFIG:
    ldr r0, ADDR+24
    bx lr
GET_ARROW_CONFIG:
    ldr r0, ADDR+28
    bx lr
GET_SELECTING_CONFIG:
    ldr r0, ADDR+32
    ldr r1, ADDR+36
    bx lr
DECODE_SKILL_BOOK:
    ldr r1, ADDR+40
    add r1, #4
    mov pc, r1
GET_RANGE_WORD_ID:
    ldr r0, ADDR+44
    bx lr
.ltorg
.align
ADDR:

