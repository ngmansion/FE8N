.thumb
b slow_0x01a09c     @revert
b slow_0x01a1c0

.align
slow_0x01a1c0:

    mov r7, r1
    ldr r1, =0x0801a1d8
    ldr r1, [r1]
    ldr r0, =0x0801a1dc
    ldr r0, [r0]
    str r0, [r1, #4]
    bl main_0x01a1c0
    ldr r0, =0x0801a1c8
    mov pc, r0



main_0x01a1c0:
        push {r4, r5, lr}
        cmp r2, #0x7c
        beq end_0x01a1c0
        push {r1, r2, r3}

        ldr r4, =0x03004df0
        ldr r4, [r4]
        mov r5, r2
        bl main
        pop {r1, r2, r3}
        mov r2, r5
    end_0x01a1c0:
        pop {r4, r5, pc}


slow_0x01a09c:
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
@r4 = アドレス
@r5 = 移動
        push {lr}
        bl Hurry
        bl Galeforce
        cmp r5, #15
        ble notOverFlow
        mov r5, #15
    notOverFlow:
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
    endHurry:
        bx lr


.align
.ltorg
addr:

