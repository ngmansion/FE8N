.thumb
@org   0808e75c

    push    {r4, r5, r6, r7, lr}
    mov r7, r8
    push    {r7}
    mov r7, r9      @追加
    push    {r7}    @追加
    mov r4, r0
    mov r5, r1
    mov r0, #68
    ldsh    r6, [r0, r4]
    
    mov r0, #63
    and r0, r6
    cmp r0, #0
    bne check
    mov r0, #64
    and r0, r6
    cmp r0, #0
@   beq start
@   ldr r0, [r4, #64]
@   ldr r1, =0x0808e688
@   mov lr, r1
@   mov r1, r5
@   @dcw    0xF800
@   b   dont
    
    
start:
    bl SetNumbers
    bl DrawWords

dont:
    mov r0, #1
    ldr r1, =0x08001efc
    mov lr, r1
    .short 0xF800
check:
    mov r0, r4
    add r0, #85
    ldrb    r0, [r0, #0]
    lsl r0, r0, #24
    asr r0, r0, #24
    bne end
    bl DrawNumbers


end:
    pop {r3}        @追加
    mov r9, r3      @追加
    pop {r3}
    mov r8, r3
    pop {r4, r5, r6, r7}
    pop {r0}
    bx r0

.align
.ltorg


DrawWords:
    push {lr}
    bl DrawWordLv
    ldr r1, [r4, #64]
    bl $0008e660    @HP文字
    bl DrawWordASPrfRsl
    bl DrawWordAvoDdg
    pop {pc}

DrawWordLv:
        ldr r1, [r4, #64]
        sub r1, #0x40   @一段上へ
        mov r2, #0
        ldr r3, =0x2160
        strh    r3, [r1, #0]
        add r3, #1
        strh    r3, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        add r3, #1
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]
        bx lr

DrawWordASPrfRsl:
        ldr r1, [r4, #64]
        add r1, #0x40   @二段下へ
        sub r1, #0x09   @左へ

        mov r2, #0
        ldr r3, =0x2165
        strh    r3, [r1, #0]
        add     r3, #1
        strh    r3, [r1, #2]
        strh    r2, [r1, #4]        @数字部分
        strh    r2, [r1, #6]        @数字部分

        add     r3, #1
        strh    r3, [r1, #8]
        add     r3, #1
        strh    r3, [r1, #10]
        strh    r2, [r1, #12]       @数字部分
        strh    r2, [r1, #14]       @数字部分

        add     r3, #1
        strh    r3, [r1, #16]
        add     r3, #1
        strh    r3, [r1, #18]
        strh    r2, [r1, #20]        @数字部分
        strh    r2, [r1, #22]        @数字部分
        bx lr

DrawWordAvoDdg:
        ldr r1, [r4, #64]
        add r1, #0x80   @二段下へ
        sub r1, #0x09   @左へ

        mov r2, #0
        ldr r3, =0x2100
        strh    r3, [r1, #0]
        add     r3, #1
        strh    r3, [r1, #2]

        strh    r2, [r1, #4]        @数字部分
        strh    r2, [r1, #6]        @数字部分
        strh    r2, [r1, #8]        @数字部分

        add     r3, #1
        strh    r3, [r1, #10]
        add     r3, #1
        strh    r3, [r1, #12]

        strh    r2, [r1, #14]        @数字部分
        strh    r2, [r1, #16]        @数字部分
        ldr r3, =0x210B
        strh    r3, [r1, #18]
        strh    r2, [r1, #20]
        strh    r2, [r1, #22]
        strh    r2, [r1, #24]
        bx lr
.align
.ltorg

SetNumbers:
    push {lr}
    bl SetNumberLv
    bl SetNumberHP
    bl SetNumberAAPR
    bl SetNumberHACD
    pop {pc}

SetNumberLv:
        push {lr}
        ldrb    r0, [r5, #8]    @レベル
        bl  NUMBER
        ldr r1, =0x02028e44
        ldrb    r0, [r1, #6]
        sub r0, #48
        mov r2, r4
        add r2, #81             @横位置
        strb    r0, [r2, #0]
        ldrb    r0, [r1, #7]
        sub r0, #48
        mov r1, r4
        add r1, #82             @横位置
        strb    r0, [r1, #0]

        ldrb    r0, [r5, #9]    @Exp
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        mov r2, r4
        add r2, #83             @横位置
        strb    r0, [r2, #0]

        ldrb    r0, [r1, #7]
        sub r0, #48
        mov r1, r4
        add r1, #84             @横位置
        strb    r0, [r1, #0]
        pop {pc}

SetNumberHP:
        push {lr}
        ldrb    r0, [r5, #19]    @ヒットポイント
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44
        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #0]
        
        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #1]

        mov r0, r5
        bl $00018ea4        @最大HP
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #2]

        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #3]
        pop {pc}

SetNumberAAPR:
        push {lr}
        sub sp, #80 @装備あたりまで
        mov r0, sp
        bl SET_POW
        add sp, #80
        
        bl GetAttack
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44
        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #4]        @change
        
        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #5]        @change
@@@@@@@@
        bl GetSpeed
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #6]        @change

        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #7]        @change
@@@@@@@@
        bl GetDefence
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #8]        @change

        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #9]        @change

@@@@@@@@
        bl GetResistance
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #10]        @change

        ldrb    r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb    r0, [r3, #11]        @change
        pop {pc}

SetNumberHACD:
        push {r4, lr}
        ldr r4, =0x02025108
        bl GetFirstNum
        bl Hundred
        mov r7, r1          @退避
        bl NUMBER

        ldr r1, =0x02028e44
        ldrb r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb  r0, [r3, #20]
        ldrb r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb  r0, [r3, #21]

        mov r0, r7
        bl GetHundredNum
        strb   r0, [r3, #12]

    @@@@
        bl GetSecondNum
        bl Hundred
        mov r7, r1          @退避
        bl NUMBER
        ldr r1, =0x02028e44
        ldrb r0, [r1, #6]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb  r0, [r3, #22]
        ldrb r0, [r1, #7]
        sub r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        strb  r0, [r3, #23]

        mov r0, r7
        bl GetHundredNum
        strb   r0, [r3, #13]

        bl SetThirdNum
        bl SetFourthNum
        bl SetFifthNum

        pop {r4, pc}


SetThirdNum:
    push {lr}
    bl GetThirdNum
    bl Hundred
    mov r7, r1          @退避
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb  r0, [r1, #6]
    sub   r0, #48
    mov   r2, r4
    add   r2, #81
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #15]

    ldrb  r0, [r1, #7]
    sub   r0, #48
    mov   r1, r4
    add   r1, #82
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #14]

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #16]
    pop {pc}

SetFourthNum:
    push {lr}
    bl GetFourthNum
@    bl Hundred
    mov r7, r1          @退避
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb  r0, [r1, #6]
    sub   r0, #48
    mov   r2, r4
    add   r2, #81
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #18]

    ldrb  r0, [r1, #7]
    sub   r0, #48
    mov   r1, r4
    add   r1, #82
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #17]

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #19]
    pop {pc}

SetFifthNum:
    push {lr}
    bl GetFifthNum
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb  r0, [r1, #6]
    sub   r0, #48
    mov   r2, r4
    add   r2, #81
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #24]

    ldrb  r0, [r1, #7]
    sub   r0, #48
    mov   r1, r4
    add   r1, #82
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #25]

    pop {pc}


GetHundredNum:
    push {lr}
    cmp r0, #0
    beq falseHundred
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb    r0, [r1, #7]
    sub r0, #48
    .short 0xE000
falseHundred:
    mov r0, #0xF0
    bl GET_EX_NUM_MEM_TO_R3
    pop {pc}

Hundred:
        mov r1, #0
        ldr r2, =0xFFFFFFFF
        cmp r0, r2
        beq invalidHundred
        mov r2, r0
    loopHundred:
        cmp r2, #99
        ble underHundred
        sub r2, #100
        add r1, #1
        b loopHundred
    invalidHundred:
        mov r1, r0
    underHundred:
        bx lr


GetFirstNum:
        ldr r1, =0x0203a568
        mov r0, #74
        ldrh r0, [r1, r0]
        cmp r0, #0
        beq falseFirst
        mov r0, #96
        ldrh r0, [r1, r0]
        .short 0xE000
    falseFirst:
        ldr r0, =0xFFFFFFFF
        bx lr

GetSecondNum:
        ldr r1, =0x0203a568
        mov r0, #74
        ldrh r0, [r1, r0]
        cmp r0, #0
        beq falseSecond
        mov r0, #102
        ldrh r0, [r1, r0]
        .short 0xE000
    falseSecond:
        ldr r0, =0xFFFFFFFF
        bx lr

GetThirdNum:
        ldr r1, =0x0203a568
        mov r0, #98
        ldrh r0, [r1, r0]
        bx lr

GetFourthNum:
        ldr r1, =0x0203a568
        mov r0, #104
        ldrh r0, [r1, r0]
        bx lr

GetFifthNum:
        ldr r1, =0x0203a568
        ldr r0, [r1]
        ldrb r0, [r0, #19]
        ldr r1, [r1, #4]
        ldrb r1, [r1, #17]
        add r0, r0, r1
        bx lr

.align
.ltorg

DrawNumbers:
    push {lr}
    ldr r1, =0x82e0
    mov r8, r1

    bl DrawNumberLv
    bl DrawNumberHP
    bl DrawNumberAS_Prf_Rsl
    pop {pc}

DrawNumberLv:
        push {lr}
        mov r0, r4
        add r0, #70
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r5, r0, #3

        ldr r7, =0x085b8cdc

        ldr r1, =0x82e0
        mov r8, r1

        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r0, r0, #3
        sub r0, #8          @1段上にずらす(縦座標のみ)
        mov r9, r0

        mov r0, r5
        add r0, #16             @やや左
        mov r1, r4
        add r1, #81
        ldrb r3, [r1, #0]     @数字ロード
        cmp r3, #240
        beq underLevel
        add r3, r8
        mov r2, r7
        mov r1, r9
        bl $00002b08

    underLevel:
        mov r0, r5
        add r0, #23             @やや左

        mov r1, r4
        add r1, #82
        ldrb r3, [r1, #0]
        add r3, r8
        mov r1, r9
        mov r2, r7
        bl $00002b08

        mov r1, r4
        add r1, #83
        ldrb r0, [r1, #0]
        cmp r0, #240
        beq underExp
        mov r0, r5
        add r0, #41
        ldrb r3, [r1, #0]
        ldr r1, =0x82e0
        add r3, r3, r1
        mov r1, r9
        mov r2, r7
        bl $00002b08
    underExp:
        mov r0, r5
        add r0, #48
        mov r1, r4
        add r1, #84
        ldrb r3, [r1, #0]
        add r3, r8
        mov r1, r9
        mov r2, r7
        bl $00002b08
        pop {pc}

DrawNumberHP:
        push {r5, lr}
        mov r0, r4
        add r0, #70
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r5, r0, #3

        ldr r1, =0x82e0
        mov r8, r1

        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r0, r0, #3
        mov r9, r0

        mov r0, r5
        add r0, #17
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #0]
        cmp r3, #240
        beq underHP
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underHP:
        mov r0, r5
        add r0, #24
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #1]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #2]
        cmp r3, #240
        beq underMHP
        mov r0, r5
        add r0, #42         @やや右
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underMHP:
        mov r0, r5
        add r0, #49         @やや右
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #3]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

        pop {r5, pc}
      

DrawNumberAS_Prf_Rsl:
        push {r5, lr}
        mov r0, r4
        add r0, #70
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r5, r0, #3
        sub r5, #0x30          @左にずらす
        mov r7, r5
        add r7, #17
        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r0, r0, #3
        add r0, #8         @1段下にずらす
        mov r9, r0


        ldr r1, =0x82e0     @先頭の数字で色をある程度変えられる
        mov r8, r1

@@@@@@@@Atk
@        bl GET_EX_NUM_MEM_TO_R3
@        ldrb    r3, [r3, #4]
@        cmp r3, #240
@        beq underAtk
@        add r3, r8
@        mov r0, r7
@        mov r1, r9
@        ldr r2, =0x085b8cdc
@        bl $00002b08
@
@    underAtk:
@        mov r0, r5
@        add r0, #24
@        bl GET_EX_NUM_MEM_TO_R3
@        ldrb    r3, [r3, #5]
@        add r3, r8
@        mov r1, r9
@        ldr r2, =0x085b8cdc
@        bl $00002b08

@@@@@@@@AS
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #6]
        cmp r3, #240
        beq underAS
        mov r0, r5
        add r0, #0x18
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underAS:
        mov r0, r5
        add r0, #0x18
        add r0, #7
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #7]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

@@@@@@@@Prt
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #8]
        cmp r3, #240
        beq underPrt
        add r3, r8
        mov r0, r5
        add r0, #0x38
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underPrt:
        mov r0, r5
        add r0, #0x38
        add r0, #7
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #9]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

@@@@@@@@Rsl
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #10]
        cmp r3, #240
        beq underRsl
        mov r0, r5
        add r0, #0x58
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underRsl:
        mov r0, r5
        add r0, #0x58
        add r0, #7
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #11]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08
DrawNumberAvo_Ddg:
        mov r0, #8         @1段下にずらす
        add r9, r0

@@@@@@@@Avo
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #16]
        cmp r3, #0xF0
        beq underAvo100
        add r3, r8
        mov r0, r5
        add r0, #0x18
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08
    underAvo100:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #15]
        cmp r3, #0xF0
        beq underAvo10
        add r3, r8
        mov r0, r5
        add r0, #0x18
        add r0, #7
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08
    underAvo10:

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #14]
        add r3, r8
        mov r0, r5
        add r0, #0x18
        add r0, #14
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

@@@@@@@@Ddg
        bl GET_EX_NUM_MEM_TO_R3
@        ldrb    r3, [r3, #19]      @100超えないでしょ・・・
        ldrb    r3, [r3, #18]
        cmp r3, #0xF0
        beq underDdg10

        mov     r0, r5
        add     r0, #0x40
        add     r3, r8
        mov     r1, r9
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    underDdg10:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #17]
        mov     r0, r5
        add r0, #0x40
        add r0, #7
        add     r3, r8
        mov     r1, r9
        ldr     r2, =0x085b8cdc
        bl      $00002b08
@@@@@@@@体格
        bl GET_EX_NUM_MEM_TO_R3
@        ldrb    r3, [r3, #19]      @100超えないでしょ・・・
        ldrb    r3, [r3, #24]
        cmp r3, #0xF0
        beq underCon10

        mov     r0, r5
        add     r0, #0x58
        add     r3, r8
        mov     r1, r9
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    underCon10:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #25]
        mov     r0, r5
        add     r0, #0x58
        add     r0, #7
        add     r3, r8
        mov     r1, r9
        ldr     r2, =0x085b8cdc
        bl      $00002b08

        pop {r5, pc}

GetAttack:
        ldr r0, =0x0203a568
        mov r1, #72
        ldrh r1, [r1, r0]
        cmp r1, #0
        beq falseAT

        mov r1, #90
        ldrh r0, [r1, r0]
        .short 0xE000
    falseAT:
        mov r0, #0xFF
        bx lr
GetSpeed:
        ldr r0, =0x0203a568
        mov r1, #94
        ldrh r0, [r1, r0]
        bx lr

GetDefence:
        ldr r0, =0x0203a568
        mov r1, #92
        ldrh r0, [r1, r0]
        bx lr
GetResistance:
        ldr r3, =0x0203a568
        mov r0, r3
        add r0, #86
        ldrb r0, [r0, #0]
        lsl r0, r0, #24
        asr r0, r0, #24
        mov r1, #23
        ldsb r1, [r3, r1]
        add r2, r0, r1

        mov r0, r3
        add r0, #88
        ldrb r0, [r0, #0]
        lsl r0, r0, #24
        asr r0, r0, #24
        mov r1, #24
        ldsb r1, [r3, r1]
        add r1, r0, r1

        ldr r0, =0x0203a568
        add r0, #92
        ldrh r0, [r0]

        add r0, r0, r1
        sub r0, r0, r2
        bx lr

.align
.ltorg

COPY_SIZE = (72)

SET_POW:
        push {r5, lr}
        mov r1, r5
        mov r5, r0

        ldr r0, =0x0203a568
        bl AtkSideFunc

        mov r0, r5
        mov r1, r5
        bl DefSideFunc

        ldr r0, =0x0203a568
        mov r1, r5
        ldr r2, =0x0802a8c8
        mov lr, r2
        .short 0xF800
        pop {r5, pc}


AtkSideFunc:
        push {r4, r5, r6, lr}       @装備処理に合わせる
        mov r4, r0
        mov r5, r1
        mov r6, r4

        mov r0, r4
        mov r1, r5
        mov r2, #COPY_SIZE
        bl MEMCPY_R1toR0_FUNC

        mov r0, r5
        bl STRONG_FUNC
        strb r0, [r4, #20]

        mov r0, r5
        bl SKILL_FUNC
        strb r0, [r4, #21]

        mov r0, r5
        bl SPEED_FUNC
        strb r0, [r4, #22]

        mov r0, r5
        bl DEFENCE_FUNC
        strb r0, [r4, #23]

        mov r0, r5
        bl RESISTANCE_FUNC
        strb r0, [r4, #24]

        mov r0, r5
        bl LUCK_FUNC
        strb r0, [r4, #25]

        bl MagicFuncIfNeed

        mov r0, r4
        bl TERRAIN_FUNC

        mov r2, #0
        mov r1, #83
        strb r2, [r4, r1]       @すくみ初期化
        mov r1, #84
        strb r2, [r4, r1]       @すくみ初期化

@以降装備処理
        mov r0, r4
        bl $080168d0
        ldr r1, =0x0802a894
        mov pc, r1


MagicFuncIfNeed:
        push {lr}
        ldr r3, =0x08018ecc     @magic_func
        ldr r1, [r3]
        ldr r2, =0x468F4900
        cmp r1, r2
        bne notMagic        @魔力パッチなしならジャンプ

        mov r0, r5
            mov lr, r3
            .short 0xF800
        strb r0, [r4, #26]
        b endMagic
    notMagic:
        ldr r2, [r5, #0]
        ldr r3, [r5, #4]
        ldrb r2, [r2, #19]
        ldrb r3, [r3, #17]
        add r0, r2, r3

        ldrb r2, [r5, #26]
        add r0, r2

        strb r0, [r4, #26]
    endMagic:
        pop {pc}


DefSideFunc:
        push {lr}
        mov r1, #0
        str r1, [r0, #0]    @ユニット不明
        str r1, [r0, #4]    @兵種不明
        str r1, [r0, #8]    @状態不明

        mov r1, #0xFF
        strb r1, [r0, #0xb] @所属不明

        mov r1, #0
        add r0, #0x48
        strh r1, [r0] @装備不明
        sub r0, #0x48

        pop {pc}


STRONG_FUNC:
    ldr r2, =0x08018ec4
    mov pc, r2
SKILL_FUNC:
    ldr r2, =0x08018ee4
    mov pc, r2
SPEED_FUNC:
    ldr r2, =0x08018f24
    mov pc, r2

DEFENCE_FUNC:
    ldr r2, =0x08018f64
    mov pc, r2

RESISTANCE_FUNC:
    ldr r2, =0x08018f84
    mov pc, r2
LUCK_FUNC:
    ldr r2, =0x08018fac
    mov pc, r2
TERRAIN_FUNC:
    ldr r2, =0x0802a648
    mov pc, r2

MEMCPY_R1toR0_FUNC:
    ldr r3, =0x080d6908
    mov pc, r3

$080168d0:
    ldr r1, =0x080168d0
    mov pc, r1

.align
.ltorg

$00002b08:
@r0 = x座標
@r1 = y座標
@r2 = ?
@r3 = ?
    ldr r6, =0x08002b08
    mov pc, r6

$00018ea4:
    ldr r1, =0x08018ea4
    mov pc, r1

$0008e660:
    ldr r2, =0x0808e660
    mov pc, r2

NUMBER:
    ldr r1, =0x08003868
    mov pc, r1
    

GET_EX_NUM_MEM_TO_R3:
    ldr r3, ADDR
    bx lr

.ltorg
.align
ADDR:
