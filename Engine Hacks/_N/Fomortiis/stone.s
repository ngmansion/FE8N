.thumb
@> 0802b6ac
mov r0, r4
bl fodes_func
cmp r0, #0
beq normal
ldr r1, =0x0802b732
mov pc, r1

normal:
    ldr r0, =0x0802b6cc
    ldr r0, [r0]
    ldrb r0, [r0, #15]
    cmp r0, #64
    beq goto0002b6fe
    ldr r1, =0x0802b6b4
    mov pc, r1
goto0002b6fe:
    ldr r1, =0x0802b6fe
    mov pc, r1

fodes_func:
ldr r1, addr
mov pc, r1

.align
.ltorg
addr:


