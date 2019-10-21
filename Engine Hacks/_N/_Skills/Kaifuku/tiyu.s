.thumb
    push {r4, lr}
    mov r4, r0
    mov r0, r5
        ldr r1, adr @治癒
        mov lr, r1
        .short 0xF800
    mov r2, r0
    mov r0, r4
    ldr r1, =0x08019f44
    ldr r1, [r1]
    add r0, r0, r1
    ldrb r0, [r0]
    lsl r0, r0, #24
    asr r0, r0, #24
    orr r0, r2
    pop {r4, pc}
.align
.ltorg
adr:


