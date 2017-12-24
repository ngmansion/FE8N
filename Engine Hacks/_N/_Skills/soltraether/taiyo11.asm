@thumb
	push	{r4, r5, r6, r7, lr}
	mov	r6, r0
	ldrh	r0, [r6, #44]
	add	r0, #1
	mov	r7, #0
	strh	r0, [r6, #44]
	lsl	r0, r0, #16
	asr	r0, r0, #16
	mov	r2, #46
	ldsh	r1, [r6, r2]
	cmp	r0, #10		;元は　cmp	r0, r1
	ble	number19
	ldr	r4, =$0203e14e
	ldr	r0, [r6, #92]
bl	b5AF10
	lsl	r0, r0, #1
	add	r0, r0, r4
	mov	r1, #0
	ldsh	r5, [r0, r1]
	add	r4, r5, #1
	lsl	r4, r4, #16
	asr	r4, r4, #16
	ldr	r0, [r6, #92]
bl	b5AF10
	lsl	r5, r5, #1
	add	r5, r5, r0
	mov	r0, r5
ldr	r1, =$08059890
mov	lr, r1
@dcw $F800
	lsl	r0, r0, #16
	asr	r0, r0, #16
	str	r0, [r6, #76]
	ldr	r0, [r6, #92]
bl	b5AF10
	lsl	r4, r4, #1
	add	r4, r4, r0
	mov	r0, r4
ldr	r1, =$08059890
mov	lr, r1
@dcw $F800
	lsl	r0, r0, #16
	asr	r0, r0, #16
	str	r0, [r6, #80]
	strh	r7, [r6, #44]
	ldr	r1, [r6, #76]
	strh	r1, [r6, #46]
	str	r7, [r6, #84]
	str	r7, [r6, #88]
	cmp	r1, r0
	bne	number11
	mov	r0, #1
	str	r0, [r6, #88]
number11
	ldr	r1, [r6, #76]
	ldr	r0, [r6, #80]
	cmp	r1, r0
	ble	number12
	mov	r0, #1
	neg	r0, r0
	b	number13

number12
	mov	r0, #1
number13
	str	r0, [r6, #72]
	mov	r0, r6
		mov	r1, #0
		mov	r0, #41
		strb	r1, [r6, r0]
		ldr	r1, =$0805351D
		str	r1, [r6, #12]
			
;			この処理に戻すと、光るが回復はしなくなる。(物理でも回復する処理か)
;			00002de2 0000     	lsl	r0, r0, #0
;			00002de4 2100     	mov	r1, #0
;			00002de6 60c1     	str	r1, [r0, #12]
;			00002de8 4770     	bx	lr
	ldr	r0, [r6, #92]
bl	b5AF10
	ldr	r1, =$02017780
	lsl	r0, r0, #1
	add	r0, r0, r1
	mov	r1, #2
	strh	r1, [r0]
number19
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
	
b5AF10
	ldr	r1, =$0805af10
	mov	pc, r1
	