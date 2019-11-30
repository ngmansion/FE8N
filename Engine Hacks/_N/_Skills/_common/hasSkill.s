.thumb
    ldr r1, adr+4   @IDロード
    ldr r3, adr     @ポインタロード
    mov pc, r3
.align
adr:
