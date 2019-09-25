.equ hasRemove, (adr+0)
@;0x01cefc
.thumb
    bl random
    cmp r0, #0
    beq RETURN
    
Sound:	@;再行動
    ldr	r0, =0x0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	RETURN
    mov	r0, #97
    ldr	r2, =0x080d4ef4
    mov	lr, r2
    .short 0xf800

RETURN:
	mov r0, #0
    ldr r3, =0x0801cf5e
    mov pc, r3



random:
    push {lr}
    
    ldr r0, [r0, #12]
    ldr r1, =0x0801cf04
    ldr r1, [r1]
    and	r0, r1	@;再移動前はスキップ
    beq non
    
    
    
    ldr r0, [r4]
        ldr r2, hasRemove
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non
        mov r0, #99
        ldr r2, =0x08000c58
        mov lr, r2
        .short 0xf800
    ldr r1, [r4]
    ldrb	r1, [r1, #25]
    cmp	r1, r0
    ble	non
    ldr r0, [r4]
    ldr	r1, [r0, #12]
    ldr	r2, =0xfffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    mov	r0, #1
    .short 0xE000
non:
    mov	r0, #0
    pop	{pc}
.ltorg
adr:
