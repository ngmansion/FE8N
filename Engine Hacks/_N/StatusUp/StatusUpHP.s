.thumb
GetMaxHp:
        push {r4, r5, r6, lr}
        mov r4, r0      @元の処理に合わせる
        ldr r0, =0x0203a4e8
        cmp r0, r4
        beq calced
        ldr r0, =0x0203a568
        cmp r0, r4
        beq calced
        b main
@@@@フェールセーフ処理
    calced:
        ldrb r0, [r4, #18]
        b return

main:
.align
calc_addr:
        mov r5, #ADDR-calc_addr-6
        add r5, pc
        mov r6, #0
        .short 0xE000
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq END
        mov r0, r4
        bl GoToR3
        add r6, r0
        b loop
    END:
        mov r0, r6
    return:
        pop {r4, r5, r6, pc}


GoToR3:
nop
mov pc, r3

GET_UNIT_DATA:
ldr r1, =0x08019108
mov pc, r1

.align
.ltorg
ADDR:

