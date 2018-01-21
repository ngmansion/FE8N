@thumb
; 00094fc0
;逆ソートは000950b0

    ldr r3, [r4, #0]
    ldr r0, [r3, #0]
    ldr r0, [r0, #0]	;メモリ先頭4バイトのユニットデータのベースアドレス
    ldrb r0, [r0, #4]	;Unit ID
    ldrb r1, [r2, #4]	;Unit ID

    cmp r0, #0x45
    ble jump0
    mov r0, #0
jump0:
    cmp r1, #0x45
    ble jump1
    mov r1, #0
jump1:
    lsl r0, r0, #4
    lsl r1, r1, #4

    ldr r2, =$080a7678
    ldr r2, [r2]
    add r0, r0, r2
    add r1, r1, r2
    ldrb r2, [r0, #0xC]
    ldrb r0, [r0, #0xB]
    lsl r2, r2, #30
    lsr r2, r2, #22
    orr r0, r2
    
    ldrb r2, [r1, #0xC]
    ldrb r1, [r1, #0xB]
    lsl r2, r2, #30
    lsr r2, r2, #22
    orr r1, r2

    ldr r2, =$08094fca	;逆ソートは080950ba
    mov pc, r2
;	cmp	r0, r1
	
	