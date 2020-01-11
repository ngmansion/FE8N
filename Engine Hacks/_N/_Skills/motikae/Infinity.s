.thumb

Infinity:
    push {r4, r5, lr}
    mov r4, r0  @ユニット
    mov r5, r1  @アイテム
    bl InfinityWeapon
    cmp r0, #1
    beq return
    bl StaffSavant
return:
    pop {r4, r5, pc}

STAFF = (4)
ITEM = (9)

InfinityWeapon:
        push {lr}
        mov r0, r5
        bl GetItemSpecies
        cmp r0, #STAFF
        beq falseInfinityWeapon
        cmp r0, #ITEM
        bge falseInfinityWeapon

        mov r0, r4
        mov r1, #0
        bl HasInfinityWeapon
        b endInfinityWeapon
    falseInfinityWeapon:
        mov r0, #0
    endInfinityWeapon:
        pop {pc}

StaffSavant:
        push {lr}
        mov r0, r5
        bl GetItemSpecies
        cmp r0, #STAFF
        bne falseStaffSavant
        mov r0, r4
        mov r1, #0
        bl HasStaffSavant
        b endStaffSavant
    falseStaffSavant:
        mov r0, #0
    endStaffSavant:
        pop {pc}

GetItemSpecies:
    ldr	r3, =0x080172f0
    mov	pc, r3

HasInfinityWeapon:
    ldr r2, addr
    mov pc, r2
HasStaffSavant:
    ldr r2, addr+4
    mov pc, r2
.align
.ltorg
addr:
