
@ 0802ac68

.thumb
		push {r4, lr}
		mov r3, r0      @自分
		mov r4, r1      @相手
            push {r3}
            bl HasAssassinate
            pop {r3}
            cmp r0, #1
            beq $0002ac8a

        mov r1, #72
        ldrh r0, [r3, r1]
        cmp r0, #0
        beq false
        push {r3}
        bl GetWeaponType    @r0に武器の種類ID
        pop {r3}
        
        mov r1, r0
        cmp r1, #0 
        bne false   @剣以外は終了
        mov r0, r4
        add r0, #40
        add r0, r0, r1
        ldrb r0, [r0, #0]
        cmp r0, #250
        bls false

		ldr r0, [r3, #0]
		ldr r1, [r3, #4]
		ldr r2, [r0, #40]
		ldr r0, [r1, #40]
		orr r2, r0
		mov r0, #128
		lsl r0, r0, #18
		and r2, r0
		cmp r2, #0
		bne $0002ac8a
    false:
		mov r0, r3
		add r0, #108
		strh r2, [r0, #0]
		b $0002acbe
	$0002ac8a:
		mov r2, r3
		add r2, #108
		mov r0, #50
		strh r0, [r2, #0]

		ldr r3, [r4, #0]
		ldr r4, [r4, #4]
		ldr r0, [r3, #40]
		ldr r1, [r4, #40]
		orr r0, r1
		mov r1, #128
		lsl r1, r1, #8
		and r0, r1
		cmp r0, #0
		beq $0002acaa
		mov r0, #25
		strh r0, [r2, #0]
	$0002acaa:
		ldr r0, [r3, #40]
		ldr r1, [r4, #40]
		orr r0, r1
		mov r1, #128
		lsl r1, r1, #17
		and r0, r1
		cmp r0, #0
		beq $0002acbe
		mov r0, #0
		strh r0, [r2, #0]
	$0002acbe:
		pop {r4}
		pop {r0}
		bx r0

GetWeaponType:
    ldr r2, =0x080172f0
    mov pc, r2
HasAssassinate:
    ldr r2, ADDR
    mov pc, r2

.align
.ltorg
ADDR:


