
@ ORG 0802c708

.thumb
    mov r0, r4
    mov r1, r5
    bl GetWeaponType
    mov r1, r0
    mov r0, #0
    ldsb r0, [r2, r0]
    cmp r1, r0
    bne next

    mov r1, r4
    mov r0, r5
    bl GetWeaponType
    mov r1, r0
    mov r0, #1
    ldsb r0, [r2, r0]
    cmp r1, r0
    bne next

    ldr r0, =0x0802c724
    mov pc, r0

next:
    ldr r0, =0x0802c748
    mov pc, r0

GetWeaponType:
        push {r4, r5, lr}
        push {r2}
        mov r4, r0
        mov r5, r1
        add r0, #80
        ldrb r0, [r0]
        cmp r0, #0
        beq startWeaponTypeA
        cmp r0, #9
        beq startWeaponTypeB
        b endWeaponType

    startWeaponTypeA:
        mov r0, r4
        mov r1, r5
        bl HasSlenderSword
        cmp r0, #1
        beq spearWeaponType

        mov r0, r4
        mov r1, r5
        bl HasHeavySword
        cmp r0, #1
        beq axeWeaponType
        mov r0, #0
        b endWeaponType

    startWeaponTypeB:
        mov r0, r4
        mov r1, r5
        bl HasSlenderSword
        cmp r0, #1
        beq spearWeaponType

        mov r0, r4
        mov r1, r5
        bl HasHeavySword
        cmp r0, #1
        beq axeWeaponType
        mov r0, #9
        b endWeaponType


    spearWeaponType:
        mov r0, #1
        b endWeaponType
    axeWeaponType:
        mov r0, #2
        b endWeaponType

    endWeaponType:
        pop {r2}
        pop {r4, r5, pc}

HasSlenderSword:
    ldr r2, addr
    mov pc, r2
HasHeavySword:
    ldr r2, addr+4
    mov pc, r2

.align
.ltorg
addr:



