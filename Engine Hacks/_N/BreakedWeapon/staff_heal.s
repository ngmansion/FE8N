.thumb


@ 08024794

        bl $08019108
        bl main
        pop {r4, pc}


main:
        push {r4, r5, r6, lr}
        push {r7}
        sub sp, #8
        mov r6, r0
        mov r1, #10
        bl $080348dc
        mov r4, r0
        mov r0, #10
        str r0, [sp]
        mov r0, #1
        str r0, [sp, #4]
        mov r0, #0
        mov r1, r6
        mov r2, r4
        mov r3, #0
        bl $08034744
        mov r5, r0
        add r5, #0x38
        mov r0, r5
        mov r1, r6
        bl inner
        add r4, #0x61
        lsl r4, r4, #1
        ldr r0, =0x02022ca8
        add r4, r0
        mov r0, r5
        mov r1, r4
        bl $08003da0
        add sp, #8
        pop {r7}
        pop {r4, r5, r6, pc} 



inner:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl $08003cf8
        mov r0, #0x99
        lsl r0, r0, #3
        add r0, #2
        bl $08009fa8
        mov r3, r0
        mov r0, r4
        mov r1, #0x10
        mov r2, #3
        bl $080043b8

        ldrb r3, [r5, #0x13]
        mov r0, r4
        mov r1, #8
        mov r2, #2
        bl $080043dc

        ldr r0, =0x0203a4e8
        ldrb r0, [r0, #0xB]
        bl $08019108

        ldrb r1, [r0, #0x1E]
        bl $08016d60
        push {r0}
        mov r0, r5
        bl $08018ea4
        mov r1, r0
        pop {r0}
        ldrb r3, [r5, #0x13]
        add r3, r0
        cmp r3, r1
        blt jump
        mov r3, r1
    jump:
        mov r0, r4
        mov r1, #0x20
        mov r2, #2
        bl $080043dc
        ldr r0, =0x04C9
        bl $08009fa8
        mov r3, r0
        mov r0, r4
        mov r1, #0x28
        mov r2, #3
        bl $080043b8
        mov r0, r5
        bl $08018ea4
        mov r3, r0

        mov r0, r4
        mov r1, #0x38
        mov r2, #2
        bl $080043dc
        pop {r4, r5, pc}

$08019108:
    ldr r3, =0x08019108
    mov pc, r3
$080348dc:
    ldr r7, =0x080348DC
    mov pc, r7
$08034744:
    ldr r7, =0x08034744
    mov pc, r7
$08003da0:
    ldr r7, =0x08003da0
    mov pc, r7
$08003cf8:
    ldr r7, =0x08003cf8
    mov pc, r7
$08009fa8:
    ldr r7, =0x08009fa8
    mov pc, r7
$080043b8:
    ldr r7, =0x080043b8
    mov pc, r7
$080043dc:
    ldr r7, =0x080043dc
    mov pc, r7
$08016d60:
    ldr r7, =0x08016d60
    mov pc, r7
$08018ea4:
    ldr r7, =0x08018ea4
    mov pc, r7



.align
.ltorg
