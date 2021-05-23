.thumb


        push {r4, lr}
        mov r4, r1

        bl SpecialSpiral

        mov r0, r4
        bl FODES_FUNC
        beq false
        ldr r1, =0x0203a4d0
        ldrh r0, [r1, #14]
        cmp r0, #0
        beq false
        ldr r1, LETHALITY_ID
        mov r10, r1
        mov r1, #0

        ldr r3, =0x0802a490 @乱数
        mov lr, r3
        .short 0xF800

        cmp r0, #1
        beq true
    false:
        mov r0, #0
        .short 0xE000
    true:
        mov r0, #1
        pop {r4, pc}

SpecialSpiral:
        push {r4, lr}
        mov r4, r0
        mov r2, #48
        ldrb r2, [r0, r2]
        mov r3, #0x0F
        and r3, r2
        cmp r3, #7
        beq cmpSpiral       @必殺状態

        cmp r2, #0
        bne falseSpiral     @既に何かの状態
        b checkSpiral
    cmpSpiral:
        lsr r3, r2, #4
        cmp r3, #2
        bgt falseSpiral     @既に必殺状態

    checkSpiral:
        bl HAS_SPECIAL_SPIRAL
        cmp r0, #0
        beq falseSpiral
        mov r0, #0x27       @2ターン・ヒッサツ
        mov r2, #111
        strb r0, [r4, r2]

    falseSpiral:
        pop {r4, pc}

LETHALITY_ID = ADDR+0
FODES_FUNC:
    ldr r3, ADDR+4
    mov pc, r3
HAS_SPECIAL_SPIRAL:
    ldr r3, ADDR+8
    mov pc, r3

.align
.ltorg
ADDR:

