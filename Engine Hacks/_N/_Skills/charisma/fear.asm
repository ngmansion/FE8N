@thumb
;;;@org	$0802ABC4
;;	ldr	r0, =$08FE5AE0
;;	mov	pc, r0
;; 珍しくソースつき
;; かなりゴリ押し
;; ほとんど動作確認してないので不具合あるかもしれません
;; 9/30 背負われていてもカリスマを振りまいていたのを修正
;;charisma
	push {r14}
	push {r2-r7}
	mov r3, #0x00
	mov r5, r0
	ldrb r0,[r5, #0x0B]
	cmp  r0, #0x3F
	blt  enemy
        cmp  r0, #0x81
	bge  ally
        b end
ally
	ldr r6, =$202BE48
	mov r7, #0x3F
	b entry
enemy
	ldr r6, =$202CFB8
	mov r7, #0x32
	b entry
entry	
	ldr r0,[r6, #0x00]
	cmp r0, #0x00
	beq end
	ldr r0, [r6,#0x0C]
	ldr r1, =$1002C
	and r0, r1
	cmp r0, #0	;; 戦闘参加中判定
	bne next
;ユニット
	ldr r0,[r6]
	ldrh	r0, [r0, #0x26]
	lsl	r0, r0, #16
        bmi Xdistance
class
	ldr r0,[r6, #0x04]
	ldrb r0,[r0,#0x04]
	cmp r0, #0x2F	;ドル
	beq Xdistance
	cmp r0, #0x30	;ドル
	beq Xdistance
	cmp r0, #0x4F	;ネクロ
	beq Xdistance
next
	add r6, #0x48
	sub r7,#0x01
	cmp r7, #0x00
	bgt entry
	b end
Xdistance
	ldrb r0, [r6, #0x10]
	ldrb r1, [r5, #0x10]
	sub r2, r0, r1
	cmp r2, #0x00
	bge Ydistance
	neg r2
Ydistance
	ldrb r0, [r6, #0x11]
	ldrb r1, [r5, #0x11]
	sub r1, r0, r1
	cmp r1, #0x00
	bge distance
	neg r1
distance
	add r1, r1, r2
	cmp r1, #0x00	;; 自分
	beq next	
	cmp r1, #0x03	;; カリスマ範囲
	bgt next
charisma_fear			;; 恐怖
	mov r1, #0x66		;必殺
	ldrb r0,[r5, r1]
	sub r0, #0x0A
	bge str_hit
	mov r0, #0x00
str_hit
	strb r0, [r5, r1]
	mov r1, #0x62		;回避
	ldrb r0,[r5, r1]
	sub r0, #0x0A
	bge str_avo
	mov r0, #0x00
str_avo
	strb r0, [r5, r1]
	b next	
end
	mov r0, r5
	pop {r2-r7}
	mov r1,#0x19
	ldsb r1,[r0, r1]
	add r0,#0x68
	strh r1,[r0]
	pop {r1}
	bx r1

