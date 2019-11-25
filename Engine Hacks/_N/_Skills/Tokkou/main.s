TRUE = (1)
FALSE = (0)

EFFECTIVE_BONUS1 = Adr+40
EFFECTIVE_BONUS2 = Adr+44
EFFECTIVE_BONUS3 = Adr+48
EFFECTIVE_BONUS4 = Adr+52

.thumb
@org 08016a30
	push {lr}
	push {r4, r5}
	mov r4, r0
	mov r5, r1
	bl Nihil
	cmp r0, #TRUE
	beq END
	b main
END:
	pop {r4, r5}
	pop {pc}
RETURN:
	mov r5, #0	@加算なし
	ldr r0, =0x0802aa6e
	mov pc, r0

main:
		mov r0, r4
		ldr r0, Adr
		ldr r1, Adr+16
		ldr r2, EFFECTIVE_BONUS1
		bl Effector
		cmp r0, #TRUE
		beq result

		ldr r0, Adr+4
		ldr r1, Adr+20
		ldr r2, EFFECTIVE_BONUS2
		bl Effector
		cmp r0, #TRUE
		beq result

		ldr r0, Adr+8
		ldr r1, Adr+24
		ldr r2, EFFECTIVE_BONUS3
		bl Effector
		cmp r0, #TRUE
		beq result
	
		ldr r0, Adr+12
		ldr r1, Adr+28
		ldr r2, EFFECTIVE_BONUS4
		bl Effector
		cmp r0, #TRUE
		beq result
		mov r0, #FALSE

	result:
		pop {r4, r5}
		cmp r0, #FALSE
		beq jump
		mov r5, r1	@TRUEなら結果をr5に設定
	jump:
		b RETURN

Effector:
@	r0 = 飛び先
@	r1 = 特効対象
@	r2 = 倍率
@
@	r0 = TRUE/FALSE
@	r1 = 威力
		push {r4, lr}
		mov r4, r2
		bl checkEffective
		cmp r0, #FALSE
		beq endEffector
		mov r0, r4
		mov r1, #90
		ldsh r1, [r5, r1]
		bl Calculator
		mov r1, r0
		mov r0, #TRUE
	endEffector:
		pop {r4, pc}

checkEffective:
@	r0 = 飛び先
@	r1 = 特効対象
@	
@	r0 = TRUE/FALSE
		push {r4, lr}
		mov r4, r1
		mov lr, r0
		.short 0xF800
		cmp r0, #FALSE
		beq endEffective	@スキル未所持
		mov r1, r4
		bl effect_test
		cmp r0, #FALSE
		beq endEffective	@非特効対象
		mov r0, #TRUE	@成功
	endEffective:
		pop {r4, pc}
	
effect_test:
		ldr r3, [r5, #4]
		ldrb r3, [r3, #4]
		b effective_loop
	back:
		ldrb r0, [r1, #0]
		cmp r0, r3
		beq true
		add r1, #1
	effective_loop:
		ldrb r0, [r1, #0]
		cmp r0, #0
		bne back
		mov r0, #FALSE
		b false
	true:
		mov r0, #TRUE
	false:
		bx lr

Calculator:
		cmp r0, #0
		beq multiplication
		cmp r0, #1
		beq multiplication
		cmp r0, #2
		beq multiplication
		cmp r0, #3
		beq multiplication
		cmp r0, #4
		beq multiplication
		add r0, r1
		b endCalculator
	multiplication:
		mul r0, r1
	endCalculator:
		bx lr

Nihil:
		push {lr}
		mov r0, r5
			ldr r1, Adr+32 @相手見切り
			mov lr, r1
			.short 0xF800
		cmp r0, #1
		beq trueNihil
		
		mov r0, r4
			ldr r1, Adr+32 @自分見切り
			mov lr, r1
			.short 0xF800
		cmp r0, #1
		beq falseNihil
		
		mov r0, r5
			ldr r1, Adr+36 @相手練達
			mov lr, r1
			.short 0xF800
		cmp r0, #1
		beq trueNihil
	falseNihil:
		mov r0, #FALSE
		b endNihil
	trueNihil:
		mov r0, #TRUE
	endNihil:
		pop {pc}

.align
.ltorg
Adr:
