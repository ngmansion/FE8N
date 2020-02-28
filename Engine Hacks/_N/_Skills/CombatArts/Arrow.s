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

        ldrb r0, [r4, #11]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        ldrb r1, [r1, #11]
        cmp r0, r1
        bne return

        ldr r0, ADDR
        ldrb r0, [r0]
        cmp r0, #0
        beq return
        mov r1, #0x10   @X coord
        mul r0, r1
        mov r1, #0x80    @Y coord
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
.byte 0x01
.byte 0x00
.byte 0xF8  @icon_coordY
.byte 0x00  @icon_size(1)

.byte 0x00  @icon_coordX(マイナス可)
.byte 0x40  @icon_size(2)
.byte 0x06  @icon_species
.byte 0x08

.align
.ltorg
ADDR:


