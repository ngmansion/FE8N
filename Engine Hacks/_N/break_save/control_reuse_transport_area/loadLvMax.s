.thumb

DATA_MASK = (0b0111)
BOOK_NUM = (5)          @0始まりなので5

main:
    push {r4, r5, lr}
    mov r4, #0
loop:
    add r4, #1
    cmp r4, #51
    bgt end

    bl Section3bit

    b loop
end:
    pop {r4, r5, pc}

Section3bit:
    push {lr}
    mov r0, r4
    bl LoadData
    mov r1, r4
    bl GenerateData
    pop {pc}

GenerateData:
@[in]
@r0 = データ
@r1 = 部隊表ID
        push {r4, r5, lr}
        mov r4, r0
        mov r0, r1
        bl Get_Status
        mov r5, r0
@@@@@@@@
        mov r0, #0b00000100
        and r0, r4
        lsl r0, #5
        cmp r0, #0
        beq classIsCorrect

        ldr r1, [r5, #4]
        cmp r1, #0
        beq zeroClass
        ldrb r1, [r1, #4]
        mov r2, #0b01111111
        and r1, r2
    zeroClass:
        orr r0, r1
        bl Get_ClassAddr
        str r0, [r5, #4]
    classIsCorrect:
@@@@@@@@

        mov r0, #0b0011
        and r0, r4
        add r5, #71
        strb r0, [r5]

        pop {r4, r5, pc}

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

Get_ClassAddr:
    ldr r1, =0x0801911c
    mov pc, r1

EXTRACT_SAVE_BASE = addr+0
GET_BOOK:
    ldr r3, addr+4
    mov pc, r3

.align
.ltorg
addr:
