@変更時はGetSkillも同時に修正する事

DATA_MASK = 0b00111111

.thumb
@I	r0 = ベースアドレス
@	r1 = 0 is Skill1, 1 is Skill2, ...
@	r2 = セットするデータ
@	
	push {r4, r5, lr}
	mov r5, r2
	mov r2, r0
	mov r4, r1

	ldr r3, MAX_MANUAL_SKILL_INDEX
	cmp r1, r3
	bge false
	mov r3, #DATA_MASK
	and r5, r3
@▼本処理
	cmp r1, #1
	bgt expand
@▼1-2スキル
	bl set_unitSkill
	b end
expand:
@▼3-6スキル
	bl set_unitSkillEx
	b end
end:
@    bl DecodeSkill
    .short 0xE000
false:
	mov r0, #0
	pop {r4, r5, pc}
	
	
set_unitSkill:	@いつか作る？
	bx lr
	
set_unitSkillEx:
	push {lr}
	mov r0, r2
	bl getExSkillBaseAdr
	cmp r0, #0
	beq falseEx   @Exスキルは自軍のみ
	mov r1, r4
	bl setExSkillToBaseAdr
falseEx:
	pop {pc}
	
setExSkillToBaseAdr:
@I	r0 = ユニットのセーブベースアドレス
@	r1 = SkillIndex
@O	r0 = SkillID
	mov r2, r0
	cmp r1, #2
	beq three
	cmp r1, #3
	beq four
	cmp r1, #4
	beq five
	cmp r1, #5
	beq six
	b end2
three:
	ldrb r0, [r2, #0]
	mov r3, #0b00111111
	bic r0, r3
	
	orr r0, r5
	strb r0, [r2, #0]
	b end2
four:
@@@@@@
	ldrb r0, [r2, #0]
	mov r3, #0b11000000
	bic r0, r3

	mov r1, r5
	mov r3, #0b000011
	and r1, r3

	lsl r1, r1, #6

	orr r0, r1
	strb r0, [r2, #0]
@@@@@@
	ldrb r0, [r2, #1]
	mov r3, #0b00001111
	bic r0, r3

	mov r1, r5
	mov r3, #0b111100
	and r1, r3

	lsr r1, r1, #2

	orr r0, r1
	strb r0, [r2, #1]

	b end2
five:
@@@@@@@@@
	ldrb r0, [r2, #1]
	mov r3, #0b11110000
	bic r0, r3

	mov r1, r5
	mov r3, #0b001111
	and r1, r3

	orr r0, r1
	strb r0, [r2, #1]
@@@@@@@@@@@
	ldrb r0, [r2, #2]
	mov r3, #0b00000011
	bic r0, r3

	mov r1, r5
	mov r3, #0b110000
	and r1, r3

	lsr r1, r1, #4

	orr r0, r1
	strb r0, [r2, #2]

	b end2
six:
	ldrb r0, [r2, #2]
	mov r3, #0b11111100
	bic r0, r3

	lsl r1, r5, #2

	orr r0, r1
	strb r0, [r2, #2]

end2:
	bx lr

getExSkillBaseAdr:
	ldr r3, addr+0
	mov pc, r3

MAX_MANUAL_SKILL_INDEX = addr+4

.align
.ltorg
addr:



