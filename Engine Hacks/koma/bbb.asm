@thumb
	
	ldr	r4, [zako]
	ldr	r2, [status+4]
	ldr	r2, [r2]
	ldrb	r2, [r2, #8]
	cmp	r2, #10	;レベル
	ble	end
	ldr	r4, [tsuyoi]
end
	lsl	r1, r0, #2
	add	r1, r1, r0
	lsl	r1, r1, #2
	ldr	r2, [return]
	mov	pc, r2
return
@dcd	$0807d650
status
@dcd	$03004DF0
zako
@dcd	$089263A8
tsuyoi
@dcd	$089263A8


