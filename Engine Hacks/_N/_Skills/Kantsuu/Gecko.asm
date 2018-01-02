@thumb
;;@org	$08E48BB0
	
	mov	r0, #72
	ldrh	r0, [r2, r0]
		bl	WEAPON
	cmp	r0, #7
	bgt	end
	add	r0, #40
	ldrb	r0, [r2, r0]
	cmp	r0, #250
	bls	end
	
    mov r0, r2
        push {r2}
        @align 4
        ldr r1, [adr] ;月光
        mov lr, r1
        @dcw $F800
        pop {r2}
    cmp r0, #0
    beq end

	ldrb	r0, [r2, #0x15]	;;月光発動率
	mov	r1, #0
	ldr	r3, =$0802a490 ;;r0=確率, r1=#0 乱数
	mov	lr, r3
	@dcw	$F800
	cmp	r0, #1
	bne	end
	
	ldr	r3, [r5, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	orr	r1, r4
	ldr	r0, =0xFFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]
	
	pop	{r4, r5}
	asr	r4, r4, #1
	pop	{r0}
	bx	r0
	
end
	ldr	r3, =$0802b24a
	mov	pc, r3
WEAPON
	ldr	r3, =$080172f0
	mov	pc, r3
@ltorg
adr:

