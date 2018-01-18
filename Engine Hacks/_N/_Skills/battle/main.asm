;0x02ad3c
@thumb
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1
    
    mov	r0, r6
        @align 4
        ldr r1, [adr] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne Return
    
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;死線
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq Return
    
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] ;自分
    mov r1, r6
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] ;相手
Return:
    ldr r5, [r4, #76]
    ldr r0, =$0802ad44
    mov r15, r0
@ltorg
adr:

