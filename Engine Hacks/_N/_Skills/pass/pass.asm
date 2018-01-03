@thumb
	

	cmp	r3, #0
	bne	Start
	strb	r3, [r6, #8]
	ldr	r0, =$0801a1ea
	mov	pc, r0
;
;自軍は索敵マップだと無効
;
Start:
    push {r3}
    ldrb r0, [r4, #11]
    lsr r0, r0, #6
    bne Jump
    ldr r0, =$0202BCF9
    ldrb r0, [r0]
    cmp r0, #0
    bne nonPass
;
;謎のバグ防止
;
Jump:
    mov r0, r13
    ldr r1, =$03007d18
    cmp r0, r1
    beq nonPass
;
;スキルチェック
;
    mov r0, r4
        @align 4
        ldr r1, [adr] ;hasNihil
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne ouiPass
    
nonPass:
    mov r0, #1
    b Return
ouiPass:
    mov r0, #0
Return:
    pop {r3}
    ldr r1, =$0801a1e6
    mov pc, r1
@ltorg
adr: