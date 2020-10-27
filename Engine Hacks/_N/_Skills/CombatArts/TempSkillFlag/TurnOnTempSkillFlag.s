.thumb
ATK = (0x0203a4e8)
DEF = (0x0203a568)
FIRST_ATTACKED_FLAG     = (0b10000000)
COMBAT_HIT              = (0b01000000)  @戦技発動フラグ
RAGING_STORM_FLAG       = (0b00100000)
DEFEAT_FLAG             = (0b00010000)

    ldr r2, =DEF
    cmp r1, r2
    beq start
    ldr r2, =ATK
start:
    cmp r0, #0
    beq zero
    cmp r0, #1
    beq one
    cmp r0, #2
    beq two
    cmp r0, #3
    beq three
    b end
zero:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #FIRST_ATTACKED_FLAG
    orr r0, r1
    strb r0, [r2]
    b end
one:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #COMBAT_HIT
    orr r0, r1
    strb r0, [r2]
    b end
two:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #RAGING_STORM_FLAG
    orr r0, r1
    strb r0, [r2]
    b end
three:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #DEFEAT_FLAG
    orr r0, r1
    strb r0, [r2]
    b end
    nop
end:
    bx lr


