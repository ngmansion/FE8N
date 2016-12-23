@thumb
;@org	$0802b58c
	
	cmp	r0, #1
	beq	poison
	cmp	r0, #3
	beq	half
	
	mov	r1, #111
	cmp	r0, #6
	beq	sleep
	cmp	r0, #7
	beq	confu
	cmp	r0, #8
	beq	silent
	ldr	r1, =$0802b5ea
	mov	pc, r1
poison
	ldr	r1, =$0802b598
	mov	pc, r1
half
	ldr	r1, =$0802b5d4
	mov	pc, r1
	
sleep
	mov	r0, #0x32
	b	end
confu
	mov	r0, #0x34
	b	end
silent
	mov	r0, #0x33
end
	strb	r0, [r4, r1]
	ldr	r1, =$0802B59E	;;=$0802b5b2
	mov	pc, r1