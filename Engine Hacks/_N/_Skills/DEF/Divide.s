.thumb
@r0 = 減算結果
@r1 = 攻撃側
@r2 = 守備側
@
@[out]
@
@r0 = 計算結果
@
        push {r4, r5, r6, lr}
        cmp r0, #0
        ble end   @半減不要
        mov r6, r0
        mov r4, r1
        mov r5, r2

        mov r0, r5
        mov r1, r4
        bl HasGodShield
        cmp r0, #0
        beq jump1
        bl divide   @相手(r5)が神盾所持
    jump1:
        bl WaryFighter
        cmp r0, #0
        beq jump2
        bl divide
    jump2:
        mov r0, r6
    end:
        pop {r4, r5, r6, pc}

WaryFighter:
        push {lr}
        ldrb r0, [r5, #0xb]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        ldrb r1, [r1, #0xb]
        cmp r0, r1
        beq falseWaryFighter
    @r4が攻め。r5が守備隊形の場合、この攻撃は半減
        mov r0, r5
        mov r1, r4
        bl HasWaryFighter
        b endWaryFighter
    falseWaryFighter:
        mov r0, #0
    endWaryFighter:
        pop {pc}

divide:
    mov r0, r6
    asr r0, r0, #1
    bne not_div
    mov r0, #1
not_div:
    mov r6, r0
    bx lr
    pop {pc}

HasGodShield:
ldr r2, addr+0
mov pc, r2
HasWaryFighter:
ldr r2, addr+4
mov pc, r2

.align
.ltorg
addr:


