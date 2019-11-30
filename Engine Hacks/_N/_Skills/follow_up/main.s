.thumb
HAS_DARTING_FUNC = (Adr+36)

@.org 0002af18
    mov r5, r0
    ldr r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne normal @闘技場なら終了
    
    bl waryFighter_judgeActivate
    push {r0}
    bl followup_skill
    pop {r1}
    
    cmp r0, #0x00
    beq	no_active
    cmp r0, #0x11
    beq	no_active
@絶対追撃発動
    cmp r1, #0
    bne normal @1なら守備隊形発動
    cmp r0, #0x01
    beq active1
    cmp r0, #0x10
    beq active2
    b normal
active1:
    ldr r0, =0x0802af56
    mov pc, r0
active2:
    ldr r0, =0x0802af5c
    mov pc, r0

no_active:
    cmp r1, #0
    beq normal
    ldr r0, =0x0802af80 @追撃無し
    mov pc, r0
    

    
    
normal: @通常追撃判定
    mov r0, r5
    mov r1, #94
    ldsh r2, [r6, r1]
    ldsh r3, [r5, r1]
    ldr r1, =0x0802af24
    mov pc, r1


active_DartingBlow:
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

        ldr r0, =0x03004df0
        ldr r0, [r0]
        ldrb r0, [r0, #0xB]
        ldrb r1, [r4, #0xB]
        cmp r0, r1
        bne falseDarting    @攻め者と不一致

        mov r0, #1
        b endDarting
    falseDarting:
        mov r0, #0
    endDarting:
        pop {pc}



waryFighter_judgeActivate:
    push {r7, lr}
        mov r0, r6
        mov r1, r5
        bl waryFighter_impl
        mov r7, r0
        
        mov r0, r5
        mov r1, r6
        bl waryFighter_impl
        orr r0, r7
    pop {r7, pc}
        
waryFighter_impl:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        
        mov r0, r5
            ldr r1, Adr+20 @見切り
            mov lr, r1
            .short 0xF800
        cmp r0, #1
        beq	non_waryFighter_impl

        mov r0, r5
        mov r1, r4
        bl active_DartingBlow
        cmp r0, #1
        beq non_waryFighter_impl    @相手が飛燕発動
        
        mov r0, r4
            ldr r1, Adr+24 @守備隊形
            mov lr, r1
            .short 0xF800
        cmp r0, #0
        beq	non_waryFighter_impl
        
        mov r0, #1
        .short 0xE000
        non_waryFighter_impl:
            mov r0, #0
        pop {r4, r5, pc}


followup_skill:
    push {r7, lr}
        bl formation_judgeActivate @隊形スキル
        mov r7, r0
        bl breaker_judgeActivate @殺しスキル
        orr r0, r7
    pop {r7, pc}

    formation_judgeActivate:
        push {r7, lr}
            mov r0, r5
            mov r1, r6
            bl boldFighter @攻撃隊形
            mov r7, r0
            
            mov r0, r6
            mov r1, r5
            bl vengefulFighter @迎撃隊形
            lsl r0, r0, #4
            orr r0, r7
        pop {r7, pc}


        boldFighter: @攻撃隊形
            push {r4, r5, lr}
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    ldr r1, Adr+20 @見切り
                    mov lr, r1
                    .short 0xF800
                cmp r0, #1
                beq	non_bold
                
                mov r0, r5
                mov r1, r4
                bl active_DartingBlow
                cmp r0, #1
                beq	non_bold

                mov r0, r4
                    ldr r1, Adr+28 @攻撃隊形
                    mov lr, r1
                    .short 0xF800
                cmp r0, #0
                beq	non_bold

                mov r0, #72
                ldrh r0, [r4, r0]	@反撃されないなら不可
                cmp r0, #0
                beq non_bold
                mov r0, #72
                ldrh r0, [r5, r0]	@反撃されないなら不可
                cmp r0, #0
                beq non_bold
                mov r0, #1
                .short 0xE000
            non_bold:
                mov r0, #0
            pop {r4, r5, pc}

        vengefulFighter: @迎撃隊形
            push {r4, r5, lr}
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    ldr r1, Adr+20 @見切り
                    mov lr, r1
                    .short 0xF800
                cmp r0, #1
                beq	non_vengeful
                
                mov r0, r5
                mov r1, r4
                bl active_DartingBlow
                cmp r0, #1
                beq	non_vengeful

                mov r0, r4
                    ldr r1, Adr+32 @迎撃隊形
                    mov lr, r1
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
.ltorg
Adr:
