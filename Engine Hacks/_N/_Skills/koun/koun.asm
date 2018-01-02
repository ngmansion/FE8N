@thumb

    mov	r0, r2
        @align 4
        ldr r1, [adr] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne endwo
    
    mov r0, r6
        @align 4
        ldr r1, [adr+4] ;強運
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq endwo
    
	mov	r0, #0
	strh	r0, [r5]
endwo:
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
@ltorg
adr:
	