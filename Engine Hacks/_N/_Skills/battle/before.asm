.equ SAVIOR_ADR, (adr+44)
.equ SAVIOR_DAMAGE, (10)

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _bldr reg, dest
	ldr \reg, =\dest
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@;0x02a90c
@;ステータス画面にも影響がある
@;相手が存在するとは限らない(ダミーかもしれない)
.thumb
    mov	r0, r5
    ldr r1, adr	@;見切り
    _blr r1
    cmp r0, #0
    bne RETURN
@;闘技場チェック
    ldr r0, Alina_Adr
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne RETURN
    
    bl shishi
    
    bl Savior	@;護り手
@;相手の存在をチェック
    ldr r0, [r5, #4]
    cmp r0, #0
    beq RETURN
    
    bl kishin
    
    bl kongou
    
    bl koroshi
    
    bl DistantDef
    
    bl CloseDef
    
RETURN:
    pop {r4, r5}
    pop {r0}
    bx r0


    Savior:
        push {lr}
        
        mov r0, r4
        ldr r1, SAVIOR_ADR
        _blr r1
        cmp r0, #0
        beq endSavior
        
        ldr r0, [r4, #12]
        mov r1, #0x10
        and r0, r1
        beq endSavior
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #SAVIOR_DAMAGE
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endSavior:
        mov r0, #0
        pop {pc}

    DistantDef:
        push {lr}
        ldr r0, Range_Adr
        ldrb r0, [r0] @;距離
        cmp r0, #1
        ble endDistantDef
        
        mov r0, r4
        ldrb r0, [r0, #11]
        ldr r1, Attacker_Adr
        ldr r1, [r1]
        ldrb r1, [r1, #11]
        cmp r0, r1
        beq endDistantDef	@;攻撃者と一致
        
        mov r0, r4
        ldr r1, adr+40	@;遠距離防御
        _blr r1
        cmp r0, #0
        beq endDistantDef
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endDistantDef:
        mov r0, #0
        pop {pc}
        

    CloseDef:
        push {lr}
        ldr r0, Range_Adr
        ldrb r0, [r0] @;距離
        cmp r0, #1
        bne endCloseDef
        
        mov r0, r4
        ldrb r0, [r0, #11]
        ldr r1, Attacker_Adr
        ldr r1, [r1]
        ldrb r1, [r1, #11]
        cmp r0, r1
        beq endCloseDef	@;攻撃者と一致
        
        mov r0, r4
        ldr r1, adr+36 @;近距離防御
        _blr r1
        cmp r0, #0
        beq endCloseDef
        
        mov r1, #92
        ldrh r0, [r4, r1]
        add r0, #6
        strh r0, [r4, r1]
        mov r0, #1
        .short 0xE000
    endCloseDef:
        mov r0, #0
        pop {pc}

true:
    mov r0, #1
    pop {pc}
false:
    mov r0, #0
    pop {pc}

koroshi:
    push {lr}
    bl breaker_impl
    cmp r0, #0
    beq false
gotKoroshi:
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @;自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @;自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] @;自分
    
    mov r1, #96
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] @;自分
    
    mov r1, #98
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] @;自分
    b true

shishi:
    push {lr}
    mov r0, r4
    ldr r1, adr+4
    _blr r1
    cmp r0, #0
    .short 0xD000
    b gotKoroshi
    b false
    
kishin:
    push {lr}
    mov r0, r4
    ldr r1, adr+8	@;鬼神
    _blr r1
    cmp r0, #0
    beq false
    
    ldr r0, Attacker_Adr
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne false
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #5 @;威力
    strh r0, [r4, r1] @;自分

    mov r1, #102
    ldrh r0, [r4, r1]
    add r0, #15 @;必殺
    strh r0, [r4, r1] @;自分
    b true

kongou:
    push {lr}
    mov r0, r4
    ldr r1, adr+12 @;金剛
    _blr r1
    cmp r0, #0
    beq false
    
    ldr r0, Attacker_Adr
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne false
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #10
    strh r0, [r4, r1]
    b true

breaker_impl:
    push {lr}
    mov r0, r5
    add r0, #74
    ldrh r0, [r0]
    ldr r1, Equipment_Adr
    _blr r1
    cmp r0, #0
    beq sword
    cmp r0, #1
    beq lance
    cmp r0, #2
    beq axe
    cmp r0, #3
    beq bow
    cmp r0, #4
    beq false
    cmp r0, #7
    ble magic
    b false
sword:
    mov r0, r4
    ldr r1, adr+16
    _blr r1
    b merge
lance:
    mov r0, r4
    ldr r1, adr+20
    _blr r1
    b merge
axe:
    mov r0, r4
    ldr r1, adr+24
    _blr r1
    b merge
bow:
    mov r0, r4
    ldr r1, adr+28
    _blr r1
    b merge
magic:
    mov r0, r4
    ldr r1, adr+32
    _blr r1
merge:
    pop {pc}
.align
Alina_Adr:
.long 0x0203a4d0
Range_Adr:
.long 0x0203a4d2
Attacker_Adr:
.long 0x03004df0
Equipment_Adr:
.long 0x080172f0
.ltorg
adr:

