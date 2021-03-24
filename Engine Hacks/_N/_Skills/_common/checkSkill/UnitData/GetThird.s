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
    bne judgeTYPE

    ldrb r0, [r3, #8]
    cmp r0, #20
    ble FALSE       @レベル20以下なら終了
elseUnit:
    ldr r0, [r3]
    add r0, #0x31
    ldrb r0, [r0]
    b endUnit

judgeTYPE:
    ldr r0, UNIT_SKILL3_TYPE
    cmp r0, #0
    beq elseUnit    @敵なら常に有効
    cmp r0, #1
    beq boss        @敵将なら常に有効

boss:
    ldr r0, [r3]
    ldr r1, [r3, #4]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
    ldr r1, =0x01008000
    and r0, r1
    bne elseUnit @敵将チェック
FALSE:
    mov r0, #0
endUnit:
    bx lr

UNIT_SKILL3_TYPE = addr+0

.align
.ltorg
addr:
