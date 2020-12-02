.thumb
@org $0802aa7c

    cmp r0, #0
    beq CombatArts

    ldrh r0, [r7, #0]
    bl getItemText
    add r1, #0x22
    ldrb r0, [r1]
    bl exchange
    mul r4, r0
    b non
CombatArts:
    mov r0, r6
    mov r1, r8
    bl EffectiveBonus
    cmp r0, #0
    beq non
    lsl r4, #1
non:
    add r4, r4, r5
    ldr r0, =0x0802aab6
    mov pc, r0

exchange:
        cmp r0, #0
        beq three
        cmp r0, #3
        beq zero
        bx lr
    zero:
        mov r0, #0
        bx lr
    three:
        mov r0, #3
        bx lr
getItemText:
    ldr r1, =0x080172c0
    mov pc, r1

FLY_E2_ID = (0x2D)      @てつのゆみ
ARMOR_E2_ID = (0x26)    @ハンマー
HORSE_E2_ID = (0x1B)    @ホースキラー
MONSTER_E2_ID = (0xAA)  @竜石

EffectiveBonus:
        push {r4, r5, r6, lr}
        mov r4, r0
        mov r6, r1
        
        mov r1, r4
        add r1, #72
        ldrh r0, [r1]
        cmp r0, #0
        beq endEffective    @武器がない

        mov r0, r6
        mov r1, r4
        bl HAS_RENTATSU
        cmp r0, #1
        beq endEffective
    @Grounder
        mov r0, #FLY_E2_ID
        ldr r1, FLY_E_ADR
    
        bl effective_impl
        cmp r0, #1
        beq getEffective
    @HelmSplitter
        mov r0, #ARMOR_E2_ID
        ldr r1, ARMOR_E_ADR
    
        bl effective_impl
        cmp r0, #1
        beq getEffective
    @@@@@
        mov r0, #HORSE_E2_ID
        ldr r1, HORSE_E_ADR
        bl effective_impl
        cmp r0, #1
        beq getEffective
    @@@@@
        mov r0, #MONSTER_E2_ID
        ldr r1, MONSTER_E_ADR
        bl effective_impl
        cmp r0, #1
        beq getEffective
    @無惨
        mov r0, r4
        mov r1, #0
        bl HAS_ATROCITY
        cmp r0, #1
        beq getEffective
    
        b endEffective
    getEffective:
        mov r0, #1
        .short 0xE000
    endEffective:
        mov r0, #0
        pop {r4, r5, r6, pc}

effective_impl:
    @r0に特効リストを利用する武器のID
    @r1にとび先
        push {r4, r5, r6, lr}
        mov r5, r6
    
        eor r4, r0
        eor r0, r4
        eor r4, r0
            mov lr, r1
            .short 0xF800
        cmp r0, #0
        beq falseEffective_impl
        mov r0, r4
        bl $08017478
    @r4に装備武器
    @r5に相手アドレス
    @r6に特効リスト
        mov r6, r0
        mov r3, r4
        mov r1, r6
        mov r4, r5
        ldr r2, [r4, #4]
        ldrb r2, [r2, #4]    @r2に相手兵種ID
        ldr r5, =0x080161B8
        ldr r5, [r5]         @r5にアイテムリスト先頭アドレス
        ldr r0, =0x080169c8
        mov pc, r0
    falseEffective_impl:
        mov r0, #0
        pop	{r4, r5, r6}
        pop	{r1}
        bx	r1

$08017478:
    ldr r1, =0x08017478
    mov pc, r1

FLY_E_ADR = (addr+0)
ARMOR_E_ADR = (addr+4)
HORSE_E_ADR = (addr+8)
MONSTER_E_ADR = (addr+12)
HAS_ATROCITY:
    ldr r2, (addr+16)
    mov pc, r2
HAS_RENTATSU:
    ldr r2, (addr+20)
    mov pc, r2

.align
.ltorg
addr:

