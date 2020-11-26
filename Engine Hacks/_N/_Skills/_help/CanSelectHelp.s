.thumb
    mov r1, #0
    b start
    mov r1, #1
    b start
    mov r1, #2
    b start
    mov r1, #3
    b start
    mov r1, #4
    b start
    mov r1, #5
    b start
    mov r1, #6
    b start
    mov r1, #7
start:
    push {r4, lr}
    mov r4, r0
    ldr r0, ADDR+0
    ldrb r0, [r1, r0]
    cmp r0, #0
    bne canSelect
    ldr r0, =0x0808aeb0 @選択できなくする処理
    mov pc, r0
canSelect:
    pop {r4, pc}
.align
.ltorg
ADDR:
