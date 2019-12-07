TRUE = (1)
FALSE = (0)
XENO_ADR = (adr+4)
REVERSE_XENO = (adr+12)
SET_SKILLANIME_ATK_FUNC = (adr+16)
SET_SKILLANIME_DEF_FUNC = (adr+20)
GENOCIDE_WORK_ADR = (adr+24)

.thumb
@0802ae54
@
@
@
    ldr r2, =0x0203AE40 @スキルアニメ拡張の初期化
    mov r0, #0x0
    str r0, [r2] @スキルアニメ記録のリセット

    ldr r2, GENOCIDE_WORK_ADR
    mov r0, #0x0
    str r0, [r2] @フラグリセット
    
    ldr r0, =0x0203a4d0
    ldrh r2, [r0]
    mov r0, #2
    and r0, r2
    cmp r0, #0
    bne return @戦闘予測なら終了
    mov r0, #0x20
    and r0, r2
    bne return @闘技場なら終了
@突撃
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl Charge
@ジェノサイド
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl Xeno
return:
    ldr r3, [r6]
    ldr r1, [r3]
    lsl r1, r1, #8
    lsr r1, r1, #27
    ldr r0, =0x0802ae5c
    mov pc, r0

Xeno:
        push {r5, r6, lr}
        mov r5, r0
        mov r6, r1
    
        mov r2, #72
        ldrh r2, [r6, r2]
        cmp r2, #0
        beq falseXeno @相手が反撃不可(自分が反撃不可はあり得ないの前提)
    @攻め側
        mov r0, r5
        mov r1, r6
        mov r2, #TRUE
        bl HasXeno
        cmp r0, #1
        beq firstXeno
    @受け側
        mov r0, r6
        mov r1, r5
        mov r2, #FALSE
        bl HasXeno
        cmp r0, #1
        beq secondXeno
        b falseXeno

    firstXeno:
        mov r0, r5
        ldr r1, XENO_ADR
        ldr r1, [r1, #12]
            ldr r2, SET_SKILLANIME_ATK_FUNC
            mov lr, r2
            .short 0xF800
        mov r0, r5
        mov r1, r6
        bl Xeno_impl
        b retXeno

    secondXeno:
        mov r0, r6
        ldr r1, REVERSE_XENO
        ldr r1, [r1, #12]
            ldr r2, SET_SKILLANIME_DEF_FUNC
            mov lr, r2
            .short 0xF800
        mov r0, r6
        mov r1, r5
        bl Xeno_impl
        b retXeno
    falseXeno:
        nop
    retXeno:
        pop {r5, r6, pc}
        
    
HasXeno:
        push {r4, r5, lr}
        mov r5, r2
        mov r4, r0
        
        cmp r5, #FALSE
        beq Reverse

        mov r0, r4
            ldr r2, XENO_ADR @Xeno
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq notXeno @不発
        b merge
    Reverse:
        mov r0, r4
            ldr r2, REVERSE_XENO
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq notXeno @不発
        b merge
    merge:
        ldrb r0, [r4, #0x13] @nowHP
            ldr r1, =0x08000c78
            mov lr, r1
            .short 0xF800
        lsl r0, r0, #24
        asr r0, r0, #24
        cmp r0, #0
        beq endXeno @確率失敗

        mov r0, #1
        b endXeno

    notXeno:
        mov r0, #0
    endXeno:
        pop {r4, r5, pc}

Xeno_impl:
        mov r3, r0
        ldr r2, GENOCIDE_WORK_ADR
        ldrb r0, [r3, #11]	@部隊表ID取得
        strb r0, [r2]
        
        add r1, #100
        ldrb r0, [r1]
        sub r0, #20
        bge jumpXeno
        mov r0, #0
    jumpXeno:
        strb r0, [r1]
        
        mov r1, #90
        ldsb r0, [r3, r1]
        add r0, #10
        strb r0, [r3, r1]
        
        mov r1, #94
        ldsb r0, [r3, r1]
        add r0, #3
        strb r0, [r3, r1]
        
        bx lr
    
Charge:
        push {r5, r6, lr}
        mov r5, r0
        mov r6, r1
    @
        mov r0, r5
        mov r1, r6
        bl HasCharge
        cmp r0, #1
        beq trueCharge
    @
        mov r0, r6
        mov r1, r5
        bl HasCharge
        cmp r0, #1
        beq trueCharge
        b falseCharge
        
    trueCharge:
        mov r0, #0xFF
        ldr r2, GENOCIDE_WORK_ADR @無効部隊表IDストア(非ジェノサイド)
        strb r0, [r2]
        b retCharge
    falseCharge:
        nop
    retCharge:
        pop {r5, r6, pc}
    
    
    
    HasCharge:
        push {r4, lr}
        mov r4, r0
        mov r2, #94
        ldsh r0, [r4, r2]
        ldsh r2, [r1, r2]
        cmp r0, r2
        ble notCharge @速さが足りない！
        ldrb r0, [r4, #0x13]
        ldrb r2, [r1, #0x13]
        cmp r0, r2
        ble notCharge @HPが足りない！
    
        mov r0, r4
            ldr r2, adr+8 @突撃
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq notCharge
        mov r0, #1
        b endCharge
    notCharge:
        mov r0, #0
    endCharge:
        pop {r4, pc}
.align
.ltorg
adr:
