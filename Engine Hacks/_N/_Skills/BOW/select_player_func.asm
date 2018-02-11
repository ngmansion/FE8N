@thumb
;@org $08016e7c
    push {lr}
    mov r1, #255
    and r0, r1
    lsl r1, r0, #3
    add r1, r1, r0
    lsl r1, r1, #2
    ldr r0, =$080172d4	;アイテムテーブル(説明ID)
    ldr r0, [r0]
    add r1, r1, r0
    ldrb r0, [r1, #25]		;射程ロード
;;;;;▽撃破捕獲追加処理▽
    ldr r1, [r6, #12]	;捕獲
    mov r3,#0x80
    lsl r3, r3,#0x17
    tst r1, r3
    bne one
;;;;;△撃破捕獲追加処理△
    ldr r1, [r6, #4]
    ldrb r1, [r1, #4]
    cmp r1, #0x1B
    beq magi
    cmp r1, #0x1C
    beq magi
    cmp r1, #0x1D
    beq tikai
    cmp r1, #0x1E
    beq tikai
    b end
one	;捕獲フラグがオン
    mov r0, #0x11
    b end
magi	;神射手
    cmp r0, #0x22
    bne end
    add r0, #1
    b end
tikai ;近接射撃
    cmp r0, #0x11
    beq end
    cmp r0, #0x12
    beq end
    sub r0, #0x10
    b end
end
    ldr	r3, =$08016e8e
    mov	pc, r3




