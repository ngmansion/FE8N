.thumb

main:
    push {lr}
    mov r1, #0
    bl HasStatusUp
    cmp r0, #0
    beq end
    bl GetPow
    b end
false:
    mov r0, #0
end:
	pop {pc}

GetPow:
    ldr r0, addr+0
    bx lr

HasStatusUp:
    ldr r2, addr+4
    mov pc, r2
.align
.ltorg
addr:

