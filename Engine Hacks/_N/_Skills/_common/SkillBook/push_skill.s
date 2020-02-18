

.thumb
pushSkill:
@I	r0 = ベースアドレス
@	r1 = スキルID
@O	-
@
	push {r4, r5, r6, lr}
	mov r4, r0

    mov r0, r1
    @bl EncodeSkill
    mov r6, r0
	bl pushSkill_impl
	pop {r4, r5, r6, pc}
	
	
pushSkill_impl:
@▼本処理
	push {lr}
	mov r5, #0
loop:
	mov r0, r4
	mov r1, r5
	bl get_skill
	cmp r0, #0
	beq loop_end
	add r5, #1
	b loop
loop_end:
	mov r1, #0x3F	@%00111111
	and r6, r1
@indexごとの内部処理へ分岐
	cmp r5, #0
	beq one
	cmp r5, #1
	beq two
	cmp r5, #2
	beq three
	cmp r5, #3
	beq four
	cmp r5, #4
	beq five
	cmp r5, #5
	beq six
	b FALSE_impl
one:
two:
	mov r1, r5
	mov r0, r4
	mov r2, r6
	bl push_unitSkill
	b END_impl
three:
four:
five:
six:
	mov r0, r4
	bl getExSkillBaseAdr
	cmp r0, #0
	beq FALSE_impl
	
	mov r1, r5
	mov r2, r6
	bl push_unitSkillEx
	b END_impl
FALSE_impl:
	mov r0, #0
END_impl:
	pop {pc}
	
	
push_unitSkill:
@▼内部処理1
	mov r3, r0
	cmp r1, #1
	beq two_impl
@スキル1
    ldrh r0, [r3, #0x3A]
    mov r1, #0x3F	@%0000000000111111
    mvn r1, r1
    and r0, r1
    
    orr r0, r2
    strh r0, [r3, #0x3A]
	b end_unit
@スキル2:
two_impl:
    ldrh r0, [r3, #0x3A]
    ldr r1, =0xFC0	@%0000111111000000
    
    mvn r1, r1
    and r0, r1
    
    lsl r2, r2, #6
    orr r0, r2
    strh r0, [r3, #0x3A]

end_unit:
	bx lr
	
	
push_unitSkillEx:
@▼内部処理2
	mov r3, r0
	cmp r1, #2
	beq three_impl
	cmp r1, #3
	beq four_impl
	cmp r1, #4
	beq five_impl
	cmp r1, #5
	beq six_impl
	b end_unit_ex
three_impl:
	strb r2, [r3]
	b end_unit_ex
four_impl:
	ldrb r0, [r3]
	lsl r1, r2, #6
	orr r0, r1
	strb r0, [r3]
	
	lsr r1, r2, #2

	strb r1, [r3, #1]
	b end_unit_ex
	
five_impl:
	ldrb r0, [r3, #1]
	lsl r1, r2, #4
	
	orr r0, r1
	strb r0, [r3, #1]
	
	lsr r1, r2, #4
	strb r1, [r3, #2]
	b end_unit_ex
	
six_impl:
	ldrb r0, [r3, #2]
	lsl r1, r2, #2
	
	orr r0, r1
	strb r0, [r3, #2]
	b end_unit_ex
	nop
end_unit_ex:
	bx lr
	
get_skill:
	ldr r3, addr
	mov pc, r3
getExSkillBaseAdr:
	ldr r3, addr+4
	mov pc, r3
EncodeSkill:
    ldr r3, addr+4
    add r3, #2
    mov pc, r3
DecodeSkill:
    ldr r3, addr+4
    add r3, #4
    mov pc, r3
.align
.ltorg
addr:

