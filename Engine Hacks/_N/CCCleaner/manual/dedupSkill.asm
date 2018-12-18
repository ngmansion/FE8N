@define GETSKILL ADR+0
@define JUDGEUNIT ADR+4

@define unit_data r4
@define max_num r6
@define count r5

@thumb
;I	r0 = ベースアドレス
;	r1 = 最大スキル数
;O	r0 = ヒットしたらindex。しなかったら最大数を戻す
    push {r4, r5, r6, lr}
    mov r4, r0
    mov count, r1
    mov max_num, r1
    
loop:
    sub count 1
    
    cmp count max_num	;マイナスを検知
    bhi FALSE
    
    mov r0, unit_data
    mov r1, count
    bl ex_getSkill
    cmp r0, #0
    beq loop
    
    mov r1, r0
    mov r0, unit_data
    bl ex_judgeUnit
    cmp r0, #1
    beq TRUE
    b loop
    
FALSE:
	mov r0, max_num
	b END
TRUE:
	mov r0, count
END:
    pop {r4, r5, r6, pc}
@align 4
@ltorg

ex_getSkill:
	ldr r3, [GETSKILL]
	mov pc, r3
	
ex_judgeUnit:
	ldr r3, [JUDGEUNIT]
	mov pc, r3

ADR: