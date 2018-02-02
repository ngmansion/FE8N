
@thumb
@define RETURN_ADR $0802a4a6
	lsl	r0, r0, #16
	lsr	r3, r0, #16
	lsl	r1, r1, #24
	asr	r2, r1, #24
	ldr r0, =$0802a4b4
	ldr	r0, [r0]
	ldrh	r1, [r0, #0]
	mov	r0, #2
	and	r0, r1
	beq	start ;独自処理
	mov	r0, r2
	bx	lr
start:
    mov r0, lr ;戻りアドレス確認
;除外判定
    cmp r2, #0
    bne return ;r2は謎。通常は0が入る筈。気味が悪いから0なら除外
    ldr r1, =$0802b40B ;必殺は対象外
    cmp r0, r1
    beq return
    ldr r1, =$0802b607	;デビルアクスも対象外
    cmp r0, r1
    beq return
;除外判定終了
	push	{r3, lr}    ;;;;;;;;
	mov	r3, sp
	ldr r2, =$0802AFD1 ;汎用
	ldr r1, =$0802aff9 ;連続専用
loop ;加攻撃者アドレス取得ループ
	ldr	r0, [r3]
	cmp	r0, r2
	beq	gotA ;汎用
	cmp	r0, r1
	beq	gotR ;連続専用
	add	r3, #4
	b	loop
return:
    push {lr}
    ldr	r0, =RETURN_ADR
    mov	pc, r0
gotR: ;連続用
    mov r2, r6
    b hokan
    
gotA: ;汎用
    sub r3, #4
    ldr r2, [r3] ;加攻撃者アドレス取得
hokan:
    ldr r3, =$0203a568 ;被攻撃者アドレス補間
    cmp r2, r3
	bne check
	ldr r3, =$0203a4e8 ;被攻撃者アドレス補間
check:
;大盾チェック
	mov	r0, sp
	ldr	r0, [r0, #24]
	ldr	r1, =$0802B3B9	;;(元の)大盾は専用
	cmp	r0, r1
	beq	Reverse
;独自チェック
	mov	r0, r10
	cmp	r0, #0xDF
	beq	Reverse
	b	nonTATE
Reverse
	eor r3, r2
	eor r2, r3
	eor r3, r2
nonTATE:
;トライアングルチェック
    ldr r0, =$0203a604
    ldr r0, [r0]
    ldr r0, [r0]
    mov r1, #128
    lsl r1, r1, #3
    and r0, r1
    beq nonTri
    mov r0, #0
    str r0, [sp] ;r3
    b end
nonTri:    ;見切りチェック
    mov r0, r3
        push {r2}
        @align 4
        ldr r3, [adr]
        mov lr, r3
        @dcw $F800
        pop {r2}
    cmp r0, #0
    beq toking
    mov r0, #0
    str r0, [sp+4] ;r3
    
toking: ;王の器チェック
    mov r0, r2
        push {r2}
        @align 4
        ldr r3, [adr+4] ;王の器
        mov lr, r3
        @dcw $F800
        pop {r2}
    cmp r0, #0
    beq togod
    ldr r0, [sp] ;r3
    add r0, #10
    str r0, [sp] ;r3
    
togod: ;神の器チェック
    mov r0, r2
        push {r2}
        @align 4
        ldr r3, [adr+12] ;神の器
        mov lr, r3
        @dcw $F800
        pop {r2}
    cmp r0, #0
    beq toace
    ldr r0, [sp] ;r3
    add r0, #30
    str r0, [sp] ;r3
    
toace: ;勇将チェック
    mov r0, r2
        push {r2}
        @align 4
        ldr r3, [adr+8] ;勇将
        mov lr, r3
        @dcw $F800
        pop {r2}
	cmp	r0, #0
	beq	end
gotAC:
	ldrb	r0, [r2, #0x13]	;NOW
	ldrb	r1, [r2, #0x12]	;MAX
	lsl	r0, r0, #1
	cmp	r0, r1
	bgt	end
	ldr	r0, [sp] ;r3
	add	r0, #30
	str	r0, [sp] ;r3
end
    mov r2, #0
    pop {r3}
    ldr r0, =RETURN_ADR
    mov pc, r0

;non
;	pop	{r3}
;	mov	r0, #0
;	bx	lr
;0x8反撃
;0x4追撃

@ltorg
adr:
