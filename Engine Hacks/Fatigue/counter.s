.thumb
UNIT_MAX_NUM = (51)
FATIGUE_MAX = (3)

REST_CONDITION =    0x02210004

Unit:
        push {r4, lr}
        bl IsIgnoreMap
        cmp r0, #1
        beq endOutLoopUnit

        mov r4, #1	@部隊表IDは1から
    outLoopUnit:
        cmp r4, #UNIT_MAX_NUM
        bgt endOutLoopUnit
        
        mov r0, r4
            ldr r1, =0x08019108
            mov lr, r1
            .short 0xF800
        ldr r1, [r0]
        cmp r1, #0
        beq endOutLoopUnit @ユニットがもういない

        bl Count
        add r4, #1
        b outLoopUnit

    endOutLoopUnit:
        pop {r4, pc}


IsIgnoreMap:
        push {lr}

        ldr r1, FATIGUE_STATUS
        ldrb r1, [r1]
        cmp r1, #0          @序章は無視
        beq trueIgnore
        ldr r2, ChapterIgnoreSetting_Fatigue
        bl Listfunc
        .short 0xE000
    trueIgnore:
        mov r0, #1
        pop {pc}



.align
Count:
        push {r4, lr}
        mov r4, r0

        bl JudgeCount
        cmp r0, #1
        beq clearCount

        add r4, #71
        ldrb r2, [r4]
        mov r0, #0b00000011
        and r2, r0
        cmp r2, #FATIGUE_MAX
        bge endCount

        add r2, #1
        strb r2, [r4]
        b endCount
    clearCount:
        add r4, #71
        ldrb r2, [r4]
        mov r0, #0b00000011
        bic r2, r0
        strb r2, [r4]
    endCount:
        pop {r4, pc}


    JudgeCount:
            push {lr}
            ldr r1, [r4, #12]
            ldr r0, =REST_CONDITION
            and r1, r0
            bne trueClear

            ldr r1, FATIGUE_STATUS
            ldrb r1, [r1]
            ldr r2, ChapterSetting_Fatigue
            bl Listfunc
            cmp r0, #1
            beq trueClear

            ldr r1, [r4]
            ldrb r1, [r1, #4]
            ldr r2, UnitSetting_Fatigue
            bl Listfunc
            cmp r0, #1
            beq trueClear
    
            mov r0, #0
            .short 0xE000
        trueClear:
            mov r0, #1
            pop {pc}

Listfunc:
@r2 = リスト先頭ポインタ
@r1 = 検索キー
    whileLoop:
        ldrb r0, [r2]
        cmp r0, #0
        beq endLoop
        cmp r0, r1
        beq trueLoop
        add r2, #1
        b whileLoop
    trueLoop:
        mov r0, #1
    endLoop:
        bx lr

UnitSetting_Fatigue = addr+0
ChapterSetting_Fatigue = addr+4
ChapterIgnoreSetting_Fatigue = addr+8
FATIGUE_STATUS = addr+12

.align
.ltorg
addr:
