.thumb
@;@org	$0802b004
    push {r4, lr}
    mov r4, #0
    ldr r0, [r0, #76]
    mov r1, #32
    and r0, r1
    cmp r0, #0
    bne Brave @;x勇者武器持ってるなら

    bl dengeki
    cmp r4, #0
    beq endBrave
Brave:
    ldr r0, =0x0203a604
    ldr r3, [r0, #0]
    ldr r2, [r3, #0]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #16
    orr r1, r0
    ldr r0, =0xFFF80000
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]
    mov r4, #1				@;攻撃回数加算
endBrave:
    bl renzoku
    
    mov r0, r4
    pop {r4}
    pop {pc}

renzoku:
    push {lr}
    mov r0, r6
        ldr r1, ADDRESS @;連続
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq endRenzoku
got:
	mov	r0, #0x15
	ldsb	r0, [r6, r0]
	lsl	r0, r0, #16
	lsr	r0, r0, #16
	
	ldrb r0, [r6, #0x13] @;現在HP
	ldrb r1, [r6, #0x12] @;最大HP
	cmp r0, r1
	blt endRenzoku
	add r4, #1				@;攻撃回数加算
endRenzoku:
    pop {pc}

dengeki:
    push {lr}
    ldr r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne end_bolt

    mov r0, r6
    mov r1, r8
        ldr r3, ADDRESS+4 @;bolt
        mov lr, r3
        .short 0xF800
    orr r4, r0
    
    mov r0, r8
    mov r1, r6
        ldr r3, ADDRESS+4 @;bolt
        mov lr, r3
        .short 0xF800
    orr r4, r0
end_bolt:
    pop {pc}

.ltorg
ADDRESS:
