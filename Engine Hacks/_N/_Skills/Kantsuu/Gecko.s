.thumb

SET_SKILLANIME_ATK_FUNC = (adr+4)
HAS_NIHIL_FUNC = (adr+8)

@org    0x08E48BB0

    mov r0, r2
        push {r2}
        ldr r1, adr @月光
        mov lr, r1
        .short 0xF800
        pop {r2}
    cmp r0, #0
    beq end
    
    mov r0, r8
        push {r2}
        ldr r2, HAS_NIHIL_FUNC
        mov lr, r2
        .short 0xF800
        pop {r2}
    cmp r0, #1
    beq end
    
@奥義目印

    ldrb    r0, [r2, #0x15] @@月光発動率
    mov r1, #0
        push {r2}
        ldr r3, =0x0802a490 @r0=確率, r1=#0 乱数
        mov lr, r3
        .short  0xF800
        pop {r2}
    cmp r0, #1
    bne end
    
    mov r0, r2
    ldr r1, adr
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800
    
    pop {r4, r5}
    asr r4, r4, #1  @半減
    pop {r0}
    bx  r0
    
end:
    ldr r3, =0x0802b24a
    mov pc, r3
WEAPON:
    ldr r3, =0x080172f0
    mov pc, r3
.align
.ltorg
adr:

