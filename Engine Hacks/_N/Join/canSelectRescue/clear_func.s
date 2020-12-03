.thumb
RETURN_ADDR_FALSE   = (0x0802289c)
RETURN_ADDR_TRUE    = (0x08022874)
MAX_NUM             = (9)

Vanish:
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #27]  @選択中
        mov r1, #0

        ldr r3, =0x02026a84
        ldr r3, [r3]
    loopStart:
        cmp r1, #MAX_NUM
        bgt END                 @特定のエミュレータでのフリーズを回避する為
        ldr r2, [r3, #0x2C]     @描写中ユニット
        ldrb r2, [r2, #0xB]     @部隊表ID
        cmp r0, r2
        beq vanishEND
        ldr r3, [r3, #0x20]
        cmp r3, #0
        beq END
        add r1, #1
        b loopStart
    vanishEND:
        mov r0, #1          @0以外ならなんでも
        add r3, #0x40
        strb r0, [r3]
    END:
        bx lr
