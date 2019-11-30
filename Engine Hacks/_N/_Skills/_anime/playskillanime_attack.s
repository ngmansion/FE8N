@Call 08070946 (FE8J)
@仕様は、ドキュメントを読んでください。 skl_anime_table.event
@
.thumb
	mov		r0,#0x0  @攻撃側を取得
	ldr		r1, adr  @ get_skillanime_data 発動しているスキルの取得
	mov		r14, r1
	.short 0xf800

	cmp		r0,#0x00
	beq		exit	@不明 ディフォルトアニメをそのまま利用

	ldr	r1, [r0,#0x0]	@フレームポインタ SkillAnimation[skill_id].frame_list
	str r1, [r7, #0x48]
	
	ldr	r1, [r0,#0x4]	@TSAポインタ SkillAnimation[skill_id].tsa_list
	str r1, [r7, #0x4c]
	str r1, [r7, #0x50]

	ldr	r1, [r0,#0x8]	@画像ポインタ SkillAnimation[skill_id].image_list
	str r1, [r7, #0x54]
	
	ldr	r1, [r0,#0xC]	@パレットポインタ SkillAnimation[skill_id].palette_list
	str r1, [r7, #0x58]

exit: @フック時に壊してしまう命令の再送
	ldr		r3,=0x08056158	@フレームとTSA画像による魔法のアニメ 
	mov		r14, r3
	.short 0xf800

	ldr		r0, =0x0203E11C
	mov		r1, #0x0
	ldsh	r0, [r0, r1]
	
	ldr		r3,=0x08070950+1	@元に戻す
	mov		pc,r3

.align
.ltorg
adr:
