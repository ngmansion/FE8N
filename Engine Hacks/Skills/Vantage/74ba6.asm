@thumb
@org	$08074ba6
	ldr	r0, [adr+4]
	ldrb	r0, [r0, #0xF]
	lsl	r0, r0, #24
	lsr	r0, r0, #31
	b	end
adr
@dcd $0202BCEC
	nop
end