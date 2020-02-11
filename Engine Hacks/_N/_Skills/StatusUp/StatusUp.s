.thumb

main:
    push {r4, r5, lr}
    mov r4, r0
    mov r5, #0
    bl normal
    add r5, r0

    bl addition1
    add r5, r0

    bl addition2
    add r5, r0

    mov r0, r5
    pop {r4, r5, pc}

normal:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasStatusUp
        cmp r0, #0
        beq end
        bl GetPow
    end:
        pop {pc}

addition1:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasStatusUpAdd1
        cmp r0, #0
        beq end1
        bl GetPowAdd1
    end1:
        pop {pc}

addition2:
        push {lr}
        mov r0, r4
        mov r1, #0
        bl HasStatusUpAdd2
        cmp r0, #0
        beq end2
        bl GetPowAdd2
    end2:
        pop {pc}

GetPow:
    ldr r0, addr+0
    bx lr
HasStatusUp:
    ldr r2, addr+4
    mov pc, r2
HasStatusUpAdd1:
    ldr r2, addr+8
    mov pc, r2
HasStatusUpAdd2:
    ldr r2, addr+12
    mov pc, r2
GetPowAdd1:
    ldr r0, addr+16
    ldr r1, addr+20
    ldrb r0, [r0, r1]
    bx lr
GetPowAdd2:
    ldr r0, addr+16
    ldr r1, addr+24
    ldrb r0, [r0, r1]
    bx lr
.align
.ltorg
addr:

