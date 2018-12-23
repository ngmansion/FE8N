@define ORACLE_FLAG 0xDD ;奥義目印

@thumb
@org	$0802b2fc
	push	{lr}
	ldr	r0, [r1, #4]
	ldr	r1, =$0203a4d0
	ldrb	r0, [r0, #4]
	cmp	r0, #0x66	;;クラス魔王は瞬殺不可
	beq	non
	ldrh	r0, [r1, #14]
	cmp	r0, #0
	beq	non
;奥義目印
    mov r1, ORACLE_FLAG
    mov r10, r1
	mov	r1, #0
	bl	$0802a490 ;;r0=確率, r1=#0 乱数
;	lsl	r0, r0, #24
;	asr	r0, r0, #24
	cmp	r0, #1
	beq	goto
non
	mov	r0, #0
	b	end
goto
	mov	r0, #1
end
	pop	{pc}