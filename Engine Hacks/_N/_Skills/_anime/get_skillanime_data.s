@
@再生するスキルアニメ構造体の取得
@取得できなければ 0 が返される
@
@引数 r0=スキルの種類 #0x00=攻撃 #0x01=防衛
.thumb
    push {lr}

	ldr r3, =0x0203AB40		@発動したスキルアニメを記録している場所
							@Player 攻撃スキル	0203AB40
							@Player 防衛スキル	0203AB41
							@Enemy  攻撃スキル	0203AB42
							@Enemy  防衛スキル	0203AB43
							@攻撃スキルと防衛スキルが同時に発動することがあるので分ける.

	LDR r1, =0x02029000
	CMP r7, r1
	BLS Player

Enemy:
	add		r3, #0x02       @敵軍
	add		r3, r0          @防衛スキルなら+1 攻撃スキルなら+0
	b		Join1

Player:
	add		r3, r0          @防衛スキルなら+1 攻撃スキルなら+0
@	b		Join1

Join1:
	ldrb	r0, [r3]      @記録しておいたスキルIDを取得

	cmp		r0,#0x00
	beq		Exit	@不明 ディフォルトアニメをそのまま利用

	ldr		r1,	adr       @SkillAnimation* SkillAnimation[SKILL_ID] skillanimation@
	lsl		r0 ,r0 ,#0x2	@r1=skill_id << 2 (ポインタ参照するため)
	ldr		r0,[r1,r0]      @skl_anime_table[skill_id].SkillAnime

Exit:
    pop {pc}
.align 4
.ltorg
adr: