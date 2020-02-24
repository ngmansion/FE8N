.thumb
@
@r4は初期化する
@
main:
        ldr r0, [r4, #12]
        mov r1, #1
        and r0, r1
        cmp r0, #0
        beq $00027648

        ldr r0, ADDR
        ldrb r0, [r0]
        cmp r0, #0
        beq return
        mov r1, #0x10   @X coord
        mul r0, r1
        mov r1, #125    @Y coord
        bl WRAMDisplay
    return:
        ldr r0, =0x08027994
        mov pc, r0

$00027648:
ldr r0, =0x08027648
mov pc, r0



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


