.thumb
max_num             = (5)

Vanish:

        mov r1, #0
        ldr r3, =0x02026a84
        ldr r3, [r3]
    loopStart:
        cmp r1, #max_num
        bgt falseVanish                 @特定のエミュレータでのフリーズを回避する為
@@@@以下暫定エラーチェック
        ldr r2, [r3, #0x2C]     @描写中ユニット
        lsr r0, r2, #24
        cmp r0, #0x02           @02アドレス以外なら無視
        bne continueVanish

        ldrb r0, [r2, #18]  @maxHP
        ldrb r2, [r2, #19]
        cmp r0, r2
        blt continueVanish
        ldr r2, [r3, #0x2C]     @描写中ユニット

        ldrb r0, [r2, #3]
        cmp r0, #0x08           @08/09アドレス以外なら無視(ユニットデータ)
        beq skip1Vanish
        cmp r0, #0x09
        bne continueVanish
    skip1Vanish:

        ldrb r0, [r2, #7]
        cmp r0, #0x08           @08/09アドレス以外なら無視(クラスデータ)
        beq skip2Vanish
        cmp r0, #0x09
        bne continueVanish
    skip2Vanish:

@@@@ユニットID判定
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #27]  @選択中

        ldrb r2, [r2, #0xB]     @部隊表ID
        cmp r0, r2
        beq trueVanish
        
    continueVanish:
        ldr r3, [r3, #0x20] @08002D7C
        cmp r3, #0          @08002D7E
        beq falseVanish             @08002D80
        add r1, #1
        b loopStart

    trueVanish:
        mov r0, #1          @0以外ならなんでも
        add r3, #0x40
        strb r0, [r3]
    falseVanish:
        bx lr


