.thumb
COMMAND_GIVE = 0x0C
@Dumped from Fire Emblem Destiny
@ 0x32038
    push {r4, r5, r6, lr}
    ldr r4, =0x0203F101 @同じです適当な空き領域と思われる
    ldrb r2, [r4]
    cmp r2, #2
    beq two
    cmp r2, #1
    beq one
    cmp r2, #3
    beq three
    b end
one:
@1おそらく普通の救出(shelter)
        ldr r1, =0x080320b0 @=0x08032164
        mov lr, r1
        .short 0xF800
@extra_func
    ldr r5,[sp]         @085C2F58 085C3060 00000000
    mov r2,#0x17
    strb r2,[r4,#0x11]
    bl GetNothingFuncAddr   @    ldr r4, [r5,#4]     @original_TalkFix
                            @    sub r4, #0x30       @085C3060 → 085C3030
    str r0, [r5,#4]
    ldr r4,=0x202bce9
    mov r5,#80
    strb r5,[r4]

    ldr r4, =0x0203F101 @適当な空き領域と思われる
    mov r2, #3
    strb r2, [r4]   @次にthreeへ飛ばす為のフラグ
@extra_func
    mov r0, #0
    b end

three:  @救出後、Bキャンセルした時の処理
    mov r0, #COMMAND_GIVE
    ldr r1, =0x0203a954
    strb r0, [r1, #17]
    mov r0, #1          @change
    b end

@Pair-UP
two:
    mov r6, r0
    ldr r4, =0x0203A954 @=0x0203A958
    ldrb r0, [r4, #0xD]
        ldr r1, =0x08019108 @=0x08019430
        mov lr, r1
        .short 0xF800
    mov r5, r0
    ldrb r0, [r4, #0xC]
        ldr r1, =0x08019108 @=0x08019430
        mov lr, r1
        .short 0xF800
    mov r4, r0
        ldr r1, =0x08037b04 @=0x08037A6C
        mov lr, r1
        .short 0xF800
    mov r2, #0x10
    ldsb r0, [r5, r2]
    mov r3, #0x11
    ldsb r1, [r5, r3]
    ldsb r2, [r4, r2]
    ldsb r3, [r4, r3]
        push {r4}
        ldr r4, =0x0801d838 @=0x0801DBD4
        mov lr, r4
        .short 0xF800
        pop {r4}
    mov r1, r0
    mov r0, r4
    mov r2, #0
    mov r3, r6
        push {r4}
        ldr r4, =0x0801d8e0 @=0x0801DC7C
        mov lr, r4
        .short 0xF800
        pop {r4}
    mov r0, r5
    mov r1, r4
        ldr r3, =0x08018060 @=0x0801834C
        mov lr, r3
        .short 0xF800
    mov r0, r4
        ldr r3, =0x080280a0 @=0x0802810C(000280a6:C0 46)
        mov lr, r3
        .short 0xF800
    ldr r0, =0x03004DF0 @=0x03004E50
    ldr r1, =0x03004E10 @=0x03004E70
    str r1, [r0]
    mov r0, #0xFF
    strb r0, [r1, #0xC]
    ldr r2, =0x0202BCC2 @カーソルの座標@0202BCC6
    ldrb r0, [r2]
    strb r0, [r1, #0x11] @座標？
    ldrb r0, [r2, #2]
    strb r0, [r1, #0x10] @座標？
    ldr r4, =0x02024E68 @そのままで多分良い
    ldr r6, =0x08A132D0 @=0x089A2C48
    mov r5, #0x3F
loop:
    ldr r0, [r4]
    cmp r0, r6
    bne jump1
    ldr r0, [r4, #0x1C]
    cmp r0, #0
    beq jump1
    mov r0, r4
        ldr r1, =0x08002fbc @0x0800306C
        mov lr, r1
        .short 0xF800
jump1:
    sub r5, #1
    add r4, #0x6C
    cmp r5, #0
    bge loop
    mov r0, #0
end:
    pop {r4-r6}
    pop {r1}
    ldr r1, =0x0803208e
    mov pc, r1


.align
GetNothingFuncAddr:
    mov r0, #nothing_func-GetNothingFuncAddr-6
    add r0, pc
    bx lr
.align

nothing_func:   @($085C3030)
.word 0x0002000B
.word 0
.word 0x03
.word 0x0801D0D5
.word 0x0007000B
.word 0
.word 0x08
.word 0x085C29C8
.word 0x16
.word 0x0801CCED
.word 0x16
.word 0x08031F59        @ここを"three"の処理に置き換えても出来るが見送り

next_func:  @通常の救出後処理($085C3060)
.word 0x16
.word 0x0803780D    @セーブ
.word 0x16
.word 0x0801CF65
.word 0x16
.word 0x0801CF81
.word 0x02
.word 0x0801CFA9
.word 0x0C
.word 0
.word 0x0004000B
.word 0

.align
.ltorg
