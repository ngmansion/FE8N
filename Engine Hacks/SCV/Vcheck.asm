@thumb
;@org	$08027658 > 00 48 87 46 D8 03 E9 08
;@org	$085C6E08
;@incbin	data.bin


;@org	$085C6EB0
	push    {r4 r5 r6 r7}
;ldr     r0,=202BD31h
;ldrb    r0,[r0]
;mov     r1,#0x80
;and     r0,r1
;cmp     r0,#0
;bne     end
	mov     r1,#0x10
	ldsb    r1,[r4,r1]
	lsl     r1,r1,#4
	ldr     r2,=$0202BCAC	;(202BCB0)
	mov     r3,#0xC
	ldsh    r0,[r2,r3]
	sub     r3,r1,r0
	mov     r0,#0x11
	ldsb    r0,[r4,r0]
	lsl     r0,r0,#4
	mov     r5,#0xE
	ldsh    r1,[r2,r5]
	sub     r2,r0,r1
	mov     r1,r3
	add     r1,#0x10
	mov     r0,#0x80
	lsl     r0,r0,#1
	lsl     r6,r7,#0x18
	cmp     r1,r0
	bhi     end
	mov     r0,r2
	add     r0,#0x10
	cmp     r0,#0xB0
	bhi     end


	ldr     r1,=$0201
	add     r0,r3,r1
	sub     r1,#2
	and     r0,r1
	mov     r1,r2
	add     r1,#0xFB
	mov     r2,#0xFF
	and     r1,r2
	ldr     r3,=$85C6E78
	push    {r0 r1 r2 r3}
	mov     r0,#0x12
	ldrb    r0,[r4,r0]
	mov     r1,#0x13
	ldrb    r1,[r4,r1]
	cmp     r0,r1
	bne     jump1
	mov     r5,#0
	b       none
jump1
	cmp     r1,#0
	bne     jump2
	mov     r5,#0xE
	b       none
jump2
	sub     r2,r0,r1
	mov     r1,r0
	mov     r0,#0xC
	mul     r0,r2
@dcw	$DF06;	swi     #6
	mov     r5,#1
	add     r5,r5,r0
none
	pop     {r0 r1 r2 r3}
	lsl     r2,r5,#2
	add     r2,r2,r3
	ldr     r2,[r2]
ldr     r3,=$08002B08		;8002BB8
mov     r14,r3
	mov     r3,#0
@dcw	$F800
end
	
;追加矢印処理
	ldrb	r0, [r4, #11]
	lsr	r0, r0, #6
	beq	noncheck
	mov	r0, #0x3B
	ldrb	r0, [r4, r0]
	lsl	r0, r0, #24
	bpl	noncheck
	mov     r1,#0x10
	ldsb    r1,[r4,r1]
	lsl     r1,r1,#4
	ldr     r2,=$0202BCAC	;(202BCB0)
	mov     r3,#0xC
	ldsh    r0,[r2,r3]
	sub     r3,r1,r0
	mov     r0,#0x11
	ldsb    r0,[r4,r0]
	lsl     r0,r0,#4
	mov     r5,#0xE
	ldsh    r1,[r2,r5]
	sub     r2,r0,r1
	mov     r1,r3
	add     r1,#0x10
	mov     r0,#0x80
	lsl     r0,r0,#1
	lsl     r6,r7,#0x18
	cmp     r1,r0
	bhi     noncheck
	mov     r0,r2
	add     r0,#0x10
	cmp     r0,#0xB0
	bhi     noncheck
	
	ldr     r1,=$0201
	add     r0,r3,r1
	sub     r1,#2
	and     r0,r1
	mov     r1,r2
	add     r1,#0xFB
	mov     r2,#0xFF
	and     r1,r2
	
	mov	r2, pc
	add	r2, #28
	mov     r3,#0
ldr     r4,=$08002B08		;8002BB8
mov     r14,r4
@dcw	$F800
	
noncheck
	pop     {r4 r5 r6 r7}
	
;ここからオリジナルの処理
	mov     r0,r4
	add     r0,#0x30
	ldrb    r0,[r0]
	lsl     r0,r0,#0x1C
	lsr     r0,r0,#0x1C
	ldr     r1,=$08027660			;80276BFh
	mov	pc, r1

@dcd	$00030001
@dcd	$086F0004