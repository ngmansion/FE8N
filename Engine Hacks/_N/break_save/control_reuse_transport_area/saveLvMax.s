.thumb

DATA_MASK = (0b0111)
DATA_MASK_BOOK = (0b0111111)
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
    bl Chapter
    pop {r4, r5, pc}

Chapter:
@現在章で疲労判定するため
        ldr r0, =0x0202BCFA
        ldrb r0, [r0]
        ldr r1, WORK_MEM_FOR_TRANSPORT_FATIGUE
        strb r0, [r1]
        bx lr

Section3bit:
    push {lr}
    mov r0, r4
    bl CreateData
    mov r1, r4
    bl SeveData
    pop {pc}

CreateData:
@
@[in]
@r0=作りたい部隊表ID
@[out]
@r0=作ったデータ
@
        push {lr}
        bl Get_Status
        mov r2, r0
        ldr r0, [r2, #4]        @兵種
        ldrb r0, [r0, #4]       @兵種ID
        mov r1, #0b10000000
        and r0, r1
        lsr r0, r0, #5

        add r2, #71
        ldrb r1, [r2]
        mov r2, #0b11
        and r1, r2

        orr r0, r1
        pop {pc}



SeveData:
@
@[in]
@r0=セットするデータ
@r1=セットする部隊表ID
@
        push {r4, lr}
        mov r4, r0
        mov r0, r1
        bl GetAddr @書き込み先アドレスとズラしビットを取得

        mov r2, r1
        mov r1, r0
        mov r0, r4
        bl SetData @

        pop {r4, pc}

SetData:
        push {r4, lr}
        mov r4, r1
        mov r1, r2
        bl MergeData

        bl CpyData
        pop {r4, pc}

MergeData:
        ldrb r2, [r4, #1]
        lsl r2, #8
        ldrb r3, [r4, #0]
        orr r2, r3

        mov r3, #DATA_MASK
        lsl r3, r1
        bic r2, r3

        lsl r0, r1
        orr r0, r2
        bx lr

CpyData:
        strb r0, [r4, #0]
        lsr r0, #8
        strb r0, [r4, #1]
        bx lr


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
WORK_MEM_FOR_TRANSPORT_FATIGUE = addr+4

SET_BOOK:
    ldr r3, addr+8
    mov pc, r3

.align
.ltorg
addr:

