@thumb
    ldr r2, =$0203a5e8 
    ldr r1, [r2]
    cmp r1, #0
    beq not
got:
    mov r1, #0
    str r1, [r2]
    ldr r0, =$0806fc70
    mov pc, r0
;
;
;
not:
    cmp r0, #0
    bne bran
    ldr r0, =$0806fc24
    ldr r0, [r0]
    b merge
bran:
    ldr r0, =$0806fc68
    ldr r0, [r0]
merge:
    ldr r0, [r0]
    add r0, #74
    ldrh r0, [r0, #0]
    
    ldr r1, =$0806fc30
    mov pc, r1
    