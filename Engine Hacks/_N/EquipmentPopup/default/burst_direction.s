.thumb
@0008ea0c

ADDRESS = (0x0808ea48)

        push {r4, r5, lr}
        mov r5, r0          @横座標
        mov r4, r1          @縦座標    0x0cかつ  0x0cなら下じゃないとアウト(パネル最拡張)
        bl $0008dedc
        mov r1, r0
        mov r2, #1          @上に上げる
@        b original
        cmp r4, #0xC
        beq Cselect
        cmp r4, #0xA
        beq jump
        cmp r4, #5
        bgt jump2
    jump:
        mov r2, #4
    jump2:
        cmp r5, #0xE
        beq $0008ea3c
        b $0008ea32

Cselect:
        cmp r5, #14
        blt downBurst
        mov r0, #0
        cmp r5, #16
        blt mostRightUp
        b original

    mostRightUp:
        mov r2, #0
        b END

    original:
        cmp r4, #5
        ble downBurst       @潰すと上にはみ出す（飛んだら下に下ろす）
        cmp r4, #11
        bgt $0008ea32       @潰すと下にはみ出す（飛んだら上に上げる）
        ldr r0, =ADDRESS
        ldr r0, [r0]
        lsl r1, r1, #3
        add r1, r1, r0
        mov r0, #5
        ldsb r0, [r1, r0]
        cmp r0, #0
        bge $0008ea32
    downBurst:
        mov r2, #4          @下に降りる事が確定
    $0008ea32:
        cmp r5, #1
        bgt $0008ea38       @潰すと右にはみ出す
        sub r2, #1          @さらに右に曲がる
    $0008ea38:
        cmp r5, #22
        ble END       @潰すと左にはみ出す
    $0008ea3c:
        add r2, #1          @左に曲がる
    END:
        mov r0, r2              @０最右上　１右上　２左上　[３右下　４右下]　５左下　６はバグ
        pop {r4, r5}
        pop {r1}
        bx r1

$0008dedc:
    ldr r2, =0x0808dedc
    mov pc, r2



