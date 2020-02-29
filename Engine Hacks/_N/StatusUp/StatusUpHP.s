.thumb
GetMaxHp:
        push {r4, lr}
        mov r4, r0      @元の処理に合わせる
        ldrb r0, [r4, #0xB]
        bl GET_UNIT_DATA
        cmp r0, r4
        beq main
@@@@フェールセーフ処理
        ldrb r0, [r4, #18]
        pop {r4, pc}

main:
        push {r5, r6}
.align
calc_addr:
        mov r5, #(ADDR+4)-calc_addr-6
        add r5, pc
        mov r6, #0
        .short 0xE000
    loop:
        add r5, #4
        ldr r3, [r5]
        cmp r3, #0
        beq FINISH
        mov r0, r4
        bl GoToR3
        add r6, r0
        b loop
    FINISH:
        mov r0, r6
        pop {r5, r6}
        ldr r1, ADDR
        mov pc, r1


GoToR3:
nop
mov pc, r3

GET_UNIT_DATA:
ldr r1, =0x08019108
mov pc, r1

.align
.ltorg
ADDR:

