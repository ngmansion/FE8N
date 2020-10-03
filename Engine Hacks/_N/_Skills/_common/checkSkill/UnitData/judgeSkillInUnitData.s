@
@ユニットデータ内のスキルと高難度敵スキルの判定
@
@[in]
@r0 = ユニットデータ先頭アドレス
@r1 = Skill ID
@
@[out]
@r0 = 0   FALSE
@   = 1   TRUE
@
.thumb

        push {r4, r5, r6, lr}
        mov r4, r0
        mov r6, r1
.align
calc_addr:
        mov r5, #ADDR-calc_addr-10   @すぐ後で減算するので6ではなく10
        add r5, pc

@        sub r5, #4
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq FALSE

        mov r0, r4
        bl GoToR3
        cmp r0, r6      @一致確認
        beq TRUE
        b loop
    FALSE:
        mov r0, #0
        .short 0xE000
    TRUE:
        mov r0, #1
        pop {r4, r5, r6, pc}

GoToR3:
nop
mov pc, r3

.align
.ltorg
ADDR:
