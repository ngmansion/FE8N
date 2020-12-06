PRESS_INPUT_ADR = (0x085775cc)


.thumb
@0802f740
	cmp r0, #0x89
	beq	metis
	bl getItemEffect
	cmp r0, #0x2E
	beq manual
	ldr	r1, =0x0802f760 @その他のアイテムへ
	mov pc, r1
metis:
	b meti
	
manual:
    mov r0, r6
	bl getItemATK
    cmp r0, #255
    bne not_eraser
@▼消す処理
	bl Eraser
    
    mov r0, r4
    mov r1, r7
        ldr r3, =0x080186a8
        mov lr, r3
        .short 0xF800
    ldr r0, ADR+4 @使用後の説明
    ldr r1, =0x0802f858
    mov pc, r1
@▼スキル書の処理
    
not_eraser:
    mov r6, r0
	ldr r1, MAX_NUM
	sub r1, #1
	mov r0, r4
	bl ex_getSkill
	cmp r0, #0
	beq go_normal	@まだ余裕があるから使える
    
    mov r0, r4
    bl ex_dedupSkill
	ldr r1, MAX_NUM
	cmp r0, r1
	beq return	@重複も存在しない場合はreturnへ
    
    mov r1, r0
    mov r0, r4
    bl ex_removeSkill
    
go_normal:
    mov r0, r4
    mov r1, r6
    bl ex_pushSkill

return:
	mov	r0, r4
        ldr r1, =0x080186a8
        mov lr, r1
    mov r1, r7
    .short 0xF800

    ldr r0, ADR @使用後の説明
    ldr r1, =0x0802f858
    mov pc, r1
    
meti:
@▼メティスの書
	ldr	r0, [r4, #12]
	mov	r1, #128
	lsl	r1, r1, #6
	orr	r0, r1
	str	r0, [r4, #12]
	mov	r0, r4
ldr	r1, =0x0802f750
mov pc, r1


Eraser:
@スキルを削除する
@削除したスキルを書にする
@
	push {lr}
@重複チェック
	mov r0, r4
	ldr r1, MAX_NUM
	bl ex_dedupSkill
	ldr r1, MAX_NUM
	cmp r0, r1
@	bne dedup	@重複が存在する場合は最優先で抽出
@ボタンチェック
    ldr r0, =PRESS_INPUT_ADR
	ldr	r0, [r0]
	ldrh	r1, [r0, #4]
	mov	r0, #4
	and	r0, r1
	bne reverse
@末尾のスキルを抽出
    mov r0, r4
    bl ex_popSkill
    b merge
reverse:
@手前のスキルを抽出
        mov r0, r4
        mov r1, #0
        bl GET_BOOK_DATA
        mov r1, #0
        cmp r0, #0
        bne trueRemove     @何かあるから消せる
@@@@@@@@
        mov r0, r4
        mov r1, #1
        bl GET_BOOK_DATA
        mov r1, #1
        cmp r0, #0
        bne trueRemove
        b merge
trueRemove:
    mov r0, r4
    bl ex_removeSkill
    b merge
dedup:
@重複スキルを削除
	mov r1, r0
    mov r0, r4
    bl ex_removeSkill
merge:
    bl GetMatchingSkillBook
    mov r0, r4
    add r0, #0x1E
    lsl r1, r7, #1
    add r0, r0, r1
    strb r5, [r0]		@スキルの書のIDをストア。
    mov r1, #2			@この後に減算処理があるため、
    strb r1, [r0, #1]	@残り回数を1回にするには回数2をストア。
    cmp r5, #0
    bne notVanish
    mov r1, #1
    strb r1, [r0, #1]
notVanish:
    pop {pc}

GetMatchingSkillBook:
        push {lr}
        cmp r0, #0
        beq falseMatching
        mov r6, r0
        mov r5, #0 @カウンタ
    nextMatching:
            add r5, #1
            cmp r5, #255
            bgt falseMatching

            mov r0, r5
            bl getItemEffect
            cmp r0, #0x2e
            bne nextMatching

            mov r0, r5
            bl getItemATK
            cmp r0, #0
            beq nextMatching

            cmp r0, r6
            beq trueMatching
            b nextMatching
    falseMatching:
        mov r5, #0
    trueMatching:
        pop {pc}

getItemEffect:
	ldr r1, =0x080174E4
	mov pc, r1
getItemATK:
	ldr r1, =0x08017384
	mov pc, r1



MAX_NUM = ADR+8
GETSKILL = ADR+12
DEDUPSKILL = ADR+16
PUSHSKILL = ADR+20
POPSKILL = ADR+24
REMOVESKILL = ADR+28

ex_getSkill:
	ldr r3, GETSKILL
	mov pc, r3
ex_dedupSkill:
	ldr r3, DEDUPSKILL
	mov pc, r3
ex_pushSkill:
	ldr r3, PUSHSKILL
	mov pc, r3
ex_popSkill:
	ldr r3, POPSKILL
	mov pc, r3
ex_removeSkill:
	ldr r3, REMOVESKILL
	mov pc, r3
GET_BOOK_DATA:
	ldr r3, ADR+32
	mov pc, r3

.align
.ltorg
ADR:

