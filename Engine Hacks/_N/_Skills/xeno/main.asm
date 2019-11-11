.thumb
@;0002ae54
@
@
@
    ldr r2, =0x0203AB40 @;スキルアニメ拡張の初期化
    mov r0, #0x0
    str r0, [r2] @;スキルアニメ記録のリセット

    ldr r2, =0x0203a5e8
    mov r0, #0x0
    str r0, [r2] @;フラグリセット
    
    ldr r0, =0x0203a4d0
    ldrh r2, [r0]
    mov r0, #2
    and r0, r2
    cmp r0, #0
    bne return @;戦闘予測なら終了
    mov r0, #0x20
    and r0, r2
    bne return @;闘技場なら終了
@;突撃
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl Charge
@;ジェノサイド
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl Zeno
return:
    ldr r3, [r6]
    ldr r1, [r3]
    lsl r1, r1, #8
    lsr r1, r1, #27
    ldr r0, =0x0802ae5c
    mov pc, r0

Zeno:
	push {r5, r6, lr}
	mov r5, r0
	mov r6, r1

	mov r2, #72
	ldrh r2, [r6, r2]
	cmp r2, #0
	beq falseXeno @;相手が反撃不可(自分が反撃不可はあり得ないの前提)
@;攻め側
	mov r0, r5
	mov r1, r6
	bl HasZeno
	cmp r0, #0
	bne firstXeno
@;受け側
	mov r0, r6
	mov r1, r5
	bl HasZeno
	cmp r0, #0
	bne secondXeno
	b falseXeno
firstXeno:
    mov r0, r5
    mov r1, r6
    bl Zeno_impl
    b retZeno
secondXeno:
    mov r0, r6
    mov r1, r5
    bl Zeno_impl
    b retZeno
falseXeno:
	nop
retZeno:
	pop {r5, r6, pc}
	

HasZeno:
    push {r4, lr}
    mov r4, r0
    
    mov r0, r1
        ldr r1, adr
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne notZeno
    mov r0, r4
        ldr r1, adr+4 @;zeno
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq notZeno
    ldrb r0, [r4, #0x13] @;nowHP
        ldr r1, =0x08000c78
        mov lr, r1
        .short 0xF800
    lsl r0, r0, #24
    asr r0, r0, #24
    b endZeno
notZeno:
    mov r0, #0
endZeno:
    pop {r4, pc}

Zeno_impl:
    mov r3, r0
    ldr r2, =0x0203a5e8
    ldrb r0, [r3, #11]	@;部隊表ID取得
    strb r0, [r2]
    
    add r1, #100
    ldrb r0, [r1]
    sub r0, #20
    strb r0, [r1]
    
    mov r1, #90
    ldsb r0, [r3, r1]
    add r0, #10
    strb r0, [r3, r1]
    
    mov r1, #94
    ldsb r0, [r3, r1]
    add r0, #3
    strb r0, [r3, r1]
    
    bx lr

Charge:
	push {r5, r6, lr}
	mov r5, r0
	mov r6, r1
@;
	mov r0, r5
	mov r1, r6
	bl HasCharge
	cmp r0, #0
	bne trueCharge
@;
	mov r0, r6
	mov r1, r5
	bl HasCharge
	cmp r0, #0
	bne trueCharge
	b falseCharge
	
trueCharge:
	mov r0, #0xFF
	ldr r2, =0x0203a5e8 @;無効部隊表IDストア(非ジェノサイド)
	strb r0, [r2]
	b retCharge
falseCharge:
	nop
retCharge:
    pop {r5, r6, pc}



HasCharge:
    push {r4, lr}
    mov r4, r0
    mov r2, #94
    ldsh r0, [r4, r2]
    ldsh r2, [r1, r2]
    cmp r0, r2
    ble notCharge @;速さが足りない！
    ldrb r0, [r4, #0x13]
    ldrb r2, [r1, #0x13]
    cmp r0, r2
    ble notCharge @;HPが足りない！

    
    mov r0, r1
        ldr r1, adr	@;見切り
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne notCharge
    mov r0, r4
        ldr r1, adr+8 @;突撃
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq notCharge
    mov r0, #1
    b endCharge
notCharge:
    mov r0, #0
endCharge:
    pop {r4, pc}
.align
.ltorg
adr:
