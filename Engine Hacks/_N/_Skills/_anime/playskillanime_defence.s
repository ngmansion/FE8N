@Call 08070B96 (FE8J)
@仕様は、ドキュメントを読んでください。 skl_anime_table.event
@

.thumb
	mov		r0,#0x1  @防衛側を取得
	ldr		r1, adr  @ get_skillanime_data 発動しているスキルの取得
	mov r14, r1
	.short 0xf800
	
	cmp		r0,#0x00
	beq		exit	@不明 ディフォルトアニメをそのまま利用
	
	ldr	r1,[r0,#0x0]	@フレームポインタ SkillAnimation[skill_id].frame_list
	str r1, [r4, #0x48]
	
	ldr	r1,[r0,#0x4]	@TSAポインタ SkillAnimation[skill_id].tsa_list
	str r1, [r4, #0x4c]
	str r1, [r4, #0x50]
	
	ldr	r1,[r0,#0x8]	@画像ポインタ SkillAnimation[skill_id].image_list
	str r1, [r4, #0x54]
	
	ldr	r1,[r0,#0xC]	@パレットポインタ SkillAnimation[skill_id].palette_list
	str r1, [r4, #0x58]

exit: @フック時に壊してしまう命令の再送
	ldr r3,=0x08056158	@フレームとTSA画像による魔法のアニメ 
	mov r14, r3
	.short 0xf800

	ldr r0, [r4, #0x5c] @ pointer:08603B74 -> 08071C65

	ldr r3,=0x0805b058   @GetCoreAIStruct
	mov r14, r3
	.short 0xf800

	ldr	r3,=0x08070BA0+1	@元に戻す
	mov pc,r3

.align
.ltorg
adr:
