.thumb

VALID_BIT =         0b00011111


    push {r4, lr}
    mov r4, r0

    mov r0, r4
    ldr r1, FATIGUE_SUFFIX
    bl GET_BOOK_DATA
    mov r1, #VALID_BIT
    and r0, r1

    cmp r0, #1
    ble false
    cmp r0, #2
    ble half

quarter:
    ldrb r0, [r4, #18]
    asr r0, r0, #2
    sub r0, r1
    neg r0, r0
    b end
half:
    ldrb r0, [r4, #18]
    asr r0, r0, #1 @半減
    sub r0, r1
    neg r0, r0
    b end
false:
    mov r0, #0
end:
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
