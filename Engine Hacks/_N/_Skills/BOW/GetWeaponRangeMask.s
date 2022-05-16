.thumb
@org $08016e7c

RETURN_ADDR = 0x08016e8e

        push {lr}
        mov r3, r0
        mov r1, #255
        and r0, r1
        lsl r1, r0, #3
        add r1, r1, r0
        lsl r1, r1, #2
        ldr r0, =0x080172d4     @アイテムテーブル(説明ID)
        ldr r0, [r0]
        add r1, r1, r0
        ldrb r0, [r1, #25]  @射程ロード
@@@@▽撃破捕獲追加処理▽
        ldr r1, [r6, #12] @捕獲
        mov r2,#0x80
        lsl r2, r2,     #0x17
        tst r1, r2
        bne one         @捕獲フラグがオン
@@@@△撃破捕獲追加処理△
        ldr r1, [r6, #4]
        ldrb r1, [r1, #4]
        cmp r1, #0x1B
        beq distant
        cmp r1, #0x1C
        beq distant
        cmp r1, #0x1D
        beq close
        cmp r1, #0x1E
        beq close
        b next
    one:
        mov r0, #0x11
        b end
    distant:    @神射手
        cmp r0, #0x22
        bne next
        add r0, #1
        b next
    close:      @近接射撃
        cmp r0, #0x11
        beq next
        cmp r0, #0x12
        beq next
        sub r0, #0x10
        b next

    next:
    end:
        ldr r3, =RETURN_ADDR
        mov pc, r3

.align
.ltorg
ADDR:



