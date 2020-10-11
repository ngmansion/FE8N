.thumb
.org 0x000173b4
$080173b4:
.org 0x0002aae4
    push {r4, r5, lr}
    mov r4, r0
    mov r1, #74
    ldrh r0, [r1, r4]
    bl $080173b4        @r0に武器の重さ
    mov r5, r0
    ldrb r0, [r4, #20]  @力
    mov r1, #5
    swi #6      @(r0)/(r1)

    ldrb r1, [r4, #26]  @体格
    add r1, r1, r0
    sub r0, r5, r1
    bhi make
    mov r0, #0
make:
    ldrb r1, [r4, #22]
    sub r0, r1, r0
    bge plus
    mov r0, #0
plus:
    add r4, #94
    strh r0, [r4]
    pop {r4, r5, pc}
