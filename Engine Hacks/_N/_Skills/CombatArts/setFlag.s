.thumb
@ 0802a2bc

SOUND_ID = (97)
ATK = (0x0203a4e8)
DEF = (0x0203a568)
        
        
        ldr r0, =0x0802a2d8
        ldr r0, [r0]
        .short 0x2102
        .short 0x8001
        .short 0x9804
        .short 0x9000
        
        push {r2,r3}

        mov r0, r13
        ldr r0, [r0, #36]
        ldr r1, =0x08050803
        cmp r0, r1
        bne end @武器選択直前ではない

        mov r0, #0
        mov r1, r4
        bl SET_COMBAT_ART

        ldr r0, ADDR+4
        ldrb r0, [r0]
        cmp r0, #0
        beq end
        cmp r0, #1
        beq end
        
        bl GetSkill
        mov r1, r4
        bl SET_COMBAT_ART
@サウンド
        mov     r0, #SOUND_ID
        ldr     r1, =0x080d4ef4 @サウンド
        mov     lr, r1
        .short 0xf800
end:
    bl arrow_reset_func
    bl ClearTempFlag        @敵のフラグが消しきれない懸念。念のため

        pop {r2,r3}
        ldr r0, =0x0802a2c6
        mov pc, r0

GetSkill:
        ldr r2, ADDR+4
        ldrb r2, [r2]
        sub r2, #2
        ldr r1, ADDR
        ldrb r0, [r1, r2]
        bx lr



arrow_reset_func:
    ldr r0, ADDR
    mov r1, #0
    str r1, [r0]
    str r1, [r0, #4]
    str r1, [r0, #8]
    str r1, [r0, #12]
    bx lr

ClearTempFlag:          @saikoudou/main.sにもある
        push {lr}
        mov r0, #0xFF
        ldr r1, =ATK
        bl TURN_OFF_TEMP_SKILL_FLAG
        mov r0, #0xFF
        ldr r1, =DEF
        bl TURN_OFF_TEMP_SKILL_FLAG
        
        pop {pc}


SET_COMBAT_ART:
    ldr r2, ADDR+8
    mov pc, r2
TURN_OFF_TEMP_SKILL_FLAG:
    ldr r2, ADDR+12
    mov pc, r2

.align
.ltorg
ADDR:

