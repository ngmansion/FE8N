.thumb
@org	$08019f28
    push {r4, lr}
    mov r4, r0
    mov r0, r5
    mov r1, #0
        ldr r2, adr @回復
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq nonHeal
    
gotHeal:
    mov r3, #20
    b end
nonHeal:
    mov r3, #0
end:
    ldr r1, =0x08019f34
    ldr r1, [r1]
    add r0, r4, r1
    ldrb r0, [r0]
    lsl r0, r0, #24
    asr r0, r0, #24
    add r0, r0, r3
    pop {r4, pc}
.align
.ltorg
adr:
