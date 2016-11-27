	.include "MPlayDef.s"

	.equ	endlessbattle4_grp, voicegroup000
	.equ	endlessbattle4_pri, 0
	.equ	endlessbattle4_rev, 0
	.equ	endlessbattle4_mvl, 127
	.equ	endlessbattle4_key, 0
	.equ	endlessbattle4_tbs, 1
	.equ	endlessbattle4_exg, 0
	.equ	endlessbattle4_cmp, 1

	.section .rodata
	.global	endlessbattle4
	.align	2

@**************** Track 1 (Midi-Chn.1) ****************@

endlessbattle4_1:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte	TEMPO , 123*endlessbattle4_tbs/2
	.byte		VOICE , 124
	.byte		PAN   , c_v+0
	.byte		VOL   , 45*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N06   , Dn1 , v040
	.byte		N13   , Fs2 
	.byte	W06
	.byte		N05   , Dn1 , v080
	.byte	W06
	.byte		N01   , Dn1 , v100
	.byte	W06
	.byte		N05   , Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		N06   , Dn1 , v048
	.byte		N13   , Fs2 
	.byte	W06
	.byte		N05   , Dn1 , v068
	.byte	W06
	.byte		N01   , Dn1 , v076
	.byte	W06
	.byte		N05   , Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v084
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		N06   
	.byte		N13   , Fs2 
	.byte	W06
	.byte		N05   , Dn1 , v020
	.byte	W06
	.byte		N01   , Dn1 , v044
	.byte	W06
	.byte		N02   , Dn1 , v056
	.byte	W02
	.byte		N01   , Dn1 , v068
	.byte	W04
@ 001   ----------------------------------------
	.byte		N06   , Dn1 , v056
	.byte		N13   , Fs2 
	.byte	W06
	.byte		N06   , Dn1 , v080
	.byte	W06
	.byte		N01   , Dn1 , v100
	.byte	W06
	.byte		N05   , Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		N06   , Dn1 , v048
	.byte		N13   , Fs2 
	.byte	W06
	.byte		N05   , Dn1 , v080
	.byte	W06
	.byte		N01   , Dn1 , v092
	.byte	W06
	.byte		N05   , Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		N23   , Fs1 , v092
	.byte		N13   , Fs2 , v040
	.byte	W24
@ 002   ----------------------------------------
LoopStart_001:
endlessbattle4_1_002:
	.byte		N05   , Dn1 , v048
	.byte		N05   , Fs2 
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W12
	.byte		N02   , Dn1 , v056
	.byte	W02
	.byte		N01   , Dn1 , v068
	.byte	W04
	.byte	PEND
@ 003   ----------------------------------------
endlessbattle4_1_003:
	.byte		N05   , Dn1 , v112
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		N23   , Fs1 , v080
	.byte	W24
	.byte	PEND
@ 004   ----------------------------------------
endlessbattle4_1_004:
	.byte		N05   , Dn1 , v112
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W12
	.byte		N02   , Dn1 , v056
	.byte	W02
	.byte		N01   , Dn1 , v068
	.byte	W04
	.byte	PEND
@ 005   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 006   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_004
@ 007   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 008   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_002
@ 009   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 010   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_002
@ 011   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 012   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_004
@ 013   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 014   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_004
@ 015   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 016   ----------------------------------------
	.byte		N05   , Dn1 , v112
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W12
	.byte		N02   , Dn1 , v056
	.byte	W02
	.byte		        Dn1 , v068
	.byte	W04
@ 017   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_003
@ 018   ----------------------------------------
	.byte		N12   , Dn1 , v036
	.byte		N12   , Fs2 
	.byte	W16
	.byte		N07   , Dn1 , v068
	.byte	W08
	.byte		N12   , Fs2 , v016
	.byte	W08
	.byte		N03   , Dn1 , v052
	.byte	W16
	.byte		N14   , Dn1 , v040
	.byte		N12   , Fs2 , v036
	.byte	W16
	.byte		N07   , Dn1 , v032
	.byte	W08
	.byte		N12   , Fs2 , v016
	.byte	W08
	.byte		N03   , Dn1 , v020
	.byte	W16
@ 019   ----------------------------------------
endlessbattle4_1_019:
	.byte		N12   , Dn1 , v036
	.byte		N12   , Fs2 
	.byte	W16
	.byte		N07   , Dn1 , v068
	.byte	W08
	.byte		N12   , Fs2 , v016
	.byte	W08
	.byte		N14   , Dn1 , v052
	.byte	W16
	.byte		N12   , Dn1 , v036
	.byte		N12   , Fs2 
	.byte	W16
	.byte		N07   , Dn1 , v032
	.byte	W08
	.byte		N12   , Fs2 , v016
	.byte	W08
	.byte		N03   , Dn1 , v020
	.byte	W16
	.byte	PEND
@ 020   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_019
@ 021   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_019
@ 022   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_019
@ 023   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_019
@ 024   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_019
@ 025   ----------------------------------------
	.byte		N12   , Dn1 , v036
	.byte		N12   , Fs2 
	.byte	W16
	.byte		N07   , Dn1 , v068
	.byte	W08
	.byte		N12   , Fs2 , v016
	.byte	W08
	.byte		N03   , Dn1 , v052
	.byte	W16
	.byte		N12   , Dn1 , v036
	.byte		N12   , Fs2 
	.byte	W24
	.byte		N03   , Dn1 , v016
	.byte		N23   , Fs1 , v092
	.byte	W24
@ 026   ----------------------------------------
endlessbattle4_1_026:
	.byte		N05   , Dn1 , v120
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v088
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W12
	.byte		N02   , Dn1 , v064
	.byte	W02
	.byte		N01   , Dn1 , v068
	.byte	W04
	.byte	PEND
@ 027   ----------------------------------------
endlessbattle4_1_027:
	.byte		N05   , Dn1 , v120
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v088
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		N23   , Fs1 , v088
	.byte	W24
	.byte	PEND
@ 028   ----------------------------------------
	.byte		N05   , Dn1 , v120
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v088
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W12
	.byte		N02   , Dn1 , v064
	.byte	W02
	.byte		        Dn1 , v068
	.byte	W04
@ 029   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_027
@ 030   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_026
@ 031   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_027
@ 032   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_026
@ 033   ----------------------------------------
	.byte		N05   , Dn1 , v120
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v108
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v088
	.byte	W06
	.byte		        Dn1 , v044
	.byte	W06
	.byte		        Dn1 , v116
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		N11   , Fs1 , v100
	.byte	W12
	.byte		N05   , Dn1 , v096
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
@ 034   ----------------------------------------
endlessbattle4_1_034:
	.byte		N23   , Fs1 , v096
	.byte		N23   , Fs2 , v048
	.byte	W24
	.byte		N05   , Dn1 , v088
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v096
	.byte	W06
	.byte		N23   , Fs1 
	.byte	W24
	.byte	PEND
@ 035   ----------------------------------------
	.byte		N05   , Dn1 , v088
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v072
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v096
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		N02   , Dn1 , v072
	.byte	W03
	.byte		        Dn1 , v076
	.byte	W03
	.byte		N05   , Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v052
	.byte	W06
@ 036   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_1_034
@ 037   ----------------------------------------
	.byte		N05   , Dn1 , v088
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		N05   
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v072
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v096
	.byte	W06
	.byte		        Dn1 , v036
	.byte	W06
	.byte		        Dn1 , v088
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v048
	.byte	W06
	.byte		N02   , Dn1 , v072
	.byte	W03
	.byte		        Dn1 , v076
	.byte	W03
	.byte		N05   , Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v052
	.byte	W06
@ 038   ----------------------------------------
	.byte		        Dn1 , v040
	.byte		N05   , Fs2 
	.byte	W06
	.byte		        Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v096
	.byte	W06
	.byte		        Dn1 , v068
	.byte	W06
	.byte		        Dn1 , v076
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v084
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v096
	.byte		N13   , Fs2 , v040
	.byte	W06
	.byte		N05   , Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v044
	.byte	W06
	.byte		N02   , Dn1 , v056
	.byte	W02
	.byte		N01   , Dn1 , v068
	.byte	W04
@ 039   ----------------------------------------
	.byte		N05   , Dn1 , v112
	.byte		N13   , Fs2 , v056
	.byte	W06
	.byte		N05   , Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		        Dn1 , v028
	.byte	W06
	.byte		        Dn1 , v020
	.byte	W06
	.byte		        Dn1 , v092
	.byte		N13   , Fs2 , v048
	.byte	W06
	.byte		N05   , Dn1 , v080
	.byte	W06
	.byte		        Dn1 , v092
	.byte	W06
	.byte		        Dn1 , v060
	.byte	W06
	.byte		        Dn1 , v100
	.byte	W06
	.byte		        Dn1 , v040
	.byte	W06
	.byte		N20   , Fs1 , v092
	.byte		N13   , Fs2 , v040
	.byte	W24
@ 040   ----------------------------------------
 	.byte	GOTO
	 .word LoopStart_001
	.byte	FINE

@**************** Track 2 (Midi-Chn.2) ****************@

endlessbattle4_2:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 73
	.byte		PAN   , c_v+6
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte	W04
	.byte		VOICE , 73
	.byte	W92
@ 001   ----------------------------------------
	.byte	W96
@ 002   ----------------------------------------
LoopStart_002:
	.byte		N32   , Ds4 , v108
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W09
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N05   , Fn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		        Gn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N56   , Cn5 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W08
	.byte	W04
	.byte	W05
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 003   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W15
	.byte		N02   , Cn5 , v084
	.byte	W03
	.byte		        Cs5 
	.byte	W03
	.byte		N23   , Dn5 , v104
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		        As4 , v108
	.byte	W08
	.byte	W05
	.byte	W03
	.byte	W04
	.byte	W04
	.byte		        Fn4 
	.byte	W01
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
@ 004   ----------------------------------------
	.byte		N17   , Gn4 
	.byte	W06
	.byte	W06
	.byte	W06
	.byte		N05   , Fn4 
	.byte	W01
	.byte	W05
	.byte		TIE   , Gn4 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 005   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte		EOT   
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N02   , As4 , v084
	.byte	W01
	.byte	W01
	.byte	W01
	.byte		        Bn4 
	.byte	W01
	.byte	W02
	.byte		N23   , Cn5 , v108
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W10
	.byte	W05
	.byte	W02
	.byte		        As4 
	.byte	W02
	.byte	W05
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 006   ----------------------------------------
	.byte		N32   , Gn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N05   
	.byte	W06
	.byte		        Gs4 
	.byte	W06
	.byte		N44   , Fn4 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
@ 007   ----------------------------------------
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W04
	.byte		N23   , Gn4 
	.byte	W02
	.byte	W04
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W05
	.byte		N17   , Cn4 
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W06
	.byte	W04
	.byte		        Dn4 
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte		N11   , Ds4 
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W03
@ 008   ----------------------------------------
	.byte		N17   , Gn4 
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N05   , Fn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		TIE   , Gn4 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 009   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte		EOT   
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
@ 010   ----------------------------------------
	.byte		N32   , Ds4 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W08
	.byte	W09
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N05   , Fn4 
	.byte	W01
	.byte	W03
	.byte	W02
	.byte		        Gn4 
	.byte	W01
	.byte	W03
	.byte	W02
	.byte		N56   , Cn5 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
@ 011   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W10
	.byte		N23   
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N17   , Dn5 , v104
	.byte	W01
	.byte	W02
	.byte	W13
	.byte	W02
	.byte		        Ds5 , v092
	.byte	W10
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N11   , Fn5 , v088
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 012   ----------------------------------------
	.byte		N40   , Gn5 , v080
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N05   , Fn5 , v088
	.byte	W06
	.byte		N44   , Cn5 , v108
	.byte	W06
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W08
	.byte	W07
	.byte	W09
	.byte	W08
@ 013   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N23   , Gn4 
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		        Ds5 , v092
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W02
	.byte		        Dn5 , v104
	.byte	W07
	.byte	W09
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 014   ----------------------------------------
	.byte		N40   , Cn5 , v108
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N05   , As4 
	.byte	W06
	.byte		N44   , Fn4 
	.byte	W08
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 015   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N23   
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N17   , Gn4 
	.byte	W18
	.byte		        Gs4 
	.byte	W18
	.byte		N11   , As4 
	.byte	W12
@ 016   ----------------------------------------
	.byte		N17   , Gn4 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N05   , Fn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		TIE   , Gn4 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W18
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 017   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte		EOT   
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W12
@ 018   ----------------------------------------
	.byte	W96
@ 019   ----------------------------------------
	.byte	W96
@ 020   ----------------------------------------
	.byte	W96
@ 021   ----------------------------------------
	.byte	W96
@ 022   ----------------------------------------
	.byte	W96
@ 023   ----------------------------------------
	.byte	W30
	.byte		VOL   , 30*endlessbattle4_mvl/mxv
	.byte	W42
	.byte		VOICE , 73
	.byte	W24
@ 024   ----------------------------------------
	.byte	W24
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte		N02   , As4 , v084
	.byte	W01
	.byte	W02
	.byte		        Bn4 
	.byte	W01
	.byte	W02
	.byte		N17   , Cn5 , v108
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W06
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N05   , Dn5 
	.byte	W06
	.byte		TIE   , Cn5 
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 025   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte		EOT   
	.byte	W01
	.byte	W01
	.byte		VOICE , 61
	.byte	W01
	.byte	W02
@ 026   ----------------------------------------
	.byte		VOL   , 42*endlessbattle4_mvl/mxv
	.byte		N48   , Gs1 , v104
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte		N24   , Cn2 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte		        Ds2 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
@ 027   ----------------------------------------
	.byte		N48   , Fn2 
	.byte	W30
	.byte	W17
	.byte	W01
	.byte		        Dn2 
	.byte	W16
	.byte	W17
	.byte	W15
@ 028   ----------------------------------------
	.byte		N24   , Fn3 
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W06
	.byte	W02
	.byte		        Ds3 
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W01
	.byte		        As2 
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Gn2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 029   ----------------------------------------
	.byte		N48   , An2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		        Fn2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 030   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Cn2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Dn2 
	.byte	W24
@ 031   ----------------------------------------
	.byte	W10
	.byte	W14
	.byte		N24   , Ds2 
	.byte	W04
	.byte	W18
	.byte	W02
	.byte		        Cn2 
	.byte	W16
	.byte	W08
	.byte		N23   , Ds2 
	.byte	W10
	.byte	W14
@ 032   ----------------------------------------
	.byte		N72   , Fn2 
	.byte	W04
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W08
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte		N24   , Gs2 
	.byte	W02
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 033   ----------------------------------------
	.byte		N72   , Fn2 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W08
	.byte		VOICE , 73
	.byte	W10
	.byte		VOL   , 38*endlessbattle4_mvl/mxv
	.byte		N01   , Dn5 , v036
	.byte	W02
	.byte		        Ds5 , v056
	.byte	W02
	.byte		        En5 , v068
	.byte	W02
@ 034   ----------------------------------------
	.byte		N17   , Fn5 , v092
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N05   , Gn5 
	.byte	W06
	.byte		N11   , Fn5 
	.byte	W12
	.byte		N23   , Ds5 , v100
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N17   , Dn5 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte		N05   , Ds5 
	.byte	W06
@ 035   ----------------------------------------
	.byte		N11   , Dn5 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N52   , Cn5 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte		N11   , Dn5 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte		        Ds5 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
@ 036   ----------------------------------------
	.byte		N17   , Fn5 , v092
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W13
	.byte	W02
	.byte		N05   , Gn5 
	.byte	W06
	.byte		N11   , Fn5 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte		N28   , Ds5 , v100
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N01   , Fn5 , v048
	.byte	W01
	.byte	W01
	.byte		        Gn5 , v064
	.byte	W02
	.byte		        Gs5 , v072
	.byte	W01
	.byte	W01
	.byte		N23   , As5 , v084
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
@ 037   ----------------------------------------
	.byte		N05   , Gs5 , v092
	.byte	W06
	.byte		        Gn5 
	.byte	W06
	.byte		N72   , Ds5 , v100
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 038   ----------------------------------------
	.byte		N44   , Gn3 , v108
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte		N36   , Dn4 
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W07
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W10
	.byte		N03   , Cs4 
	.byte	W04
	.byte		        Cn4 
	.byte	W04
@ 039   ----------------------------------------
	.byte		N80   , Bn3 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W07
	.byte	W04
@ 040   ----------------------------------------
 	.byte	GOTO
	 .word LoopStart_002
	.byte	FINE

@**************** Track 3 (Midi-Chn.3) ****************@

endlessbattle4_3:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 33
	.byte		PAN   , c_v+0
	.byte		        c_v+40
	.byte		VOL   , 50*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N30   , Gn1 , v127
	.byte	W36
	.byte		PAN   , c_v+40
	.byte		N30   
	.byte	W36
	.byte		N19   
	.byte	W24
@ 001   ----------------------------------------
	.byte		N30   
	.byte	W36
	.byte		N30   
	.byte	W36
	.byte		N10   
	.byte	W12
	.byte		N02   , Dn2 , v104
	.byte	W06
	.byte		        Gn1 
	.byte	W06
@ 002   ----------------------------------------
LoopStart_003:
endlessbattle4_3_002:
	.byte		N11   , Cn2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Cn2 , v092
	.byte	W12
	.byte		N11   , Cn2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Cn2 , v092
	.byte	W12
	.byte		N11   , Cn2 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Cn2 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Cn2 , v080
	.byte	W06
	.byte	PEND
@ 003   ----------------------------------------
endlessbattle4_3_003:
	.byte		PAN   , c_v+40
	.byte		N11   , As1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , As1 , v092
	.byte	W12
	.byte		N11   , As1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , As1 , v092
	.byte	W12
	.byte		N11   , As1 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , As1 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , As1 , v080
	.byte	W06
	.byte	PEND
@ 004   ----------------------------------------
endlessbattle4_3_004:
	.byte		PAN   , c_v+40
	.byte		N11   , Gs1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Gs1 , v092
	.byte	W12
	.byte		N11   , Gs1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Gs1 , v092
	.byte	W12
	.byte		N11   , Gs1 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Gs1 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Gs1 , v080
	.byte	W06
	.byte	PEND
@ 005   ----------------------------------------
endlessbattle4_3_005:
	.byte		PAN   , c_v+40
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Gn1 , v092
	.byte	W12
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Gn1 , v092
	.byte	W12
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Gn1 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Gn1 , v080
	.byte	W06
	.byte	PEND
@ 006   ----------------------------------------
	.byte		PAN   , c_v+40
	.byte		N11   , Fn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Fn1 , v092
	.byte	W12
	.byte		N11   , Fn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Fn1 , v092
	.byte	W12
	.byte		N11   , Fn1 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Fn1 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Fn1 , v080
	.byte	W06
@ 007   ----------------------------------------
	.byte		PAN   , c_v+40
	.byte		N11   , Ds2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Ds2 , v092
	.byte	W12
	.byte		N11   , Ds2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Ds2 , v092
	.byte	W12
	.byte		N11   , Ds2 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Ds2 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Ds2 , v080
	.byte	W06
@ 008   ----------------------------------------
endlessbattle4_3_008:
	.byte		PAN   , c_v+40
	.byte		N11   , Dn2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Dn2 , v092
	.byte	W12
	.byte		N11   , Dn2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Dn2 , v092
	.byte	W12
	.byte		N11   , Dn2 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Dn2 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Dn2 , v080
	.byte	W06
	.byte	PEND
@ 009   ----------------------------------------
	.byte		PAN   , c_v+40
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Gn1 , v092
	.byte	W12
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Gn1 , v092
	.byte	W12
	.byte		N11   , Gn1 , v127
	.byte	W12
	.byte		N02   , Dn2 
	.byte	W06
	.byte		        Gn2 
	.byte	W06
@ 010   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_002
@ 011   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_003
@ 012   ----------------------------------------
	.byte		PAN   , c_v+40
	.byte		N11   , An1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , An1 , v092
	.byte	W12
	.byte		N11   , An1 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , An1 , v092
	.byte	W12
	.byte		N11   , An1 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , An1 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , An1 , v080
	.byte	W06
@ 013   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_004
@ 014   ----------------------------------------
endlessbattle4_3_014:
	.byte		PAN   , c_v+40
	.byte		N11   , Cs2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N07   , Cs2 , v092
	.byte	W12
	.byte		N11   , Cs2 , v127
	.byte	W12
	.byte		N02   
	.byte	W12
	.byte		N06   , Cs2 , v092
	.byte	W12
	.byte		N11   , Cs2 , v127
	.byte	W12
	.byte		PAN   , c_v+40
	.byte		N02   , Cs2 , v092
	.byte	W06
	.byte		PAN   , c_v+40
	.byte		        c_v+40
	.byte		N02   , Cs2 , v080
	.byte	W06
	.byte	PEND
@ 015   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_014
@ 016   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_008
@ 017   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_005
@ 018   ----------------------------------------
	.byte		PAN   , c_v+40
	.byte		N44   , Gs1 , v116
	.byte	W48
	.byte		N20   , Ds2 
	.byte	W24
	.byte		        Gs2 
	.byte	W24
@ 019   ----------------------------------------
	.byte		N22   , As2 
	.byte	W24
	.byte		N52   , As1 
	.byte	W60
	.byte		N04   , Cn2 
	.byte	W06
	.byte		        Dn2 
	.byte	W06
@ 020   ----------------------------------------
endlessbattle4_3_020:
	.byte		N44   , Ds2 , v116
	.byte	W48
	.byte		N22   , As1 
	.byte	W24
	.byte		        Ds2 
	.byte	W24
	.byte	PEND
@ 021   ----------------------------------------
	.byte		N44   , Fn2 
	.byte	W48
	.byte		N22   , Cn2 
	.byte	W24
	.byte		        An1 
	.byte	W24
@ 022   ----------------------------------------
	.byte		N68   , Gs1 
	.byte	W72
	.byte		N22   , Ds2 
	.byte	W24
@ 023   ----------------------------------------
	.byte		        As1 
	.byte	W24
	.byte		        Fn2 
	.byte	W24
	.byte		        Cn3 
	.byte	W24
	.byte		        As2 
	.byte	W24
@ 024   ----------------------------------------
	.byte		N44   , An2 
	.byte	W48
	.byte		        An1 
	.byte	W48
@ 025   ----------------------------------------
	.byte		N22   , Fn2 
	.byte	W24
	.byte		        Ds2 
	.byte	W24
	.byte		        Cn2 
	.byte	W24
	.byte		        An1 
	.byte	W24
@ 026   ----------------------------------------
	.byte		N76   , Gs1 
	.byte	W84
	.byte		N04   , As1 
	.byte	W06
	.byte		        Cn2 
	.byte	W06
@ 027   ----------------------------------------
	.byte		N44   , As1 
	.byte	W48
	.byte		N22   , Cn2 
	.byte	W24
	.byte		        Dn2 
	.byte	W24
@ 028   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_020
@ 029   ----------------------------------------
	.byte		N44   , Fn2 , v116
	.byte	W48
	.byte		        Fn1 
	.byte	W48
@ 030   ----------------------------------------
	.byte		        Gs1 
	.byte	W48
	.byte		N22   , Ds2 
	.byte	W24
	.byte		N44   , Gs2 
	.byte	W24
@ 031   ----------------------------------------
	.byte	W24
	.byte		        Gs1 
	.byte	W48
	.byte		N22   , Cn2 
	.byte	W24
@ 032   ----------------------------------------
	.byte		        As1 
	.byte	W24
	.byte		N22   
	.byte	W24
	.byte		N22   
	.byte	W24
	.byte		N22   
	.byte	W24
@ 033   ----------------------------------------
	.byte		        Bn1 
	.byte	W24
	.byte		N22   
	.byte	W24
	.byte		        Gn1 
	.byte	W24
	.byte		        Bn1 
	.byte	W24
@ 034   ----------------------------------------
	.byte		N32   , Cn2 
	.byte	W36
	.byte		        As1 
	.byte	W36
	.byte		N22   , Gs1 
	.byte	W24
@ 035   ----------------------------------------
endlessbattle4_3_035:
	.byte		N30   , Gs1 , v116
	.byte	W36
	.byte		N30   
	.byte	W36
	.byte		N19   
	.byte	W24
	.byte	PEND
@ 036   ----------------------------------------
	.byte		N32   , Cn2 
	.byte	W36
	.byte		        As1 
	.byte	W36
	.byte		N20   , Gs1 
	.byte	W24
@ 037   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_3_035
@ 038   ----------------------------------------
	.byte		N30   , Gn1 , v127
	.byte	W36
	.byte		N30   
	.byte	W36
	.byte		N19   
	.byte	W24
@ 039   ----------------------------------------
	.byte		N30   
	.byte	W36
	.byte		N30   
	.byte	W36
	.byte		N02   , Dn2 , v104
	.byte	W12
	.byte		        Gn1 
	.byte	W12
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_003
	.byte	FINE

@**************** Track 4 (Midi-Chn.4) ****************@

endlessbattle4_4:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 50
	.byte		PAN   , c_v-32
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N10   , Cn3 , v068
	.byte	W12
	.byte		N04   , Gn2 , v064
	.byte	W12
	.byte		        Gn2 , v076
	.byte	W12
	.byte		N10   , Cn3 
	.byte	W12
	.byte		N04   , Gn2 
	.byte	W12
	.byte		        Gn2 , v064
	.byte	W12
	.byte		N10   , Cn3 , v092
	.byte	W12
	.byte		N04   , Gn2 , v064
	.byte	W12
@ 001   ----------------------------------------
	.byte		N11   , Bn2 , v108
	.byte	W12
	.byte		N04   , Gn2 , v064
	.byte	W12
	.byte		        Gn2 , v076
	.byte	W12
	.byte		N10   , Bn2 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		        Gn2 , v064
	.byte	W12
	.byte		N10   , Bn2 , v092
	.byte	W12
	.byte		N04   , Gn2 , v064
	.byte	W12
@ 002   ----------------------------------------
LoopStart_004:
	.byte		N11   , Dn3 , v104
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N10   , Dn3 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N10   , Dn3 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Dn3 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
@ 003   ----------------------------------------
	.byte		N10   , Cn3 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Cn3 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , Cn3 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Cn3 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 004   ----------------------------------------
endlessbattle4_4_004:
	.byte		N11   , As2 , v104
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , As2 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , As2 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , As2 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte	PEND
@ 005   ----------------------------------------
	.byte		N11   , An2 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , An2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , An2 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , An2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 006   ----------------------------------------
	.byte		N10   , Gn2 , v104
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N10   , Gn2 , v072
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N10   , Gn2 , v084
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N11   , Gn2 , v072
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
@ 007   ----------------------------------------
	.byte		N10   , Gn2 , v104
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N10   , Gn2 , v072
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N11   , Gn2 , v084
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
	.byte		N11   , Gn2 , v072
	.byte	W12
	.byte		N04   , Ds2 , v076
	.byte	W12
@ 008   ----------------------------------------
	.byte		N10   , Fn2 , v104
	.byte	W12
	.byte		N04   , Dn2 , v076
	.byte	W12
	.byte		N10   , Fn2 , v072
	.byte	W12
	.byte		N04   , Dn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 009   ----------------------------------------
	.byte		N10   , Cn3 , v104
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Cn3 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N10   , Bn2 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N10   , Bn2 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
@ 010   ----------------------------------------
	.byte		N10   , Dn3 , v104
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Dn3 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Dn3 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N10   , Dn3 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
@ 011   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Cn3 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Cn3 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , Cn3 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 012   ----------------------------------------
	.byte		N11   , An2 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , An2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , An2 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , An2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 013   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_4_004
@ 014   ----------------------------------------
	.byte		N10   , Gs2 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , Gs2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 015   ----------------------------------------
	.byte		N11   , Gs2 , v104
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N10   , Gs2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v084
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
	.byte		N11   , Gs2 , v072
	.byte	W12
	.byte		N04   , Fn2 , v076
	.byte	W12
@ 016   ----------------------------------------
	.byte		N10   , Cn3 , v104
	.byte	W12
	.byte		N04   , An2 , v076
	.byte	W12
	.byte		N10   , Cn3 , v072
	.byte	W12
	.byte		N04   , An2 , v076
	.byte	W12
	.byte		N10   , Cn3 , v084
	.byte	W12
	.byte		N04   , An2 , v076
	.byte	W12
	.byte		N10   , Cn3 , v072
	.byte	W12
	.byte		N04   , An2 , v076
	.byte	W12
@ 017   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Dn3 , v072
	.byte	W12
	.byte		N04   , Cn3 , v076
	.byte	W12
	.byte		N11   , Bn2 , v084
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W12
	.byte		N11   , Bn2 , v072
	.byte	W12
	.byte		N04   , Gn2 , v076
	.byte	W08
	.byte		VOICE , 48
	.byte	W02
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte	W02
@ 018   ----------------------------------------
	.byte		N23   , Gn2 , v072
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte		        Gs2 
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W01
	.byte		        Cn3 
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W05
	.byte	W03
	.byte	W02
	.byte		        Ds3 
	.byte	W02
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W02
@ 019   ----------------------------------------
	.byte		        Fn3 
	.byte	W04
	.byte	W06
	.byte	W06
	.byte	W06
	.byte	W02
	.byte		        Gn3 
	.byte	W05
	.byte	W06
	.byte	W07
	.byte	W06
	.byte		        As2 
	.byte	W24
	.byte		        Dn3 
	.byte	W24
@ 020   ----------------------------------------
	.byte		        As2 
	.byte	W24
	.byte		N80   , Gn2 
	.byte	W28
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 021   ----------------------------------------
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte		N23   , Fn2 
	.byte	W24
	.byte		        An2 
	.byte	W24
	.byte		        Ds3 
	.byte	W24
@ 022   ----------------------------------------
	.byte		N44   , Cn3 
	.byte	W48
	.byte		        As2 
	.byte	W48
@ 023   ----------------------------------------
	.byte		N22   , Dn3 
	.byte	W24
	.byte		        Cn3 
	.byte	W24
	.byte		N44   , As2 
	.byte	W48
@ 024   ----------------------------------------
	.byte		N23   , Gn2 
	.byte	W24
	.byte		        An2 
	.byte	W24
	.byte		        Cn3 
	.byte	W24
	.byte		        Ds3 
	.byte	W24
@ 025   ----------------------------------------
	.byte		        Fn3 
	.byte	W24
	.byte		        An3 
	.byte	W24
	.byte		N44   , Cn3 
	.byte	W48
@ 026   ----------------------------------------
	.byte		N92   , Gn2 
	.byte	W96
@ 027   ----------------------------------------
	.byte		        As2 
	.byte	W96
@ 028   ----------------------------------------
	.byte		        Ds2 
	.byte	W96
@ 029   ----------------------------------------
	.byte		        Fn2 
	.byte	W96
@ 030   ----------------------------------------
	.byte		        Gs2 
	.byte	W96
@ 031   ----------------------------------------
	.byte		        Cn3 
	.byte	W96
@ 032   ----------------------------------------
	.byte		        As2 
	.byte	W96
@ 033   ----------------------------------------
	.byte		        Gn2 
	.byte	W96
@ 034   ----------------------------------------
	.byte		N32   , Ds3 , v068
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W07
	.byte	W05
	.byte	W03
	.byte	W02
	.byte		        Gn3 
	.byte	W02
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W08
	.byte	W06
	.byte		N44   , Ds3 
	.byte	W02
	.byte	W09
	.byte	W09
	.byte	W04
@ 035   ----------------------------------------
	.byte	W04
	.byte	W09
	.byte	W09
	.byte	W02
	.byte		N23   , Cn3 
	.byte	W07
	.byte	W08
	.byte	W09
	.byte		        As2 
	.byte	W08
	.byte	W09
	.byte	W07
	.byte		        Gs2 
	.byte	W01
	.byte	W09
	.byte	W09
	.byte	W05
@ 036   ----------------------------------------
	.byte		N32   , As2 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W02
	.byte		        Ds3 
	.byte	W01
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W04
	.byte	W14
	.byte		        Fn3 
	.byte	W24
@ 037   ----------------------------------------
	.byte	W01
	.byte	W06
	.byte	W03
	.byte	W02
	.byte		N80   , Ds3 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 038   ----------------------------------------
	.byte		VOICE , 50
	.byte		VOL   , 40*endlessbattle4_mvl/mxv
	.byte		N11   , Cn2 
	.byte	W12
	.byte		N04   , Gn1 , v064
	.byte	W12
	.byte		        Gn1 , v076
	.byte	W12
	.byte		N10   , Cn2 
	.byte	W12
	.byte		N04   , Gn1 
	.byte	W12
	.byte		        Gn1 , v064
	.byte	W12
	.byte		N10   , Cn2 , v092
	.byte	W12
	.byte		N04   , Gn1 , v064
	.byte	W12
@ 039   ----------------------------------------
	.byte		N11   , Bn1 , v092
	.byte	W12
	.byte		N04   , Gn1 , v064
	.byte	W12
	.byte		        Gn1 , v076
	.byte	W12
	.byte		N11   , Bn1 , v068
	.byte	W12
	.byte		N04   , Gn1 , v076
	.byte	W12
	.byte		        Gn1 , v064
	.byte	W12
	.byte		N10   , Bn1 , v092
	.byte	W12
	.byte		N04   , Gn1 , v064
	.byte	W12
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_004
	.byte	FINE

@**************** Track 5 (Midi-Chn.5) ****************@

endlessbattle4_5:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 61
	.byte		PAN   , c_v+0
	.byte		VOL   , 50*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N06   , Gn3 , v072
	.byte	W12
	.byte		        Gn3 , v040
	.byte	W12
	.byte		        Gn3 , v016
	.byte	W12
	.byte		        Gn3 , v092
	.byte	W12
	.byte		        Gn3 , v060
	.byte	W12
	.byte		        Gn3 , v036
	.byte	W12
	.byte		        Gn3 , v092
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
@ 001   ----------------------------------------
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
	.byte		        Gn3 , v052
	.byte	W12
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
	.byte		        Gn3 , v052
	.byte	W12
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W11
	.byte		PAN   , c_v+47
	.byte		BEND  , c_v+0
	.byte	W01
@ 002   ----------------------------------------
LoopStart_005:
	.byte		VOL   , 0*endlessbattle4_mvl/mxv
	.byte		N01   , Ds3 , v104
	.byte	W96
@ 003   ----------------------------------------
	.byte	W96
@ 004   ----------------------------------------
	.byte	W96
@ 005   ----------------------------------------
	.byte	W96
@ 006   ----------------------------------------
	.byte	W96
@ 007   ----------------------------------------
	.byte	W96
@ 008   ----------------------------------------
	.byte	W96
@ 009   ----------------------------------------
	.byte	W92
	.byte		VOL   , 42*endlessbattle4_mvl/mxv
	.byte	W03
	.byte	W01
@ 010   ----------------------------------------
	.byte		N44   , Gn2 , v096
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte		        Cn3 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
@ 011   ----------------------------------------
	.byte		        As2 
	.byte	W06
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte		        Fn2 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W03
@ 012   ----------------------------------------
	.byte		N32   
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		N02   , Gn2 
	.byte	W01
	.byte	W02
	.byte		        An2 
	.byte	W01
	.byte	W02
	.byte		        As2 
	.byte	W01
	.byte	W02
	.byte		        Cn3 
	.byte	W01
	.byte	W02
	.byte		N17   , Dn3 
	.byte	W18
	.byte		        Ds3 
	.byte	W12
	.byte	W06
	.byte		N11   , Fn3 
	.byte	W09
	.byte	W03
@ 013   ----------------------------------------
	.byte		N17   , Gn3 
	.byte	W12
	.byte	W06
	.byte		N05   , Fn3 
	.byte	W06
	.byte		N68   , Cn3 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
@ 014   ----------------------------------------
	.byte		N44   , Gs2 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W02
	.byte		N36   , Cn3 
	.byte	W08
	.byte	W05
	.byte	W06
	.byte	W06
	.byte	W05
	.byte	W06
	.byte	W03
	.byte		N02   , Dn3 , v104
	.byte	W02
	.byte	W01
	.byte		        Ds3 
	.byte	W03
	.byte		        En3 
	.byte	W01
	.byte	W02
@ 015   ----------------------------------------
	.byte		N44   , Fn3 , v096
	.byte	W30
	.byte	W07
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Cn3 
	.byte	W01
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W04
@ 016   ----------------------------------------
	.byte		N44   
	.byte	W03
	.byte	W09
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte		N17   , An2 
	.byte	W01
	.byte	W03
	.byte	W05
	.byte	W04
	.byte	W04
	.byte	W01
	.byte		N02   , As2 
	.byte	W03
	.byte		        Bn2 
	.byte	W03
	.byte		N23   , Cn3 
	.byte	W01
	.byte	W05
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W02
@ 017   ----------------------------------------
	.byte		N48   
	.byte	W02
	.byte	W06
	.byte	W05
	.byte	W06
	.byte	W06
	.byte	W06
	.byte	W06
	.byte	W06
	.byte	W05
	.byte		N30   , Bn2 
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
@ 018   ----------------------------------------
	.byte		N44   , Gn2 , v127
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W12
	.byte		        Cn3 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
@ 019   ----------------------------------------
	.byte	W14
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W03
	.byte		N23   
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte		        Dn3 
	.byte	W24
	.byte		        As2 
	.byte	W24
@ 020   ----------------------------------------
	.byte		N44   , Gn2 
	.byte	W05
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N32   , Ds2 
	.byte	W01
	.byte	W32
	.byte	W03
	.byte		N05   , Fn2 
	.byte	W06
	.byte		        Gn2 
	.byte	W06
@ 021   ----------------------------------------
	.byte		N44   , Fn2 
	.byte	W01
	.byte	W05
	.byte	W04
	.byte	W05
	.byte	W05
	.byte	W05
	.byte	W05
	.byte	W04
	.byte	W05
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte		N23   , Cn2 
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W11
	.byte		N11   , Dn2 
	.byte	W12
@ 022   ----------------------------------------
	.byte		N44   , Ds2 
	.byte	W48
	.byte		N23   , Fn2 
	.byte	W24
	.byte		        Gn2 
	.byte	W24
@ 023   ----------------------------------------
	.byte		N44   , As2 
	.byte	W06
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N17   , Fn2 
	.byte	W01
	.byte	W01
	.byte	W16
	.byte		        Gn2 
	.byte	W18
	.byte		N11   , As2 
	.byte	W12
@ 024   ----------------------------------------
	.byte		N17   , Cn3 
	.byte	W18
	.byte		N05   , Dn3 
	.byte	W06
	.byte		TIE   , Cn3 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W08
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
@ 025   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W04
	.byte	W05
	.byte	W03
	.byte	W04
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W03
	.byte		EOT   
	.byte	W01
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W01
	.byte	W03
	.byte	W02
@ 026   ----------------------------------------
	.byte		N24   , Cn2 , v104
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Ds2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte		        Gs2 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte		        Cn3 
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
@ 027   ----------------------------------------
	.byte		N48   , Dn3 
	.byte	W30
	.byte	W17
	.byte	W01
	.byte		        As2 
	.byte	W16
	.byte	W17
	.byte	W15
@ 028   ----------------------------------------
	.byte		        Gn3 
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W06
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W01
	.byte		N24   , Fn3 , v080
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Ds3 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 029   ----------------------------------------
	.byte		N96   , Cn3 , v104
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 030   ----------------------------------------
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N48   , Ds2 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		        Fn2 
	.byte	W24
@ 031   ----------------------------------------
	.byte	W10
	.byte	W14
	.byte		N24   , Gn2 
	.byte	W04
	.byte	W18
	.byte	W02
	.byte		        Gs2 
	.byte	W16
	.byte	W08
	.byte		        Cn3 
	.byte	W10
	.byte	W14
@ 032   ----------------------------------------
	.byte		N72   , Dn3 
	.byte	W04
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W08
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte		N24   , Fn3 
	.byte	W02
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
@ 033   ----------------------------------------
	.byte		N96   , Dn3 
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 034   ----------------------------------------
	.byte		N36   , Fn3 
	.byte	W01
	.byte	W32
	.byte	W03
	.byte		N12   , Ds3 
	.byte	W12
	.byte		        Ds3 , v056
	.byte	W12
	.byte		        Ds3 , v040
	.byte	W12
	.byte		N36   , Dn3 , v104
	.byte	W24
@ 035   ----------------------------------------
	.byte	W12
	.byte		N72   , Cn3 
	.byte	W04
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
@ 036   ----------------------------------------
	.byte		N36   , Fn3 
	.byte	W36
	.byte		N12   , Ds3 
	.byte	W12
	.byte		        Ds3 , v056
	.byte	W12
	.byte		        Ds3 , v040
	.byte	W12
	.byte		N36   , Dn3 , v104
	.byte	W24
@ 037   ----------------------------------------
	.byte	W10
	.byte	W02
	.byte		N66   , Cn3 
	.byte	W01
	.byte	W03
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 038   ----------------------------------------
	.byte		N06   , Gn3 , v072
	.byte	W12
	.byte		        Gn3 , v040
	.byte	W12
	.byte		        Gn3 , v016
	.byte	W12
	.byte		        Gn3 , v092
	.byte	W12
	.byte		        Gn3 , v060
	.byte	W12
	.byte		        Gn3 , v036
	.byte	W12
	.byte		        Gn3 , v092
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
@ 039   ----------------------------------------
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
	.byte		        Gn3 , v052
	.byte	W12
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
	.byte		        Gn3 , v052
	.byte	W12
	.byte		        Gn3 , v108
	.byte	W12
	.byte		        Gn3 , v076
	.byte	W12
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_005
	.byte	FINE

@**************** Track 6 (Midi-Chn.6) ****************@

endlessbattle4_6:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 50
	.byte		PAN   , c_v+31
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N11   , Gn2 , v068
	.byte	W36
	.byte		N10   , Gn2 , v076
	.byte	W36
	.byte		        Gn2 , v092
	.byte	W24
@ 001   ----------------------------------------
	.byte		        Gn2 , v108
	.byte	W36
	.byte		        Gn2 , v084
	.byte	W36
	.byte		        Gn2 , v092
	.byte	W24
@ 002   ----------------------------------------
LoopStart_006:
	.byte		N11   , Gn2 , v104
	.byte	W24
	.byte		N10   , Gn2 , v072
	.byte	W24
	.byte		N11   , Gn2 , v084
	.byte	W24
	.byte		        Gn2 , v072
	.byte	W24
@ 003   ----------------------------------------
	.byte		N10   , Fn2 , v104
	.byte	W24
	.byte		        Fn2 , v072
	.byte	W24
	.byte		N11   , Fn2 , v084
	.byte	W24
	.byte		        Fn2 , v072
	.byte	W24
@ 004   ----------------------------------------
	.byte		N10   , Ds3 , v104
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
	.byte		        Ds3 , v084
	.byte	W24
	.byte		N11   , Ds3 , v072
	.byte	W24
@ 005   ----------------------------------------
	.byte		        Dn3 , v104
	.byte	W24
	.byte		N10   , Dn3 , v072
	.byte	W24
	.byte		        Dn3 , v084
	.byte	W24
	.byte		        Dn3 , v072
	.byte	W24
@ 006   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
	.byte		        Cn3 , v084
	.byte	W24
	.byte		        Cn3 , v072
	.byte	W24
@ 007   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
	.byte		N11   , Cn3 , v084
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
@ 008   ----------------------------------------
	.byte		        Dn3 , v104
	.byte	W24
	.byte		N11   , Dn3 , v072
	.byte	W24
	.byte		N10   , Fn3 , v084
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
@ 009   ----------------------------------------
	.byte		        Gn3 , v104
	.byte	W24
	.byte		N11   , Gn3 , v072
	.byte	W24
	.byte		N10   , Gn3 , v084
	.byte	W24
	.byte		N11   , Gn3 , v072
	.byte	W24
@ 010   ----------------------------------------
	.byte		N10   , Gn3 , v104
	.byte	W24
	.byte		N11   , Gn3 , v072
	.byte	W24
	.byte		N10   , Gn3 , v084
	.byte	W24
	.byte		        Gn3 , v072
	.byte	W24
@ 011   ----------------------------------------
	.byte		        Fn3 , v104
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
	.byte		        Fn3 , v084
	.byte	W24
	.byte		N11   , Fn3 , v072
	.byte	W24
@ 012   ----------------------------------------
	.byte		N10   , Fn3 , v104
	.byte	W24
	.byte		N11   , Fn3 , v072
	.byte	W24
	.byte		N10   , Fn3 , v084
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
@ 013   ----------------------------------------
	.byte		N11   , Gn3 , v104
	.byte	W24
	.byte		        Gn3 , v072
	.byte	W24
	.byte		N10   , Gn3 , v084
	.byte	W24
	.byte		        Gn3 , v072
	.byte	W24
@ 014   ----------------------------------------
	.byte		        Ds3 , v104
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
	.byte		N11   , Ds3 , v084
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
@ 015   ----------------------------------------
	.byte		        Fn3 , v104
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
	.byte		N10   , Fn3 , v084
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
@ 016   ----------------------------------------
	.byte		N11   , Fn3 , v104
	.byte	W24
	.byte		N10   , Fn3 , v072
	.byte	W24
	.byte		        Fn3 , v084
	.byte	W24
	.byte		        Fn3 , v072
	.byte	W24
@ 017   ----------------------------------------
	.byte		        Gn3 , v104
	.byte	W24
	.byte		N11   , Cn4 , v072
	.byte	W24
	.byte		N10   , Dn4 , v084
	.byte	W24
	.byte		        Gn3 , v072
	.byte	W24
@ 018   ----------------------------------------
	.byte	W96
@ 019   ----------------------------------------
	.byte	W96
@ 020   ----------------------------------------
	.byte	W96
@ 021   ----------------------------------------
	.byte	W96
@ 022   ----------------------------------------
	.byte	W96
@ 023   ----------------------------------------
	.byte	W96
@ 024   ----------------------------------------
	.byte	W96
@ 025   ----------------------------------------
	.byte	W68
	.byte	W03
	.byte		VOICE , 109
	.byte		PAN   , c_v+47
	.byte		VOL   , 50*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte	W01
	.byte		N03   , Gn3 , v108
	.byte	W04
	.byte		        An3 
	.byte	W03
	.byte		        As3 
	.byte	W04
	.byte		        Cn4 
	.byte	W03
	.byte		N02   , Dn4 
	.byte	W04
	.byte		        Ds4 
	.byte	W03
	.byte		        Fn4 
	.byte	W03
@ 026   ----------------------------------------
	.byte		N44   , Gn4 
	.byte	W07
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W06
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte		        Ds5 
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W02
	.byte	W04
	.byte	W03
	.byte	W09
@ 027   ----------------------------------------
	.byte	W24
	.byte		N23   , Dn5 
	.byte	W24
	.byte		        Cn5 
	.byte	W24
	.byte		        As4 
	.byte	W22
	.byte	W02
@ 028   ----------------------------------------
	.byte		N44   , Gn4 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N17   , As4 
	.byte	W18
	.byte		        Ds4 
	.byte	W18
	.byte		N11   , Gn4 
	.byte	W12
@ 029   ----------------------------------------
	.byte		N44   , Fn4 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte		N23   , Cn4 
	.byte	W24
	.byte		        Dn4 
	.byte	W24
@ 030   ----------------------------------------
	.byte		TIE   , Ds4 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W04
@ 031   ----------------------------------------
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W04
	.byte	W03
	.byte	W05
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte		EOT   
	.byte	W01
	.byte		N17   , Dn4 
	.byte	W18
	.byte		        Ds4 
	.byte	W18
	.byte		N11   , Fn4 
	.byte	W12
@ 032   ----------------------------------------
	.byte		N60   , Gn4 
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W11
	.byte		N17   
	.byte	W18
	.byte		N05   , Gs4 
	.byte	W06
@ 033   ----------------------------------------
	.byte		N92   , Gn4 
	.byte	W06
	.byte	W08
	.byte	W05
	.byte	W05
	.byte	W04
	.byte	W04
	.byte	W05
	.byte	W05
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W01
	.byte		VOICE , 50
	.byte	W01
@ 034   ----------------------------------------
	.byte		N36   , Gn2 , v104
	.byte	W01
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W07
	.byte	W05
	.byte	W03
	.byte	W02
	.byte		N12   
	.byte	W02
	.byte	W04
	.byte	W04
	.byte	W02
	.byte		        Gn2 , v056
	.byte	W01
	.byte	W05
	.byte	W04
	.byte	W02
	.byte		        Gn2 , v040
	.byte	W06
	.byte	W06
	.byte		N36   , Fn2 , v104
	.byte	W02
	.byte	W09
	.byte	W09
	.byte	W04
@ 035   ----------------------------------------
	.byte	W04
	.byte	W08
	.byte		N72   , Ds2 
	.byte	W01
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W03
	.byte	W03
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
@ 036   ----------------------------------------
	.byte		N36   , Gn2 
	.byte	W04
	.byte	W03
	.byte	W03
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W02
	.byte		N12   
	.byte	W01
	.byte	W03
	.byte	W04
	.byte	W03
	.byte	W01
	.byte		        Gn2 , v056
	.byte	W02
	.byte	W04
	.byte	W04
	.byte	W02
	.byte		        Gn2 , v040
	.byte	W12
	.byte		N36   , Fn2 , v104
	.byte	W24
@ 037   ----------------------------------------
	.byte	W01
	.byte	W06
	.byte	W03
	.byte	W02
	.byte		N56   , Ds2 
	.byte	W01
	.byte	W03
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
@ 038   ----------------------------------------
	.byte		N10   , Gn2 , v068
	.byte	W36
	.byte		        Gn2 , v076
	.byte	W36
	.byte		N11   , Gn2 , v092
	.byte	W24
@ 039   ----------------------------------------
	.byte		N10   
	.byte	W36
	.byte		        Gn2 , v068
	.byte	W36
	.byte		N11   , Gn2 , v092
	.byte	W24
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_006
	.byte	FINE

@**************** Track 7 (Midi-Chn.7) ****************@

endlessbattle4_7:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 50
	.byte		PAN   , c_v+47
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N11   , Dn2 , v068
	.byte	W36
	.byte		N10   , Dn2 , v076
	.byte	W36
	.byte		N11   , Dn2 , v092
	.byte	W24
@ 001   ----------------------------------------
	.byte		        Dn2 , v108
	.byte	W36
	.byte		N10   , Dn2 , v084
	.byte	W36
	.byte		N11   , Dn2 , v092
	.byte	W24
@ 002   ----------------------------------------
LoopStart_007:
	.byte		        Ds3 , v104
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
	.byte		N10   , Ds3 , v084
	.byte	W24
	.byte		N11   , Ds3 , v072
	.byte	W24
@ 003   ----------------------------------------
	.byte		        Dn3 , v104
	.byte	W24
	.byte		N10   , Dn3 , v072
	.byte	W24
	.byte		        Dn3 , v084
	.byte	W24
	.byte		        Dn3 , v072
	.byte	W24
@ 004   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W24
	.byte		        Cn3 , v072
	.byte	W24
	.byte		N10   , Cn3 , v084
	.byte	W24
	.byte		N11   , Cn3 , v072
	.byte	W24
@ 005   ----------------------------------------
	.byte		N10   , As2 , v104
	.byte	W24
	.byte		        As2 , v072
	.byte	W24
	.byte		N11   , As2 , v084
	.byte	W24
	.byte		        As2 , v072
	.byte	W24
@ 006   ----------------------------------------
	.byte		        Gs2 , v104
	.byte	W24
	.byte		        Gs2 , v072
	.byte	W24
	.byte		N10   , Gs2 , v084
	.byte	W24
	.byte		        Gs2 , v072
	.byte	W24
@ 007   ----------------------------------------
	.byte		N11   , As2 , v104
	.byte	W24
	.byte		        As2 , v072
	.byte	W24
	.byte		        As2 , v084
	.byte	W24
	.byte		N10   , As2 , v072
	.byte	W24
@ 008   ----------------------------------------
	.byte		        Gs2 , v104
	.byte	W24
	.byte		N11   , Gs2 , v072
	.byte	W24
	.byte		        Cn3 , v084
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
@ 009   ----------------------------------------
	.byte		N11   , Dn3 , v104
	.byte	W24
	.byte		N10   , Dn3 , v072
	.byte	W24
	.byte		N11   , Dn3 , v084
	.byte	W24
	.byte		N10   , Dn3 , v072
	.byte	W24
@ 010   ----------------------------------------
	.byte		N11   , Ds3 , v104
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
	.byte		N10   , Ds3 , v084
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
@ 011   ----------------------------------------
	.byte		        Dn3 , v104
	.byte	W24
	.byte		N11   , Dn3 , v072
	.byte	W24
	.byte		        Dn3 , v084
	.byte	W24
	.byte		N10   , Dn3 , v072
	.byte	W24
@ 012   ----------------------------------------
	.byte		        Cn3 , v104
	.byte	W24
	.byte		        Cn3 , v072
	.byte	W24
	.byte		N11   , Cn3 , v084
	.byte	W24
	.byte		        Cn3 , v072
	.byte	W24
@ 013   ----------------------------------------
	.byte		        Ds3 , v104
	.byte	W24
	.byte		N10   , Ds3 , v072
	.byte	W24
	.byte		        Ds3 , v084
	.byte	W24
	.byte		        Ds3 , v072
	.byte	W24
@ 014   ----------------------------------------
	.byte		        Cn3 , v104
	.byte	W24
	.byte		        Cn3 , v072
	.byte	W24
	.byte		N11   , Cn3 , v084
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
@ 015   ----------------------------------------
	.byte		N11   , Cn3 , v104
	.byte	W24
	.byte		N10   , Cn3 , v072
	.byte	W24
	.byte		        Cn3 , v084
	.byte	W24
	.byte		N11   , Cn3 , v072
	.byte	W24
@ 016   ----------------------------------------
	.byte		N10   , En3 , v104
	.byte	W24
	.byte		N11   , En3 , v072
	.byte	W24
	.byte		        En3 , v084
	.byte	W24
	.byte		        En3 , v072
	.byte	W24
@ 017   ----------------------------------------
	.byte		        Dn3 , v104
	.byte	W24
	.byte		N10   , Gn3 , v072
	.byte	W24
	.byte		        Fn3 , v084
	.byte	W24
	.byte		        Dn3 , v072
	.byte	W24
@ 018   ----------------------------------------
	.byte	W96
@ 019   ----------------------------------------
	.byte	W96
@ 020   ----------------------------------------
	.byte	W96
@ 021   ----------------------------------------
	.byte	W96
@ 022   ----------------------------------------
	.byte	W92
	.byte		VOICE , 109
	.byte	W04
@ 023   ----------------------------------------
	.byte	W80
	.byte		VOL   , 50*endlessbattle4_mvl/mxv
	.byte	W16
@ 024   ----------------------------------------
	.byte	W96
@ 025   ----------------------------------------
	.byte	W60
	.byte	W01
	.byte	W10
	.byte	W24
	.byte	W01
@ 026   ----------------------------------------
	.byte	W96
@ 027   ----------------------------------------
	.byte	W96
@ 028   ----------------------------------------
	.byte	W96
@ 029   ----------------------------------------
	.byte	W96
@ 030   ----------------------------------------
	.byte	W96
@ 031   ----------------------------------------
	.byte	W96
@ 032   ----------------------------------------
	.byte	W96
@ 033   ----------------------------------------
	.byte	W96
@ 034   ----------------------------------------
	.byte	W96
@ 035   ----------------------------------------
	.byte	W96
@ 036   ----------------------------------------
	.byte	W96
@ 037   ----------------------------------------
	.byte	W72
	.byte		VOICE , 50
	.byte		PAN   , c_v+47
	.byte		VOL   , 50*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N06   , Ds2 , v104
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W02
	.byte		VOL   , 35*endlessbattle4_mvl/mxv
	.byte	W01
	.byte	W02
	.byte	W01
	.byte	W01
	.byte	W01
@ 038   ----------------------------------------
	.byte		N10   , Dn2 , v068
	.byte	W36
	.byte		        Dn2 , v076
	.byte	W36
	.byte		N11   , Dn2 , v092
	.byte	W24
@ 039   ----------------------------------------
	.byte		N11   
	.byte	W36
	.byte		N10   , Dn2 , v068
	.byte	W36
	.byte		        Dn2 , v092
	.byte	W24
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_007
	.byte	FINE

@**************** Track 8 (Midi-Chn.8) ****************@

endlessbattle4_8:
	.byte	KEYSH , endlessbattle4_key+0
@ 000   ----------------------------------------
	.byte		VOICE , 43
	.byte		PAN   , c_v+25
	.byte		VOL   , 53*endlessbattle4_mvl/mxv
	.byte		BEND  , c_v+0
	.byte		N32   , Gn1 , v116
	.byte	W36
	.byte		        Gn1 , v088
	.byte	W36
	.byte		N23   , Gn1 , v116
	.byte	W24
@ 001   ----------------------------------------
	.byte		N32   
	.byte	W36
	.byte		        Gn1 , v088
	.byte	W36
	.byte		N11   , Gn1 , v116
	.byte	W12
	.byte		N03   , Gn1 , v084
	.byte	W04
	.byte		        Gn1 , v092
	.byte	W04
	.byte		        Gn1 , v104
	.byte	W04
@ 002   ----------------------------------------
LoopStart_008:
endlessbattle4_8_002:
	.byte		N32   , Cn2 , v100
	.byte	W36
	.byte		N56   , Cn2 , v096
	.byte	W60
	.byte	PEND
@ 003   ----------------------------------------
endlessbattle4_8_003:
	.byte		N32   , As1 , v100
	.byte	W36
	.byte		N56   , As1 , v096
	.byte	W60
	.byte	PEND
@ 004   ----------------------------------------
endlessbattle4_8_004:
	.byte		N32   , Gs1 , v100
	.byte	W36
	.byte		N56   , Gs1 , v096
	.byte	W60
	.byte	PEND
@ 005   ----------------------------------------
endlessbattle4_8_005:
	.byte		N32   , Gn1 , v100
	.byte	W36
	.byte		N56   , Gn1 , v096
	.byte	W60
	.byte	PEND
@ 006   ----------------------------------------
	.byte		N32   , Fn1 , v100
	.byte	W36
	.byte		N56   , Fn1 , v096
	.byte	W60
@ 007   ----------------------------------------
	.byte		N32   , Ds1 , v100
	.byte	W36
	.byte		N56   , Ds1 , v096
	.byte	W60
@ 008   ----------------------------------------
endlessbattle4_8_008:
	.byte		N32   , Dn2 , v100
	.byte	W36
	.byte		N56   , Dn2 , v096
	.byte	W60
	.byte	PEND
@ 009   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_005
@ 010   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_002
@ 011   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_003
@ 012   ----------------------------------------
	.byte		N32   , An1 , v100
	.byte	W36
	.byte		N56   , An1 , v096
	.byte	W60
@ 013   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_004
@ 014   ----------------------------------------
endlessbattle4_8_014:
	.byte		N32   , Cs2 , v100
	.byte	W36
	.byte		N56   , Cs2 , v096
	.byte	W60
	.byte	PEND
@ 015   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_014
@ 016   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_008
@ 017   ----------------------------------------
	.byte	PATT
	 .word	endlessbattle4_8_005
@ 018   ----------------------------------------
	.byte		N92   , Gs1 , v092
	.byte	W96
@ 019   ----------------------------------------
	.byte		        As1 
	.byte	W96
@ 020   ----------------------------------------
	.byte		        Ds1 
	.byte	W96
@ 021   ----------------------------------------
	.byte		        Fn1 
	.byte	W96
@ 022   ----------------------------------------
	.byte		        Gs1 
	.byte	W96
@ 023   ----------------------------------------
	.byte		        As1 
	.byte	W96
@ 024   ----------------------------------------
	.byte		        An1 
	.byte	W96
@ 025   ----------------------------------------
	.byte		N92   
	.byte	W96
@ 026   ----------------------------------------
	.byte		        Gs1 
	.byte	W96
@ 027   ----------------------------------------
	.byte		        As1 
	.byte	W96
@ 028   ----------------------------------------
	.byte		        Ds1 
	.byte	W96
@ 029   ----------------------------------------
	.byte		        Fn1 
	.byte	W96
@ 030   ----------------------------------------
	.byte		        Gs1 
	.byte	W96
@ 031   ----------------------------------------
	.byte		N92   
	.byte	W96
@ 032   ----------------------------------------
	.byte		N24   , As1 , v088
	.byte	W24
	.byte		        As1 , v084
	.byte	W24
	.byte		N24   
	.byte	W24
	.byte		N23   
	.byte	W24
@ 033   ----------------------------------------
	.byte		N24   , Bn1 , v116
	.byte	W24
	.byte		        Bn1 , v084
	.byte	W24
	.byte		N24   
	.byte	W24
	.byte		N23   
	.byte	W24
@ 034   ----------------------------------------
	.byte		N32   , Cn2 , v116
	.byte	W36
	.byte		        As1 , v104
	.byte	W36
	.byte		N92   , Gs1 
	.byte	W24
@ 035   ----------------------------------------
	.byte	W72
	.byte		N05   , Gs1 , v072
	.byte	W06
	.byte		        Gs1 , v088
	.byte	W06
	.byte		        Gs1 , v096
	.byte	W06
	.byte		        Gs1 , v116
	.byte	W06
@ 036   ----------------------------------------
	.byte		N32   , Cn2 
	.byte	W36
	.byte		        As1 , v104
	.byte	W36
	.byte		N68   , Gs1 
	.byte	W24
@ 037   ----------------------------------------
	.byte	W48
	.byte		N24   , Ds1 , v108
	.byte	W24
	.byte		        Gs1 , v116
	.byte	W24
@ 038   ----------------------------------------
	.byte		N32   , Gn1 
	.byte	W36
	.byte		        Gn1 , v088
	.byte	W36
	.byte		N23   , Gn1 , v116
	.byte	W24
@ 039   ----------------------------------------
	.byte		N32   
	.byte	W36
	.byte		        Gn1 , v088
	.byte	W36
	.byte		N11   , Gn1 , v116
	.byte	W12
	.byte		N03   , Gn1 , v084
	.byte	W04
	.byte		        Gn1 , v092
	.byte	W04
	.byte		N02   , Gn1 , v104
	.byte	W04
@ 040   ----------------------------------------
	.byte	GOTO
	 .word LoopStart_008
	.byte	FINE

@******************************************************@
	.align	2

endlessbattle4:
	.byte	8	@ NumTrks
	.byte	0	@ NumBlks
	.byte	endlessbattle4_pri	@ Priority
	.byte	endlessbattle4_rev	@ Reverb.

	.word	endlessbattle4_grp

	.word	endlessbattle4_1
	.word	endlessbattle4_2
	.word	endlessbattle4_3
	.word	endlessbattle4_4
	.word	endlessbattle4_5
	.word	endlessbattle4_6
	.word	endlessbattle4_7
	.word	endlessbattle4_8

	.end
