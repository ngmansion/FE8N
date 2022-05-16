.thumb
@org   0x0801742c
@@@@ free range patch?

        push {r0}
        lsl r0, r0, #0x18
        lsr r1, r0, #0x13
        lsr r0, r0, #0x16
        add r0, r1
        ldr r1, =0x08017404
        ldr r1, [r1]
        add r1, r0
        ldrb r1, [r1, #0x19]
        cmp r1, #0xF0
        blt end_free_range
        
        cmp r1, #0xFF
        beq end_free_range

        mov r0, #0xFF
        pop {r1}
        bx lr

@@@@
end_free_range:
    pop {r1}
    mov     r0, r13
    ldr     r2, =0x03007D6C
    cmp     r0, r2
    beq     false
    ldr     r0, [r0, #4]
    ldr     r2, =0x0802A833  @(スタック確認)
    cmp     r0, r2
    beq     five
    mov     r0, #0x1
    lsl     r0, r0, #16
    cmp     r6, r0
    bgt     six
    cmp     r5, r0
    blt     zero
five:
    mov     r0, r5
    b       check
six:
    mov     r0, r6
    b       check
zero:
    ldr     r0, =0x03004DF0
    ldr     r0, [r0]
check:
    cmp     r0, #0
    bne     continue
false:
    lsl r0, r1, #0x18
    lsr r1, r0, #0x13
    lsr r0, r0, #0x16
    add r0, r1
    ldr r1, =0x08017404
    ldr r1, [r1]
    add r1, r0
    ldrb r1, [r1, #0x19]
    mov     r0, #0xF
    and     r0, r1
    bx      lr

continue:
    push {lr}
    bl main
    mov     r1, #0xF
    and     r0, r1
    pop {pc}

main:
        push {r3, r4, r5, r6, lr}
        mov r4, r0
        mov r5, r1
    @@@@
    lsl r6, r1, #0x18
    lsr r1, r6, #0x13
    lsr r6, r6, #0x16
    add r6, r1
    ldr r1, =0x08017404
    ldr r1, [r1]
    add r6, r1
    @@@@▽撃破捕獲▽
        ldr     r3, [r0, #12]   @捕獲
        mov     r2, #0x80
        lsl     r2, r2, #0x17
        tst     r3, r2
        bne     one
    @@@@△撃破捕獲△
        ldr     r0, [r0, #4]
        ldrb    r0, [r0, #4]
        cmp     r0, #0x1B   @スナイパー
        beq     sagittary
        cmp     r0, #0x1C   @スナイパー
        bne     combat
    sagittary:
        ldrb r1, [r6, #25]
        cmp     r1, #0x22
        bne     combat
        mov     r0, #0x23
        b   return
    combat:
        bl combat_arts
        cmp r0, #0
        bne return
        ldrb r0, [r6, #25]
        b return
    one:
        mov     r0, #0x11
        b       return
    return:
        pop {r3, r4, r5, r6, pc}


combat_arts:
@
@ 今はスキルID決め打ち。
@
        push {lr}
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #0xB]
        ldrb r1, [r4, #0xB]
        cmp r0, r1
        bne false_combat

        ldrb r0, [r6, #25]
        mov r1, #0xF
        and r0, r1
        cmp r0, #0x01
        beq javelin_check
        cmp r0, #0x02
        beq long_check
        b false_combat

    long_check:
        mov r0, r4
        bl GET_COMBAT_ARTS
        cmp r0, #0xB6
        beq long_arts
        cmp r0, #0x7F
        beq long_arts
        b false_combat

    javelin_check:
        mov r0, r4
        bl GET_COMBAT_ARTS
        cmp r0, #0xCD
        beq javelin_arts
        cmp r0, #0xCE
        beq javelin_arts
        b false_combat
    long_arts:
        mov r0, #0x23       @戦技の射程
        b end_combat_arts
    javelin_arts:
        mov r0, #0x22       @戦技の射程
        b end_combat_arts
    false_combat:
        mov r0, #0
    end_combat_arts:
        pop {pc}

CAN_USE_COMBAT_ARTS:
    ldr r3, (ADDR+0)
    mov pc, r3
GET_COMBAT_ARTS:
    ldr r3, (ADDR+4)
    mov pc, r3
.align
.ltorg
ADDR:

