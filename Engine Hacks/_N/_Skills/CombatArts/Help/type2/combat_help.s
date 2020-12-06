.thumb

AVO_WORD_ID = 0x0484
MT_WORD_ID = 0x0492
CRT_WORD_ID = 0x0490
HIT_WORD_ID = 0x0483
@ org 0008bf4c

    push    {r4, lr}
    mov r4, r0
    bl GetSelectingCombatID
    cmp r0, #0
    beq notCombat
    b combat
notCombat:
    mov r0, r4
    ldr r4, =0x0203e7a8
    bl  $000172f0   @r0に武器の種類ID
    bl  $00016bc8
    ldr r3, =0x0808bf58
    mov pc, r3

combat:
    push {r7}
    ldr     r4, =0x0203e7a8
    bl GET_COMBAT_SPECIES
    cmp r0, #0xFF
    beq nothingWeaponType
    bl $00016bc8
    mov     r2, #8
    b jumpWeapon
nothingWeaponType:
    ldr     r0, =0x04BF
    bl      $00009fa8
    mov     r2, #7
jumpWeapon:
@@@@
    mov     r3, r0
    mov     r0, r4
    mov     r1, #0

    bl      $000043b8
@@@@
    ldr     r0, =MT_WORD_ID
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #47
    mov     r2, #8
    bl      $000043b8
@@@@
    ldr     r0, =CRT_WORD_ID
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #97
    mov     r2, #8
    bl      $000043b8

@@@@二段目
    add     r4, #8
    bl GET_COST_WORD_ID
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #0
    mov     r2, #8
    bl      $000043b8
    ldr     r0, =0x04C4
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #24
    mov     r2, #7
    bl      $000043b8
@@@@
    ldr     r0, =HIT_WORD_ID
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #47
    mov     r2, #8
    bl      $000043b8
@@@@
    ldr     r0, =AVO_WORD_ID
    bl      $00009fa8
    mov     r3, r0
    mov     r0, r4
    mov     r1, #97
    mov     r2, #8
    bl      $000043b8
    mov     r0, #2
    pop     {r7}
    pop     {r4, pc}

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


GET_WAR_CONFIG:
    ldr r0, ADDR+0
    bx lr
GET_ARROW_CONFIG:
    ldr r0, ADDR+4
    bx lr
GET_COMBAT_SPECIES:
    ldr r1, ADDR+8
    mov pc, r1
GET_COST_WORD_ID:
    ldr r0, ADDR+12
    bx lr
GET_SELECTING_CONFIG:
    ldr r0, ADDR+16
    ldr r1, ADDR+20
    bx lr
DECODE_SKILL_BOOK:
    ldr r1, ADDR+24
    add r1, #4
    mov pc, r1
GET_COMBAT_ARTS_TYPE:
    ldr r1, ADDR+28
    mov pc, r1

$00009fa8:
    ldr r1, =0x08009fa8
    mov pc, r1
$000043b8:
    ldr r7, =0x080043b8
    mov pc, r7

$000172f0:
    ldr r1, =0x080172f0
    mov pc, r1
$00016bc8:
    ldr r1, =0x08016bc8
    mov pc, r1
.align
.ltorg
ADDR:
