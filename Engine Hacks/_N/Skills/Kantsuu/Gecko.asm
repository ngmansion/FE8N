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
;ヴァルター様専用
	ldr	r0, [r2]
	add r0, #0x31
	ldrb	r0, [r0]
	cmp r0, #2
	beq	random
	
	ldr	r0, [r2, #4]
	ldrb	r0, [r0, #4]
@align 4
	ldr	r3, [adr]
loop
	ldrb	r1, [r3]
	cmp	r1, #0
	beq	end
	cmp	r0, r1
	beq	random
	add	r3, #1
	b	loop
	
random
	ldrb	r0, [r2, #0x15]	;;貫通発動率
	ldr	r3, =$0802b226
	mov	pc, r3
end
	ldr	r3, =$0802b24a
	mov	pc, r3
WEAPON
	ldr	r3, =$080172f0
	mov	pc, r3
@ltorg
adr:

