@ 080369c4
@ 08036a46
.thumb
add r0, #92
mov r3, #0
ldsh r3, [r0, r3]
sub r1, r1, r3
mov r8, r1
bl main
ldr r0, addr
mov pc, r0

main:
        push {r4, r5, lr}
        push {r2}
        cmp r1, #0
        ble jump2   @半減不要
        sub r0, #92
    
        mov r4, r2
        mov r5, r0
    
        mov r0, r5
        mov r1, r4
        bl HasGodShield
        cmp r0, #0
        beq jump1
        bl divide
    jump1:
        ldrb r0, [r5, #0xb]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        ldrb r1, [r1, #0xb]
        cmp r0, r1
        beq jump2
    
        mov r0, r5
        mov r1, r4
        bl HasWaryFighter
        cmp r0, #0
        beq jump2
        bl divide
    jump2:
        mov r1, r8
        pop {r2}
        pop {r4, r5, pc}

divide:
    mov r0, r8
    asr r0, r0, #1
    bne not_div
    mov r0, #1
not_div:
    mov r8, r0
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

