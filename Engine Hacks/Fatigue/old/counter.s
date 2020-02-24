.thumb
UNIT_MAX_NUM = (51)
FATIGUE_MAX = (31)

VALID_BIT =         0b00011111
REST_CONDITION =    0b00100000

Unit:
        push {r4, lr}
        mov r4, #1	@部隊表IDは1から
    outLoopUnit:
        cmp r4, #UNIT_MAX_NUM
        bgt endOutLoopUnit
        
        mov r0, r4
            ldr r1, =0x08019108
            mov lr, r1
            .short 0xF800
        ldr r1, [r0]
        cmp r1, #0
        beq endOutLoopUnit @ユニットがもういない

        bl Count
        add r4, #1
        b outLoopUnit

    endOutLoopUnit:
        pop {r4, pc}


.align
Count:
        push {r4, lr}
        mov r4, r0

            mov r0, r4
            ldr r1, FATIGUE_SUFFIX
            bl GET_BOOK_DATA
            mov r1, #REST_CONDITION
            tst r0, r1
            beq trueClear
    
            mov r0, #0
            .short 0xE000
        trueClear:
            mov r0, #1

        cmp r0, #1
        beq clearCount

        mov r0, r4
        ldr r1, FATIGUE_SUFFIX
        bl GET_BOOK_DATA
        mov r2, r0

        mov r1, #VALID_BIT
        and r0, r1

        cmp r0, #FATIGUE_MAX
        bge endCount

        add r2, #1
        .short 0xE000
    clearCount:
        mov r2, #0

        mov r0, r4
        ldr r1, FATIGUE_SUFFIX
        bl SET_BOOK_DATA
    endCount:
        pop {r4, pc}


FATIGUE_SUFFIX = addr+0

GET_BOOK_DATA:
    ldr r3, addr+4
    mov pc, r3
SET_BOOK_DATA:
    ldr r3, addr+8
    mov pc, r3

.align
.ltorg
addr:
