.thumb

ARENA_ADDR = (0x0203a4d0)

@       書き換え
@       00017bdc > 70 47
@
@       0002aeec > 00 4A 97 46 XX XX XX 08(コレを貼るアドレス)
@
        push    {r4, r5, lr}
        mov     r4, r0
        mov     r5, r1
        ldr     r0, =0x0203A568
        bl      func1
        cmp     r0, #0
        beq     jump1
        ldr     r0, =0x0203A4E8
        b       jump2
jump1:
        ldr     r0, =0x0203A568
jump2:
        str     r0, [r5, #0]
        bl      func2
        str     r0, [r4, #0]
        pop     {r4, r5, pc}
        
        
func1:
        push    {r4, r5, lr}
        mov r4, r0
        ldr r0, =ARENA_ADDR
        ldrh r0, [r0]
        mov r2, #0x20
        and r2, r0
        bne false       @闘技場なら終了

@@@@@@@@@@@@受け側チェック
        mov     r5, #0
        mov     r2, r4
        add     r2, #72
        ldrh    r2, [r2]

        cmp     r2, #0
        beq     false   @装備なしなら不発
        ldr     r2, [r4, #76]
        lsl     r3, r2, #24
        bmi     false   @反撃不可武器なら不発

        mov  r0, r4
        bl   func2
        bl   HAS_LIONINE_POISE
        cmp  r0, #1
        beq  true

        mov     r0, r4
        bl      HAS_VANTAGE
        cmp     r0, #0
        beq     false   @待ち伏せ未所持なら不発
        mov     r0, r4
        bl      HAS_NIHIL
        cmp     r0, #0
        beq     skipVantage     @見切り未所持
@受けが待ち伏せと見切りの両方持ちなら、この時点で一旦オン
        ldr     r2, =0x0203A4D0         @??????????
        ldrh    r2, [r2]
        mov     r5, #1
        and     r5, r2
skipVantage:

        mov     r0, r4
        bl      func2        @攻め側のアドレス取得
        mov     r4, r0
@@@@@@@@@@@@攻め側チェック
        ldr     r2, [r4, #76]
        lsl     r3, r2, #24
        bmi     false   @反撃不可武器なら不発
        mov     r0, r4
        bl      HAS_NIHIL
        cmp     r0, #1
        beq     false   @攻め側が見切りを持っているなら不発
        
        mov     r0, r4
        bl      HAS_VANTAGE
        cmp     r0, #1
        beq     end     @攻め側が待ち伏せを持っているならスキップ
true:
        ldr     r0, =0x0203A4D0         @??????????
        ldrh    r0, [r0]
        mov     r5, #1
        and     r5, r0
        b end
false:
        mov r5, #0
end:
        mov     r0, r5
        pop     {r4, r5, pc}
        
        
func2:
        ldr     r2, =0x0203A568
        mov     r3, r0
        sub     r0, #128
        cmp     r3, r2
        beq     jump201
        add     r3, #128
        mov     r0, r3
jump201:
        bx      lr
        

.align

HAS_VANTAGE:
ldr r1, addr
mov pc, r1

HAS_NIHIL:
ldr r1, addr+4
mov pc, r1

HAS_LIONINE_POISE:
ldr r1, addr+8
mov pc, r1

.align
.ltorg
addr:

