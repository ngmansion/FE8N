.thumb

    mov r1, #58
    ldsh r0, [r6, r1]
    cmp r0, #1
    bne Return
    ldr r0, =0x0203a5e8 
    ldr r0, [r0]
    cmp r0, #0
    bne Return @ジェノサイヤ人削除
    mov r0, r7
    mov r1, #12
    ldr r2, =0x08070c7a
    mov pc, r2

Return:
    ldr r0, =0x08070c7e
    mov pc, r0
    
    
    
    


