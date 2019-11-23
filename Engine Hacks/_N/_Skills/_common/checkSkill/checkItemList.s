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
			mov r0, r6
			lsl r1, r5, #1
			add r1, #30
			ldrb r1, [r4, r1]
			bl Listfunc
			cmp r0, #1
			beq trueItem
		add r5, #1
		b forItem

	falseItem:
		mov r0, #0
		b endItem
	trueItem:
		mov r0, #1
	endItem:
		pop {r4, r5, r6, pc}


Listfunc:
@r0 = リスト先頭ポインタ
@r1 = 検索キー
		cmp r0, #0
		beq endLoop
		cmp r1, #0
		beq endLoop
		mov r2, r0
	whileLoop:
		ldrb r0, [r2]
		cmp r0, #0
		beq falseLoop
		cmp r0, r1
		beq trueLoop
		add r2, #1
		b whileLoop
	falseLoop:
		mov r0, #0
		b endLoop
	trueLoop:
		mov r0, #1
	endLoop:
		bx lr
