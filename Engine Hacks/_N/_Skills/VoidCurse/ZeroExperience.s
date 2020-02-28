.thumb

@ ORG 
    bl main
    cmp r0, #0
    beq false
    mov r0, #0
    str r0, [r2]
false:
    ldr r0, =0x0802c468
    mov pc, r0

main:
        push {r2, lr}
        mov r0, r3
        mov r1, #0
        bl HAS_VOID_CURSE
        pop {r2, pc}

HAS_VOID_CURSE:
    ldr r2, addr+0
    mov pc, r2

.align
.ltorg
addr:

