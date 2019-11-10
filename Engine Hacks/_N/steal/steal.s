
STAFF = (4)
ITEM = (9)

.thumb
	ldr r0, [r1, #8]
	lsl r0, r0, #27
	bmi false	@売却不可アイテムは盗めない
	
	ldrb r0, [r1, #7]
	cmp r0, #ITEM
	beq true
	cmp r0, #STAFF
	beq true
	cmp r0, #ITEM
	bgt false	@竜石などは盗めない
	cmp r6, #0
	beq false	@一番上のアイテムは盗めない
	cmp r6, #6
	blt true	@一番上のアイテムは盗めない
	mov r0, r8
	cmp r0, #0
	beq end	@一番上のアイテムは盗めない2
true:
	mov r0, #1
	b end
false:
	mov r0, #0
end:
	pop {r1}
	bx r1
	
	