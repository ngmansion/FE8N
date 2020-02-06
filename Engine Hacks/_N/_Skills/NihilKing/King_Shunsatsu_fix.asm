ORACLE_FLAG = (0x9A) @暗殺目印

.thumb
.org	0x0802a490
random:

.org	0x0802b2fc
	push	{lr}
	mov r0, r1
	bl fodes_func
	beq	false
	ldr	r1, data_Addr
	ldrh	r0, [r1, #14]
	cmp	r0, #0
	beq	false
@奥義目印
    mov r1, #ORACLE_FLAG
    mov r10, r1
	mov	r1, #0
	bl	random @@r0=確率, r1=#0 乱数
@	lsl	r0, r0, #24
@	asr	r0, r0, #24
	cmp	r0, #1
	beq end
false:
	mov	r0, #0
end:
	pop	{pc}
fodes_func:
	ldr r3, addr
	mov pc, r3
.align
.ltorg
addr:


.org 0x0802b340
data_Addr:

