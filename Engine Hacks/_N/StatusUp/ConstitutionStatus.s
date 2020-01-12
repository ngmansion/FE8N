.thumb
    mov r1, r0
    mov r0, #26
    ldsb    r0, [r4, r0]
    add r0, r0, r1
    pop {r4}
    pop {r1}
    bx  r1
