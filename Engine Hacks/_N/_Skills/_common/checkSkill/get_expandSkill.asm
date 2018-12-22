@define TRANSPORT_DATA_ADR ($0203a818)

@thumb
get_extraSkill:
;I	r0 = 隊列ID
;	r1 = 0 is Skill3, 1 is Skill4, ...
;O	r0 = skillID
	push {lr}
	cmp r0, #51
	bgt false
	mov r2, r1
	sub r0, r0, #1
	bl get_saveUnitAdr
	mov r1, r2
	bl get_unitSkill
	b end
false
	mov r0, #0
end:
	pop {pc}
	
get_saveUnitAdr:
;I	r0 = 隊列ID
;O	r0 = ユニットのセーブベースアドレス
	mov r1, 3
	mul r0, r1
	ldr r1, =TRANSPORT_DATA_ADR
	add r0, r0, r1
	bx lr
	
get_unitSkill:
;I	r0 = ユニットのセーブベースアドレス
;	r1 = SkillIndex
;O	r0 = SkillID
	cmp r1, #0
	beq three
	cmp r1, #1
	beq four
	cmp r1, #2
	beq five
	cmp r1, #3
	beq six
	mov r0, #0
	b end2
three:
	ldrb r0, [r0]
	b true
four:
	ldrb r1, [r0]
	lsr r1, r1, 6
	ldrb r2, [r0, 1]
	lsl r2, r2, 2
	orr r1, r2
	mov r0, r1
	b true
five:
	ldrb r2, [r0, 1]
	lsr r2, r2, 4
	ldrb r1, [r0, 2]
	lsl r1, r1, 4
	orr r2, r1
	mov r0, r2
	b true
six:
	ldrb r0, [r0, 2]
	lsr r0, r0, 2
	b true
	nop
true:
	mov r1, 0x3F	;IDをビットマスク
	and r0, r1
end2:
	bx lr