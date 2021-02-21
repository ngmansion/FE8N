.thumb
IS_MAGIC:
        push {r4, lr}
        mov r4, r0

        ldr r2, =0x0203a4e8
        cmp r4, r2
        beq jumpMagic
        ldr r2, =0x0203a568
        cmp r4, r2
        bne falseMagic
    jumpMagic:
        mov r1, #0
        bl HAS_SOUL_BLADE
        cmp r0, #1
        beq trueMagic

        mov r0, r4
        add r0, #80
        ldrb r0, [r0]
        cmp r0, #4
        beq trueMagic
        cmp r0, #5
        beq trueMagic
        cmp r0, #6
        beq trueMagic
        cmp r0, #7
        beq trueMagic
    falseMagic:
        mov r0, #0
        .short 0xE000
    trueMagic:
        mov r0, #1
        pop {r4, pc}
.align
HAS_SOUL_BLADE:
    ldr r2, ADDR
    mov pc, r2
.align
.ltorg
ADDR:

