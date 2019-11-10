.equ TRANSPORT_DATA_ADR, (0x0203a818)
.equ MAX_UNIT, 51

.thumb
b common1
nop
b common2
nop

common1:
@;I      r0 = 隊列ID
@;O      r0 = ユニットのセーブベースアドレス
        ldr r0, [r0]
        ldrb r0, [r0, #4]
        sub r0, #1
        lsl r1, r0, #1
        add r0, r0, r1
        ldr r1, =TRANSPORT_DATA_ADR
        add r0, r0, r1
        bx lr

common2:
        cmp r0, #MAX_UNIT
        bgt false
        mov r0, #1
        b true
false:
        mov r0, #0
true:
        bx lr


