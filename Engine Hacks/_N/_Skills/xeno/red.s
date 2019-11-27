.thumb
    
    add r0, #48
    ldrb r0, [r0]
    lsl r0, r0, #28
    lsr r0, r0, #28

    ldrb r1, [r6, #0xB]
    ldr r2, =0x0203a5e8
    ldrb r2, [r2]
    cmp r1, r2
@    bne unred @無効化
    b unred
    mov r0, #4
unred:
    ldr r1, =0x08055744
    mov pc, r1



