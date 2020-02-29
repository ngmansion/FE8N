.thumb

GetNowHpCustomized:
        push {r4, lr}
        mov r4, r0
        bl GET_MAX_HP
        ldrb r1, [r4, #19]
        cmp r1, r0
        ble endNowHp    @最大HPを超過していない
        strb r0, [r4, #19]  @現在HP上書き
        .short 0xE000
    endNowHp:
        mov r0, r1
        pop {r4, pc}

GET_MAX_HP:
ldr r1, =0x08018ea4
mov pc, r1
