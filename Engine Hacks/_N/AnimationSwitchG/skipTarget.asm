@thumb
@org $08039f14
	
	lsl r1, r1, #31
	bmi $08039f2a
	ldrh	r1, [r0, #12]
	lsl r1, r1, #28
	bmi $08039f2a
	
	mov r2, r4
	add r2, #100
	mov r0, #0
	ldsh r1, [r2, r0]
	



