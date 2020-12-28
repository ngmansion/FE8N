.thumb

judgeOccult:
        push {r4, lr}
        mov r4, r0
        mov r1, #0
            ldr r2, ADDR+0 @奥義の書
            mov lr, r2
            .short 0xF800
        cmp r0, #1
        beq end
        
        mov r0, #0x50
        ldrb r0, [r4, r0]
        cmp r0, #7
        bgt false
        add r0, #40
        ldrb r0, [r4, r0]
        cmp r0, #250
        bls false
        mov r0, #1
        .short 0xE000
    false:
        mov r0, #0
    end:
        pop {r4, pc}
.align
.ltorg
ADDR:

