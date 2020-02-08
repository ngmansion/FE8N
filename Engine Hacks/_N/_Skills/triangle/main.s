@ 0802c754
.thumb
    bl CancelAffinity
    bl triangle
    ldr r0, [r4, #76]
    mov r6, #128
    lsl r6, r6, #1
    and r0, r6
    cmp r0, #0
    beq ret2

    ldr r0, =0x0802c75e
    mov pc, r0
ret2:
    ldr r0, =0x0802c766
    mov pc, r0

CancelAffinity:
        push {r6, lr}
        mov r6, #0
        
        bl HasCancelAffinity
        add r6, r0
        eor r4, r5
        eor r5, r4
        eor r4, r5
        bl HasCancelAffinity
        add r6, r0
        eor r4, r5
        eor r5, r4
        eor r4, r5
        
        cmp r6, #0
        beq endCancelAffinity   @どちらも持っていないならジャンプ
        mov r1, r4
        add r1, #83
        mov r0, #0
        strb r0, [r1, #0]
        add r1, #1
        mov r0, #0
        strb r0, [r1, #0]
        
        mov r1, r5
        add r1, #83
        mov r0, #0
        strb r0, [r1, #0]
        add r1, #1
        mov r0, #0
        strb r0, [r1, #0]
    endCancelAffinity:
        pop {r6, pc}


 
triangle:
        push {r6, lr}
        mov r6, #0
        bl HasTriangle
        add r6, r0
        eor r4, r5
        eor r5, r4
        eor r4, r5
        
        bl HasTriangle
        add r6, r0
        eor r4, r5
        eor r5, r4
        eor r4, r5
        
        cmp r6, #1
        ble falseTriangle
        
        mov r1, r4
        add r1, #83
        mov r0, #0
        ldsb r0, [r1, r0]
        mul r0, r6
        strb r0, [r1, #0]
        
        add r1, #1
        mov r0, #0
        ldsb r0, [r1, r0]
        mul r0, r6
        strb r0, [r1, #0]
        
        mov r1, r5
        add r1, #83
        mov r0, #0
        ldsb r0, [r1, r0]
        mul r0, r6
        strb r0, [r1, #0]
        
        add r1, #1
        mov r0, #0
        ldsb r0, [r1, r0]
        mul r0, r6
        strb r0, [r1, #0]
    falseTriangle:
        pop {r6, pc}


HasTriangle:
        push {lr}
        mov r0, r4
        mov r1, r5
            ldr r2, adr
            mov lr, r2
            .short 0xF800
        lsl r0, r0, #1
        add r0, #1
        pop {pc}

HasCancelAffinity:
        push {lr}
        mov r0, r4
        mov r1, r5
            ldr r2, adr+4
            mov lr, r2
            .short 0xF800
        pop {pc}

.align
.ltorg
adr:




