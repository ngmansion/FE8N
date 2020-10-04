.thumb
@.org 0802cbc4
    and r1, r0
    cmp r1, #0
    beq goto

    mov r1, r4
    add r1, #125
    mov r0, #1
    strb r0, [r1, #0]

goto:
    bl main
    cmp r0, #1
    beq skill_active

    bl main2
    cmp r0, #1
    beq skill_active    @スキル発動かつ回数0

    ldr r1, =0x0802cbd2
    mov pc, r1

skill_active:
    ldrh r0, [r5, #0]
    ldr r1, =0x0802cbda
    mov pc, r1


main:
        mov r0, r4
        ldrh r1, [r5]
        ldr r2, addr
        mov pc, r2

STAFF = (4)

main2:  @武器破壊
        push {lr}

        ldrh r0, [r5, #0]
        bl GetItemSpecies
        cmp r0, #STAFF
        bne falseMain2      @杖以外

        ldr r0, =0x0203a568
        mov r1, r4
        bl IsEnemy
        cmp r0, #0
        beq falseMain2               @味方ならジャンプ

        ldr r0, =0x0203a568
        mov r1, r4
        bl HAS_CORROSION
        cmp r0, #0
        beq falseMain2      @不発

        ldrh r0, [r5, #0]
        bl $00016894            @杖・道具減少
        strh r0, [r5, #0]
        lsl r0, r0, #16
        lsr r0, r0, #16         @破損しない武器対応
        bne falseMain2          @残っているなら飛ぶ

        mov r0, #1              @スキル発動かつ回数0
        .short 0xE000
    falseMain2:
        mov r0, #0
        pop {pc}

IsEnemy:
        ldrb r0, [r0, #0xB]
        ldrb r1, [r1, #0xB]
        mov r2, #0x80
        and r0, r2
        and r1, r2
        cmp r0, r1
        beq notEnemy
        mov r0, #1
        .short 0xE000
    notEnemy:
        mov r0, #0
        bx lr
        


$00016894:
    ldr r1, =0x08016894
    mov pc, r1

GetItemSpecies:
    ldr r1, =0x080172f0
    mov pc, r1

HAS_CORROSION:
    ldr r3, addr+4
    mov pc, r3

.align
.ltorg
addr:
