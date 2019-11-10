PIERCE_FLG = (0x01)
SHIELD_FLG =  (0x02)
SURESTRIKE_FLG = (0x04)

@ORG	0x70b72
.thumb
	ldr	r0, =0x08603B18
	mov	r1, r8
	lsl	r1, r1, #20
	lsr	r1, r1, #29
	mov r2, #(PIERCE_FLG | SHIELD_FLG)
	and r1, r2
	cmp	r1, r2
	bne	nonbreak	@大楯と貫通が同時発動してなければ通常処理 ← 必的のエフェクトを削除したので変更
	mov r0, pc
	add r0, #(ADR - calc_adr)	@同時発動なら差し替え
calc_adr:
nonbreak:
	mov	r1, #3
	ldr	r2, =0x08070b74
	mov	pc, r2
.align
.ltorg
ADR:



