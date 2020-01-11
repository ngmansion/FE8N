.thumb

        push {r4, r5, r6, r7, lr}
        push {r1, r2}
        mov r5, r0
        mov r6, r1
        mov r7, r2
.align
calc_addr:
        mov r4, #ADDR-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r4, pc

@        sub r4, #4
    loop:
        add r4, #4
        ldr r3, [r4]
        cmp r3, #0
        beq FALSE
        mov r0, r5
        mov r1, r6
        mov r2, r7
        bl GoToR3
        cmp r0, #1
        beq TRUE
        b loop
    FALSE:
        mov r0, #0
    TRUE:
        cmp r0, #1
        pop {r1, r2}
        pop {r4, r5, r6, r7, pc}



GoToR3:
nop
mov pc, r3

.align
.ltorg
ADDR:
