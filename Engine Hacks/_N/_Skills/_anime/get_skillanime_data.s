@
@�Đ�����X�L���A�j���\���̂̎擾
@�擾�ł��Ȃ���� 0 ���Ԃ����
@
@���� r0=�X�L���̎�� #0x00=�U�� #0x01=�h�q
.thumb
    push {lr}

	@���������ꏊ�𐳊m�ɑ��肷��.
	ldr r2, =0x03004F9C @gCurrentUnitIndex
	ldr r3, =0x02000000 @WRAM 
	lsl r1 ,r2 ,#0x2
	add r1 ,r1, r3
	ldr r1, [r1, #0x0]  @ pointer:02000000 (WRAM )

	ldr r3, =0x0203AB40		@���������X�L���A�j�����L�^���Ă���ꏊ
							@Player �U���X�L��	0203AB40
							@Player �h�q�X�L��	0203AB41
							@Enemy  �U���X�L��	0203AB42
							@Enemy  �h�q�X�L��	0203AB43
							@�U���X�L���Ɩh�q�X�L���������ɔ������邱�Ƃ�����̂ŕ�����.

	LDR r2, =0x02029000
	CMP r1, r2
	BLS Player

Enemy:
	add		r3, #0x02       @�G�R
	add		r3, r0          @�h�q�X�L���Ȃ�+1 �U���X�L���Ȃ�+0
	b		Join1

Player:
	add		r3, r0          @�h�q�X�L���Ȃ�+1 �U���X�L���Ȃ�+0
@	b		Join1

Join1:
	ldrb	r0, [r3]      @�L�^���Ă������X�L��ID���擾

	cmp		r0,#0x00
	beq		Exit	@�s�� �f�B�t�H���g�A�j�������̂܂ܗ��p

	ldr		r1,	adr       @SkillAnimation* SkillAnimation[SKILL_ID] skillanimation@
	lsl		r0 ,r0 ,#0x2	@r1=skill_id << 2 (�|�C���^�Q�Ƃ��邽��)
	ldr		r0,[r1,r0]      @skl_anime_table[skill_id].SkillAnime

Exit:
    pop {pc}
.align 4
.ltorg
adr: