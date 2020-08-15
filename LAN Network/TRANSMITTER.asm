#include<P16F84A.inc>

	__CONFIG _XT_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON
	
	CBLOCK	0x0c ; Used to create variables (global variables)
		COUNT
		SHORT
		LONG
		XT
	ENDC				;(end varible declartions)

	ORG	0

INITIALISE				; a destionion to goto
	BSF	STATUS, RP0		;bit 5 (bsf set to 1 and used to create inputs and output) rp0 is used to switch banks
	BCF	OPTION_REG, 7		;rbpu (bcf sets to 0 and is used for high and low ) this is a active low pullup resistorr 
	MOVLW	B'11110000'		; 
	MOVFW	TRISA
	MOVLW	B'11111111'
	MOVFW	TRISB
	BCF	STATUS, RP0

	
START	
	MOVF	PORTB, W
	MOVWF	XT
	BCF	PORTA, 3
	CALL	SHORTDEL
	MOVLW	8
	MOVWF	COUNT
ROTATE	RLF	XT
	BTFSS	STATUS, 0
	BCF	PORTA, 3
	BTFSC	STATUS, 0
	BSF	PORTA, 3
	CALL	SHORTDEL
	DECFSZ	COUNT
	GOTO	ROTATE
	BSF	PORTA, 3
	CALL	LONGDEL
	GOTO	START
	
	
LONGDEL	    MOVLW   12
	    MOVWF   LONG
LONGDELDO   CALL    SHORTDEL
	    DECFSZ  LONG, F
	    GOTO    LONGDELDO
	    RETURN
	    
SHORTDEL    MOVLW   D'100'
	    MOVWF   SHORT
SHORTDELDO  DECFSZ  SHORT, F
	    GOTO    SHORTDELDO
	    RETURN
	END


