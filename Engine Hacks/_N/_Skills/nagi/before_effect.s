.thumb
@
@ 遠距離戦技用エフェクト強制変更
@
STORE_ADDR = 0x0805865c
RETURN_ADDR1 = 0x080585ea

@000585e0
    ldrh r1, [r1, #0]
    bl $00058e44
    ldr r1, =STORE_ADDR
    ldr r1, [r1]
    strh r0, [r1, #2]

    bl main
    ldr r0, =RETURN_ADDR1
    mov pc, r0

$00058e44:
    ldr r2, =0x08058e44
    mov pc, r2

main:
        push {lr}

        bl GET_COMBAT_ART
        mov r1, #0x1a
        cmp r0, #0xCD
        .short 0xd100   @bne
        b store
        mov r1, #0x03
        cmp r0, #0xCE
        .short 0xd100   @bne
        b store
        b end

    store:
        ldr r2, =STORE_ADDR
        ldr r2, [r2]
        strh r1, [r2, #2]
    end:
        pop {pc}

GET_COMBAT_ART:
    ldr r0, addr+0
    mov pc, r0

.align
.ltorg
addr:

