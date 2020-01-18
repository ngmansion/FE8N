.thumb

@ 0802a9dc

    push {r6, lr}
    mov r6, r0

    mov r0, r5
    sub r0, #72
    mov r1, r4
    bl ChangeMagic
    cmp r0, #1
    beq true

    mov r1, #2
    and r1, r6
    cmp r1, #0
    beq false

true:   @魔法
    mov r1, #1
    b end
false:  @物理
    mov r1, #0
end:
    pop {r6, pc}

ChangeMagic:
    ldr r2, addr
    mov pc, r2
.align
.ltorg
addr:



