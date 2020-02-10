.thumb
@org   0802aac0
    

    mov r1, #8
    ldrb r1, [r7, r1]
    cmp r1, #7  @武器種
    bgt butu
    cmp r1, #4  @武器種
    ble butu
    b magi    @魔法
butu:
    push {r0}
    mov r0, r6
    mov r1, r8
    bl ChangeMagic
    cmp r0, #1
    pop {r0}
    beq magi
    mov r1, #20 @ここから力読み込み
    ldsb r1, [r6, r1]
    b end
magi:
    mov r1, #26 @ここから体格読み込み
    ldsb r1, [r6, r1]
end:
    add r0, r0, r1
    strh r0, [r5]
    ldr r0, =0x0802aac8
    mov pc, r0
    
ChangeMagic:
    ldr r2, addr
    mov pc, r2
    
.align
.ltorg
addr:
    