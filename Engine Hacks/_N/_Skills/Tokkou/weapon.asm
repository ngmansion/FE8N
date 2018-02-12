@thumb
@org $0802aa7c
    
    cmp r0, #0
    beq non
    
    mov r0, #90
    ldsh r0, [r6, r0]
        @align 4
        ldr r1, [adr]
    mul r0, r1
    lsl r0, r0, #16
    asr r4, r0, #16
non
    add r4, r4, r5
    b $0802aab6
@align 4
adr




