.thumb
@救出中ならTURE
@但し、運び屋所持かつ味方救出中ならFALSEで上書き
@見切り不可
@

@r0はユニットアドレス
    pop {r0}
    push {r1, r2, r3, r4, lr}
    mov r4, r0
    bl Savior
    cmp r0, #1
    beq false

    bl rescue_flag
    b RETURN
false:
    mov r0, #0
RETURN:
    cmp r0, #0
    pop {r1, r2 ,r3, r4, pc}

Savior:
@スキル所持and味方救出中ならTRUE
@
        push {lr}

        mov r0, r4
        mov r1, #0
        bl HasSavior
        cmp r0, #0
        beq falseSavior

        ldr r0, [r4, #12]
        mov r1, #0x10
        and r0, r1
        beq falseSavior @救出してない
        ldrb r0, [r4, #27]
        cmp r0, #0
        beq falseSavior   @救出してない

        mov r0, #1
        b endSavior
    falseSavior:
        mov r0, #0
    endSavior:
        pop {pc}


rescue_flag:
        ldr r0, [r4, #12]
        mov r1, #16
        and r0, r1
        beq false_flag
        mov r0, #1
        b end_flag
    false_flag:
        mov r0, #0
    end_flag:
        bx lr

HasSavior:
ldr r2, addr
mov pc, r2

.align
.ltorg
addr:
