@thumb

;	cmp	r0, #0	
;	bne	noeffect
	ldrh r1, [r5, #0x0C]
	mov r0, #0x80
	lsl r0,r0,#2
	and r0, r1
	cmp r0, #0	;; LtoR or RtoL?
	beq RtoL
LtoR
	mov r0, #1
	b LoadAddress
RtoL
	mov r0, 0
LoadAddress
	ldr r1, = $203E184
	lsl r0,r0, #2
	add r1, r1, r0
	ldr r1, [r1]	
	mov r0, #0x6F
	add r0, r1, r0
	ldrb r0,[r0]
	mov r1, #0x0F
	and r1, r0
	cmp r1, #0	;; probably not necessary
	beq noeffect
	mov r0, r5
	ldr r2, = $80562F0
	mov pc, r2
noeffect
	ldr	r1, =$080562F4
	mov	pc, r1