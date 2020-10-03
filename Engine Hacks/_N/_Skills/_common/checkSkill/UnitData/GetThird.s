@
@ユニットデータ内のスキルと高難度敵スキルの判定
@
@[in]
@r0 = ユニットデータ先頭アドレス
@
@[out]
@r0 = 0     FALSE
@   = else  Skill ID
@
.thumb
    mov r3, r0
@
@特殊条件スキルチェック
@
jumpUnit: @自軍以外チェック
    ldrb r1, [r3, #0xB]
    mov r0, #0xC0
    and r0, r1
    bne elseUnit

    ldrb r0, [r3, #8]
    cmp r0, #20
    ble FALSE       @レベル20以下なら終了
elseUnit:
    ldr r0, [r3]
    add r0, #0x31
    ldrb r0, [r0]
    b endUnit
FALSE:
    mov r0, #0
endUnit:
    bx lr

.align
.ltorg
addr:
