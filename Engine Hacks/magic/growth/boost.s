
RETURN_ADR = (0x08017ddc)

.thumb
@08017dd4

@幸運
    ldrb r0, [r3, #18]
    strb r0, [r4, #25]
@魔力
    ldr r1, [r4, #4]
    add r1, #80
    ldrb r0, [r1]    @兵種魔力
    add r3, #50
    ldrb r1, [r3]    @ユニット魔力
    add	r0, r0, r1
    strb r0, [r4, #26]
@END
    strb r2, [r4, #8]
    mov	r0, r4
    ldr r1, =RETURN_ADR
    mov pc, r1
