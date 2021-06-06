METIS = (0x89)
METIS_EFFECT = (0x2E)  @メティスの書の効果ID


.thumb
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        lsl r0, r1, #24
        lsr r0, r0, #24
        cmp r0, #METIS
        beq meti
        b scroll
    meti:
        ldr r0, [r4, #12]
        mov r1, #128
        lsl r1, r1, #6
        and r0, r1
        cmp r0, #0
        bne false
        b true

    scroll:
        mov r0, r5
        bl GET_WEAPON_EFFECT
        cmp r0, #METIS_EFFECT
        bne false
        
        mov r0, r5
        bl GET_WEAPON_MT
    
        cmp r0, #255
        bne SkillBook
@@@@@@@@消滅処理
        mov r0, r4
        mov r1, #1
        bl GET_BOOK_DATA
        cmp r0, #0
        bne true     @何かあるから消せる
        mov r0, r4
        mov r1, #0
        bl GET_BOOK_DATA
        cmp r0, #0
        bne true
        b false     @未習得 or 書のないスキル
@@@@@@@@
    SkillBook:
        bl DECODE_BOOK
        mov r5, r0
        
        mov r0, r4
        mov r1, r5
        bl CONTAINSKILL
        cmp r0, #1      @1なら習得済み
        beq false
        mov r0, r4
        mov r1, r5
        bl JUDGEUNIT
        cmp r0, #1      @1なら習得済み
        beq false
        
        mov r0, r4
        ldr r1, MAX_NUM
        sub r1, #1
        bl GET_BOOK_DATA
        cmp r0, #0
        beq true        @まだ余裕があるから使える
    
        mov r0, r4
    
        ldr r1, MAX_NUM
        bl DEDUPSKILL
    
        ldr r1, MAX_NUM
        cmp r0, r1
        bne true        @ダブりがあるなら使える
    false:
        mov r0, #1      @使用不可
        .short 0xE000
    true:
        mov r0, #0      @使用可能
        pop {r4, r5, pc}


GET_WEAPON_EFFECT:
    ldr r3, =(0x080174e4)
    mov pc, r3

GET_WEAPON_MT:
    ldr r3, =(0x08017384)
    mov pc, r3

MAX_NUM = ADDR+0

GET_BOOK_SKILL:
    ldr r3, ADDR+4
    mov pc, r3
CONTAINSKILL:
    ldr r3, ADDR+8
    mov pc, r3
DEDUPSKILL:
    ldr r3, ADDR+12
    mov pc, r3
JUDGEUNIT:
    ldr r3, ADDR+16
    mov pc, r3
DECODE_BOOK:
    ldr r1, ADDR+20
    add r1, #4
    mov pc, r1
GET_BOOK_DATA:
    ldr r3, ADDR+24
    mov pc, r3

.align
.ltorg
ADDR:


