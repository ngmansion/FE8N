

.org 0x016894
.thumb
	
	push {lr}
	mov r2, r0
	bl func
	mov r3, r1	@アドレス保持
	lsr r1, r2, #8
	beq check	@既に回数ゼロなので減算しない

	lsl r0, r0, #28
	bmi nonBreak	@耐久無限(減算and消滅してはいけない)
	ldr r1, =0xffffff00
	add r2, r2, r1	@減算
	cmp	r2, #255
	bgt nonBreak	@ゼロではない
check:
	mov r0, r3
	bl checkBreak
	cmp r0, #0
	beq end	@消滅（ゼロ応答）
nonBreak:
	mov r0, r2
end:
	pop {pc}

checkBreak:
	ldr r1, pointer
	mov pc, r1
.align
.ltorg
pointer:

.org 0x017314
func:
