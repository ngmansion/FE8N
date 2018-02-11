@thumb
;@org	$08017420

;▽元処理
    ldr r0, =$080172d4	;アイテムテーブル(説明ID)
    ldr r0, [r0]
    add r1, r1, r0
    ldrb r0, [r1, #25]
;△元処理
    mov r1, r13
    ldr r2, =$03007D6C
    cmp r1, r2
    beq end
    ldr r1, [r1, #4]
    ldr r2, =$0802A833
    cmp r1, r2
    beq five
    mov r1, #0x1
    lsl r1, r1, #16
    cmp r6, r1
    bgt six
    cmp r5, r1
    blt zero
five
    ldr r1, [r5, #4]
    b kit
six
    ldr r1, [r6, #4]
    b kit
zero
    ldr r1, =$03004df0
    ldr r1, [r1]
    cmp r1, #0
    beq end
    ldr r1, [r1, #4]
kit
    ldrb r1, [r1, #4]
    cmp r1, #0x1D		;フォレストナイト
    beq tikai
    cmp r1, #0x1E		;フォレストナイト
    bne end
tikai
    cmp r0, #0x11
    beq end
    cmp r0, #0x12
    beq end
    sub r0, #0x10
end:
    lsr r0, r0, #4
    bx lr