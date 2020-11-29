.thumb
main:
        push {r4, r5, lr}
        mov r4, r0
        ldr r0, [r4, #44]
        ldrh r5, [r0, #18]
        ldr r0, GET_COMBAT_INDEX
        ldrb r0, [r0]
        cmp r0, #0
        beq normal
        cmp r0, #1
        beq normal

        bl GetSelectiongID
        cmp r0, #3
        bne notOracle
        mov r5, #0x6C   @リフ
    notOracle:
        mov r1, r4
        add r1, #78
        strh r5, [r1]

        mov r0, #0x20
        ldr r1, GET_SETTING_HELP_POSITION
        strb r0, [r1]

        bl GetSkillHelp
        mov r1, r4
        add r1, #76
        strh r0, [r1]
        pop {r4, r5, pc}
    normal:
        ldr r0, =0x0808b5b4
        mov pc, r0

GetSkillHelp:
        ldr r0, GET_COMBAT_INDEX
        ldrb r0, [r0]
        sub r0, #2
        ldr r1, GET_COMBAT_ADDR
        ldrb r0, [r0, r1]   @ID取得
        ldr r1, GET_ICON_LIST_SIZE
        mul r0, r1
        ldr r1, GET_ICON_LIST
        add r0, r1
        ldr r1, GET_ICON_LIST_HELP_OFFSET
        ldrh r0, [r0, r1]
        bx lr

GetSelectiongID:
        push {r4, lr}
        mov r4, r0
        sub r4, #2
        ldr r0, GET_COMBAT_ADDR
        ldrb r0, [r4, r0]
        bl GET_COMBAT_ARTS_TYPE
        pop {r4, pc}

GET_COMBAT_ADDR = addr+0
GET_COMBAT_INDEX = addr+4
GET_ICON_LIST = addr+8
GET_ICON_LIST_SIZE = addr+12
GET_ICON_LIST_HELP_OFFSET = addr+16
GET_SETTING_HELP_POSITION = addr+20
GET_COMBAT_ARTS_TYPE:
    ldr r1, addr+24
    mov pc, r1

.align
.ltorg
addr:
