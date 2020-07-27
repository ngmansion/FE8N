.thumb
    mov r1, r0
    mov r0, #0x23
    ldrb r0, [r0, r1]
    cmp r0, #1
    beq false
    cmp r0, #2
    beq true
    cmp r0, #3
    beq true
default:
    ldr r0, [r1, #8]
    mov r1, #5  @物理または杖
    and r0, r1
    beq false
true:
    mov r0, #1      @壊れない
    b end
false:
    mov r0, #0      @壊れる
end:
    bx lr


