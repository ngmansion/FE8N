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

DEFEATED = (0b01000000) @迅雷済みフラグ

main:
        push {lr}
        bl Hurry
        bl Galeforce
        pop {pc}

Galeforce:
        ldrb r0, [r4, #0xB]
        lsr r0, r0, #6
        bne endGale
        mov r0, #69
        ldrb r0, [r4, r0]

        mov r1, #DEFEATED
        and r0, r1
        beq endGale
        asr r5, r5, #1
    endGale:
        bx lr

Hurry:
        ldr r0, [r4, #12]
        ldr r1, =0x40000000
        tst r0, r1
        beq endHurry
        add r5, #2
        cmp r5, #15
        ble endHurry
        mov r5, #15
    endHurry:
        bx lr


.align
.ltorg
addr:

