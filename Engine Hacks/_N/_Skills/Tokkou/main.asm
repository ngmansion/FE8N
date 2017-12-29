@thumb
;@org 00016a30
    push {lr}
    push {r4, r5}
    mov r4, r0
    mov r5, r1
    
    @align 4
    ldr r0, [Adr]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    cmp r0, #0
    bne hit1
    
    @align 4
    ldr r0, [Adr+4]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    cmp r0, #0
    bne hit2
    
    @align 4
    ldr r0, [Adr+8]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    cmp r0, #0
    bne hit3
    
    @align 4
    ldr r0, [Adr+12]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    cmp r0, #0
    bne hit4
    
non:
    mov r1, #0
    b end
hit1:
    @align 4
    ldr r1, [Adr+16]
    b end
hit2:
    @align 4
    ldr r1, [Adr+20]
    b end
hit3:
    @align 4
    ldr r1, [Adr+24]
    b end
hit4:
    @align 4
    ldr r1, [Adr+28]
    b end
    
end:
    ldr r0, [r5, #4]
    ldrb r3, [r0, #4]
    pop {r4, r5}
    ldr r2, =$08016a46
    mov pc, r2
    @ltorg
Adr: