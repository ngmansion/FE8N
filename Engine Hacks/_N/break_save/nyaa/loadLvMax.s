.thumb

DATA_MASK = (0b0111)

main:
    push {r4, r5, lr}
    mov r4, #0
loop:
    add r4, #1
    cmp r4, #51
    bgt end
    mov r0, r4
    bl LoadData
    mov r1, r4
    bl GenerateData
    b loop
end:
    pop {r4, r5, pc}

GenerateData:
@[in]
@r0 = データ
@r1 = 部隊表ID
        push {r4, lr}
        mov r4, r0
        mov r0, r1
        bl Get_Status
        mov r3, r0

        mov r1, #0b0100
        and r1, r4
        lsl r1, r1, #3

        ldrb r0, [r3, #8]
        orr r0, r1
        strb r0, [r3, #8]

        mov r0, #0b0011
        and r0, r4
        add r3, #71
        strb r0, [r3]

        pop {r4, pc}


LoadData:
@[in]
@r0 = 部隊表ID
@[out]
@r0 = データ
        push {r4, lr}
        mov r4, r0
        bl GetAddr

        ldrb r2, [r0, #1]
        lsl r2, #8
        ldrb r0, [r0, #0]
        orr r0, r2
        lsr r0, r1
        mov r1, #0b0111
        and r0, r1

        pop {r4, pc}



GetAddr:
        push {r4, r5, lr}

        mov r5, r0
        bl GetBase
        mov r4, r0

        mov r0, r5
        bl GetBit

        mov r1, r0
        mov r0, r4
        pop {r4, r5, pc}

GetBase:
        push {lr}
        sub r0, #1
        mov r1, #3
        mul r0, r1
        bl div_eight
        ldr r1, EXTRACT_SAVE_BASE
        add r0, r1
        pop {pc}

GetBit:
        push {lr}
        sub r0, #1
        mov r1, #3
        mul r0, r1
        bl mod_eight
        pop {pc}



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

EXTRACT_SAVE_BASE = addr+0

.align
.ltorg
addr:
