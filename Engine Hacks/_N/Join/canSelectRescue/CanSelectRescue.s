.thumb
RETURN_ADDR_FALSE   = (0x0802289c)
RETURN_ADDR_TRUE    = (0x08022874)

@0002286c
        push {lr}
        ldr r0, =0x0202bcac
        add r0, #61
        ldrb r1, [r0, #0]
        mov r0, #0x50
        and r1, r0
        cmp r1, #0x50
        beq notRepeater        @救出後
        ldr r0, =0x03004df0
        ldr r2, [r0, #0]
        ldr r1, [r2, #12]
        ldr r0, =RETURN_ADDR_TRUE
        mov pc, r0

notRepeater:
        ldr r0, =RETURN_ADDR_FALSE
        mov pc, r0
