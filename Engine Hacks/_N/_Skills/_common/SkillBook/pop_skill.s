
.thumb
popSkill:
@I  r0 = ベースアドレス
@O  r0 = 取得したBookData。0は失敗。
@
popSkill_impl:
@▼本処理
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r5, #0
    mov r6, #0
loop:
    ldr r3, MAX_MANUAL_SKILL_NUM
    cmp r5, r3
    bge FALSE_impl
    mov r0, r4
    mov r1, r5
    bl GET_BOOK_DATA
    cmp r0, #0
    beq check_loop          @末尾かもしれない
    mov r6, r0
    b continue_loop
check_loop:
    mov r0, r4
    mov r1, r5
    bl GET_BOOK_SKILL
    cmp r0, #0
    beq loop_end
    b continue_loop
    nop
continue_loop:
    add r5, #1
    b loop

loop_end:
    mov r0, r4
    sub r1, r5, #1
    mov r2, #0
    bl SET_BOOK

    mov r0, r6
    b END_impl

FALSE_impl:
    mov r0, #0
END_impl:
    pop {r4, r5, r6, pc}

GET_BOOK_SKILL:
    ldr r3, addr+0
    mov pc, r3
SET_BOOK:
    ldr r3, addr+4
    mov pc, r3
MAX_MANUAL_SKILL_NUM = addr+8
GET_BOOK_DATA:
    ldr r3, addr+12
    mov pc, r3

.align
.ltorg
addr:

