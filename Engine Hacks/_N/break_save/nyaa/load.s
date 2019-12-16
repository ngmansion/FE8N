CHAPTER_BASE_ADR = (0x0202bcec)
.thumb
@080a7cb0
    push {r4, r5, r6, r7, lr}
    sub sp, #176
    sub sp, #176
    nop			@消すと下の命令が異常動作する・・・
    ldr r1, =0x080a9bb5
    mov r0, lr
    cmp r0, r1
    beq normal
    mov r0, #0
    b merge
    
normal:
	ldr r0, =CHAPTER_BASE_ADR
	ldrb r0, [r0, #12]
@	mov r0, r9
    add r0, #1
merge:
    ldr r1, =0x160
    mul r0, r1
    ldr r1, =0x0E007400
    add r1, r0, r1
    mov r4, r1
@ここからスキル
    mov r1, #0
    cmp r0, #0
    bne jump
    mov r1, #1
jump:
    mov r0, r1
        ldr r1, ADR
        mov lr, r1
        .short 0xF800
@ここまでスキル
    mov r0, r4
    
    ldr r1, =0x080a7d24
    ldr r1, [r1]
    ldr r3, [r1]
    mov r1, sp
        ldr r2, =0x080d65c8 @
        mov lr, r2
        mov r2, #176
        lsl r2, r2, #1
        .short 0xF800
    nop
        ldr r0, =0x0803144c @=輸送隊のベースアドレスロード
        mov lr, r0
        .short 0xF800
    mov r4, r0
    add r5, sp, #100
    add r5, #100
    ldr r1, =0x080a7cc8
    mov pc, r1
.align
.ltorg
ADR:

