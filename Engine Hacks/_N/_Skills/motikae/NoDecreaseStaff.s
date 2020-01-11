.thumb
@.org 0802cbc4
    and r1, r0
    cmp r1, #0
    beq goto

    mov r1, r4
    add r1, #125
    mov r0, #1
    strb r0, [r1, #0]

goto:
    bl main
    cmp r0, #1
    beq skill_active

    ldr r1, =0x0802cbd2
    mov pc, r1

skill_active:
    ldrh r0, [r5, #0]
    ldr r1, =0x0802cbda
    mov pc, r1


main:
        mov r0, r4
        ldrh r1, [r5]
        ldr r2, addr
        mov pc, r2
.align
.ltorg
addr:
