.thumb
add r0, #92
ldrh r1, [r2, #0]
ldrh r3, [r0, #0]
sub r1, r1, r3
bl main
ldr r0, addr
mov pc, r0

main:
        push {r4, r5, r6, lr}
        push {r2}
        cmp r1, #0
        ble end   @半減不要
        sub r2, #90
        sub r0, #92
        mov r4, r2
        mov r5, r0
        mov r6, r1

        mov r0, r5
        mov r1, r4
        bl HasGodShield
        cmp r0, #0
        beq jump1
        bl divide   @相手(r5)が神盾所持
    jump1:
        bl WaryFighter
        cmp r0, #0
        beq jump2
        bl divide
    jump2:
        mov r1, r6
    end:
        pop {r2}
        pop {r4, r5, r6, pc}

WaryFighter:
        push {lr}
        ldrb r0, [r5, #0xb]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        ldrb r1, [r1, #0xb]
        cmp r0, r1
        beq jumpWaryFighter
    @r4が攻め。r5が守備隊形の場合、この攻撃は半減
        mov r0, r5
        mov r1, r4
        bl HasWaryFighter
        b endWaryFighter
jumpWaryFighter:
    @r5が攻め。r4が守備隊形の場合、この攻撃は半減
        mov r0, r4
        mov r1, r5
        bl HasWaryFighter
    endWaryFighter:
        pop {pc}

divide:
    mov r0, r6
    asr r0, r0, #1
    bne not_div
    mov r0, #1
not_div:
    mov r6, r0
    bx lr

HasGodShield:
ldr r2, addr+4
mov pc, r2
HasWaryFighter:
ldr r2, addr+8
mov pc, r2

.align
.ltorg
addr:

