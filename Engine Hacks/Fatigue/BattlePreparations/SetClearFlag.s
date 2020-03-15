.thumb
D_STATUS_NONE = 0x00
D_STATUS_IGNORE = 0x01
D_STATUS_CLEAR = 0x02
FATIGUE_STATUS = 0x0203B000+0xd4

    mov r0, #D_STATUS_CLEAR
    ldr r1, =FATIGUE_STATUS
    strb r0, [r1]
    bx lr
