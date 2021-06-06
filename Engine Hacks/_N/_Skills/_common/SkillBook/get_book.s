.thumb
@スキル書で習得したユニットのブックID(スキルIDではない)を取得する
@I  r0 = ベースアドレス
@   r1 = 0 is Skill1, 1 is Skill2, ...
@O  r0 = BookID
    push {r4, lr}
    mov r2, r0
    mov r4, r1

    ldr r3, MAX_BOOK_DATA_NUM
    cmp r1, r3
    bge false
@▼本処理
    cmp r1, #0
    bne expand
@▼1スキル
    bl get_unitSkill
    bl EncodeSkill      @スキル1はスキルIDが入っているので、ブックIDに変換する
    b end
expand:
@▼2-5スキル
    bl get_unitSkillEx
    b end
end:
    .short 0xE000
false:
    mov r0, #0
    pop {r4, pc}
    
    
get_unitSkill:
    push {lr}       @get_bookskillにもあり。
    mov r1, #0x3A
    ldrb r0, [r1, r0]
    pop {pc}
    
get_unitSkillEx:
    push {lr}
    mov r0, r2
    bl getExSkillBaseAdr
    cmp r0, #0
    beq falseEx   @Exスキルは自軍のみ
    mov r1, r4
    bl getExSkillFromBaseAdr
falseEx:
    pop {pc}
    
getExSkillFromBaseAdr:
@I  r0 = ユニットのセーブベースアドレス
@   r1 = SkillIndex
@O  r0 = SkillID
    cmp r1, #1
    beq one
    cmp r1, #2
    beq two
    cmp r1, #3
    beq three
    cmp r1, #4
    beq four
    mov r0, #0
    b returnExSkillFromBaseAdr
one:                    @スキル2
    ldrb r0, [r0]
    b endExSkillFromBaseAdr
two:                    @スキル3
    ldrb r1, [r0]
    lsr r1, r1, #6
    ldrb r2, [r0, #1]
    lsl r2, r2, #2
    orr r1, r2
    mov r0, r1
    b endExSkillFromBaseAdr
three:                    @スキル4
    ldrb r2, [r0, #1]
    lsr r2, r2, #4
    ldrb r1, [r0, #2]
    lsl r1, r1, #4
    orr r2, r1
    mov r0, r2
    b endExSkillFromBaseAdr
four:                    @スキル5
    ldrb r0, [r0, #2]
    lsr r0, r0, #2
    b endExSkillFromBaseAdr
    nop
endExSkillFromBaseAdr:
    mov r1, #0b00111111     @IDをビットマスク
    and r0, r1
returnExSkillFromBaseAdr:
    bx lr

getExSkillBaseAdr:
    ldr r3, addr+0
    mov pc, r3
EncodeSkill:
    ldr r3, addr+0
    add r3, #2
    mov pc, r3
DecodeSkill:
    ldr r3, addr+0
    add r3, #4
    mov pc, r3

MAX_BOOK_DATA_NUM = addr+4

.align
.ltorg
addr:



