.thumb
ATK = (0x0203a4e8)
DEF = (0x0203a568)
FIRST_ATTACKED_FLAG     = (0b10000000)
COMBAT_HIT              = (0b01000000)  @命中
RAGING_STORM_FLAG       = (0b00100000)
DEFEAT_FLAG             = (0b00010000)

b IsTempSkillFlag
nop
b TurnOnTempSkillFlag
nop
b TurnOffTempSkillFlag
nop


IsTempSkillFlag:
    ldr r2, =DEF
    cmp r1, r2
    beq startIS
    ldr r2, =ATK
startIS:
    cmp r0, #0
    beq zeroIS
    cmp r0, #1
    beq oneIS
    cmp r0, #2
    beq twoIS
    cmp r0, #3
    beq threeIS
    mov r0, #0
    b endIS
zeroIS:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #FIRST_ATTACKED_FLAG
    and r0, r1
    beq endIS
    mov r0, #1
    b endIS
oneIS:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #COMBAT_HIT
    and r0, r1
    beq endIS
    mov r0, #1
    b endIS
twoIS:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #RAGING_STORM_FLAG
    and r0, r1
    beq endIS
    mov r0, #1
    b endIS
threeIS:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #DEFEAT_FLAG
    and r0, r1
    beq endIS
    mov r0, #1
    b endIS
    nop
endIS:
    bx lr


TurnOnTempSkillFlag:
    ldr r2, =DEF
    cmp r1, r2
    beq startON
    ldr r2, =ATK
startON:
    cmp r0, #0
    beq zeroON
    cmp r0, #1
    beq oneON
    cmp r0, #2
    beq twoON
    cmp r0, #3
    beq threeON
    b endON
zeroON:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #FIRST_ATTACKED_FLAG
    orr r0, r1
    strb r0, [r2]
    b endON
oneON:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #COMBAT_HIT
    orr r0, r1
    strb r0, [r2]
    b endON
twoON:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #RAGING_STORM_FLAG
    orr r0, r1
    strb r0, [r2]
    b endON
threeON:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #DEFEAT_FLAG
    orr r0, r1
    strb r0, [r2]
    b endON
    nop
endON:
    bx lr


TurnOffTempSkillFlag:
    ldr r2, =DEF
    cmp r1, r2
    beq startOFF
    ldr r2, =ATK
startOFF:
    cmp r0, #0
    beq zeroOFF
    cmp r0, #1
    beq oneOFF
    cmp r0, #2
    beq twoOFF
    cmp r0, #3
    beq threeOFF
    cmp r0, #0xFF
    beq clearOFF
    b endOFF
zeroOFF:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #FIRST_ATTACKED_FLAG
    bic r0, r1
    strb r0, [r2]
    b endOFF
oneOFF:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #COMBAT_HIT
    bic r0, r1
    strb r0, [r2]
    b endOFF
twoOFF:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #RAGING_STORM_FLAG
    bic r0, r1
    strb r0, [r2]
    b endOFF
threeOFF:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #DEFEAT_FLAG
    bic r0, r1
    strb r0, [r2]
    b endOFF
clearOFF:
    add r2, #71
    ldrb r0, [r2]
    mov r1, #FIRST_ATTACKED_FLAG
    bic r0, r1
    mov r1, #COMBAT_HIT
    bic r0, r1
    mov r1, #RAGING_STORM_FLAG
    bic r0, r1
    mov r1, #DEFEAT_FLAG
    bic r0, r1
    strb r0, [r2]
endOFF:
    bx lr



