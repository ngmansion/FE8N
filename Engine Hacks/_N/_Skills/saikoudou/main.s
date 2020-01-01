ATK = (0x0203a4e8)
DEF = (0x0203a568)
DEFEAT = 0xFF
DEFEATED = 0xFE
DEFEAT2 = 0x7F
DEFEATED2 = 0x7E
hasRemove = (adr+0)
hasGaleforce = (adr+4)
hasLifetaker = (adr+8)
hasCantoPlus = (adr+12)
hasGaleCause = (adr+16)
TARGET_UNIT = (0x03004df0)
WEAPON_SP_ADR = (0x080172f0)
@0801cea8
.thumb
    push {r4, r5, lr}
    mov r5, r0
	ldr r4, =TARGET_UNIT
	ldr r4, [r4]
@    ldr r4, =ATK

    ldr r0, [r4, #12]
    ldr r1, =0x0801cf04
    ldr r1, [r1]
    and r0, r1
    cmp r0, #0
    bne FALSE	@死亡・待機(or再行動済)・??状態
    
    mov r0, r4
    ldrb	r1, [r0, #0x13]
    cmp r1, #0
    beq FALSE	@自分のHPゼロなら何もせずに終了
    
    mov r0, r4
    ldrb r1, [r0, #11]
    mov r2, #192
    and r2, r1
    bne FALSE @自軍以外は終了
    
    ldr r0, =0x0203a954
    ldrb r0, [r0, #17]
    cmp r0, #1
    beq FALSE @待機選択なら終了
    cmp r0, #17
    beq FALSE @制圧選択なら終了

    bl RagingStorm  @アイムール
    cmp r0, #0
    beq notStorm
    mov r0, r4
    add r0, #69
    mov r1, #DEFEATED
    strb r1, [r0] @撃破済み
    b Sound
notStorm:
    mov r0, r4
    add r0, #69
    ldrb r1, [r0]
    cmp r1, #DEFEAT
    beq pattern1
    cmp r1, #DEFEATED
    beq pattern0
    cmp r1, #DEFEAT2
    beq pattern2
    cmp r1, #DEFEATED2
    beq pattern0
    b pattern3
pattern1:
@再行動なし撃破
@
    mov r1, #DEFEATED
    strb r1, [r0] @撃破済み

	bl kaifuku
	
    bl shippuJinrai
    cmp r0, #1
    beq Sound	@再行動
    b next

pattern2:
@再行動済み撃破
@
    mov r1, #DEFEATED2
    strb r1, [r0] @撃破済み
    
    bl kaifuku
	b next

pattern3:
@再行動なし未撃破
@
    ldr r0, =DEF
    ldr r1, [r0, #4]
    cmp r1, #0		@相手がいない
    beq next		@
    
    bl jinpuShourai	@神風招来
    cmp r0, #0
    beq next
@一回目撃破(再行動済みフラグ)をオン
    mov r0, #69
    mov r1, #DEFEATED
    strb r1, [r4, r0] @撃破済み
    
    b Sound	@再行動
    
pattern0:
@再行動済み未撃破
@
next:
@スキル再移動による再移動化
    mov r0, r4
        ldr r1, adr+12 @再移動
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne Canto
    ldr r2, =TARGET_UNIT
    ldr r3, [r2]
    mov r4, r2
    ldr r0, =0x0801ceb0 @通常の再移動判定
    mov pc, r0
Canto:
    ldr r4, =TARGET_UNIT
    ldr r3, =0x0801cece
    mov pc, r3


Sound:	@再行動
    ldr	r0, =0x0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	end
    mov	r0, #97
    ldr	r2, =0x080d4ef4
    mov	lr, r2
    .short 0xf800
end:
	mov	r0, #0
	pop	{r4, r5}
	pop	{r1}
	bx	r1

FALSE:
	ldr r4, =TARGET_UNIT
    ldr r3, =0x0801cefc
    mov pc, r3

@アイムール
RagingStorm:
        push {lr}
    @スキルを持っているか
        mov r0, r4
        ldr r1, =DEF
        bl hasRagingStorm
        cmp r0, #0
        beq falseStorm
    @戦技を発動中か
        mov r0, #67
        ldrb r0, [r4, r0]
        mov r1, #0xFE
        and r0, r1
        cmp r0, r1
        bne falseStorm
        mov r0, #1
        b endStorm
    falseStorm:
        mov r0, #0
    endStorm:
        pop {pc}

@神風招来
@
jinpuShourai:
    push {lr}
    mov	r0, r4
        ldr r2, hasGaleCause
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non_ka
    
    mov r0, r4
    ldr r1, =ATK
    ldrb r0, [r0, #0xB]
    ldrb r2, [r1, #0xB]
    cmp r0, r2
    bne non_ka
    add r1, #0x48
    ldrh r0, [r1]
        ldr r2, =WEAPON_SP_ADR
        mov lr, r2
        .short 0xF800
    cmp r0, #4		@杖
    bne non_ka
    b gogot @待機チェック
@疾風迅雷
@
shippuJinrai:
    push {lr}
    mov r0, r4
        ldr r2, hasGaleforce
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non_ka
gogot:
    mov	r0, r4
    ldr	r1, [r0, #12]	@行動済み等の状態
    ldr	r2, =0xfffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    
    mov	r0, #1
    .short 0xE000
non_ka:
    mov	r0, #0
    pop	{pc}
    
@生命吸収
kaifuku:
    push {lr}
    mov r0, r4
        ldr r2, adr+8
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non_hp

    mov	r2, r4
    ldrb r0, [r2, #19] @現在19
    ldrb r1, [r2, #18] @最大18
    asr r1, r1, #1
    add r0, r0, r1
    
    ldrb r1, [r2, #18] @最大18
    cmp r0, r1
    ble jump_hp
    mov r0, r1
jump_hp:
    strb r0, [r2, #19] @現在19
    
    mov r0, #0x89
    mov r1, #0xB8
        ldr r2, =0x08014B50 @音
        mov lr, r2
        .short 0xF800
    mov	r0, #1
    .short 0xE000
non_hp:
    mov	r0, #0
    pop	{pc}

HAS_RASINGSTORM = (adr+20)

hasRagingStorm:
ldr r2, HAS_RASINGSTORM
mov pc, r2


.align
.ltorg
adr:
