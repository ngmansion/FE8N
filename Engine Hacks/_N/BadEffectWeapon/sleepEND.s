.thumb
@.org	0x0802b824

	mov	r0, #111
	ldrb	r0, [r5, r0]
	lsl	r0, r0, #28
	lsr	r0, r0, #28
	cmp	r0, #2
	beq	$0802b836       @スリープで終了

    mov r0, r5
    bl GetReverseStatus
    add r0, #72
    ldrh r0, [r0]

    bl GET_WEAPON_EFFECT
	cmp	r0, #5
	bne notStone

	mov	r0, #111
	ldrb	r0, [r5, r0]
	lsl	r0, r0, #28
	lsr	r0, r0, #28
	cmp	r0, #11
	beq	$0802b836           @石化武器かつ相手が石化なら
notStone:
	mov	r0, #111
	ldrb	r0, [r5, r0]
	lsl	r0, r0, #28
	lsr	r0, r0, #28
	cmp	r0, #13
	bne	$0802b860
	ldr	r4, =0x0802b85c
	ldr	r4, [r4]
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	mov	r0, #2
	orr	r1, r0
	lsl	r1, r1, #3
	ldrb	r2, [r3, #2]
	mov	r0, #7
	and	r0, r2
	orr	r0, r1
	strb	r0, [r3, #2]
	ldr	r0, [r4, #0]
	add	r0, #4
	str	r0, [r4, #0]
	mov	r0, #1
	ldr r3, =0x0802b86a
	mov pc, r3

GetReverseStatus:
        ldr r1, =0x0203a4e8
        cmp r0, r1
        beq zero_is_atk
        mov r0, r1
        .short 0xE000
    zero_is_atk:
        ldr r0, =0x0203a568
        bx lr

$0802b836:
ldr r3, =0x0802b836
mov pc, r3

$0802b860:
ldr r3, =0x0802b860
mov pc, r3

GET_WEAPON_EFFECT:
ldr r1, =0x080174cc
mov pc, r1

.align
.ltorg
ADDR:
