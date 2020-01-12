.thumb
    push {r4, lr}
    mov r4, r0  
    bl  $000168d0   @装備チェック
    lsl r0, r0, #16
    lsr r0, r0, #16
    bl  $000161c8   @力武器補正値
    pop {r4, pc}

$000168d0:
    ldr r1, =0x080168d0
    mov pc, r1
$000161c8:
    ldr r1, =0x080161c8
    mov pc, r1

