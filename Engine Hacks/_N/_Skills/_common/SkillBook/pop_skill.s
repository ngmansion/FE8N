
.thumb
popSkill:
@I  r0 = ベースアドレス
@O  r0 = 取得したBookData。0は失敗。
@
    push {r4, r5, lr}
    mov r4, r0
    bl popSkill_impl
    pop {r4, r5, pc}


popSkill_impl:
@▼本処理
    push {lr}
    mov r5, #0
loop:
    ldr r3, MAX_MANUAL_SKILL_NUM
    cmp r5, r3
    bge FALSE_impl
    mov r0, r4
    mov r1, r5
    bl GET_BOOK_SKILL
    cmp r0, #0
    beq loop_end
    add r5, #1
    b loop
loop_end:
    mov r3, r0

    mov r0, r4
    mov r1, r5
    mov r2, #0

    mov r4, r3
    bl SET_BOOK

    mov r0, r4
    b END_impl

FALSE_impl:
    mov r0, #0
END_impl:
    pop {pc}

GET_BOOK:
    ldr r3, addr+0
    mov pc, r3

SET_BOOK:
    ldr r3, addr+4
    mov pc, r3

MAX_MANUAL_SKILL_NUM = addr+8

.align
.ltorg
addr:

