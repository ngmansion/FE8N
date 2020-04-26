@
@発動したスキルアニメーションを記録する
@
.thumb
    push {r4,r5,lr}
	mov r4,r0  @SkillType 攻撃=0 防衛=1
	mov r5,r1  @SkillID

	cmp		r5,#128
	bge		exit	@アニメーションを持っていない
	@発動したスキルIDを記録したい.
	@ただ、アニメーションを持っていないスキルIDは記録したくない.
	ldr		r3,	adr	 @SkillAnimation* SkillAnimation[SKILL_ID] skillanimation@
	lsl		r1 ,r5 ,#0x2	@r1=skill_id << 2 (ポインタ参照するため)
	ldr		r3,[r3,r1]	 @skl_anime_table[skill_id].SkillAnime
	cmp		r3,#0x00
	beq		exit	@アニメーションを持っていない

	@アニメをもっているようなので記録する
	ldr		r3, =0x0203AE40   @保持していると判定されたスキルIDを記録. スキル発動のアニメーションを出す時に利用する
	strb	r5, [r3,r4]

	@攻撃スキル	0203AE40
	@防衛スキル	0203AE41

exit:
	pop {r4,r5, pc}
.align
.ltorg
adr:
