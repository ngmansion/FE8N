@thumb
;(59456>返しリザイア)
	mov	r0, r9
	lsl	r0, r0, #2
	add	r0, r0, r6
	strh	r1, [r0]
	ldr	r6, =$0203AB20	;(勝手な太陽フラグ)
	mov	r0, r10
;	
;
	lsl	r0, r0, #1
	add	r0, #1
	lsl	r0, r0, #1
	add	r0, r0, r6
	mov	r1, #1
	strh	r1, [r0]
	ldr	r0, =$0805950C
	mov	pc, r0