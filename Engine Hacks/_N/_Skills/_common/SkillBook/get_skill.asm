
@thumb
get_Skill:
;I	r0 = ベースアドレス
;	r1 = 0 is Skill1, 1 is Skill2, ...
;O	r0 = skillID
	push {r4, lr}
	mov r2, r0
	mov r4, r1
	
	ldrb r0, [r0, #11]
	bl common_skill2
	cmp r0, #0
	beq false
	mov r0, r2
	mov r1, r4
	
	cmp r1, #5
	bgt false
;▼本処理
	cmp r1, #1
	bgt expand
;▼1-2スキル
	bl get_unitSkill
	b end
expand:
;▼3-6スキル
	bl get_saveExSkill_ex
	mov r1, r4
	bl get_unitSkillEx
	b end
false
	mov r0, #0
end:
	pop {r4, pc}
	
	
get_unitSkill:
	mov r3, r0
	cmp r1, #1
	beq two
one:
    ldrh r0, [r3, #0x3A]
    mov r1, %111111
    and r0, r1
	b end_get_unitSkill
two:
    ldrh r0, [r3, #0x3A]
    ldr r1, =%111111000000
    and r0, r1
    lsr r0, r0, #6
    b end_get_unitSkill
end_get_unitSkill:
	bx lr
	
	
	
get_unitSkillEx:
;I	r0 = ユニットのセーブベースアドレス
;	r1 = SkillIndex
;O	r0 = SkillID
	cmp r1, #2
	beq three
	cmp r1, #3
	beq four
	cmp r1, #4
	beq five
	cmp r1, #5
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
@align 4
@ltorg
get_saveUnitAdr:
	ldr r3, [Adr+4]
	mov pc, r3
get_saveExSkill_ex:
	ldr r3, [Adr+0]
	mov pc, r3
common_skill2:
    ldr r3, [Adr+8]
    mov pc, r3
Adr:



