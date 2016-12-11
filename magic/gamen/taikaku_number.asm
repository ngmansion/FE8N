@thumb
@org	$08089598

	ldr	r1, [r5, #12]
	ldr	r0, [r1, #4]
	mov	r2, #18
	ldsb	r2, [r0, r2]	;基礎値
	mov	r0, #29
	ldsb	r0, [r1, r0]	;doping
	add	r2, r2, r0
	mov	r1, #4
	cmp	r0, #0
	bne	hikaru
	mov	r1, #2
hikaru
	ldr	r0, =$02003F78
	bl	$08004a9c
;体格
	ldr	r1, [r5, #12]
	ldr	r0, [r1, #4]
	mov	r2, #17
	ldsb	r2, [r0, r2]
	ldr	r0, [r1, #0]
	ldrb	r0, [r0, #19]
	lsl	r0, r0, #24
	asr	r0, r0, #24
	add	r2, r2, r0
	ldr	r0, =$02003FF8
	mov	r1, #2
	bl	$08004a9c
;救出アイコン
	ldr	r0, [r5, #12]
	ldr	r1, [r0, #0]
	ldr	r2, [r0, #4]
	ldr	r0, [r1, #40]
	ldr	r1, [r2, #40]
	orr	r0, r1
	bl	$08018804
	mov	r1, r0
	mov	r2, #160
	lsl	r2, r2, #7
	ldr	r0, =$02003FF8
	add	r0, #2
	bl	$08003608	;馬or天馬or飛竜アイコン
	ldr	r6, =$02003e86
	
;救出中相手
	mov	r4, r5
	add	r4, #120
	ldr	r0, [r5, #12]
	bl	$080190c0
	mov	r3, r0
	mov	r1, #24
	mov	r2, #2
	mov	r0, r4
	add	r0, #0x10
	bl	$080043b8	;=文字描写
	b	$0808962a
	
;@org	$080895b6
;	ldr	r1, [r5, #12]
;	ldr	r0, [r1, #4]
;	mov	r2, #17
;	ldsb	r2, [r0, r2]
;	ldr	r0, [r1, #0]
;	ldrb	r0, [r0, #19]
;	lsl	r0, r0, #24
;	asr	r0, r0, #24
;	add	r2, r2, r0
;	ldr	r0, =$02003E06
;	mov	r1, #2
;	bl	$08004a9c
;	b	$080895e4