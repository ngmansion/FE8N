.thumb
    mov r0, r6
    mov r1, r2
    bl HasFortune

    cmp r0, #0
    beq endwo
    
	mov	r0, #0
	strh	r0, [r5]
endwo:
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
    
HasFortune:
    ldr r2, addr
    mov pc, r2
.align
.ltorg
addr:
	