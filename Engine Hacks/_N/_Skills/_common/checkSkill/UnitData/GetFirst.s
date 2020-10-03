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

    ldr r0, [r3]
    add r0, #0x26
    ldrb r0, [r0]
    bx lr
.align
.ltorg
addr:
