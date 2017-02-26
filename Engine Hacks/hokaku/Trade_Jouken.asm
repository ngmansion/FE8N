@thumb
@org	$08022f04
	;同行者がいる場合は敵ユニットでも交換対象
	lsl	r0, r0, #25
	bmi	$08022F48	;敵ならジャンプ
	ldrb	r0, [r2, #27]	;同行者ロード
	lsl	r1, r0, #24
	bmi	check
	lsl	r1, r0, #25
	bmi	$08022F2E	;友軍ジャンプ
	beq	$08022F2E
check
	bl	$08019108
	ldr	r2, [$08022f40]
	ldr	r2, [r2]
	ldrb	r0, [r0, #0x1E]
	ldrb	r1, [r2, #0x1E]
	orr	r0, r1
	bne	$08022f3c	;道具有るならジャンプ
	b	$08022f2E