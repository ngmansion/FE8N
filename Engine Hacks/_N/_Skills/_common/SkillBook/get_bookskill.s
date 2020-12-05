.thumb
@I  r0 = ベースアドレス
@   r1 = 0 is Skill1, 1 is Skill2, ...
@O  r0 = skillID
    push {lr}
    bl GET_MAX_BOOKSKILL_NUM_R2
    cmp r1, r2
    bge END

    bl GET_BOOK
    bl DECODE_BOOK
    pop {pc}
END:
    mov r0, #0
    pop {pc}

DECODE_BOOK:
    ldr r3, addr+0
    add r3, #4
    mov pc, r3
GET_BOOK:
    ldr r3, addr+4
    mov pc, r3
GET_MAX_BOOKSKILL_NUM_R2:
    ldr r2, addr+8
    bx lr

.align
.ltorg
addr:



