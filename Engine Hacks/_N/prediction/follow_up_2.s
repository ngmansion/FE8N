.thumb

    push {r0, lr}

    bl SetR1Addr

    bl main
    cmp r0, #1
@   bne not_follow_up   @1以外なら追撃不可
    pop {r0, pc}

main:
        push {r4, lr}
        sub sp, #8
        mov r4, r0

        str r0, [sp]
        str r1, [sp, #4]

        mov r0, sp          @ポインタ渡し
        add r1, sp, #4      @ポインタ渡し
        bl $0002af00    @=追撃関連

        cmp r0, #0
        beq nextInitial      @追撃無しなので終了
        ldr r0, [sp]
        cmp r0, r4
        bne nextInitial      @相手の追撃なので終了
        mov r0, #1
        .short 0xE000
    nextInitial:
        mov r0, #0
        add sp, #8
        pop {r4, pc}

SetR1Addr:
        ldr r1, =0x0203a568
        cmp r0, r1
        bne endSet
        ldr r1, =0x0203a4e8
    endSet:
        bx lr

$0002af00:
    ldr r2, =0x0802af00
    mov pc, r2


