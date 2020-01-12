.thumb

Faire:
    push {lr}
    bl JudgeFaire
    cmp r0, #1
    bne falseFaire
    bl GetFairePow
    b endFaire
falseFaire:
    mov r0, #0
endFaire:
	pop {pc}

JudgeFaire:
        push {r4, lr}
        mov r4, r0
        mov r1, #0
        bl HasFaire
        cmp r0, #1
        bne falseJudge  @スキル未所持

        mov r0, r4
        bl GetEquipment
        lsl r0, r0, #16
        lsr r0, r0, #16
        bl GetWeaponSp
        mov r1, r0
        bl GetFaireSp
        cmp r0, r1
        bne falseJudge  @武器種類不一致
        mov r0, #1
        b endJudge
    falseJudge:
        mov r0, #0
    endJudge:
        pop {r4, pc}

GetEquipment:
ldr r1, =0x080168d0
mov pc, r1

GetWeaponSp:
ldr r1, =0x080172f0
mov pc, r1

GetFaireSp:
ldr r0, addr
bx lr

GetFairePow:
ldr r0, addr+4
bx lr

HasFaire:
    ldr r2, addr+8
    mov pc, r2
.align
.ltorg
addr:

