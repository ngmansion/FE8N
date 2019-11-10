@define hasRemove (adr+0)
;0x01cefc
@thumb
    bl random
    cmp r0, #0
    beq RETURN
    
Sound:	;再行動
    ldr	r0, =$0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	RETURN
    mov	r0, #97
    ldr	r2, =$080d4ef4
    mov	lr, r2
    @dcw 0xf800

RETURN:
	mov r0, #0
    ldr r3, =$0801cf5e
    mov pc, r3



random
    push {lr}
    ldr r0, [r4]
        @align 4
        ldr r2, [hasRemove]
        mov lr, r2
        @dcw $F800
    cmp r0, #0
;    beq non
        mov r0, #99
        ldr r2, =$08000c58
        mov lr, r2
        @dcw 0xf800
    ldr r1, [r4]
    ldrb	r1, [r1, #25]
    cmp	r1, r0
;    ble	non
    ldr r0, [r4]
    ldr	r1, [r0, #12]
    ldr	r2, =$fffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    mov	r0, #1
    @dcw $E000
non:
    mov	r0, #0
    pop	{lr}
@ltorg
adr:
