ATK_ID = (0x5)
PULSE_ID = (0x09)	@奥義の鼓動ID

.thumb
    push {r4, lr}
    mov r4, r0
    mov r0, r5
        ldr r1, adr @治癒
        mov lr, r1
        .short 0xF800
    mov r2, r0
    mov r0, r4
    ldr r1, =0x08019f44
    ldr r1, [r1]
    add r0, r0, r1
    ldrb r0, [r0]
    lsl r0, r0, #24
    asr r0, r0, #24
    orr r0, r2
    
	mov	r2, r5
	add	r2, #48
	ldrb	r1, [r2]	@状態異常ロード
	mov	r2, #15
	and	r2, r1
	cmp	r2, #ATK_ID
	blt endTiyu
	cmp	r2, #PULSE_ID
	bgt	endTiyu
falseTiyu:  @ATK～PULSEの間なら強制無効化
	mov r0, #0
endTiyu:
    pop {r4, pc}
.align
.ltorg
adr:



