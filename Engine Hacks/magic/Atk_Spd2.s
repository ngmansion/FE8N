.thumb
@.org $0802aae4
    push {r4, r5, lr}
    mov r4, r0
    add r0, #74
    ldrh r0, [r0, #0]
        ldr r1, =0x080173b4
        mov lr, r1
        .short 0xF800
    mov r5, r0
    
    ldrb r0, [r4, #20]  @力
    mov r1, #5
    swi #6      @(r0)/(r1)
    mov r1, r0
    
    ldr r0, [r4, #4]
    ldrb r0, [r0, #17]   @クラス体格
    lsl r0, r0, #24
    asr r0, r0, #24
    ldr r2, [r4]
    ldrb r2, [r2, #19]   @ユニット体格
    lsl r2, r2, #24
    asr r2, r2, #24
    add r0, r0, r2          @r0に合計体格
    add r0, r0, r1          @力と合計
    
    sub r1, r5, r0
    cmp r1, #0
    bge jump
    mov r1, #0
jump:
    mov r0, #22
    ldsb r0, [r4, r0]
    sub r0, r0, r1
    mov r1, r4
    add r1, #94
    strh r0, [r1, #0]

@マイナスチェック
    lsl r0, r0, #16
    cmp r0, #0
    bge end
    mov r0, #0
    strh r0, [r1, #0]
end:
    pop {r4, r5, pc}
