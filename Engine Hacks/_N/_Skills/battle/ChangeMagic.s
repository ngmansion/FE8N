.thumb
    push {lr}
    bl Soulblade
    cmp r0, #0
    beq false
    mov r0, #1
    b end

false:
    mov r0, #0
end:
    pop {pc}

Soulblade:
        push {lr}
        mov r2, #67
        ldrb r2, [r0, r2]
        mov r3, #0xFE
        and r2, r3
        cmp r2, r3
        bne falseSoul

        bl HasSoulblade
        
        b endSoul
    falseSoul:
        mov r0, #0
    endSoul:
        pop {pc}



HasSoulblade:
    ldr r2, addr
    mov pc, r2

.align
.ltorg
addr:
