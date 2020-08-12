.thumb
@ 0801a09c

    push {r4, r5, lr}
    mov r4, r0
    lsl r5, r1, #24
    asr r5, r5, #24
    bl main
    mov r0, r4
    ldr r3, =0x0801a0a4
    mov pc, r3

DEFEAT   = (0b10000000) @撃破フラグ
DEFEATED = (0b01000000) @迅雷済みフラグ

main:
        push {lr}
        ldrb r0, [r4, #0xB]
        lsr r0, r0, #6
        bne end
        mov r0, #69
        ldrb r0, [r4, r0]

        mov r1, #DEFEATED
        and r0, r1
        beq end
        asr r5, r5, #1
    end:
        pop {pc}

.align
.ltorg
addr:

