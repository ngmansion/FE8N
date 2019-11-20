MIN_ID = (1)
MAX_ID = (51)	@保存可能IDは1～51まで
ONE_UNIT_DATA_SIZE = (3)	@1ユニット3バイト
TRANSPORT_DATA_ADR = (0x0203a818)

WORK_MEM_ADR = ADR

.thumb
@0803168c
	bl main
	pop	{r4, r5}
	pop	{r0}
	bx	r0
	
main:
	push {lr}
	
	ldr r0, =TRANSPORT_DATA_ADR	@書き戻し先
	ldr r1, WORK_MEM_ADR	@保持元
	
	ldr r2, =0x0803169c
	ldr r2, [r2]
	add r2, #4	@カウンタ格納アドレス取得
	ldrb r2, [r2]
	
	cmp r2, #MAX_ID
	ble not_max
	mov r2, #MAX_ID
not_max:
	mov r3, #ONE_UNIT_DATA_SIZE
	mul r2, r3
	
		ldr r3,  =0x080d6908
		mov lr, r3
		.short 0xF800
return:
	pop {pc}
.align
.ltorg
ADR:
	
