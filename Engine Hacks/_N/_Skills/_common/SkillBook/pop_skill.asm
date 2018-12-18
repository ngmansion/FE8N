@define unit_data r4
@define count r5

@thumb
popSkill:
;I	r0 = ベースアドレス
;O	r0 = 取得したskillID。0は失敗。
;
	push {r4, r5, lr}
	mov r4, r0
	ldrb r0, [r0, #11]
	bl common_skill2
	cmp r0, #0
	beq FALSE
	bl popSkill_impl
	b END
FALSE:
	mov r0, 0
END
	pop {r4, r5, pc}
	
	
popSkill_impl:
;▼本処理
	push {lr}
	mov count 1	;index0はあり得ないので
loop
	mov r0 unit_data
	mov r1, count
	bl get_skill
	cmp r0, #0
	beq loop_end
	add count 1
	b loop
loop_end:
	sub count 1 ;消すスキルに合わせる
;indexごとの内部処理へ分岐
	cmp count 0
	beq one
	cmp count 1
	beq two
	cmp count 2
	beq three
	cmp count 3
	beq four
	cmp count 4
	beq five
	cmp count 5
	beq six
	b FALSE_impl
one:
two:
	mov r1, count
	mov r0, unit_data
	bl pop_unitSkill
	b END_impl
three:
four:
five:
six:
	mov r0, unit_data
	bl common_skill1
	mov r1 count
	bl pop_unitSkillEx
	b END_impl
FALSE_impl:
	mov r0, 0
END_impl:
	pop {pc}
	
	
pop_unitSkill:
;▼内部処理1
	mov r3, r0
	cmp r1, #1
	beq two_impl
;スキル1
    ldrh r0, [r3, #0x3A]
    mov r1, %0000000000111111
    and r0, r1
    mov r1, 0
    strh r1, [r3, #0x3A]
	b end_unit
;スキル2:
two_impl:
    ldrh r0, [r3, #0x3A]
    ldr r1, =%0000111111000000
    and r0, r1
    lsr r0, r0, #6
    
    ldrh r2, [r3, #0x3A]
    mvn r1, r1
    and r2, r1
    strh r2, [r3, #0x3A]
end_unit:
	bx lr
	
	
pop_unitSkillEx:
;▼内部処理2
	mov r3, r0
	cmp r1, #2
	beq three_impl
	cmp r1, #3
	beq four_impl
	cmp r1, #4
	beq five_impl
	cmp r1, #5
	beq six_impl
	b end_unit_ex
three_impl:
	ldrb r0, [r3]
	mov r1, 0
	strb r1, [r3]
	b end_unit_ex
four_impl:
	ldrb r1, [r3]
	mov r2, %11000000
	lsr r0, r1, 6
	
	mvn r2, r2
	and r1, r2
	strb r1, [r3]
	
	ldrb r2, [r3, 1]
	lsl r1, r2, 2
	orr r0, r1
	
	mov r1, 0
	strb r1, [r3, 1]
	b end_unit_ex
	
five_impl:
	ldrb r1, [r3, 1]
	mov r2, %11110000
	lsr r0, r1, 4
	
	mvn r2, r2
	and r1, r2
	strb r1, [r3, 1]
	
	ldrb r2, [r3, 2]
	lsl r1, r2, 4
	orr r0, r1
	
	mov r1, 0
	strb r1, [r3, 2]
	
	b end_unit_ex
six_impl:
	ldrb r1, [r3, 2]
	mov r2, %11111100
	lsr r0, r1, 2
	
	mvn r2, r2
	and r1, r2
	strb r1, [r3, 2]
	b end_unit_ex
	nop
end_unit_ex:
	mov r1, %00111111	;IDをビットマスク
	and r0, r1
	bx lr
	
@align 4
@ltorg
get_skill:
	ldr r3, [Adr]
	mov pc, r3
common_skill1:
	ldr r3, [Adr+4]
	mov pc, r3
common_skill2:
	ldr r3, [Adr+8]
	mov pc, r3
Adr:

