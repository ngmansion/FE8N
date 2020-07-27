INVARID_ITEM = (0xFF)

.thumb
    add	r0, r0, r1
    push {r0}
    bl main
    pop {r1}
    add r0, r0, r1
    pop {r4}
    pop {r1}
    bx r1
    
main:   @持ってるアイテムの中から使える盾を探して補正値を持ってくる
        push {r5, r6, r7, lr}
        mov r5, r2
        cmp r5, #1
        bne jump
        sub r4, #49
    jump:
        mov r0, r4
            ldr r1, =0x080168d0     @装備アイテム取得
            mov lr, r1
            .short 0xF800
            ldr r1, =0x080172f0     @武器種類
            mov lr, r1
            .short 0xF800
        mov r7, r0

        mov r6, #28     @カウンタセット
    loop:               @アイテム確認ループ
        add r6, #2
        cmp r6, #40
        beq false

        ldrh r0, [r4, r6]
        cmp r0, #0
        beq loop                            @無いなら次へ
            ldr r1, =0x0801732c @アイテム使用回数
            mov lr, r1
            .short 0xF800
        cmp r0, #0
        beq loop                            @0回なら次へ

        ldrh r0, [r4, r6]
            ldr r1, =0x08017314
            mov lr, r1
            .short 0xF800
        mov r2, r1              @保持
        lsl r0, r0, #6  @盾パッチの下
        lsr r0, r0, #31

        cmp r0, #0
        beq loop                            @ビットオフならジャンプ

        ldrb r0, [r2, #28]
        cmp r0, #0
        bne WeaponTypeEquipment   @武器レベル0以外ならジャンプ
        b ClassTypeEquipment

    false:
        mov r0, #0
        b end
    true:
        ldr r0, [r2, #12]
        add r0, #4
        ldrb r0, [r0, r5]    @守備か魔防のボーナス
    end:
        pop {r5, r6, r7, pc}


    WeaponTypeEquipment:  @装備可能装備かチェック
        cmp r7, #INVARID_ITEM
        beq true    @装備なしならtrue
        cmp r7, #0
        beq true    @剣装備ならtrue
        b loop      @不可。戻ってほかの盾を探す


    ClassTypeEquipment:
        ldr r3, [r2, #16]
        cmp r3, #0
        beq true                    @誰でも装備可能

        ldr r0, [r4, #4]
        ldrb r0, [r0, #4]
    CALN_loop:
        ldrb r1, [r3]
        cmp r1, #0
        beq loop                    @装備不可兵種
        cmp r0, r1
        beq true                    @装備可能
        add r3, #1
        b CALN_loop

CheckUseCount:
        push {lr}
        lsr r1, r0, #8
        cmp r1, #0
        beq loop                            @回数ゼロなら次へ

            ldr r1, =0x08017314     @装備アイテム取得
            mov lr, r1
            .short 0xF800


    trueCheckUseCount:
        mov r0, #1
        pop {pc}



