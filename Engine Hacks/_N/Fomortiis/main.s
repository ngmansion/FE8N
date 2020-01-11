.thumb

        push {lr}
        ldr  r0, [r0, #4]
        ldrb r0, [r0, #4]
        ldr r1, addr
        cmp r0, r1
        beq true
        mov r0, #0
        b end
    true:
        mov r0, #1
    end:
        pop {pc}
.align
.ltorg
addr:
