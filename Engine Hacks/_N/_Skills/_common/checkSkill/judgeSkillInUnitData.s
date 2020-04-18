.thumb
    push {r4, lr}
    mov r4, r0
	mov r2, r1

    ldr r0, [r4]
    add r0, #0x26
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
@上級スキルチェック
    ldr r1, [r4, #4]
    ldr r1, [r1, #40]
    ldr r0, =0x100
    and r0, r1
    beq jumpUnit
    ldr r0, [r4]
    add r0, #0x27
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
jumpUnit: @自軍以外チェック
    ldrb r1, [r4, #0xB]
    mov r0, #0xC0
    and r0, r1
    bne elseUnit

    ldrb r0, [r4, #8]
    cmp r0, #20
    ble elseLevel     @レベル20以下なら終了
elseUnit:
    ldr r0, [r4]
    add r0, #0x31
    ldrb r0, [r0]
    cmp r0, r2
    beq ouiUnit
elseLevel:
@@@@@@@@@@@@@@@@@ルナティック

    ldr r0, LUNATIC_SKILL
    cmp r0, #0
    beq elseLunatic
    
    ldrb r1, [r4, #0xB]
    mov r0, #0x80
    and r0, r1
    beq elseLunatic     @敵以外

    ldr r0, =0x0202bcec
    ldrb r1, [r0, #20]
    mov r0, #64		@難易度ハード
    and r0, r1
    beq elseLunatic     @ハード以外

    ldr r0, [r4, #4]
    ldrb r0, [r0, #4]
    ldr r1, LUNATIC_TABLE
    ldrb r0, [r1, r0]

    cmp r0, r2
    beq ouiUnit

elseLunatic:
    mov r0, #0
    pop {r4, pc}
ouiUnit:
    mov r0, #1
endUnit:
    pop {r4, pc}

LUNATIC_SKILL = addr+0
LUNATIC_TABLE = addr+4

.align
.ltorg
addr:
