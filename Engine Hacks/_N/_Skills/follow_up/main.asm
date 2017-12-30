@thumb
;@org 0002af18
    mov r5, r0
    
    bl waryFighter_judgeActivate
    push {r0}
    bl followup_skill
    pop {r1}
    
    cmp r0, #0x00
    beq	no_active
    cmp r0, #0x11
    beq	no_active
;active
    cmp r1, #0
    bne normal
    cmp r0, #0x01
    beq active1
    cmp r0, #0x10
    beq active2
    b normal
active1:
    ldr r0, =$0802af56
    mov pc, r0
active2:
    ldr r0, =$0802af5c
    mov pc, r0

no_active:
    cmp r1, #0
    beq normal
    ldr r0, =$0802af80 ;追撃無し
    mov pc, r0
    
normal:
    mov r0, r5
    mov r1, #94
    ldsh r2, [r6, r1]
    ldsh r3, [r5, r1]
    ldr r1, =$0802af24
    mov pc, r1


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
                @align 4
                ldr r1, [Adr+20] ;見切り
                mov lr, r1
                @dcw $F800
            cmp r0, #0
            bne	non_waryFighter_impl
            
            mov r0, r4
                @align 4
                ldr r1, [Adr+24] ;守備隊形
                mov lr, r1
                @dcw $F800
            cmp r0, #0
            beq	non_waryFighter_impl
            
            mov r0, #1
            @dcw $E000
        non_waryFighter_impl:
            mov r0, #0
        pop {r4, r5, pc}


    followup_skill:
    push {r7, lr}
        bl formation_judgeActivate
        mov r7, r0
        bl breaker_judgeActivate
        orr r0, r7
    pop {r7, pc}

        formation_judgeActivate:
        push {r7, lr}
            mov r0, r5
            mov r1, r6
            bl boldFighter ;攻撃隊形
            mov r7, r0
            
            mov r0, r6
            mov r1, r5
            bl vengefulFighter ;迎撃隊形
            lsl r0, r0, #4
            orr r0, r7
        pop {r7, pc}


            boldFighter:
            push {r4, r5, lr}
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    @align 4
                    ldr r1, [Adr+20] ;見切り
                    mov lr, r1
                    @dcw $F800
                cmp r0, #0
                bne	non_bold
                
                mov r0, r4
                    @align 4
                    ldr r1, [Adr+28] ;攻撃隊形
                    mov lr, r1
                    @dcw $F800
                cmp r0, #0
                beq	non_bold
                mov r0, #1
                @dcw $E000
            non_bold:
                mov r0, #0
            pop {r4, r5, pc}

            vengefulFighter:
            push {r4, r5, lr}
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    @align 4
                    ldr r1, [Adr+20] ;見切り
                    mov lr, r1
                    @dcw $F800
                cmp r0, #0
                bne	non_vengeful
                
                mov r0, r4
                    @align 4
                    ldr r1, [Adr+32] ;迎撃隊形
                    mov lr, r1
                    @dcw $F800
                cmp r0, #0
                beq	non_vengeful
                mov r0, #1
                @dcw $E000
            non_vengeful:
                mov r0, #0
            pop {r4, r5, pc}



        breaker_judgeActivate:
        push {r7,lr}
            mov r7, #0

            mov r0, r5
            mov r1, r6
            bl breaker_impl
            orr r7, r0
            
            mov r0, r6
            mov r1, r5
            bl breaker_impl
            lsl r0, r0, #4
            orr r0, r7
        pop {r7,pc}


            breaker_impl:
            push {r4, r5, lr}
                mov r4, r0
                mov r5, r1
                
                mov r0, r5
                    @align 4
                    ldr r1, [Adr+20] ;見切り
                    mov lr, r1
                    @dcw $F800
                cmp r0, #0
                bne	end
                    ldr r0, =$080172f0
                    mov lr, r0
                    mov r0, r5
                    add	r0, #74
                    ldrh r0, [r0]
                    @dcw $F800
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
                @align 4
                ldr r0, [Adr]
                mov lr, r0
                mov r0, r4
                @dcw $F800
                b merge
            lance:
                @align 4
                ldr r0, [Adr+4]
                mov lr, r0
                mov r0, r4
                @dcw $F800
                b merge
            axe:
                @align 4
                ldr r0, [Adr+8]
                mov lr, r0
                mov r0, r4
                @dcw $F800
                b merge
            bow:
                @align 4
                ldr r0, [Adr+12]
                mov lr, r0
                mov r0, r4
                @dcw $F800
                b merge
            magic:
                @align 4
                ldr r0, [Adr+16]
                mov lr, r0
                mov r0, r4
                @dcw $F800
            merge:
                cmp r0, #0
                beq end
                
                mov r0, #1
            pop {r4, r5, pc}
            end:
                mov r0, #0
            pop {r4, r5, pc}
    
    
@ltorg
Adr:
