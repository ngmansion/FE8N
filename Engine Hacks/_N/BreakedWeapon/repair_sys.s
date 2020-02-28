
.thumb
    push {lr}
    push {r0}
    ldr r0, =0x0202BCFC
    ldrb r0, [r0]
    cmp r0, #0
    beq RETURN	@0ターン目なら終了

    bl main
RETURN:
    pop {r2}
    ldr r0, =0x080aeff8
    ldr r0, [r0]
    ldrb r1, [r0, #4]
    ldr r0, =0x080aefe4
    mov pc, r0

main:
        push {r5, lr}
.align
calc_addr:
        mov r5, #ADDR-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r5, pc

    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq RETRUN

        bl GoToR3
        b loop
    RETRUN:
        pop {r5, pc}

GoToR3:
nop
mov pc, r3

        pop {r5, pc}

.align
.ltorg
ADDR:

