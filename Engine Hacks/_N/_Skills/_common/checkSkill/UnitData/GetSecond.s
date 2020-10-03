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
@上級スキルチェック
@
    ldr r1, [r3, #4]
    ldr r1, [r1, #40]
    ldr r0, =0x100
    and r0, r1
    beq FALSE
    ldr r0, [r3]
    add r0, #0x27
    ldrb r0, [r0]
    .short 0xE000
FALSE:
    mov r0, #0
    bx lr

.align
.ltorg
addr:
