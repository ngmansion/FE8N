

.thumb
remove_skill:
@I	r0 = ベースアドレス
@	r1 = 0 is Skill1, 1 is Skill2, ...消したいスキル。
@O	r0 = 消したskillID。0は失敗。
@
@ダブり取得がある場合、インデックスの大きいほうが誤削除される。
	push {r4, r5, r6, lr}
	mov r4, r0
	mov r5, r1
	
	mov r1, r5
	cmp r1, #5
	bgt FALSE
@▼本処理▼
@▼getを使って消すスキルIDを取得
	mov r0, r4
	bl get_skill
	cmp r0, #0
	beq FALSE
	mov r5, r0
	mov r6, #0
	.short 0xe000
loop1:
	push {r0}
@▼popを使った探索処理
	mov r0, r4
	bl pop_skill
	add r6, #1
	cmp r0, r5
	bne loop1
	b loop2_st
loop2:
@▼pushを使った書き戻し処理
	pop {r1}
	mov r0, r4
	bl push_skill
loop2_st:
	sub r6, #1
	bhi loop2
@▼後処理▼
	mov r0, r5
	b END
FALSE:
	mov r0, #0
END:
	pop {r4, r5, r6, pc}
.align
get_skill:
	ldr r3, Adr
	mov pc, r3
push_skill:
	ldr r3, Adr+4
	mov pc, r3
pop_skill:
	ldr r3, Adr+8
	mov pc, r3
.align
.ltorg
Adr:

