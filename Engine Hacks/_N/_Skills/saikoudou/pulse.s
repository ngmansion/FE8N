.equ PULSE_ID, (0x19)	@奥義の鼓動の状態異常
@000185f0
.thumb
@奥義の鼓動の状態異常を自然治癒しなくする
pulse:
.short 0x1c21
.short 0x3130
.short 0x780b
	lsl r0, r3, #24
	lsr r0, r0, #24
	cmp r0, #PULSE_ID
	beq dontHeal

@.short 0x2001
@.short 0x4680
@.short 0x1c21
@.short 0x3130
@.short 0x780b
.short 0x4660
@.short 0x4018
@.short 0x2800
	ldr r2, =0x080185fc
	mov pc, r2

dontHeal:
@	sub r3, #0x10
@	strb r3, [r1]
	ldr r2, =0x08018630
	mov pc, r2
