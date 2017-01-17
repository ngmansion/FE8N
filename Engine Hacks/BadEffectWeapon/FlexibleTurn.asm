@thumb
;@org	$08017680


	add	r0, #48
	cmp	r1, #0
	beq	end
	mov	r2, #0xF0
	and	r2, r1
	bne	end
	mov	r2, #80
	orr	r1, r2
end
	strb	r1, [r0, #0]
	bx	lr