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
    ldr r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne normal @闘技場チェック

    bl WindSweep
    cmp r0, #1
    beq cancel

@    bl WaryFighter
@    cmp r0, #1
@    beq cancel

normal:
    mov r1, r8
    ldrb r0, [r1, #0]
    cmp r0, #255
    bne end @アイテム無し？？
cancel:
    ldr r0, =0x0802a840	@反撃不可
    mov pc, r0
end:
    ldr r0, =0x0802a84a
    mov pc, r0

DistantCounter:
        push {lr}
        ldrh r0, [r4, #0]
        bl GET_ITEM_EFFECT
        ldr r1, DISTANT_ITEM_EFFECT_ID
        cmp r0, r1
        bne falseDistant

        ldr r0, =0x03004df0
        ldr r0, [r0]
        mov r1, #0
        bl HAS_NIHIL
        cmp r0, #1
        beq falseDistant

        mov r0, #1
        .short 0xE000
    falseDistant:
        mov r0, #0
        pop {pc}

GET_ITEM_EFFECT:
ldr r1, =0x080174e4
mov pc, r1

WaryFighter:
        push {lr}
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        ldrb r1, [r5, #11]
        cmp r0, r1
        beq falseWaryFighter @r5は攻撃者
        mov r0, r5
        ldr r1, =0x0203a4e8
        bl hasWaryFighter
        cmp r0, #0
        beq falseWaryFighter @スキル無し
        mov r0, #1
        b endWaryFighter
    falseWaryFighter:
        mov r0, #0
    endWaryFighter:
        pop {pc}

WindSweep:
        push {lr}
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #11]
        ldrb r1, [r5, #11]
        cmp r0, r1
        beq falseWindSweep @r5は攻撃者
    
        ldr r0, =0x0203a4e8
        mov r1, r5
        bl hasWindSweep
        cmp r0, #0
        beq falseWindSweep @スキル無し

        mov r0, #1
        b endWindSweep
    falseWindSweep:
        mov r0, #0
    endWindSweep:
        pop {pc}

hasWindSweep:
ldr r2, addr
mov pc, r2

hasWaryFighter:
ldr r2, addr+4
mov pc, r2

DISTANT_ITEM_EFFECT_ID = addr+8

HAS_NIHIL:
ldr r2, addr+12
mov pc, r2

.align
.ltorg
addr:
