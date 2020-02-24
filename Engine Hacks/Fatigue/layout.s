.thumb
@ 0808963c
    cmp r1, #0
    bne normal
    b main

normal:
    mov r0, r2
    ldr r1, =0x080190ec
    mov lr, r1
    .short 0xF800
    mov r3, r0
    ldr r0, =0x08089644
    mov pc, r0

main:
        mov r0, #71
        ldrb r0, [r2, r0]
        mov r1, #0b0011
        and r0, r1
        cmp r0, #0
        beq normal

        ldr r0, FATIGUE_WORD
        bl $00009fa8
        ldr r3, =0x080043b8
        mov lr, r3
        mov r3, r0
        mov r0, r4
        mov r1, #24
        mov r2, #2
        .short 0xF800

        ldr r2, [r5, #12]
        add r2, #71
        ldrb r2, [r2]
        mov r1, #0b0011
        and r2, r1
        lsl r2, r2, #4
        
        ldr r1, =0x0808965c
        mov pc, r1


$00009fa8:
    ldr r1, =0x08009fa8
    mov pc, r1

FATIGUE_WORD = addr+0

.align
.ltorg
addr:

