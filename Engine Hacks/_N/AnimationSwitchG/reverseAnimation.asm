@thumb
@org $0802c9a8
	ldrh r0, [r0,#12]
	lsl r0, r0, #16
	lsr r0, r0, #30
	add r0, r0, #1
	bne check
	mov r0, #0
check:
	bx lr
	
flip:
	ldr r1, =$02024CC0
	ldrh r1, [r1, #4]
	lsl r1, r1, #29
	bpl end
	sub r0, r0, #1
	beq end
	mov r0, #1
end:
	bx lr
@ltorg


@org $0802ca2a
	bl flip
	pop {pc}
