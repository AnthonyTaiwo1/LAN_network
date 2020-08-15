#include<P16F84A.inc>

	__CONFIG _XT_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON

	CBLOCK	0x0c
		COUNT
		XR
		SHORT
		LONG
	ENDC

	ORG	0

START
	BSF	STATUS, RP0
	BCF	OPTION_REG, 7
	MOVLW	B'11110000'
	MOVWF	TRISA
	MOVLW	B'11111111'
	MOVWF	TRISB
	BCF	STATUS, RP0

MAIN	BTFSC	PORTA, 4
	GOTO	MAIN
	CALL	HALF
	BTFSC	PORTA, 4
	GOTO	MAIN
	CALL	FULL
	MOVLW	8
	MOVWF	COUNT
LOOP	BTFSS	PORTA, 4
	BCF	STATUS, 0
	BTFSC	PORTA, 4
	BSF	STATUS, 0
	RLF	XR, 1
	CALL	FULL
	DECFSZ	COUNT, F
	GOTO	LOOP
	MOVF	XR, 0
	MOVWF	PORTA
	GOTO	MAIN

FULL	    MOVLW   D'100'
	    MOVWF   LONG
LONGDELDO   DECFSZ  LONG, F
	    GOTO    LONGDELDO
	    RETURN
	    
HALF	    MOVLW   D'50'
	    MOVWF   SHORT
SHORTDELDO  DECFSZ  SHORT, F
	    GOTO    SHORTDELDO
	    RETURN
	END