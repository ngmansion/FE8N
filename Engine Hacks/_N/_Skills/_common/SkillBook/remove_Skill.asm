@define unit_data r4
@define target_skill r5
@define loop r6

@thumb
remove_skill:
;I	r0 = ベースアドレス
;	r1 = 0 is Skill1, 1 is Skill2, ...消したいスキル。
;O	r0 = 消したskillID。0は失敗。
;
;ダブり取得がある場合、インデックスの大きいほうが誤削除される。
	push {r4, r5, r6, lr}
	mov unit_data, r0
	mov r5, r1
	
	ldrb r0, [r0, #11]
	bl common_skill2
	cmp r0, #0
	beq FALSE
	mov r1, r5
	cmp r1, #5
	bgt FALSE
;▼本処理▼
;▼getを使って消すスキルIDを取得
	mov r0, unit_data
	bl get_skill
	cmp r0, #0
	beq FALSE
	mov target_skill, r0
	mov loop 0
	@dcw $e000
loop1:
	push {r0}
;▼popを使った探索処理
	mov r0, unit_data
	bl pop_skill
	add loop 1
	cmp r0, target_skill
	bne loop1
	b loop2_st
loop2:
;▼pushを使った書き戻し処理
	pop {r1}
	mov r0, unit_data
	bl push_skill
loop2_st:
	sub loop 1
	bhi loop2
;▼後処理▼
	mov r0, target_skill
	b END
FALSE
	mov r0, #0
END
	pop {r4, r5, r6, pc}
@align 4
@ltorg
get_skill:
	ldr r3, [Adr]
	mov pc, r3
push_skill:
	ldr r3, [Adr+4]
	mov pc, r3
pop_skill:
	ldr r3, [Adr+8]
	mov pc, r3
common_skill2
	ldr r3, [Adr+12]
	mov pc, r3
Adr:

