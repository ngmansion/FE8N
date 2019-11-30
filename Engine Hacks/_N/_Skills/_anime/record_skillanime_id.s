@
@発動したスキルアニメーションを記録する
@
.thumb
    push {r4,r5,lr}
	mov r4,r0  @RAMUnit
	mov r5,r1  @SkillID

	@発動したスキルIDを記録したい.
	@ただ、アニメーションを持っていないスキルIDは記録したくない.
	ldr		r3,	adr	 @SkillAnimation* SkillAnimation[SKILL_ID] skillanimation@
	lsl		r1 ,r5 ,#0x2	@r1=skill_id << 2 (ポインタ参照するため)
	ldr		r3,[r3,r1]	 @skl_anime_table[skill_id].SkillAnime
	cmp		r3,#0x00
	beq		exit	@アニメーションを持っていない

	@アニメをもっているようなので記録する
	ldr		r3, =0x0203AE40   @保持していると判定されたスキルIDを記録. スキル発動のアニメーションを出す時に利用する

	mov		r2,#0xB
	ldrb	r2,[r4,r2]	@UnitRAMPointer->部隊表ID	友軍+0x40	敵軍+0x80
	cmp		r2,#0x80
	blt		Player		@Player or Ally

Enemy:  @敵軍
	add		r3, #0x02		@敵軍
	@b		Join1

Player:  @自軍(または、友軍)
	@nop

@Join1
	@防衛スキルと攻撃スキルの分岐
	cmp		r5, #0x01		@大盾
	beq		DefenseSkill
	cmp		r5, #0x11		@聖盾
	beq		DefenseSkill
	cmp		r5, #0x75		@裏ジェノサイド
	beq		DefenseSkill
	b		AttackSkill

DefenseSkill:
	add		r3,#0x01	@防衛スキルは+1する.
	@b		Join2

AttackSkill:
	@nop

@Join2:
	strb	r5, [r3]		@スキルIDの記録
	
	@Player 攻撃スキル	0203AE40
	@Player 防衛スキル	0203AE41
	@Enemy  攻撃スキル	0203AE42
	@Enemy  防衛スキル	0203AE43
	@攻撃スキルと防衛スキルが同時に発動することがあるので分ける.

exit:
	pop {r4,r5, pc}
.align
.ltorg
adr:
