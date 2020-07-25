BOOK_MAX = (63)

.thumb
@	00017bd4

@ユニットID一致検索
	ldr r1, [r4]
	ldrb r0, [r1, #4]
	cmp r0, #0xFD   @闘技場相手
	bgt RETURN
	cmp r0, #0x2C   @味方ユニット判定
	bgt notAlly
	b RETURN
@;味方
	mov r5, #0
	bl GetSkill
	mov r5, r0
ret:
	bl GetSkill
	cmp r0, r5
	beq ret
	lsl r5, r5, #6
	orr r0, r0, r5
	strh r0, [r4, #0x3A]
	b RETURN
	
notAlly:
	ldr r0, =0x0202bcec
	ldrb	r1, [r0, #20]
	mov	r0, #64		@難易度ハード
	and r0, r1
	beq RETURN
@ボスチェック
    ldr r0, [r4]
    ldr r1, [r4, #4]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
    ldr r1, =0x01008000
    and r0, r1
    beq RETURN       @ボスじゃない

	mov r5, #0
	bl GetSkill_em
	mov r5, r0
ret_em:
@	bl GetSkill_em
@	cmp r0, r5
@	beq ret_em
@	lsl r5, r5, #6
@	orr r0, r0, r5
	strh r0, [r4, #0x3A]
	
RETURN:
	pop {r4, r5}
	.short 0xbc01
	.short 0x4700



GetSkill:
	push {r5, r6, r7, lr}
	ldr r0, [r4]
	mov r5, #0x26
	mov r6, #0x27
	mov r7, #0x31
	ldrb r5, [r0, r5]
	ldrb r6, [r0, r6]
	ldrb r7, [r0, r7]
	
Retry:
	mov r0, #BOOK_MAX-1  
	ldr r2, =0x08000c58
	mov lr, r2
	.short 0xf800
	
	ldr r2, =0x0202bcb2
	ldrb r2, [r2]
	add r0, r0, r2
	
loop:
	cmp r0, #BOOK_MAX-1
	ble Ok
	sub r0, #BOOK_MAX-1
	b loop
	
Ok:
	add r0, #1   @IDに補正
	
	cmp r0, r5	@同じ
	beq Retry
	cmp r0, r6	@同じ
	beq Retry
	cmp r0, r7	@同じ
	beq Retry
	cmp r0, #0x12	@杖スキル
	beq Retry
	cmp r0, #0x29	@杖スキル
	beq Retry
	cmp r0, #0x1a	@守備隊形
	beq Retry
	cmp r0, #0x2a	@突撃
	beq Retry
	cmp r0, #0x24	@死線
	beq Retry
	cmp r0, #0x28	@没
	beq Retry
	cmp r0, #0x2F	@相性激化
	beq Retry
	cmp r0, #0x35	@城塞
	beq Retry

	ldr r2, [r4]
	mov r1, #0x26
	ldrb r1, [r2, r1]
	cmp r0, r1
	beq Retry
	mov r1, #0x27
	ldrb r1, [r2, r1]
	cmp r0, r1
	beq Retry
	pop {r5, r6, r7, pc}


GetSkill_em:
	push {r5, r6, r7, lr}
	ldr r0, [r4]
	mov r5, #0x26
	mov r6, #0x27
	mov r7, #0x31
	ldrb r5, [r0, r5]
	ldrb r6, [r0, r6]
	ldrb r7, [r0, r7]
emRetry:
	mov r0, #BOOK_MAX-1  
	ldr r2, =0x08000c58
	mov lr, r2
	.short 0xf800
	
	ldr r2, =0x0202bcb2
	ldrb r2, [r2]
	add r0, r0, r2
	
emloop:
	cmp r0, #BOOK_MAX-1
	ble emOk
	sub r0, #BOOK_MAX-1
	b emloop
	
emOk:
	add r0, #1   @IDに補正
	
	cmp r0, r5	@同じ
	beq emRetry
	cmp r0, r6	@同じ
	beq emRetry
	cmp r0, r7	@同じ
	beq emRetry
	cmp r0, #0x9	@戦技
	beq emRetry
	cmp r0, #0xA	@エリート
	beq emRetry
	cmp r0, #0xB	@再動
	beq emRetry
	cmp r0, #0x10	@疾風迅雷
	beq emRetry
	cmp r0, #0x12	@杖スキル
	beq emRetry
	cmp r0, #0x1B	@戦技
	beq emRetry
	cmp r0, #0x1C	@戦技
	beq emRetry
	cmp r0, #0x1D	@戦技
	beq emRetry
	cmp r0, #0x1E	@戦技
	beq emRetry
	cmp r0, #0x23	@生命吸収
	beq emRetry
	cmp r0, #0x29	@杖スキル
	beq emRetry
	cmp r0, #0x2C	@戦技
	beq emRetry
	cmp r0, #0x30	@護り手
	beq emRetry
	cmp r0, #0x3F	@戦技
	beq emRetry
	cmp r0, #0x3E	@戦技
	beq emRetry
	cmp r0, #0x3D	@戦技
	beq emRetry

	ldr r2, [r4]
	mov r1, #0x26
	ldrb r1, [r2, r1]
	cmp r0, r1
	beq emRetry
	mov r1, #0x27
	ldrb r1, [r2, r1]
	cmp r0, r1
	beq emRetry
	pop {r5, r6, r7, pc}


