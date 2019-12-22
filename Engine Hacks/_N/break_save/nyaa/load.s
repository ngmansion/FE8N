
.thumb
@080a7cb0
push {r4, r5, r6, r7, lr}
mov r1, lr
bl main @r0に拡張セーブアドレス
sub sp, #176
sub sp, #176
nop			@消すと下の命令が異常動作する・・・
nop
nop
ldr r1, =0x080a7d24
ldr r1, [r1]    @load 0x03006790
ldr r3, [r1]
mov r1, sp
mov r2, #176
lsl r2, r2, #1
bl jumpToR3
    ldr r0, =0x0803144c @=輸送隊のベースアドレスロード
    mov lr, r0
    .short 0xF800
mov r4, r0
add r5, sp, #100
add r5, #100    @拡張アイテム分
ldr r1, =0x080a7cc8
mov pc, r1



EX_SAVE_AREA = (ADR)

main:
    push {r4, lr}
    mov r4, r1

    bl org_transport_func
@ex輸送隊用
    mov r0, r4
    bl getSuffix    @中断か通常セーブか判別
    ldr r1, =0x160
    mul r0, r1
    ldr r1, EX_SAVE_AREA    @0x0E領域
    add r0, r0, r1

    pop {r4, pc}

org_transport_func:
        push {lr}
        bl load_org_transport_data_to_wram    @オリジナルの輸送隊データ→オリジナルの輸送隊データ展開
        nop
            ldr r0, ADR+4   @拡張レベルを展開(loadLvMax.dmp)
            mov lr, r0
            .short 0xF800
        pop {pc}
    


CHAPTER_BASE_ADR = (0x0202bcec)
getSuffix:
@
@中断なら0
@普通セーブなら1 or 2 or 3
@
        ldr r1, =0x080a9bb5
        cmp r0, r1
        beq normal
        mov r0, #0
        b merge
        
    normal:
        ldr r0, =CHAPTER_BASE_ADR
        ldrb r0, [r0, #12]
    @	mov r0, r9
        add r0, #1
    merge:
        bx lr

EXPAND_DATA_ADR = (0x03006790)
ORG_TRANSPORT_DATA_ADR = (0x0203a818)

load_org_transport_data_to_wram:
@
@オリジナルの輸送隊データ展開処理を簡易的に実現
@
        push {lr}
        
        ldr r1, =ORG_TRANSPORT_DATA_ADR
        mov r2, #176
        ldr r3, =EXPAND_DATA_ADR
        ldr r3, [r3, #0]
        bl jumpToR3

        pop {pc}


jumpToR3:
@r0に展開元の0x0E領域
@r1に展開したいデータ先頭アドレス
@r2にサイズ
    nop
    bx r3

BL_GET_SAVE_BASE_ADR = (0x080a7b58)
TEMP_SAVE_ADR = (0x0E0000D4+0x1944)

common_getOrgTransportFunc:
        push {lr}
        cmp r0, #0
        beq temp_save
        
        sub r0, #1
            ldr r3, =BL_GET_SAVE_BASE_ADR @セーブのベースアドレスロード
            mov lr, r3
            .short 0xF800
        ldr r1, =0x079c @輸送隊オフセット
        add r0, r0, r1
        b End_get_saveBaseAdr
    temp_save:
        ldr r0, =TEMP_SAVE_ADR
        
    End_get_saveBaseAdr:
        pop {pc}



.align
.ltorg
ADR:

