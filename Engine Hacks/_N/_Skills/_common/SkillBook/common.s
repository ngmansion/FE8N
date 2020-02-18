TRANSPORT_DATA_ADR = (0x0203a818)
MIN_UNIT = (1)
MAX_UNIT = (51)

.thumb
b GetExSkillBaseAddr
b EncodeSkill
b DecodeSkill
nop

GetExSkillBaseAddr:
@;I      r0 = 隊列ID
@;O      r0 = ユニットのセーブベースアドレス
	ldrb r0, [r0, #0xB]
	cmp r0, #MIN_UNIT
	blt false
	cmp r0, #MAX_UNIT
	bgt false
	sub r0, #1
	lsl r1, r0, #1
	add r0, r0, r1
	ldr r1, =TRANSPORT_DATA_ADR
	add r0, r0, r1
	b end
false:
	mov r0, #0
end:
	bx lr

EncodeSkill:
        cmp r0, #0
        beq falseEncode
        cmp r0, #255
        bge falseEncode

        ldr r2, addr
        mov r3, #1
    loopEncode:
            
            cmp r3, #63
            bgt falseEncode
            ldrb r1, [r2, r3]
            cmp r0, r1
            beq trueEncode
            add r3, #1
            b loopEncode

    trueEncode:
        mov r0, r3
        .short 0xE000
    falseEncode:
        mov r0, #0
        bx lr

DecodeSkill:
        cmp r0, #0
        beq falseDecode
        cmp r0, #63
        bgt falseDecode

        ldr r2, addr
        ldrb r0, [r2, r0]
        .short 0xE000
    falseDecode:
        mov r0, #0
        bx lr

.align
.ltorg
addr:


