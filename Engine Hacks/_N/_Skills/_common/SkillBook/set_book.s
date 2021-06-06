@変更時はGetSkillも同時に修正する事

DATA_MASK = 0b00111111

.thumb
@I  r0 = ベースアドレス
@   r1 = 0 is Skill1, 1 is Skill2, ...
@   r2 = セットするBookデータ
@   
    push {r4, r5, lr}
    mov r5, r2
    mov r2, r0
    mov r4, r1

    ldr r3, MAX_BOOK_DATA_NUM
    cmp r1, r3
    bge false
@▼本処理
    cmp r1, #0
    bne expand
@▼1スキル
    mov r0, r5      @r0にbookdata
    mov r5, r2      @r5にベースアドレス
    bl DecodeSkill
    bl set_unitSkill
    b end
expand:
@▼2-5スキル
    mov r3, #DATA_MASK
    and r5, r3
    bl set_unitSkillEx
    b end
false:
    mov r0, #0
end:
    pop {r4, r5, pc}
    
    
set_unitSkill:
    mov r1, #0x3A      @set_booksKillにもあり。
    strb r0, [r5, r1]
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
@I  r0 = ユニットのセーブベースアドレス
@   r1 = SkillIndex
@O  r0 = SkillID
    mov r2, r0
    cmp r1, #1
    beq one
    cmp r1, #2
    beq two
    cmp r1, #3
    beq three
    cmp r1, #4
    beq four
    b end2
one:    @スキル2
    ldrb r0, [r2, #0]
    mov r3, #0b00111111
    bic r0, r3
    
    orr r0, r5
    strb r0, [r2, #0]
    b end2
two:    @スキル3
@@@@@@
    ldrb r0, [r2, #0]
    mov r3, #0b11000000
    bic r0, r3

    mov r1, r5
    mov r3, #0b00000011
    and r1, r3

    lsl r1, r1, #6

    orr r0, r1
    strb r0, [r2, #0]
@@@@@@
    ldrb r0, [r2, #1]
    mov r3, #0b00001111
    bic r0, r3

    mov r1, r5
    mov r3, #0b11111100
    and r1, r3

    lsr r1, r1, #2

    orr r0, r1
    strb r0, [r2, #1]

    b end2
three:    @スキル4
@@@@@@@@@
    ldrb r0, [r2, #1]
    mov r3, #0b11110000
    bic r0, r3

    mov r1, r5
    mov r3, #0b00001111
    and r1, r3
    
    lsl r1, #4

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
four:    @スキル5
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
DecodeSkill:
    ldr r3, addr+0
    add r3, #4
    mov pc, r3
MAX_BOOK_DATA_NUM = addr+4

.align
.ltorg
addr:



