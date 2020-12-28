.thumb
icon_num_limit = (8) @上限数

@.org   0x08089268

    push {r4, r5, r6, r7, lr}
@画像
    bl Initialize

    ldr r0, =0x0203a4e8
    ldr r1, =0x02003B00
    mov r2, #icon_num_limit
    bl GATHER_SKILL

    mov r1, r0
    ldr r0, =0x02003B00
    ldr r2, ICON_POSITION
    bl DrawIcon
    pop {r4, r5, r6, r7, pc}


DrawIcon:
        push {lr}
        mov r4, r0
        mov r5, r1
        mov r6, r2
        mov r7, #0
    loopDraw:
        cmp r7, r5
        bge endDraw

        ldrb r1, [r4, r7]

        ldr r3, SKL_TBL     @skl_icon_table
        ldr r0, ICON_LIST_SIZE
        mul r0, r1
        add r3, r3, r0

        ldr r2, =0x100
        add r1, r2
        mov r2, #0xA0       @color

        ldrb r3, [r3, #2]
        cmp r3, #0xFF
        bne jump
        mov r2, #0x80
    jump:
        lsl r2, r2, #7
        mov r0, r6
        bl $08003608

        ldr r0, ICON_GAP
        add r6, r6, r0      @Icon position increment

        add r7, #1
        b loopDraw

    endDraw:
        pop {pc}

Initialize:
        push {lr}
        cmp r0, #0
        beq skipDraw
        mov r4, #0
        ldr r0, EQUIPMENT_POSITION_ADDR
        ldr r0, [r0]

        ldr r6, =0x00007060
        mov r5, r6
        ldr r1, =0x000002c2
        add r2, r0, r1
        add r6, #8
        mov r3, r6
        ldr r6, =0x00000302
        add r1, r0, r6
    loopE:
        add r0, r4, r5
        strh r0, [r2, #0]
        add r0, r4, r3
        strh r0, [r1, #0]
        add r2, #2
        add r1, #2
        add r4, #1
        cmp r4, #7
        ble loopE
    skipDraw:
        pop {pc}


$08003608:
    ldr r3, =0x08003608
    mov pc, r3

GATHER_SKILL:
    ldr r3, ADDR+0
    mov pc, r3
ICON_POSITION      = ADDR+4
SKL_TBL                 = (ADDR+8)
ICON_LIST_SIZE          = (ADDR+12)
ICON_GAP                = (ADDR+16)
EQUIPMENT_POSITION_ADDR = (ADDR+20)

.align
.ltorg
ADDR:
