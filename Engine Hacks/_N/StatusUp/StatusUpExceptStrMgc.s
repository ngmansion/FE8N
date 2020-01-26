@

.thumb
	
        push {r4, r5, r6, lr}
        mov r4, r0
.align
calc_addr:
        mov r5, #ADDR-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r5, pc

@        sub r5, #4
        mov r6, #0
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq END
        mov r0, r4
        bl GoToR3
        add r6, r0
        b loop
    END:
        mov r0, r6
        pop {r4, r5, r6, pc}

GoToR3:
nop
mov pc, r3

.align
.ltorg
ADDR:

