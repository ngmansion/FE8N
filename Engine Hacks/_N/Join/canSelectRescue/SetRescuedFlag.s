.thumb

ldr r0, =0x0202bcac
add r0, #61
ldrb r2, [r0, #0]
mov r1, #2
orr r1, r2
strb r1, [r0, #0]
ldr r0, =0x0801ce30
mov pc, r0
