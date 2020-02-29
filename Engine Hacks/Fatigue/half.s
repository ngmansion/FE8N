.thumb

VALID_BIT =         0b0011


    push {r4, lr}
    mov r4, r0

    mov r0, #71
    ldrb r0, [r4, r0]
    mov r1, #VALID_BIT
    and r0, r1

    cmp r0, #1
    ble false
    cmp r0, #2
    ble half

quarter:
    ldrb r0, [r4, #18]
    asr r1, r0, #2
    sub r0, r1
    neg r0, r0
    b end
half:
    ldrb r0, [r4, #18]
    asr r1, r0, #1 @半減
    sub r0, r1
    neg r0, r0
    b end
false:
    mov r0, #0
end:
    pop {r4, pc}


.align
.ltorg
addr:
