TRANSPORT_DATA_ADR = (0x0203a818)
MIN_UNIT = (1)
MAX_UNIT = (51)

.thumb
b getExSkillBaseAdr
nop
nop
nop

getExSkillBaseAdr:
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

