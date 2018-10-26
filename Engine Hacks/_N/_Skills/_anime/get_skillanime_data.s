@
@再生するスキルアニメ構造体の取得
@取得できなければ 0 が返される
@
@引数 r0=スキルの種類 #0x00=攻撃 #0x01=防衛
.thumb
    push {r4,lr}

	mov		r4,r0				@スキルの分類

	ldr		r3, =0x0203AB40  @保持していると判定されたスキルIDを記録. スキル発動のアニメーションを出す時に利用する

	ldr		r0, =0x0203E188		@戦闘アニメで攻撃側へのRAMポインタ
	ldr		r0, [r0, #0x0]		@RAMデータへ

	mov		r2,#0xB
	ldrb	r2,[r0,r2]	@UnitRAMPointer->部隊表ID	友軍+0x40	敵軍+0x80
	cmp		r2,#0x80
	blt		Player		@Player or Ally

Enemy:
	add		r3, #0x02		@敵軍
	@b		Join1

Player:
	@nop
@Join1:

	cmp		r4, #0x00		@スキルの分類を評価
	beq		AttackSkill
	b		DefenseSkill

DefenseSkill:
	add		r3,#0x01	@防衛スキルは+1する.
	@b		Join2

AttackSkill:
	@nop

@Join2:
	ldrb	r0, [r3]      @記録しておいたスキルIDを取得

	cmp		r0,#0x00
	beq		Exit	@不明 ディフォルトアニメをそのまま利用

	ldr		r1,	adr       @SkillAnimation* SkillAnimation[SKILL_ID] skillanimation@
	lsl		r0 ,r0 ,#0x2	@r1=skill_id << 2 (ポインタ参照するため)
	ldr		r0,[r1,r0]      @skl_anime_table[skill_id].SkillAnime
	@cmp		r0,#0x00
	@beq		Exit        @不明 ディフォルトアニメをそのまま利用
	
Exit:
    pop {r4,pc}
.align 4
.ltorg
adr: