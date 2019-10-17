.thumb


@0x02ad3c
@イクリプス等の直前(自分の数値と相手の数値の計算後)
@ステータス画面では呼ばれない
@相手の数値に影響を与える処理群
.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _bldr reg, dest
	ldr \reg, =\dest
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm


    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1
    
    bl DistantGuard
    cmp r0, #0
    bne endZero
    bl WarSkill
    
    mov	r0, r6
    ldr r1, adr+16 @見切り
    _blr r1
    cmp r0, #0
    bne next
    
    bl shisen
    
next:
    
    bl godBless

Return:
    ldr r5, [r4, #76]
    ldr r0, =0x0802ad44
    mov r15, r0
endZero:
    mov r0, #0
    mov r1, r4
    add r1, #90
    strh r0, [r1] @威力
    
    mov r0, #0x7F
    mov r1, r6
    add r1, #92
    strh r0, [r1] @防御
    pop {r4, r5, r6}
    pop {r0}
    bx r0


WarSkill:
    push {lr}
	mov r0, #67
	ldrb r0, [r4, r0]
	mov r1, #0xFE
	and r0, r1
	cmp r0, r1
	bne endWar

	mov r1, r4
	add r1, #90
	ldrh r0, [r1]
	add r0, #8
	strh r0, [r1] @攻撃増加
	
	mov r1, r4
	add r1, #100
	ldrh r0, [r1]
	add r0, #20
	cmp r0, #100
	ble jumpWar
	mov r0, #100
jumpWar:
	strh r0, [r1] @命中増加
endWar:
	pop {pc}

DistantGuard:
    push {lr}
    mov r0, r6
    ldr r1, adr+0 @遠距離無効
    _blr r1
    cmp r0, #0
    beq endDistantGuard
    
    ldr r0, =0x0203a4d2
    ldrb r0, [r0] @距離
    cmp r0, #1
    beq endDistantGuard
    
    mov r0, #1
    .short 0xE000
endDistantGuard:
    mov r0, #0
    pop {pc}

godBless:
    push {lr}
    mov r0, r4
    ldr r1, adr+4 @光の加護
    _blr r1
    cmp r0, #0
    bne endBless
    
    mov r0, r6
    ldr r1, adr+8 @暗黒の加護
    _blr r1
    cmp r0, #0
    beq endBless

    mov r1, #90
    ldrh r0, [r4, r1] @威力
    asr r0, r0, #1
    strh r0, [r4, r1] @威力

    mov r0, #1
    .short 0xE000
endBless:
    mov r0, #0
    pop {pc}

shisen:
    push {lr}
    mov r0, r4
    ldr r1, adr+12 @死線
    _blr r1
    cmp r0, #0
    beq falseShisen
    
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] @自分
    mov r1, r4
    mov r0, #94
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #94
    strh r0, [r1] @自分
    
    mov r1, r6
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] @相手
    mov r0, #1
    b endShisen
falseShisen:
    mov r0, #0
endShisen:
    pop {pc}

.ltorg
adr:

