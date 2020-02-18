.thumb
main:
@I	r0 = ベースアドレス
@	r1 = チェックしたいスキル
@O	r0 = ヒットしたら1,しなかったら0を返す
	push {r4, r5, lr}
    mov r4, r0
    mov r5, r1

@いち
	mov r0, r4
	mov r1, #0
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
	cmp r0, #0
	beq false_extendSkill
@に
	mov r0, r4
	mov r1, #1
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
	cmp r0, #0
	beq false_extendSkill
@さん
	mov r0, r4
	mov r1, #2
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
	cmp r0, #0
	beq false_extendSkill
@よん
	mov r0, r4
	mov r1, #3
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
	cmp r0, #0
	beq false_extendSkill
@ご
	mov r0, r4
	mov r1, #4
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
	cmp r0, #0
	beq false_extendSkill
@ろく
	mov r0, r4
	mov r1, #5
	bl get_Skill
	cmp r0, r5
	beq true_extendSkill
false_extendSkill:
	mov r0, #0
	b end_extendSkill
	
true_extendSkill:
	mov r0, #1
end_extendSkill:
	pop {r4, r5, pc}
	
.align
.ltorg
get_Skill:
    ldr r3, adr
    mov pc, r3
adr:
