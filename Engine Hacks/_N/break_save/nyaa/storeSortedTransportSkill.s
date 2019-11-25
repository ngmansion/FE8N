MIN_ID = (1)
MAX_ID = (51)	@保存可能IDは1～51まで
ONE_UNIT_DATA_SIZE = (3)	@1ユニット3バイト
TRANSPORT_DATA_ADR = (0x0203a818)

WORK_MEM_ADR = ADR

.thumb
@08031630
	ldr	r4, =0x08031658
	ldr r4, [r4]
	ldr	r1, [r4, #0]
	mov	r5, #0	
	str	r5, [r1, #0]
	bl main
	mov r0, r6
	ldr	r1, [r4, #0]
	ldr r2, =0x08031638
	mov pc, r2
	
main:
	push {lr}
	
	ldr r0, =0x0803169c
	ldr r0, [r0]
	add r0, #4	@カウンタ格納アドレス取得
	ldrb r0, [r0]
	cmp r0, #MIN_ID
	blt return	
	cmp r0, #MAX_ID
	bgt return	@展開先部隊IDが保存不可
	
	ldrb r1, [r6, #0xB]
	cmp r1, #MIN_ID
	blt return	
	cmp r1, #MAX_ID
	bgt return	@入力元部隊IDが保存不可
	
	sub r0, #1
	mov r2, #ONE_UNIT_DATA_SIZE
	mul r0, r2
	ldr r2, WORK_MEM_ADR
	add r0, r2
	
	sub r1, #1
	mov r2, #ONE_UNIT_DATA_SIZE
	mul r1, r2
	ldr r2, =TRANSPORT_DATA_ADR
	add r1, r2
	
	mov r2, #ONE_UNIT_DATA_SIZE
		ldr r3,  =0x080d6908
		mov lr, r3
		.short 0xF800
return:
	pop {pc}
.align
.ltorg
ADR:
	
