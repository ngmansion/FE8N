@Call 08070A24 (FE8J)
@仕様は、ドキュメントを読んでください。 skl_anime_table.event
@
.thumb
	mov		r0,#0x0  @攻撃側を取得
	ldr		r1, adr  @ get_skillanime_data 発動しているスキルの取得
	mov r14, r1
	.short 0xf800
	
	cmp		r0,#0x00
	beq		default_sound	@不明 ディフォルトアニメをそのまま利用

	ldr		r0,[r0,#0x10]	@スキル発動音 SkillAnimation[skill_id].playsound
	b		exit

default_sound:
	ldr		r0,=0x03D1

exit: @フック時に壊してしまう命令の再送
	mov r1, #0x80
	lsl r1 ,r1 ,#0x1
	ldr r2, [r7, #0x5c]
	
	ldr	r3,=0x08070A2C+1	@元に戻す
	mov pc,r3

.align
.ltorg
adr:
