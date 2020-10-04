.thumb

    mov r4, r5
    add r4, #72
    ldrh r0, [r4, #0]    @外したらここを通らない
    bl $00016894           @ここで回数が減る
    strh r0, [r4, #0]    @減ったのをストア
    lsl r0, r0, #16
    lsr r0, r0, #16         @破損しない武器対応
    beq $0002b768

    mov r0, r5
    bl GetOpposite
    mov r1, r5
    bl HAS_CORROSION
    cmp r0, #0
    beq $0002b770

    mov r4, r5
    add r4, #72
    ldrh r0, [r4, #0]    @外したらここを通らない
    bl $00016894           @ここで回数が減る
    strh r0, [r4, #0]    @減ったのをストア
    lsl r0, r0, #16
    lsr r0, r0, #16         @破損しない武器対応
    bne $0002b770

$0002b768:      @戦闘中断
    ldr r3, =0x0802b768
    mov pc, r3

$0002b770:      @戦闘継続
    ldr r3, =0x0802b770
    mov pc, r3

GetOpposite:
        mov r1, r0
        ldr r0, =0x0203a4e8
        cmp r0, r1
        bne endOpposite     @不一致なら反対なのでそのまま
        ldr r0, =0x0203a568 @一致なら別のアドレス
    endOpposite:
        bx lr

$00016894:
    ldr r1, =0x08016894
    mov pc, r1

HAS_CORROSION:
    ldr r3, addr+0
    mov pc, r3

.align
.ltorg
addr:

