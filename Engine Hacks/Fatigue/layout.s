.thumb
@ 0808963c
    cmp r1, #0
    bne normal
    b main
back:
    ldr r2, [r5, #12]
normal:
    mov r0, r2
    ldr r1, =0x080190ec
    mov lr, r1
    .short 0xF800
    mov r3, r0
    ldr r0, =0x08089644
    mov pc, r0

main:
        mov r0, r2
        bl GET_FATIGUE_NUM
        cmp r0, #0
        beq back

        ldr r0, FATIGUE_WORD
        bl $00009fa8
        ldr r3, =0x080043b8
        mov lr, r3
        mov r3, r0
        mov r0, r4
        mov r1, #24
        mov r2, #2
        .short 0xF800

        ldr r0, [r5, #12]
        bl GET_FATIGUE_NUM
        mov r2, r0
        lsl r2, r2, #4
        
        ldr r1, =0x0808965c
        mov pc, r1


$00009fa8:
    ldr r1, =0x08009fa8
    mov pc, r1

FATIGUE_WORD = addr+0
GET_FATIGUE_NUM:
    ldr r2, addr+4
    mov pc, r2

.align
.ltorg
addr:

