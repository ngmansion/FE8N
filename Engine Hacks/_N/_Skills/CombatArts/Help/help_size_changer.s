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
        push {lr}
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

        .short 0xE000
    falseOne:
        mov r0, #0
        pop {pc}

DECODE_SKILL_BOOK:
    ldr r1, ADDR+0
    add r1, #4
    mov pc, r1
.ltorg
.align
ADDR:
