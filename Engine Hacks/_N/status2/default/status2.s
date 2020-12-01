.thumb

@000897f8

@@@@@@@@特にやる事が無い
        mov r0, #0
        bl SKILL_ICON
        ldr r0, =0x080898e8
        mov pc, r0

SKILL_ICON:
    ldr r3, ADDR
    mov pc, r3

.align
.ltorg
ADDR:
