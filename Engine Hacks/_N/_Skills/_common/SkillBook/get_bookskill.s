.thumb
@I  r0 = ベースアドレス
@   r1 = 0 is Skill1, 1 is Skill2, ...
@O  r0 = skillID
    push {lr}
    bl GET_MAX_BOOKSKILL_NUM_R2
    cmp r1, r2
    bge FALSE
    cmp r1, #0
    beq rawData
    bl GET_BOOK
    bl DECODE_BOOK
    b END
rawData:
    mov r1, #0x3A       @get_bookにもあり。
    ldrb r0, [r1, r0]
    b END
FALSE:
    mov r0, #0
END:
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



