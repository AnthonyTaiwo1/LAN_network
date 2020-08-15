#include <P16F84A.inc>
 __CONFIG _XT_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON
 
    CBLOCK 0x0c
    COUNT
    SHORT
    LONG
    XR
    XT
    ENDC
    ORG 0
INITIALISE
     BSF STATUS, RP0
     BCF OPTION_REG, 7
     MOVLW B'11110000'
     MOVWF TRISA
     MOVLW B'11111111'
     MOVWF TRISB
     BCF STATUS, RP0
 
START 
        BTFSC PORTA, 4
	GOTO START
	CALL SHORTDEL
        BTFSC PORTA, 4
    	GOTO START
        CALL LONGDEL
	MOVLW 8
        MOVWF COUNT
TEST	BTFSC PORTA, 4
	BSF STATUS, 0
	BTFSS PORTA, 4
	BCF STATUS,0
        RLF XR, F
	CALL LONGDEL
	DECFSZ COUNT, F
	GOTO TEST
	MOVF XR, W
	MOVWF PORTA
	
TRANSMIT	
	MOVF	PORTB, W
	MOVWF	XT
	BCF	PORTA, 3
	CALL	LONGDEL
	MOVLW	8
	MOVWF	COUNT
ROTATE	RLF	XT, F
	BTFSS	STATUS, 0
	BCF	PORTA, 3
	BTFSC	STATUS, 0
	BSF	PORTA, 3
	CALL	LONGDEL
	DECFSZ	COUNT, F
	GOTO	ROTATE
	BSF	PORTA, 3
	CALL	LONGDEL
	GOTO	START
 
LONGDEL     
	MOVLW   D'100'
	MOVWF   LONG
LONGDELDO   
        DECFSZ  LONG, F
	GOTO    LONGDELDO
	RETURN
     
SHORTDEL    
	MOVLW   D'50'
	MOVWF   SHORT
SHORTDELDO  
	DECFSZ  SHORT, F
	GOTO    SHORTDELDO
	RETURN
 END