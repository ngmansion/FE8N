.thumb
@0802a834
STR_ADR = (67)	@書き込み先(AI1カウンタ)
    push {r0}
    bl DistantCounter
    pop {r1}
    cmp r0, #1
    beq Skip
    cmp r1, #0
    beq cancel @射程外
Skip:
    bl JudgeCancel
    cmp r0, #1
    beq cancel


    mov r1, r8
    ldrb r0, [r1, #0]
    cmp r0, #255
    bne end     @アイテム無し？？
cancel:
    ldr r0, =0x0802a840     @反撃不可
    mov pc, r0
end:
    ldr r0, =0x0802a84a
    mov pc, r0


JudgeCancel:
        push {lr}
        ldr r0, =0x0203a4d0
        ldrh r0, [r0]
        mov r1, #0x20
        and r0, r1
        bne falseCancel @闘技場チェック


        bl WindSweep
        cmp r0, #1
        beq trueCancel

    falseCancel:
        mov r0, #0
        .short 0xE000
    trueCancel:
        mov r0, #1
        pop {pc}



DistantCounter:
        push {lr}
        ldr r0, =0x0203a4d2
        ldrb r0, [r0]
        cmp r0, #1
        ble falseDistant        @近距離は終了

        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        ldrb r1, [r5, #11]
        cmp r0, r1
        beq falseDistant    @r5は攻撃者なので終了

        ldrh r0, [r4, #0]
        bl GET_ITEM_EFFECT
        bl GET_DISTANT_COUNTER_ITEM_EFFECT_ID_R1
        cmp r0, r1
        beq skipDistant

        ldrh r0, [r4, #0]
        bl GET_WEAPON_TYPE
        bl GET_DISTANT_COUNTER_INVALID_WEAPON_TYPE_R1
        cmp r0, r1
        beq falseDistant        @斧は終了
    skipDistant:

        mov r0, r5
        ldr r1, =0x0203a4e8
        bl HAS_DISTANT_COUNTER
        .short 0xE000
    falseDistant:
        mov r0, #0
        pop {pc}

WindSweep:
        push {lr}
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        ldrb r1, [r5, #11]
        cmp r0, r1
        beq falseWindSweep      @r5は攻撃者
    
        ldr r0, =0x0203a4e8
        mov r1, r5
        bl hasWindSweep
        cmp r0, #0
        beq falseWindSweep      @スキル無し

        mov r0, #1
        b endWindSweep
    falseWindSweep:
        mov r0, #0
    endWindSweep:
        pop {pc}


GET_WEAPON_TYPE:
ldr r1, =0x080172f0
mov pc, r1
GET_ITEM_EFFECT:
ldr r1, =0x080174e4
mov pc, r1
GET_WEAPON_EFFECT:
ldr r1, =0x080174cc
mov pc, r1

hasWindSweep:
ldr r2, addr
mov pc, r2

GET_DISTANT_COUNTER_ITEM_EFFECT_ID_R1:
ldr r1, addr+8
bx lr

HAS_DISTANT_COUNTER:
ldr r2, addr+12
mov pc, r2

GET_DISTANT_COUNTER_INVALID_WEAPON_TYPE_R1:
ldr r1, addr+16
bx lr

.align
.ltorg
addr:
