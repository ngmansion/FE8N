@define METIS (0x89)
@define METIS_EFFECT (0x2E)  ;メティスの書の効果ID

@define GET_WEAPON_EFFECT ($080174e4)
@define GET_WEAPON_MT ($08017384)

@define MAX_NUM ADR+0
@define GETSKILL ADR+4
@define CONTAINSKILL ADR+8
@define DEDUPUNIT ADR+12
@define JUDGEUNIT ADR+16

@thumb
	push {r4, r5, lr}
	mov r4, r0
	mov r5, r1
	lsl r0, r1, #24
	lsr	r0, r0, #24
	cmp r0, METIS
	beq meti
	b scroll
meti:
	ldr	r0, [r4, #12]
	mov	r1, #128
	lsl	r1, r1, #6
	and	r0, r1
	cmp	r0, #0
	bne	cant_use
	b	can_use
scroll:
    
goto:
    mov r0, r5
    ldr r1, =GET_WEAPON_EFFECT
    mov lr, r1
    @dcw $F800
    cmp r0, METIS_EFFECT
    bne cant_use
    
    mov r0, r5
    ldr r1, =GET_WEAPON_MT
    mov lr, r1
    @dcw $F800

    cmp r0, #255
    bne not_eraser
;消滅処理
    mov r2, %111111
    ldrh r1, [r4, #0x3A]
    and r1, r2
    bne can_use ;何かあるから消せる
    b cant_use
    
not_eraser:
	mov r5, r0
	
	mov r0, r4
	mov r1, r5
	bl ex_containsSkill
	cmp r0, #1 ;1なら習得済み
	beq cant_use
	mov r0, r4
	mov r1, r5
	bl ex_judgeUnit
	cmp r0, #1 ;1なら習得済み
	beq cant_use
	
	mov r0, r4
@align 4
	ldr r1 [MAX_NUM]
	sub r1, 1
	bl ex_getSkill
	cmp r0, #0
	beq can_use	;まだ余裕があるから使える
	
	mov r0, r4
@align 4
	ldr r1 [MAX_NUM]
	bl ex_dedupUnit
	@align 4
	ldr r1 [MAX_NUM]
	cmp r0, r1
	bne can_use	;ダブりがあるなら使える
cant_use:
    mov r0, #1 ;使用不可
    b end
can_use:
    mov r0, #0 ;使用可能
end:
    pop {r4, r5, pc}
@align 4
@ltorg
ex_containsSkill:
	ldr r3, [CONTAINSKILL]
	mov pc, r3
ex_getSkill:
	ldr r3, [GETSKILL]
	mov pc, r3
ex_dedupUnit:
	ldr r3, [DEDUPUNIT]
	mov pc, r3
ex_judgeUnit:
	ldr r3, [JUDGEUNIT]
	mov pc, r3
ADR:
	

