.thumb
        push {r4, lr}   @元の処理に合わせる
        push {r5, r6}
        mov r4, r0      @元の処理に合わせる
.align
calc_addr:
        mov r5, #(ADDR+4)-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r5, pc

@        sub r5, #4
        mov r6, #0
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq FINISH
        mov r0, r4
        bl GoToR3
        add r6, r0
        b loop
    FINISH:
        mov r0, r6
        pop {r5, r6}
        ldr r1, ADDR
        mov pc, r1


GoToR3:
nop
mov pc, r3

.align
.ltorg
ADDR:

