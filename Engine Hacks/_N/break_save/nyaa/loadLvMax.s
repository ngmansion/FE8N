.thumb

@080a7d1c

main:
    push {r4, r5, lr}
    mov r4, #0
loop:
    add r4, #1
    cmp r4, #51
    bgt end
    mov r0, r4
    bl get_level_bit
    lsl r5, r0, #5
    mov r0, r4
    bl Get_Status
    mov r2, r0
    ldrb r0, [r2, #8]
    orr r0, r5
    strb r0, [r2, #8]
    b loop
end:
    pop {r4, r5, pc}

get_level_bit:
@
@r0 = ID
@
        push {r4, r5, lr}
        mov r4, r0
    
        mov r0, r4
        bl div_eight
        mov r5, r0
    
        mov r0, r4
        bl mod_eight
        mov r4, r0

        ldr r0, adr
        ldrb r0, [r0, r5]
        lsr r0, r0, r4
        lsl r0, r0, #31
        lsr r0, r0, #31
    
        pop {r4, r5, pc}


div_eight:
        mov r1, #0
        .short 0xE000
    loop_div:
        add r1, #1
    
        sub r0, #8
        bge loop_div
        mov r0, r1
        bx lr
    
mod_eight:
        mov r1, r0
        sub r0, #8
        bge mod_eight
        mov r0, r1
        bx lr

Get_Status:
        ldr r1, =0x08019108
        mov pc, r1
.align
.ltorg
adr:
