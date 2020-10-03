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

    ldr r0, LUNATIC_SKILL
    cmp r0, #0
    beq elseLunatic
    
    ldrb r1, [r3, #0xB]
    mov r0, #0x80
    and r0, r1
    beq elseLunatic     @敵以外

    ldr r0, =0x0202bcec
    ldrb r1, [r0, #20]
    mov r0, #64         @難易度ハード
    and r0, r1
    beq elseLunatic     @ハード以外

    ldr r0, [r3, #4]
    ldrb r0, [r0, #4]
    ldr r1, LUNATIC_TABLE
    ldrb r0, [r1, r0]
    b endUnit

elseLunatic:
    mov r0, #0
endUnit:
    bx lr

LUNATIC_SKILL = addr+0
LUNATIC_TABLE = addr+4

.align
.ltorg
addr:
