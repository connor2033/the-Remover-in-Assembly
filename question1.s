		AREA Pointers, CODE, READONLY
		ENTRY

		ADR r1, STRING1			;	Pointing r2 to start of STRING2
		ADR r2, EoS				;	Pointing r2 in front of STRING2
		
Loop	CMP r3, #'t'			;	Comparing r3 to 't' char
		BEQ Check				;	Branching to 'check' if char is 't'

Not		STRB r3, [r2]			;	Moving non ' the ' chars to STRING2
		
		LDRB r3, [r1], #1		;	r3 is incremented through STRING1 
		LDRB r4, [r2], #1		;	r4 is incremented through STRING2
endCMP	CMP r3, #0x00			;	Checking if r3 has reached end of STRING1
		BEQ Finish				;	Branching to Finish
		
		B	Loop				;	Branch at end of main Loop

Check 	MOV r5, r1				;	Making copy of r1 location in r5 to char for ' the ' starting at 't'
		LDRB r6, [r5, #-2]		;	Setting r6 to char before 't' to check is Space

		CMP r6, #Before			;	Checking if r6 is Before string1
		CMPNE r6, #0x20			;	Checking if r6 is Space
		LDREQB r6, [r5], #1		;	Skipping to char after 't'
		CMPEQ r6, #'h'			;	Checking if r6 is 'h'
		LDREQB r6, [r5], #1		;	Incrementing to nexr char
		CMPEQ r6, #'e'			;	Checking if char is 'e'
		LDREQB r6, [r5], #1		;	Incrementing to next char
		CMPEQ r6, #0x20			;	Checking if char after 'the' is Space
		CMPNE r6, #0x00			;	Checking if char after 'the' is EoS
		BNE	Not					;	If char fails any of the above, branch back
		
		ADD r1, #2				;	Increading the location stored in r1
		LDRB r3, [r1], #1		;	Inrementing r3 in String1
		B	endCMP					;	Branching to test if EoS
		
Finish	B Finish				;	Loop to finish program
			
			
STRING1 DCB "and the man said they must go" ;String1
EoS 	DCB 0x00 				;	End of string1
STRING2 space 0x7F 				;	Just allocating 127 bytes
Before	EQU	0xFE				;	Creating loop counter starting at 3
		
		END