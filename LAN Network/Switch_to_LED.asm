#include <P16F84A.inc>
		
		__CONFIG	    _XT_OSC &	_CP_OFF	&   _WDT_OFF	&   _PWRTE_ON

PortADirection	    EQU	    B'00000000'	    ; Constants
PortBDirection	    EQU	    B'00000111'	    ;
	    
		    ORG	    0		    ; begins the code
Initialise  
			BSF	STATUS,RP0   ; switch to bank 1;
			BCF	OPTION_REG, 7 ;enables the resistor (active low);
			MOVLW	PortADirection
			MOVWF	TRISA
			MOVLW	PortBDirection
			MOVWF	TRISB
			BCF	STATUS,RP0 ; turn to bank 0;
			
MAIN		
			BTFSC	PORTB, 0    ;this will cheack oif the switch is "on" if it is true then it will run the next line if it is off then it will skip to cheack the next led
			BSF	PORTA, 0    ;Turning ON the LED
			BTFSC	PORTB, 1
			BSF	PORTA, 1
			BTFSC	PORTB, 2
			BSF	PORTA, 2
			
			BTFSS	PORTB, 0    ;this checking if the led is "off" if it is off it will run the next line if not it will skip
			BCF	PORTA, 0    ;Turning the LED off
			BTFSS	PORTB, 1
			BCF	PORTA, 1
			BTFSS	PORTB, 2
			BCF	PORTA, 2
			GOTO	MAIN
			
			END
			
;more simplified
;MOVF PORTB,W
;MOVWF PORTA

