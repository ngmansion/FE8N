.thumb
@	書き換え
@	00017bdc > 70 47
@
@	0002aeec > 00 4A 97 46 XX XX XX 08(コレを貼るアドレス)
@
	push	{r4, r5, lr}
	mov	r4, r0
	mov	r5, r1
	ldr	r0, =0x0203A568
	bl	routine1
	cmp	r0, #0
	beq	jump1
	ldr	r0, =0x0203A4E8
	b	jump2
jump1:
	ldr	r0, =0x0203A568
jump2:
	str	r0, [r5, #0]
	bl	routine2
	str	r0, [r4, #0]
	pop	{r4, r5, pc}
	
	
routine1:
	push	{r4, lr}
@@@@@@@@@@@@受け側チェック
	mov	r4, #0
	mov	r2, r0
	add	r2, #72
	ldrh	r2, [r2]

	cmp	r2, #0
	beq	false	@装備なしなら不発
	ldr	r2, [r0, #76]
	lsl	r3, r2, #24
	bmi	false	@反撃不可武器なら不発
	bl	hasVantage
	cmp	r2, #0
	beq	false	@待ち伏せ未所持なら不発
	bl	hasNihil
	cmp	r2, #0
	beq	skipVantage	@見切り未所持
@受けが待ち伏せと見切りの両方持ちなら、この時点で一旦オン
	ldr	r2, =0x0203A4D0		@??????????
	ldrh	r2, [r2]
	mov	r4, #1
	and	r4, r2
skipVantage:

	bl	routine2	@攻め側のアドレス取得
@@@@@@@@@@@@攻め側チェック
	ldr	r2, [r0, #76]
	lsl	r3, r2, #24
	bmi	false	@反撃不可武器なら不発
	bl	hasNihil
	cmp	r2, #1
	beq	false	@攻め側が見切りを持っているなら不発
	
	bl	hasVantage
	cmp	r2, #1
	beq	end	@攻め側が待ち伏せを持っているならスキップ
true:
	ldr	r0, =0x0203A4D0		@??????????
	ldrh	r0, [r0]
	mov	r4, #1
	and	r4, r0
	b end
false:
	mov r4, #0
end:
	mov	r0, r4
	pop	{r4, pc}
	
	
routine2:
	ldr	r2, =0x0203A568
	mov	r3, r0
	sub	r0, #128
	cmp	r3, r2
	beq	jump201
	add	r3, #128
	mov	r0, r3
jump201:
	bx	lr
	
	
hasVantage:
@ユニットチェック
    push {r4, lr}
    mov r4, r0
        ldr r1, adr @待ち伏せ
        mov lr, r1
        .short 0xF800
    mov r2, r0
    mov r0, r4
    pop {r4, pc}

	
@	見切りチェック
hasNihil:
    push {r4, lr}
    mov r4, r0
        ldr r1, adr+4 @見切り
        mov lr, r1
        .short 0xF800
    mov r2, r0
    mov r0, r4
    pop {r4, pc}

.ltorg
adr:
