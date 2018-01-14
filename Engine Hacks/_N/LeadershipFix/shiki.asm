@thumb
	ldrb	r0, [r5, #11]
	cmp	r0, #63
	ble	jigun
	cmp	r0, #127
	ble	yugun
	b	tekigun
yugun
	b	yugun2

jigun
	mov	r3, #0
	ldr	r2, =$0202be48
back
	ldr	r0, [r2, #0]
	cmp	r0, #0
	bne	jumen
	b	ruikei
jumen
	ldrb	r1, [r2, #16]	;座標
	cmp	r1, #255
	bge	nonono
	ldrb	r1, [r2, #19]	;現在HP
	cmp	r1, #0
	beq	nonono
	ldrb	r1, [r2, #12]	;救出
	lsl	r1, r1, #26
	bmi	nonono
    
    mov r0, r2
        @align 4
        ldr r1, =$0802A968
        ldr r1, [r1]
        mov lr, r1
        @dcw $F800
    
	add	r3, r3, r0		;合計の指揮
nonono
	add	r2, #72
	b	back

ruikei
	mov	r2, #0
	add	r5, #90
	ldrb	r1, [r4, #1]
	ldrh	r0, [r5, #0]
	add	r0, r0, r1
	strh	r0, [r5, #0]
	add	r5, #2
	ldrb	r1, [r4, #2]
	ldrh	r0, [r5, #0]
	add	r0, r0, r1
	strh	r0, [r5, #0]
	mov	r0, #3	;効果量
	mul	r3, r0
	add	r5, #4
	ldrb	r1, [r4, #3]
	ldrh	r0, [r5, #0]
	add	r1, r3, r1	;加算
	add	r0, r0, r1
	strh	r0, [r5, #0]
	add	r5, #2
	ldrh	r0, [r5, #0]
	ldrb	r1, [r4, #4]
	add	r1, r3, r1	;加算
	add	r0, r0, r1
	strh	r0, [r5, #0]
	add	r5, #4
	mov	r1, r5
	ldrh	r0, [r1, #0]
	ldrb	r2, [r4, #5]
	add	r0, r0, r2
	strh	r0, [r1, #0]
	add	r1, #2
	ldrh	r0, [r1, #0]
	ldrb	r4, [r4, #6]
	add	r0, r0, r4
	strh	r0, [r1, #0]
	b	return
	
yugun2
	ldr	r2, =$0202ddc8
	ldr	r1, =$0202E368
	b	ikuze
tekigun
	ldr	r2, =$0202cfb8
	ldr	r1, =$0202ddc8
ikuze
	mov	r3, #0

loop
	ldr	r0, [r2, #0]
	cmp	r0, #0
	beq	nononomi

	ldrb	r0, [r2, #12]	;救出
	lsl	r0, r0, #26
	bmi	nononomi
        @align 4
        ldr r0, =$0802A968
        ldr r0, [r0]
        mov lr, r0
    mov r0, r2
    @dcw $F800
	add	r3, r3, r0
nononomi
	add	r2, #72
	cmp	r2, r1
	beq	finale
	b	loop
finale

	mov	r2, r5
	add	r2, #90
	ldrb	r1, [r4, #1]
	ldrh	r0, [r2, #0]
	add	r0, r0, r1
	strh	r0, [r2, #0]
	add	r2, #2
	ldrb	r1, [r4, #2]
	ldrh	r0, [r2, #0]
	add	r0, r0, r1
	strh	r0, [r2, #0]
	mov	r0, #5	;効果量
	mul	r3, r0
	add	r2, #4
	ldrb	r1, [r4, #3]
	ldrh	r0, [r2, #0]
	add	r1, r3, r1	;加算
	add	r0, r0, r1
	strh	r0, [r2, #0]
	mov	r1, r5
	add	r1, #98
	ldrh	r0, [r1, #0]
	ldrb	r2, [r4, #4]
	add	r2, r3, r2	;加算
	add	r0, r0, r2
	strh	r0, [r1, #0]
	add	r1, #4
	ldrh	r0, [r1, #0]
	ldrb	r2, [r4, #5]
	add	r0, r0, r2
	strh	r0, [r1, #0]
	add	r1, #2
	ldrh	r0, [r1, #0]
	ldrb	r4, [r4, #6]
	add	r0, r0, r4
	strh	r0, [r1, #0]
return
	@dcw	$B002	;;add	sp, #8
	pop	{r4, r5}
	pop	{r0}
	bx	r0
@ltorg
adr: