@thumb
;@org	$08028610


	mov r5, r7
	ldrb r0,[r5, #0x0B]
	cmp  r0, #0x3F
	blt  ally
        cmp  r0, #0x81
	bge  enemy
        b end
ally
	ldr r3, =$202BE48
	mov r7, #0x3F
	b entry
enemy
	ldr r3, =$202CFB8
	mov r7, #0x32
	b entry
entry	
	ldr r0,[r3, #0x00]
	cmp r0, #0x00
	beq end
	ldr r0, [r3,#0x0C]
	ldr r1, =$1002C
	and r0, r1
	cmp r0, #0	;; 戦闘参加中判定
	bne next
class
    push {r2}
    push {r3}
    mov r0, r3
        @align 4
        ldr r1, [adr] ;カリスマ
        mov lr, r1
        @dcw $F800
    pop {r3}
    pop {r2}
    cmp r0, #0
    bne Xdistance
        
next
	add r3, #0x48
	sub r7,#0x01
	cmp r7, #0x00
	bgt entry
	b end
Xdistance
	ldrb r0, [r3, #0x10]
	ldrb r1, [r5, #0x10]
	sub r2, r0, r1
	cmp r2, #0x00
	bge Ydistance
	neg r2
Ydistance
	ldrb r0, [r3, #0x11]
	ldrb r1, [r5, #0x11]
	sub r1, r0, r1
	cmp r1, #0x00
	bge distance
	neg r1
distance
	add r1, r1, r2
	cmp r1, #0x00	;; 自分
	beq next	
	cmp r1, #0x03	;; カリスマ範囲
	bgt next
	ldrb r0,[r6, #3]  ;; 命中
	add r0, #20
	strb r0, [r6, #3]
	ldrb r0,[r6, #4]  ;; 回避
	add r0, #20
	strb r0, [r6, #4]
	b next	
end

	ldrb	r0, [r6, #1]
	lsr	r0, r0, #1
	cmp	r0, #3
	ble	tobi1
	mov	r0, #3
tobi1
	strb	r0, [r6, #1]
	
	ldrb	r0, [r6, #2]
	lsr	r0, r0, #1
	cmp	r0, #3
	ble	tobi2
	mov	r0, #3
tobi2
	strb	r0, [r6, #2]
	
	ldrb	r0, [r6, #3]
	lsr	r0, r0, #1
	cmp	r0, #15
	ble	tobi3
	mov	r0, #15
tobi3
	strb	r0, [r6, #3]
	
	ldrb	r0, [r6, #4]
	lsr	r0, r0, #1
	cmp	r0, #15
	ble	tobi4
	mov	r0, #15
tobi4
	strb	r0, [r6, #4]
	
	ldrb	r0, [r6, #5]
	lsr	r0, r0, #1
	cmp	r0, #15
	ble	tobi5
	mov	r0, #15
tobi5
	strb	r0, [r6, #5]
	
	ldrb	r0, [r6, #6]
	lsr	r0, r0, #1
	cmp	r0, #15
	ble	tobi6
	mov	r0, #15
tobi6
	strb	r0, [r6, #6]
	
	mov	r0, r9
	add	sp, #4
	pop	{r3, r4, r5}
	mov	r8, r3
	mov	r9, r4
	mov	r10, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
@ltorg
adr: