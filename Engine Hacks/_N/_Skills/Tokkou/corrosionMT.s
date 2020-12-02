.thumb
        push {lr}
        mov r0, r8
        mov r1, r6
        bl HAS_CORROSION
        cmp r0, #1
        beq harfWeaponMT
        mov r0, #72
        ldrh r0, [r6, r0]
        ldr r3, =0x08017384
        mov lr, r3
        .short 0xF800
        b mergeWeaponMT
    harfWeaponMT:
        mov r0, #72
        ldrh r0, [r6, r0]
        ldr r3, =0x08017384
        mov lr, r3
        .short 0xF800
        asr r0, #1
    mergeWeaponMT:
        pop {pc}

HAS_CORROSION:
    ldr r2, (addr+0)
    mov pc, r2

.ltorg
.align
addr:

