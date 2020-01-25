SWORD = (0)
LANCE = (1)
AXE = (2)
BOW = (3)
STAFF = (4)
ANIMA = (5)
LIGHT = (6)
DARK = (7)

LEVEL_E = (1)
LEVEL_D = (2)
LEVEL_C = (3)
LEVEL_B = (4)
LEVEL_A = (5)
LEVEL_S = (6)

@0802acc8
.thumb
	
        push {r4, r5, lr}
        mov r4, r0
.align
calc_addr:
        mov r5, #ADDR-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r5, pc

@        sub r5, #4
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq END

        bl GoToR3
        b loop
    END:
        pop {r4, r5, pc}

GoToR3:
nop
mov pc, r3

.align
.ltorg
ADDR:
