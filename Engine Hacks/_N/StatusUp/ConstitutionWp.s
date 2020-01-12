.thumb
    push {r4, lr}
    mov r4, r0  
    bl  $000168d0   @装備チェック
    lsl r0, r0, #16
    lsr r0, r0, #16
    bl  $000161c8   @体格武器補正値
    pop {r4, pc}

$000168d0:
    ldr r1, =0x080168d0
    mov pc, r1

$000161c8:
    mov r1, r0  
    cmp r1, #0
    beq non
    mov r0, #255
    and r0, r1
    lsl r1, r0, #3
    add r1, r1, r0
    lsl r1, r1, #2
    ldr r0, =0x080172bc  @アイテム先頭アドレス
    ldr r0, [r0]        @アイテム先頭アドレスロード
    add r1, r1, r0
    ldr r0, [r1, #12]
    cmp r0, #0
    bne jump
non:
    mov r0, #0
    b   end
jump:
    ldrb    r0, [r0, #8]    @ボデリン補正
    lsl r0, r0, #24
    asr r0, r0, #24
end:
    bx lr
    

