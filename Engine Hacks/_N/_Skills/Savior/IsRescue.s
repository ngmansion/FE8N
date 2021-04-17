.thumb
@救出中ならTURE
@但し、運び屋所持かつ味方救出中ならFALSEで上書き
@見切り不可
@

@r0はユニットアドレス
    pop {r0}
    push {r1, r2, r3, lr}
    bl main
    cmp r0, #0
    pop {r1, r2 ,r3, pc}

main:
@救出中ならTRUE
        push {r4, lr}
        mov r4, r0

        ldr r0, [r4, #12]
        mov r1, #0x10
        and r0, r1
        beq falseMain
        ldrb r0, [r4, #27]
        cmp r0, #0
        beq trueMain  @問答無用でtrue

        mov r0, r4
        mov r1, #0
        bl HasSavior
        cmp r0, #1
        beq false

        bl CompareConstitution
        b end
    trueMain:
        mov r0, #1
        .short 0xE000
    falseMain:
        mov r0, #0
    end:
        pop {r4, pc}

CompareConstitution:
        push {lr}

        ldrb r0, [r4, #27]
        cmp r0, #0
        beq trueCompare
        ldr r1, =0x08019108
        mov lr, r1
        .short 0xF800

        ldr r1, [r0, #4]
        ldr r0, [r0, #0]

        ldrb r1, [r1, #17]   @クラス体格
        lsl r1, r1, #24
        asr r1, r1, #24

        ldrb r0, [r0, #19]   @ユニット体格
        lsl r0, r0, #24
        asr r0, r0, #24
        add r0, r1

        ldr r1, [r4, #4]
        ldr r2, [r4, #0]

        ldrb r1, [r1, #17]   @クラス体格
        lsl r1, r1, #24
        asr r1, r1, #24

        ldrb r2, [r2, #19]   @ユニット体格
        lsl r2, r2, #24
        asr r2, r2, #24
        add r2, r1
    @され側の体格加算
        add r0, #4
#        lsl r0, #1
        cmp r2, r0
        blt trueCompare
        mov r0, #0
        .short 0xE000

    trueCompare:
        mov r0, #1
        pop {pc}



HasSavior:
ldr r2, addr
mov pc, r2

.align
.ltorg
addr:
