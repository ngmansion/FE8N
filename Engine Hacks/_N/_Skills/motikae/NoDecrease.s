.thumb
push {r2}
bl main
pop {r2}
cmp r0, #1
beq skip
ldr r0, [r2, #0]
ldr r0, [r0, #0]
lsl r0, r0, #13
lsr r0, r0, #13
ldr r1, =0x0802b744 @NEXT
mov pc, r1

skip:
ldr r0, =0x0802b770
mov pc, r0

main:
        mov r0, r5
        mov r1, #72
        ldrh r1, [r0, r1]
        ldr r2, addr
        mov pc, r2
.align
.ltorg
addr:
