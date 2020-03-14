.thumb

    cmp r0, #0
    bne switch

    ldr r0, =0x0203a568
    ldr r1, =0x0203a4e8
    .short 0xE001

switch:
    ldr r0, =0x0203a4e8
    ldr r1, =0x0203a568

    bl main
    mov r2, r0
    mov r0, r5
    add r0, #128
    mov r1, #2

    ldr r3, addr+4
    mov pc, r3




main:
push {r4, r5, lr}
mov r5, r0
mov r3, r1

add	r0, #90
mov	r2, #0
ldsh	r1, [r0, r2]

mov	r0, #92
ldsh	r0, [r0, r3]
sub	r0, r1, r0

mov r1, r5
mov r2, r3
bl DEF_DIVIDE
mov	r4, r0

mov r0, #72
ldrh	r0, [r5, r0]
cmp r0, #0
beq jump
mov r0, #74
ldrh	r0, [r5, r0]
bl	$00017294
cmp	r0, #181	@ストーン
bne	$00036a62
jump:
mov	r4, #255

$00036a62:
cmp	r4, #0
bge	$00036a6c
mov	r4, #0

$00036a6c:
mov r0, r4
pop {r4, r5, pc}


$00017294:
ldr r1, =0x08017294
mov pc, r1

DEF_DIVIDE:
ldr r3, addr
mov pc, r3

.align
.ltorg
addr:
