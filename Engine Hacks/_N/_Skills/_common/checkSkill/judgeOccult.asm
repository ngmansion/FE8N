@thumb

    push {r4, lr}
    mov r4, r0
        @align 4
        ldr r1, [adr+0] ;スキル
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne ret
    
    mov r0, #72
    ldrh r0, [r4, r0]
        @align 4
        ldr r1, [adr+4] ;武器種類
        mov lr, r1
        @dcw $F800
    cmp r0, #7
    bgt end
    add r0, #40
    ldrb r0, [r4, r0]
    cmp r0, #250
    bls end
    mov r0, #1
    @dcw $E000
end
    mov r0, #0
ret
    pop {r4, pc}
@align 4
adr:
