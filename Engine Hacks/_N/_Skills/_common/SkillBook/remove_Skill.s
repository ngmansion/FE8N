

.thumb
remove_skill:
@I  r0 = ベースアドレス
@   r1 = 0 is Skill1, 1 is Skill2, ...消したいスキル。
@O  r0 = 消したBookData。0は失敗。
@
@ダブり取得がある場合、インデックスの大きいほうが誤削除される。
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r5, r1
    
    mov r1, r5
    ldr r2, Addr+16
    cmp r1, r2
    bge FALSE
@▼本処理▼
@▼getを使って消すスキルIDを取得
    mov r0, r4
    bl get_BookSkill
    cmp r0, #0
    beq FALSE
    bl EncodeSkill
    mov r5, r0
    mov r6, #0
    .short 0xe000
loop1:
    push {r0}
@▼popを使った探索処理
    mov r0, r4
    bl pop_skill
    cmp r0, #0
    beq loop2_st        @致命的なエラー
    add r6, #1
    cmp r0, r5
    bne loop1
    b loop2_st
loop2:
@▼pushを使った書き戻し処理
    pop {r1}
    mov r0, r4
    bl push_skill
loop2_st:
    sub r6, #1
    bhi loop2
@▼後処理▼
    mov r0, r5
    b END
FALSE:
    mov r0, #0
END:
    pop {r4, r5, r6, pc}    @BookDataを返すので、Decodeは不要

get_BookSkill:
    ldr r3, Addr
    mov pc, r3
push_skill:
    ldr r3, Addr+4
    mov pc, r3
pop_skill:
    ldr r3, Addr+8
    mov pc, r3
EncodeSkill:
    ldr r3, Addr+12
    add r3, #2
    mov pc, r3
DecodeSkill:
    ldr r3, Addr+12
    add r3, #4
    mov pc, r3

.align
.ltorg
Addr:

