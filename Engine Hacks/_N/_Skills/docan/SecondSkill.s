.thumb
A_EFFECT = (0x0203a604)

@0802B3A4
	bl main

@    mov r1, #6
@    ldsh r0, [r5, r1]
@    mov r9, r0
    ldr r3, =0x0802b3ac
    mov pc, r3

main:
		push {lr}
		ldr	r5, A_ALINA
		ldrh r0, [r5]
		mov r1, #0x20
		and r0, r1
		bne end @闘技場チェック
	
		mov r0, r8
		ldrb r0, [r0, #0xB]
			ldr r1, =0x08019108
			mov lr, r1
			.short 0xF800
		cmp r0, #0
		beq end	@壁
		
		bl cancel

		bl ikari

        bl CancelRadiance
	end:
		pop {pc}

    
cancel:
	    push {lr}
	@除外条件
	    mov r0, r7
		mov r1, r8
			ldr r2, ADDRESS @キャンセル
			mov lr, r2
			.short 0xF800
	    cmp r0, #0
	    beq falseCancel

		mov r0, #0
		mov r1, r8
		add r1, #106
		strh r0, [r1]	@必殺ゼロ

		mov r0, #94
		ldrh r0, [r7, r0]
		mov r1, r8
		add r1, #94
		ldrh r1, [r1]
		cmp r0, r1
		bgt falseCancel	@自分の方が速い

		mov r1, r8
		add r1, #94
		strh r0, [r1]	@相手攻速減少
	falseCancel:
		pop {pc}

CancelRadiance:
        push {lr}
    @除外条件
        ldr r0, =A_EFFECT
        ldr r0, [r0]
        ldr r0, [r0]
        lsl r0, r0, #29
        bmi falseCancelR            @追撃時は無意味なので不発

    @キャンセル発動条件
        mov r0, r7
        mov r1, #0
        bl HAS_CANCEL_RADIANCE
        cmp r0, #0
        beq falseCancelR

        mov r0, #0x15
        ldsb r0, [r7, r0]           @技％
        lsl r0, r0, #16
        lsr r0, r0, #16
        mov r1, #0
        bl RANDOM                   @r0=確率, r1=#0で乱数
        lsl r0, r0, #24
        asr r0, r0, #24
        cmp r0, #0
        beq falseCancelR

    @キャンセル発動
        mov r0, #0
        mov r1, r8
        add r1, #72
        strh r0, [r1]           @相手装備消去
        strb r0, [r1, #10]      @相手武器消滅防止
    falseCancelR:
        pop {pc}

ikari: @怒り
	    push {lr}
	    ldr r0, [r7, #76]
	    mov r1, #0xC0
	    and r0, r1
	    bne falseW @反撃不可武器と魔法剣は無視
	
	    mov r0, r7
	    add r0, #74
	    ldrh r0, [r0]
			ldr r1, B_WEAPON_ABILITY
			mov lr, r1
			.short 0xF800
	    cmp r0, #3
	    beq falseW @HP1武器は無視

		mov r0, r7
		mov r1, r8
		bl HasWrath
		cmp r0, #0
		beq falseW

		mov r0, r8
		mov r1, r7
		bl HasFortune
		cmp r0, #1
		beq falseW	@強運所持

	    mov r0, #0x13
	    ldrb r0, [r7, r0]	@現在HP
	    mov r1, #0x12
	    ldrb r1, [r7, r1]	@最大HP
	    lsl r0, r0, #1
	    cmp r0, r1
	    bgt falseW @HP分岐
	

	    ldrh r0, [r5, #12]
	    add r0, #50
	    strh r0, [r5, #12]
	falseW:
	    pop {pc}

.align
RANDOM:
    ldr r3, =0x0802a490
    mov pc, r3

HasWrath:
	ldr r2, ADDRESS+4 @怒り
	mov pc, r2
HasFortune:
	ldr r2, ADDRESS+8 @強運
	mov pc, r2
HAS_CANCEL_RADIANCE:
	ldr r2, ADDRESS+12 @キャンセル(蒼炎)
	mov pc, r2

.align
B_WEAPON_ABILITY:
.long 0x080174cc
A_EFFECT:
.long 0x0203a604
A_ALINA:
.long 0x0203a4d0

.ltorg
ADDRESS:
	