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
        bl HAS_GOD_SHIELD
        cmp r0, #0
        .short 0xD001
        bl divide   @相手(r5)が神盾所持

        mov r0, r6
    end:
        pop {r4, r5, r6, pc}

divide:
    mov r0, r6
    lsl r1, r0, #1
    add r0, r1
    mov r1, #5
    swi #6      @4割
    cmp r0, #0
    bgt not_div
    mov r0, #1
not_div:
    mov r6, r0
    bx lr

HAS_GOD_SHIELD:
ldr r2, addr+0
mov pc, r2

.align
.ltorg
addr:


