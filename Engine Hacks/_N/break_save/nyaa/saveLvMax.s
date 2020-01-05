.thumb

main:
    push {r4, r5, lr}
    mov r4, #0
loop:
    add r4, #1
    cmp r4, #51
    bgt end
    mov r0, r4
    bl Get_Status
    mov r2, r0
    ldrb r0, [r2, #8]
    lsl r0, r0, #26
    lsr r1, r0, #31

    mov r0, r4
    bl set_level_bit

    b loop
end:
    pop {r4, r5, pc}

set_level_bit:
@
@r0 = ID
@r1 = LVbit
@
        push {r4, r5, r6, lr}
        mov r6, r1
        mov r4, r0
    
        mov r0, r4
        bl div_eight
        mov r5, r0
    
        mov r0, r4
        bl mod_eight
        mov r4, r0

        ldr r1, addr
        ldrb r0, [r1, r5]
        
        mov r2, #1
        lsl r2, r2, r4
        bic r0, r2      @念のためビットクリア

        lsl r6, r6, r4
        orr r0, r6

        strb r0, [r1, r5]
    end_set:
        pop {r4, r5, r6, pc}


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
addr:

