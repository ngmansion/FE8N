.thumb

main:
        push {r4, lr}
        mov r4, #0

        ldr r0, ADDR
        ldrb r0, [r0]
        cmp r0, #0
        beq return
        mov r1, #0x10
        mul r0, r1
        mov r1, #125
        bl WRAMDisplay
return:
        pop {r4, pc}





.align
WRAMDisplay:
    mov r2, #ArrowData-WRAMDisplay-6
    add r2, pc
    mov r3, #0
    ldr r4, =0x08002B08
    mov pc, r4
.align
ArrowData:
.long 0x00030001
.long 0x086F0004

.align
.ltorg
ADDR:


