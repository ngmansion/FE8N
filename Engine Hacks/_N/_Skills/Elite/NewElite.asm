@thumb
    push {lr}
      push {r0}
        @align 4
        ldr r1, [adr] ;
        mov lr, r1
        @dcw $F800
        mov r1, r0
      pop {r0}
    cmp r1, #0
    bne elite
    ldr r1, [r0]
    ldr r2, [r0, #4]
    ldr r0, [r1, #40]
    ldr r1, [r2, #40]
    ldr r3, =$0802C35E
    mov pc, r3
elite
    ldr r3, =$0802C36C
    mov pc, r3
@ltorg
adr: