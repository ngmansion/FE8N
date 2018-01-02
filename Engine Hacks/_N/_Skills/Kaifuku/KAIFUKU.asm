@thumb
;@org	$08019f28
    push {r0}
    @align 4
    ldr r1, [adr] ;回復
    mov lr, r1
    mov r0, r5
    @dcw $F800
    pop {r2}
    cmp r0, #0
    beq nonHeal
    
gotHeal:
	mov	r3, #20
	b	end
nonHeal:
	mov	r3, #0
end:
	ldr	r1, =$08019f34
	ldr	r1, [r1]
	add	r0, r2, r1
	ldrb	r0, [r0]
	lsl	r0, r0, #24
	asr	r0, r0, #24
	add	r0, r0, r3
	bx	lr
@ltorg
adr: