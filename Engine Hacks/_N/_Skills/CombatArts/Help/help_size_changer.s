.thumb

@0008b55c
@戦技のスキル書なら武器(mov r0, #1)と同様の扱い

    push {r4, lr}
    mov r4, r0
    bl main
    cmp r0, #0
    beq FALSE
    ldr r0, =0x0808b58e
    mov pc, r0
FALSE:
    ldr r0, =0x0808b56c
    ldr r0, [r0]
    cmp r4, r0
    ldr r0, =0x0808b564
    mov pc, r0

main:
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

DECODE_SKILL_BOOK:
    ldr r1, ADDR+0
    add r1, #4
    mov pc, r1
GET_COMBAT_ARTS_TYPE:
    ldr r1, ADDR+4
    mov pc, r1
.ltorg
.align
ADDR:
