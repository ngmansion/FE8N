@thumb
	
	cmp	r1, #3
	bgt	true
	cmp	r1, #1
	bge	check
;	bgt	check
;	cmp	r1, #1
;	bge	false
;通常の再移動
true
	ldr	r0, =$0801CEDC
	mov	pc, r0
check
	ldr	r0, [r4]
	add	r0, #48
	ldrh	r0, [r0]
	lsl	r0, r0, #28
	lsr	r0, r0, #28
	cmp	r0, #2	;スリープ
	beq	false
	cmp	r0, #11	;ストーン
	beq	false
	cmp	r0, #13	;ストーン
	beq	false
    
    ldr r0, =$0801cece
    cmp r0, r3
    beq true ;スキル再移動発動判定済み

	ldr	r1, [r4]
	mov	r0, #29
	ldsb	r0, [r1, r0]	;ブーツ力
	ldr	r1, [r1, #4]		;クラスのアドレス
	ldrb	r1, [r1, #18]	;クラス基礎移動
	lsl	r1, r1, #24
	asr	r1, r1, #24
	add	r0, r0, r1
	ldrb	r1, [r2, #16]	;既に移動した分
	cmp	r0, r1
	ble	false
	sub	r1, r0, r1
	cmp	r1, #2
	ble	jump
	sub	r0, #2
	strb	r0, [r2, #16]
jump
	ldr	r0, =$0801cef2
	mov	pc, r0
;再移動無し
false
	ldr	r0, =$0801CEFC
	mov	pc, r0
@ltorg
adr: