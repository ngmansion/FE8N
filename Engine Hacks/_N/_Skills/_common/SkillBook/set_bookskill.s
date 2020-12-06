.thumb
@I	r0 = ベースアドレス
@	r1 = 0 is Skill1, 1 is Skill2, ...
@	r2 = セットするBookデータ
@	
    push {lr}
    bl GET_MAX_BOOKSKILL_NUM_R3
    cmp r1, r3
    bge FALSE
    cmp r1, #0
    beq rawData
    bl ENCODE_BOOK
    bl SET_BOOK

    b END
rawData:
    mov r1, #0x3A       @set_bookにもあり。
    strb r2, [r1, r0]
    b END
FALSE:
    mov r0, #0
END:
    pop {pc}

ENCODE_BOOK:
    ldr r3, addr+0
    add r3, #2
    mov pc, r3
DECODE_BOOK:
    ldr r3, addr+0
    add r3, #4
    mov pc, r3
SET_BOOK:
    ldr r3, addr+4
    mov pc, r3
GET_MAX_BOOKSKILL_NUM_R3:
    ldr r3, addr+8
    bx lr

.align
.ltorg
addr:



