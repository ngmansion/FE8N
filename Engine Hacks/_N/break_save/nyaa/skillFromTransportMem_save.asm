@define BL_ARCHIVE_DATA_ADR ($080d6548)
@define TRANSPORT_DATA_ADR ($0203a818)

@thumb
;I	r0 = ロード元。1:中断。0:その他
;O	-
	push {lr}
		@align 4
		ldr	r3, [get_saveBaseAdr]
		mov lr, r3
	    @dcw $F800
	bl extract_exSkill
end:
	pop {pc}

	
extract_exSkill:
;I	r0 = ユニットのセーブベースアドレス(0xE0000000)
;O	-
	push {lr}
	
	mov r1, r0
	ldr r0, =TRANSPORT_DATA_ADR
	mov	r2, #176 ;ビットギリギリ
	ldr	r3, =BL_ARCHIVE_DATA_ADR
		mov lr, r3
	    @dcw $F800
	pop {pc}
@align 4
@ltorg
get_saveBaseAdr:



