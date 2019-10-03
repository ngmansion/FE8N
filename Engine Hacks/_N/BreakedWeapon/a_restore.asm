.thumb
	push	{r4, r5, r6, lr}
	mov	r5, #16
	ldsb	r5, [r0, r5]
    mov	r6, #17
    ldsb	r6, [r0, r6]
    ldr	r4, =0x08025e94
    ldr r4, [r4]
    str	r0, [r4, #0]
    mov	r0, r5
    mov	r1, r6
    	ldr r3, =0x08050618
    	mov lr, r3
    	.short 0xF800
    ldr	r0, =0x08025e98
    ldr r0, [r0]
    ldr	r0, [r0, #0]
    mov	r1, #0
    	ldr r3, =0x080194bc
    	mov lr, r3
    	.short 0xF800
    ldr	r0, [r4, #0]
    	ldr r3, =0x08018730
    	mov lr, r3
    	.short 0xF800
    mov	r2, r0
    mov	r0, r5
    mov	r1, r6
    mov	r3, #1
    	ldr r4, =0x0801a798
    	mov lr, r4
    	.short 0xF800
    ldr	r0, =0x08025fbc
    ldr r0, [r0]
    	ldr r3, =0x08024e5c
    	mov lr, r3
    	.short 0xF800
    pop	{r4, r5, r6}
    pop	{r0}
    bx	r0
.align
