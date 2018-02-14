@thumb
;080178c8
    push {r0, r1}
    
    cmp r4, #0
    beq end
    
    mov r0, #99
    ldr r1, =$08000c58
    mov lr, r1
    @dcw $F800
    @align 4
    ldr r1, [adr+0]
    cmp r0, r1
    bge end
    
    @align 4
    ldr r2, [adr+4]
    mov r0, #0
loop
    ldrb r1, [r2, r0]
    cmp r1, #0
    beq finish
    add r0, #1
    b loop
finish
    sub r0, #1
    ldr r1, =$08000c58
    mov lr, r1
    @dcw $F800
    
    @align 4
    ldr r2, [adr+4]
    ldrb r4, [r2, r0]
end
    pop {r0, r1}
    strb	r1, [r0, #12]
    strb	r4, [r0, #13]
    strb	r5, [r0, #14]
    strb	r5, [r0, #15]
    ldr r0, =$080178d0
    mov pc, r0
    
@ltorg
adr
    
    