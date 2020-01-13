.thumb
@
@For
@0x0369c4
@0x036a46
@0x058718
@0x058754
@
@条件を整えてDivide.sをコール
@
@[in]
@r0 = 受け
@r1 = 攻め
@
@[out]
@r0 = ダメージ
@r1 = 攻め
@r2 = 受け
@

main:
    push {r2, lr}
    mov r2, r0

    mov r0, #90
    mov r3, #92
    ldrh r0, [r1, r0]
    ldrh r3, [r2, r3]
    sub r0, r3

    ldr r3, addr
    mov lr, r3
    .short 0xF800

    mov r1, r0
    pop {r2, pc}

.align
.ltorg
addr:

