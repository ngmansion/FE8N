@define TEMP_SAVE_ADR (0x0E0000D4+0x1944)
@define CHAPTER_BASE_ADR (0x0202bcec)

@define BL_GET_SAVE_BASE_ADR ($080a7b58)

@thumb
get_saveBaseAdr:
;I	r0 = 中断or通常セーブフラグ
;O	r0 = セーブアドレス
	push {lr}
	cmp r0, #1
	beq temp_save
	
;	ldr r0, =CHAPTER_BASE_ADR
;	ldrb r0, [r0, 12]
	mov r0, r9
        ldr r3, =BL_GET_SAVE_BASE_ADR ;セーブのベースアドレスロード
        mov lr, r3
    @dcw $F800
	
	ldr r1, =0x079c ;輸送隊オフセット
	add r0, r0, r1
	b End_get_saveBaseAdr
temp_save
	ldr r0 = TEMP_SAVE_ADR
	
End_get_saveBaseAdr:
	pop {pc}
