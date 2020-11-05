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
    add r1, #0x40   @一段下へ
    bl $0008e660    @HP文字
    bl DrawWordAAPR
    pop {pc}

DrawWordLv:
        ldr r1, [r4, #64]
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

DrawWordAAPR:
        ldr r1, [r4, #64]
        add r1, #0x80   @二段下へ
        sub r1, #0x09   @左へ

        mov r2, #0
        ldr r3, =0x2169
        strh    r3, [r1, #0]
        strh    r2, [r1, #2]        @数字部分
        strh    r2, [r1, #4]        @数字部分
        ldr r3, =0x2165
        strh    r3, [r1, #6]
        strh    r2, [r1, #8]        @数字部分
        strh    r2, [r1, #10]       @数字部分

        add r1, #12
        ldr r3, =0x216A
        strh    r3, [r1, #0]

        strh    r2, [r1, #2]        @数字部分
        strh    r2, [r1, #4]        @数字部分
        ldr r3, =0x2168
        strh    r3, [r1, #6]
        strh    r2, [r1, #8]        @数字部分
        strh    r2, [r1, #10]       @数字部分
        bx lr

.align
.ltorg

SetNumbers:
    push {lr}
    bl SetNumberLv
    bl SetNumberHP
    bl SetNumberAAPR
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

.align
.ltorg

DrawNumbers:
    push {lr}
    bl DrawNumberLv
    bl DrawNumberHP
    bl DrawNumberAAPR
    pop {pc}

DrawNumberLv:
        push {lr}
        mov r0, r4
        add r0, #70
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r5, r0, #3
        mov r7, r5
        add r7, #17
        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r0, r0, #3
        mov r9, r0
        mov r1, r4
        add r1, #81
        ldrb r0, [r1, #0]     @数字ロード
        cmp r0, #240
        beq underLevel
        ldr r2, =0x085b8cdc
        mov r3, r0
        ldr r0, =0x82e0
        add r3, r3, r0
        mov r0, r7
        mov r1, r9
        bl $00002b08

    underLevel:
        mov r0, r5
        add r0, #24
        ldr r7, =0x085b8cdc
        mov r1, r4
        add r1, #82
        ldrb r3, [r1, #0]
        ldr r1, =0x82e0
        mov r8, r1
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

        mov r7, r5
        add r7, #17
        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r0, r0, #3
        add r0, #8          @1段下にずらす(縦座標のみ)
        mov r9, r0

        ldr r1, =0x82e0
        mov r8, r1

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #0]
        cmp r3, #240
        beq underHP
        add r3, r8
        mov r0, r7
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
        add r0, #41
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underMHP:
        mov r0, r5
        add r0, #48
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #3]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

        pop {r5, pc}
      

DrawNumberAAPR:
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
        add r0, #16         @2段下にずらす
        add r0, #1          @ちょっと下へ
        mov r9, r0


        ldr r1, =0x82e0     @先頭の数字で色をある程度変えられる
        mov r8, r1

@@@@@@@@Atk
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #4]
        cmp r3, #240
        beq underAtk
        add r3, r8
        mov r0, r7
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underAtk:
        mov r0, r5
        add r0, #24
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #5]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

@@@@@@@@AS
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #6]
        cmp r3, #240
        beq underAS
        mov r0, r5
        add r0, #41
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underAS:
        mov r0, r5
        add r0, #48
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
        add r0, #17
        add r0, #0x30
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underPrt:
        mov r0, r5
        add r0, #24
        add r0, #0x30
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
        add r0, #41
        add r0, #0x30
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

    underRsl:
        mov r0, r5
        add r0, #48
        add r0, #0x30
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #11]
        add r3, r8
        mov r1, r9
        ldr r2, =0x085b8cdc
        bl $00002b08

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
