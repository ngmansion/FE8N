.equ RETURN_ADR, (0x0802b810)
.equ RETURN2_ADR, (0x0802b812)

.equ DEFEAT, (0xFF)
.equ DEFEATED, (0xFE)
.equ DEFEAT2, (0x7F)
.equ DEFEATED2, (0x7E)

@ORG 0x02b808
.thumb
	ldr r0, =0x0203a4d0
	ldrh r1, [r0, #0]
	mov r0, #2
	and r0, r1
	cmp r0, #0
	bne RETURN	@戦闘予測時はスキップ
	
	bl Jinrai
	bl Alina_back
	cmp r0, #1
	beq RETURN2
	
RETURN:
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	ldr r0, =RETURN_ADR
	mov pc, r0
	
RETURN2:
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	mov r0, #0
	ldr r2, =RETURN2_ADR
	mov pc, r2

Alina_back:
@闘技場は死なない
	ldr	r0, =0x0203a4d0
	ldrh r0, [r0]
	mov r1, #0x20
	and r0, r1
	beq falseAlina	@闘技場チェック
	mov r0, #1
	strb r0, [r6, #19]	@現在HP
	b endAlina
falseAlina:
	mov r0, #0
endAlina:
	bx lr

Jinrai:
	ldr r3, =0x03004df0
	ldr r3, [r3]
	ldrb r0, [r3, #11]
	ldrb r1, [r6, #11]
	cmp r0, r1
	beq endJinrai @やられている？
	
	lsl r0, r0, #25
	lsr r0, r0, #30
	bne endJinrai	@攻撃者が敵である
	
    mov r2, #DEFEAT2
	
	mov r0, r3
    add r0, #69
    ldrb	r1, [r0]
    cmp r1, #DEFEATED
    beq normal
    cmp r1, #DEFEATED2
    beq normal
    mov r2, #DEFEAT	@疾風迅雷用
normal:
    strb	r2, [r0]
endJinrai:
    bx lr


