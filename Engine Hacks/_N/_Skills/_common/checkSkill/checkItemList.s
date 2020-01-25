.thumb
@r0 = ユニットデータアドレス
@r1 = リスト先頭アドレス
		push {r4, r5, r6, lr}
		mov r4, r0
		mov r6, r1
		mov r5, #0
	forItem:
		cmp r5, #6
		bge falseItem
			lsl r0, r5, #1
			ldrb r0, [r4, #30]
			cmp r0, #0
			beq endItem
			mov r1, r6
			bl Listfunc
			cmp r0, #1
			beq endItem
		add r5, #1
		b forItem

	falseItem:
		mov r0, #0
		b endItem
	endItem:
		pop {r4, r5, r6, pc}


Listfunc:
@r0 = 検索キー
@r1 = リスト先頭ポインタ

		cmp r0, #0
		beq endLoop
		cmp r1, #0
		beq falseLoop
		mov r2, r1
	whileLoop:
		ldrb r1, [r2]
		cmp r1, #0
		beq falseLoop
		cmp r0, r1
		beq trueLoop
		add r2, #1
		b whileLoop
	falseLoop:
		mov r0, #0
		bx lr
	trueLoop:
		mov r0, #1
	endLoop:
		bx lr

