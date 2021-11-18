.thumb

return_addr = (0x08016860)
@0001684c

        mov r0, r6
        bl IS_INFINIT
        mov r3, r0

        mov r1, r7
        add r1, #28
        ldr r0, [r6, #8]
        and r0, r5
        mov r2, #255
        cmp r0, #0
        .short 0xd100
        ldrb r2, [r6, #20]      @アイテム最大数
        mov r0, r1
        mov r1, r4
        cmp r3, #0
        .short 0xd000
        mov r1, #4      @緑点滅

        ldr r3, =return_addr
        mov pc, r3

IS_INFINIT:
    ldr r1, addr+0
    mov pc, r1

.ltorg
.align
addr:



