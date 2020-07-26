.thumb

WAR_ADR = (67)	@書き込み先(AI1カウンタ)

HAS_DARTING_FUNC = (Adr+36)

@.org 0802af18
    mov r5, r0
    ldr r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne normal @闘技場なら終了

    bl GetFollowUpPoint

    cmp r0, #0
    bgt active      @追撃値プラス
    blt disable     @追撃値マイナス
    b normal

disable:
    ldr r0, =0x0802af80 @追撃無し
    mov pc, r0

active:    @攻守続投
    ldr r0, =0x0802af60
    mov pc, r0
normal: @通常追撃判定
    mov r0, r5
    mov r1, #94
    ldsh r2, [r6, r1]
    ldsh r3, [r5, r1]
    ldr r1, =0x0802af24
    mov pc, r1


GetFollowUpPoint:
        push {r4, r5, r6, r7, lr}
        mov r5, #0
        mov r6, #0
        ldr r4, [r4]
        ldr r7, [r7]

        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #0xB]
        ldrb r1, [r4, #0xB]
        cmp r0, r1
        beq notReverse  @r4が攻め側なので反転不要
        eor r7, r4
        eor r4, r7
        eor r7, r4
        bl followup_skills_def
        eor r0, r1
        eor r1, r0
        eor r0, r1
        b endReverse
    notReverse:
        bl followup_skills_atk
    endReverse:
        pop {r4, r5, r6, r7, pc}


followup_skills_atk:
        push {lr}
    @守備隊形
        mov r0, r4
        mov r1, r7
        bl waryFighter_judgeActivate    @守備隊形
        cmp r0, #0
        beq jumpWaryFighter
        sub r5, #1
        sub r6, #1
    jumpWaryFighter:

    @差し違え
        mov r0, r4
        mov r1, r7
        bl BrashAssault @差し違え
        cmp r0, #0
        beq jumpBrashAssault
        add r5, #1
    jumpBrashAssault:

    @戦技
        mov r0, r4
        bl WarSkill @戦技
        cmp r0, #0
        beq jumpWar
        sub r5, #1
    jumpWar:

        mov r0, r5
        mov r1, r6
        pop {pc}


followup_skills_def:
        push {lr}
    @守備隊形
        mov r0, r4
        mov r1, r7
        bl waryFighter_judgeActivate    @守備隊形
        cmp r0, #0
        beq jumpWaryFighter_def
        sub r5, #1
        sub r6, #1
    jumpWaryFighter_def:

    @切り返し
        mov r0, r7
        mov r1, r4
        bl QuickRiposte @切り返し
        cmp r0, #0
        beq jumpQuickRiposte
        add r6, #1
    jumpQuickRiposte:

    @瞬撃
        mov r0, r4
        mov r1, r7
        bl Impact   @瞬撃
        cmp r0, #0
        beq jumpImpact
        sub r6, #1
    jumpImpact:

        mov r0, r5
        mov r1, r6
        pop {pc}

WarSkill:
        ldrb r1, [r0, #0xB]
        mov r2, #0xC0
        and r2, r1
        bne falseWar

        ldr r2, =0x03004df0
        ldr r2, [r2]
        ldrb r2, [r2, #11]
        cmp r1, r2
        bne falseWar

        add r0, #WAR_ADR
        ldrb r0, [r0]
        cmp r0, #0
        beq falseWar
        mov r0, #1
        bx lr
    falseWar:
        mov r0, #0
        bx lr


Impact:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

        mov r0, r5
            ldr r2, Adr+20 @見切り
            mov lr, r2
            .short 0xF800
        cmp r0, #1
        beq falseDarting

        mov r0, r4
            ldr r2, HAS_DARTING_FUNC
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq falseDarting

        mov r0, #1
        b endDarting
    falseDarting:
        mov r0, #0
    endDarting:
        pop {r4, r5, pc}


waryFighter_judgeActivate:
        push {r5, r6, r7, lr}
        mov r5, r0
        mov r6, r1
        mov r7, #0

        mov r0, r6
        mov r1, r5
        bl HasWaryFighter
        orr r7, r0
        
        mov r0, r5
        mov r1, r6
        bl HasWaryFighter
        orr r7, r0

        mov r0, r7
        pop {r5, r6, r7, pc}
        
BrashAssault:   @差し違え
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

        mov r0, #72
        ldrh r0, [r4, r0]   @反撃されないなら不可
        cmp r0, #0
        beq non_bold
        mov r0, #72
        ldrh r0, [r5, r0]   @反撃されないなら不可
        cmp r0, #0
        beq non_bold

        mov r0, r4
        mov r1, r5
            ldr r2, Adr+28 @攻撃隊形@見切り
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq	non_bold

        mov r0, #1
        .short 0xE000
    non_bold:
        mov r0, #0
        pop {r4, r5, pc}

QuickRiposte: @切り返し
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

        ldrb r0, [r4, #0xB]
            ldr r1, =0x08019108
            mov lr, r1
            .short 0xF800
        
        ldrb r0, [r0, #19]  @現在
        ldrb r1, [r4, #18]
        asr r1, r1, #1
        cmp r0, r1
        blt non_vengeful    @HP半分

        mov r0, #72
        ldrh r0, [r5, r0]   @反撃されないなら不可
        cmp r0, #0
        beq non_vengeful

        mov r0, r4
        mov r1, r5
            ldr r2, Adr+32 @切り返し@見切り
            mov lr, r2
            .short 0xF800
        cmp r0, #0
        beq	non_vengeful

        mov r0, #1
        .short 0xE000
    non_vengeful:
        mov r0, #0
        pop {r4, r5, pc}



    breaker_judgeActivate:
        push {r7,lr}
            mov r7, #0
            mov r0, r5
            mov r1, r6
            bl breaker_impl @殺しスキル攻め側判定
            orr r7, r0
            
            mov r0, r6
            mov r1, r5
            bl breaker_impl @殺しスキル受け側判定
            lsl r0, r0, #4
            orr r0, r7
        pop {r7,pc}


        breaker_impl:
            push {r4, r5, lr}
                b end @殺しスキルはダミー
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    ldr r1, Adr+20 @見切り
                    mov lr, r1
                    .short 0xF800
                cmp r0, #0
                bne	end
                    ldr r0, =0x080172f0
                    mov lr, r0
                    mov r0, r5
                    add	r0, #74
                    ldrh r0, [r0]
                    .short 0xF800
                cmp r0, #0
                beq sword
                cmp r0, #1
                beq lance
                cmp r0, #2
                beq axe
                cmp r0, #3
                beq bow
                cmp r0, #4
                beq end
                cmp r0, #7
                ble magic
                b end
                
            sword:
                ldr r0, Adr
                mov lr, r0
                mov r0, r4
                .short 0xF800
                b merge
            lance:
                ldr r0, Adr+4
                mov lr, r0
                mov r0, r4
                .short 0xF800
                b merge
            axe:
                ldr r0, Adr+8
                mov lr, r0
                mov r0, r4
                .short 0xF800
                b merge
            bow:
                ldr r0, Adr+12
                mov lr, r0
                mov r0, r4
                .short 0xF800
                b merge
            magic:
                ldr r0, Adr+16
                mov lr, r0
                mov r0, r4
                .short 0xF800
            merge:
                cmp r0, #0
                beq end
                
                mov r0, #1
            pop {r4, r5, pc}
            end:
                mov r0, #0
            pop {r4, r5, pc}

.align
HasWaryFighter:
ldr r2, Adr+40
mov pc, r2

.align
.ltorg
Adr:
