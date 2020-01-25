.thumb
@r0 = ユニットデータアドレス
@r1 = リスト先頭アドレス
		push {r4, r5, lr}
		mov r4, r0
		add r4, #30
		mov r3, r1
		mov r5, #0
	forItem:
		cmp r5, #10
		bgt endItem
			ldrb r0, [r4, r5]
			cmp r0, #0
			beq endItem
			mov r1, r3
			bl Listfunc
			cmp r0, #1
			beq endItem
		add r5, #2
		b forItem

	endItem:
		pop {r4, r5, pc}


Listfunc:
@r0 = 検索キー
@r1 = リスト先頭ポインタ
	whileLoop:
		ldrb r2, [r1]
		cmp r2, #0
		beq falseLoop
		cmp r0, r2
		beq trueLoop
		add r1, #1
		b whileLoop
	falseLoop:
		mov r0, #0
		bx lr
	trueLoop:
		mov r0, #1
		bx lr

