PIERCE_FLG = (0x01)
SHIELD_FLG =  (0x02)
SURESTRIKE_FLG = (0x04)

.thumb
@.org	08070c30
	asr	r4, r0, #16
	
	ldr	r0,	=0x0203a4d2
	ldrb	r0, [r0]	@距離
	cmp	r0, #1
	beq	nonbreak	@直接攻撃なら通常処理
@
@貫通との同時していたらnashiへ
@

@	mov	r0, r7
@		ldr	r1, =0x0805af10
@		mov	lr, r1
@		.short	0xF800
@	mov	r1, r0
	mov	r1, #1	@上の処理は利用タイミングが違うらしく使えないので代用
	ldrh	r0, [r7, #14]	@反撃ターンが3になって欲しいが2になる…とりあえず放置
	sub	r0, #1
	lsl	r0, r0, #1
	add	r0, r0, r1
		ldr	r1, =0x08059864
		mov	lr, r1
		.short 0xF800
	lsl	r0, r0, #20
	lsr	r0, r0, #29
	mov r1, #(PIERCE_FLG | SHIELD_FLG)
	and r0, r1
	cmp	r0, r1
	bne	nonbreak	@大楯と貫通が同時発動してなければ通常処理 ← 必的のエフェクトを削除したので変更


nashi:	@片方エフェクトなし
	ldr	r0, =0x08070c66
	mov	pc, r0
nonbreak:
	cmp	r4, #0
	blt	nashi
	ldr	r0, [r6, #76]
	ldr	r1, =0x08070c38
	mov	pc, r1
	
	
	