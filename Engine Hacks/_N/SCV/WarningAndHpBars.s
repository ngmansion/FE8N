.thumb
OptionByte2 = 0x0202BD2D

    push {r7}
    sub sp, #0x10
    mov r7, sp

    bl GetOptionByte10  @オリジナルは80
    cmp r0, #1
    beq return

    bl Always

    bl Selecting

return:
    add sp, #0x10
    pop {r7}
    mov r0, #0x30
    ldrb r0, [r4,r0]
    lsl r0, #0x1C
    lsr r0, #0x1C
    ldr r1, return_addr
    mov pc, r1

.align
return_addr:
.long 0x08027660

Always:
        push {lr}
        bl CameraCacheFunc        @カメラ位置をキャッシュ
        cmp r0, #0
        beq falseAlways
        bl HpBars
        bl Pinned
    falseAlways:
        pop {pc}

Selecting:
        push {r6, lr}
        bl IsSelecting
        cmp r0, #0
        beq endSelect

        bl CheckCache
        cmp r0, #1
        beq trueCahce
    falseCache:
        bl CacheFunc
        b endSelect

    trueCahce:
        bl DisplayOtherIcons
    endSelect:
        pop {r6, pc}

CacheFunc:
        push {lr}
        mov r6, #0

        bl IsDanger
        orr r6, r0
        bl CanTalk
        lsl r0, #2
        orr r6, r0

        bl GetWarningCache
        add r0, #2
        ldrb r1, [r4,#0xB]
        strb r6, [r0, r1]       @WriteToCache
        pop {pc}

IsDanger:
        push {lr}

        ldrb r0, [r4, #0xB]
        mov r1, #0x80
        tst r0, r1
        beq falseDanger

        bl GetLiteModeFlag
        cmp r0, #1
        beq heavyDanger

        bl GetOptionByte80      @オリジナルは10
        cmp r0, #0
        beq falseDanger

        bl JUDGE_DANGER_LITE
        b endDanger
    heavyDanger:
        bl JUDGE_DANGER
        b endDanger

    falseDanger:
        mov r0, #0
    endDanger:
        pop {pc}


TALK_CHECK:
    ldr r2, =0x08086240
    mov pc, r2

COMPLETE_CACHE = 2
INCOMPLETE_CACHE = 1
NO_CACHE = 00000000

PRESS_INPUT_ADDR = (0x085775cc)

CheckCache:
        ldr r0, WarningCache
        ldrb r1, [r0]
        cmp r1, #COMPLETE_CACHE
        beq completedCache       @キャッシュ済み
        ldrb r1, [r0, #1]
        ldrb r2, [r4, #0xB]
        cmp r2, r1
        ble completeCache      @キャッシュ完了
    @未キャッシュ
        strb r2, [r0, #1]   @スタートの部隊IDストア
        mov r1, #INCOMPLETE_CACHE
        strb r1, [r0]

        ldr r2, =PRESS_INPUT_ADDR
        ldr r2, [r2]
        ldrh r1, [r2, #4]
        mov r2, #4
        tst r2, r1
        beq JumpCheckCache
        ldr r0, LITE_MODE
        mov r1, #1
        strb r1, [r0]
    JumpCheckCache:

        mov r0, #0
        b endCache
    completeCache:
        mov r1, #COMPLETE_CACHE
        strb r1, [r0]
    completedCache:
        mov r0, #1
    endCache:
        bx lr



CanTalk:
        push {lr}
        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldr r0, [r0]
        ldrb r0, [r0, #4]
        ldr r1, [r4]
        ldrb r1, [r1, #4]
        bl TALK_CHECK
        pop {pc}


DisplayOtherIcons:
        push {lr}
        ldr    r6, WarningCache
        add    r6,#2
        ldrb   r0,[r4,#0xB]
        ldrb   r6,[r6,r0]
        cmp    r6,#0
        beq    GoBack               @nothing to display
    DisplayEffective:
        mov    r0,#0b0001
        tst    r0,r6
        beq    DisplayCrit
        mov    r0,#0x00             @IconSelect
        bl     Draw_Warning_Sign
    DisplayCrit:
        mov    r0,#0b0010
        tst    r0,r6
        beq    DisplayTalk
        mov    r0,#0x00             @IconSelect
        bl     Draw_Warning_Sign
    DisplayTalk:
        mov    r0, #0b0100
        tst    r0,r6
        beq    GoBack
        mov    r0,#0x08             @IconSelect
        bl     Draw_Warning_Sign
    GoBack:
        pop {pc}


IsSelecting:
        ldr r2, =0x03004df0
        ldr r2, [r2]
        cmp r2, #0
        beq notSelecting

        ldrb r0, [r2, #0xB]
        mov r1, #0xC0
        tst r0, r1
        bne notSelecting

        ldrb r0, [r2, #0xC]
        mov r1, #1
        tst r0, r1
        beq notSelecting

        mov r0, #1
        bx lr
    notSelecting:
        ldr r1, WarningCache
        mov r0, #NO_CACHE
        str r0, [r1]        @ClearCache  LITE_MODE
        bx lr



x_coord = 0x10
y_coord = 0x11
CameraStuff = 0x0202BCAC
Xvalue = (0x0201)

CameraCacheFunc:
        push {lr}
        mov r0, #0
        str r0, [r7,#0x0]

        mov      r1,#x_coord
        ldsb  r1,[r4,r1]
        lsl      r1,#4
        ldr      r2,=CameraStuff
        mov      r3,#0xC
        ldsh  r0,[r2,r3]           @camera x
        sub      r3,r1,r0          @r3= x - camera_x
        mov      r0,#y_coord
        ldsb  r0,[r4,r0]
        lsl      r0,#4
        mov      r1,#0xE
        ldsh  r1,[r2,r1]           @camera y
        sub      r2,r0,r1          @r2 = y - camera_y
        mov      r1,r3
        add      r1,#0x10
        mov      r0,#0x80
        lsl      r0,#1
        cmp      r1,r0
        bhi      falseScreen         @x is either >0x100 or <0, so out of range
        mov      r0,r2
        add      r0,#0x10
        cmp      r0,#0xB0
        bhi      falseScreen         @y is either >0xB0 or <0, so out of range

        str      r3,[r7,#0x4]         @sp+4 = x - x'
        str      r2,[r7,#0x8]         @sp+8 = y - y'
@Find out whether we even need to display an hp bar
        mov r0, #1
        str r0, [r7,#0x0]
        .short 0xE000
    falseScreen:
        mov r0, #0
        pop {pc}

HpBars:
        push {lr}

        ldrb r0, [r4, #18]  @
        ldrb r2, [r4, #19]  @現在HP
        cmp r2, r0
        bge falseHPBars @HP最大
        mov r1, r0
        sub r0, r2
        mov r2, #11
        mul r0, r2
        swi #6      @damage*11(r0)/maxHP(r1)
        lsl r2, r0, #2
        ldr r3, HPFramePointers
        ldr r2, [r3, r2]

        ldr r0, [r7, #4]
        ldr r3, = Xvalue
        add r0, r3
        sub r3, #2      @Create 0x1FF
        and r0, r3

        ldr r1, [r7, #8]
        add r1, #0xFB
        mov r3, #0xFF
        and r1, r3

        ldr r3, =0x08002B08
        mov lr, r3
        mov r3, #0
        .short 0xF800
    falseHPBars:
        pop {pc}

Pinned:
        push {lr}
        ldrb r0, [r4, #11]
        lsr r0, r0, #6
        beq falsePin
        mov r0, #0x3B
        ldrb r0, [r4, r0]
        lsl r0, r0, #24
        bpl falsePin

        ldr r2, PinFramePointers

        ldr r0, [r7, #4]
        ldr r3, = Xvalue
        add r0, r3
        sub r3, #2      @Create 0x1FF
        and r0, r3

        ldr r1, [r7, #8]
        add r1, #0xFB
        mov r3, #0xFF
        and r1, r3

        ldr r3, =0x08002B08
        mov lr, r3
        mov r3, #0
        .short 0xF800
    falsePin:
        pop {pc}

WRAMDisplay = 0x08002B08

Draw_Warning_Sign:
@r0=thing to determine what we're drawing, r1=sp (to retrieve x and y stuff)
        push {lr}
        ldr r2, [r7, #0]
        cmp r2, #0
        beq FinishedDrawing

        ldr r2, WS_FrameData
        add r2, r0

        ldr    r1, =0x0201
        ldr    r0,[r7,#4]        @x-x'
        add    r0,r1
        add    r0,#0xB              @tweak for x coordinate, whatever that means
        sub    r1,#2
        and    r0,r1

        ldr    r1,[r7,#8]        @y-y'
        add    r1,#0xEE          @y coordinate tweak?
        mov    r3,#0xFF
        and    r1,r3

        ldr    r3, =WRAMDisplay
        mov    lr, r3
        mov    r3,#0
        .short 0xF800
FinishedDrawing:
        pop {pc}



GetWarningCache:
    ldr r0, WarningCache
    bx lr
GetOptionByte80:
    ldr r0, =OptionByte2
    ldrb r0, [r0]
    mov r1, #0x80
    and r0, r1
    lsr r0, r0, #7
    bx lr
GetOptionByte10:
    ldr r0, =OptionByte2
    ldrb r0, [r0]
    mov r1, #0x10
    and r0, r1
    lsr r0, r0, #4
    bx lr

GetLiteModeFlag:
        ldr r0, LITE_MODE
        ldrb r0, [r0]
        bx lr

LITE_MODE = addr+0
HPFramePointers = addr+4
PinFramePointers = addr+8
WarningCache = addr+12
WS_FrameData = addr+16

JUDGE_DANGER:
    ldr r0, addr+20
    mov pc, r0
JUDGE_DANGER_LITE:
    ldr r0, addr+24
    mov pc, r0

.align
.ltorg
addr:
