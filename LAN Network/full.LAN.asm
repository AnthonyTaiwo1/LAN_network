#include  <P16F84A.inc>
		__CONFIG    _XT_OSC   &    _CP_OFF   &    _WDT_OFF   &    _PWRTE_ON

PortAIO		EQU	B'00010000'		;only RA3 as input
PortBIO		EQU	B'11111111'		;All except RB0 as inputs

;--------------------------------------------------------------------------
; Variables
;--------------------------------------------------------------------------
	    Cblock 0x0c 
TOKEN		;register for token to be saved or initiated
ShortDel	;Temporary register for short delay
LongDel		;Temporary register for long delay
	    endc 
;---------------------------------------------------------------------------
			ORG     0       
Initialise		BSF	STATUS,RP0
			
			MOVLW	PortAIO
			MOVWF	TRISA
			MOVLW	PortBIO
			MOVWF	TRISB
			BCF	OPTION_REG,7 
			BCF	STATUS,RP0
			BCF	PORTA,3
			BCF	PORTA,2
			BCF	PORTA,1
			BCF	PORTA,0
			
MASTER_OR_NOT		
			BTFSC	PORTB,7 
			GOTO	INITIATE_TOKEN		
			GOTO	RECEIVE_MODE 
			
			
INITIATE_TOKEN
			CALL	LONGDELAY
			CALL	LONGDELAY
			CALL	LONGDELAY
			CALL	LONGDELAY
			CALL	LONGDELAY
		
			          
			
			
			MOVF	PORTB,0		
			MOVWF	TOKEN 
			
			BSF	TOKEN,7	    
			BCF	TOKEN,6	    
			
			BCF	STATUS,C   
					   
			GOTO	TRANSMIT_TOKEN
TRANSMIT_TOKEN	
	
			BSF	PORTA,3		
			CALL	LONGDELAY
		
			
			BTFSC	TOKEN,0		; BIT 0 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1
			
			BTFSC	TOKEN,0		; BIT 1 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1
			
			
			BTFSC	TOKEN,0		; BIT 2 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1

			
			
			BTFSC	TOKEN,0		; BIT 3 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1

			
			
			BTFSC	TOKEN,0		; BIT 4 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1

			
			
			
			BTFSC	TOKEN,0		; BIT 5 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1
			
			
			
			BTFSC	TOKEN,0		; BIT 6 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1

			
			
			
			BTFSC	TOKEN,0		; BIT 7 TRANSMITTION 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1
			
			
			
			BTFSC	TOKEN,0		; ENDING BIT 
			BSF	PORTA,3
			BTFSS	TOKEN,0
			BCF	PORTA,3
			CALL	LONGDELAY
			RRF	TOKEN,1
			
			GOTO	RECEIVE_MODE 
		
			
			
			
RECEIVE_MODE 
			BTFSC	PORTA,4
			GOTO	RECEIVING
			GOTO	RECEIVE_MODE 

;------------------------------RECEIVING SUBROUTINE			
RECEIVING	    
			
			CALL	SHORTDELAY	
			CALL	LONGDELAY	 
			
			BTFSC	PORTA,4		; BIT 0
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0 
			RRF	TOKEN,1
			
			CALL	LONGDELAY
			
			
			BTFSC	PORTA,4		;BIT 1
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
			BTFSC	PORTA,4		;BIT 2
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
			BTFSC	PORTA,4		;BIT 3
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
			BTFSC	PORTA,4		;BIT 4
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
		
			BTFSC	PORTA,4		;BIT 5
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
			
			BTFSC	PORTA,4		;BIT 6
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
			
			BTFSC	PORTA,4		;BIT 7
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN,1
			CALL	LONGDELAY
			
				
			BTFSC	PORTA,4		;ENDING BIT 
			BSF	TOKEN,0
			BTFSS	PORTA,4
			BCF	TOKEN,0
			RRF	TOKEN
			CALL	LONGDELAY
			
			GOTO	CHECKS 		
			
;-----------------------CEHCK 
			
CHECKS 	
			BTFSC	TOKEN,7			
			GOTO	CONFIRMATION_CHECK	
			GOTO	INITIATE_TOKEN		
									
CONFIRMATION_CHECK
			
			BTFSC	TOKEN,6			
			GOTO	SENDER_CHECK		
			GOTO	DESTINATION_CHECK		
			
			
			
			
;---------------------------------SENDER CHECK-----------------------			
SENDER_CHECK
			
			BTFSC	PORTB,4			
			GOTO	CHECK_TOKEN2
			GOTO	B2_0
			
			
CHECK_TOKEN2
			BTFSC	TOKEN,4			
			GOTO	CHECK_B3		
			GOTO	TRANSMIT_TOKEN
			
CHECK_B3
			BTFSC	PORTB,5			 
			GOTO	CHECK_TOKEN3		
			GOTO	B3_0
			
B3_0
			BTFSS	TOKEN,5
			GOTO	IT_IS_THE_SENDER
			GOTO	TRANSMIT_TOKEN
		
CHECK_TOKEN3
			BTFSC 	TOKEN,5
			GOTO	IT_IS_THE_SENDER	
			GOTO	TRANSMIT_TOKEN
						
B2_0	
			BTFSS	TOKEN,4 
			GOTO	CHECK_B3
			GOTO	TRANSMIT_TOKEN

			
;----------------------------------THE END OF SENDER CHECK
			
			
		
IT_IS_THE_SENDER
			
			BCF	TOKEN,7 
			GOTO	TRANSMIT_TOKEN	    
	
			
		
;----------------------------------------DESTINATION CEHCK 			
			
DESTINATION_CHECK
			
			
			
			
			BTFSC	PORTB,4			
			GOTO	CHECK_TOKEN4
			GOTO	D_B2_0
			
			
CHECK_TOKEN4
			BTFSC	TOKEN,2			
			GOTO	CHECK_D_B3		
			GOTO	TRANSMIT_TOKEN
			
CHECK_D_B3
			BTFSC	PORTB,5			
			GOTO	CHECK_TOKEN5		
			GOTO	D_B3_0
			
D_B3_0
			BTFSS	TOKEN,3
			GOTO	APPLY_CODE
			GOTO	TRANSMIT_TOKEN
		
CHECK_TOKEN5
			BTFSC	TOKEN,3
			GOTO	APPLY_CODE		
			GOTO	TRANSMIT_TOKEN
						
D_B2_0	
			BTFSS	TOKEN,2 
			GOTO	CHECK_D_B3
			GOTO	TRANSMIT_TOKEN		
			

;----------------------APPLY CODE 
			
APPLY_CODE
			BTFSC	TOKEN,0     
			BSF	PORTA,0
			BTFSS	TOKEN,0
			BCF	PORTA,0
			
			BTFSC	TOKEN,1	   
			BSF	PORTA,1
			BTFSS	TOKEN,1
			BCF	PORTA,1
			
			
			GOTO	SEND_CONFIRMATION 
				
;---------------------------------SEND_CONFIRMATION			
SEND_CONFIRMATION
			BSF	TOKEN,6
			GOTO	TRANSMIT_TOKEN
			   
;EMPTY_TOKEN		
;			BCF	TOKEN,7
;			GOTO	TRANSMIT_TOKEN
			
USE_TOKEN 
			;MAYBE SAME AS INITIATE_TOKEN 
				
	
			
			
			
			
			
LONGDELAY			
			MOVLW	D'10'
			MOVWF	LongDel	;      LongDel = 250 units
			GOTO	LONGDELAY1	;LongDelay(250)
			RETURN
			
LONGDELAY1					;  DO
			CALL	LONGDELAY2	;ShortDelay()
			DECFSZ	LongDel,F	;LongDel = LongDel - 1
			GOTO	LONGDELAY1	;UNTIL LongDel = 0
			RETURN			;END PROCEDURE
			
			
LONGDELAY2			
			MOVLW	D'250'
			MOVWF	ShortDel	;LongDel = 150 units
			GOTO	LONGDELAY3	;LongDelay(150)
			
			RETURN
						
LONGDELAY3	
						
			DECFSZ	ShortDel,F	;LongDel = LongDel - 1
			GOTO	LONGDELAY3	;UNTIL LongDel = 0
			RETURN
			
			
			
;-------------------------------------SHORTDELAY			
			
SHORTDELAY			
			MOVLW	D'5'
			MOVWF	LongDel	;      LongDel = 250 units
			GOTO	SHORTDELAY1	;LongDelay(250)
			RETURN
			
SHORTDELAY1					;  DO
			CALL	SHORTDELAY2	;ShortDelay()
			DECFSZ	LongDel,F	;LongDel = LongDel - 1
			GOTO	SHORTDELAY1	;UNTIL LongDel = 0
			RETURN			;END PROCEDURE
			
			
SHORTDELAY2			
			MOVLW	D'250'
			MOVWF	ShortDel	;LongDel = 150 units
			CALL	SHORTDELAY3	;LongDelay(150)
			
			RETURN
						
SHORTDELAY3	
						
			DECFSZ	ShortDel,F	;LongDel = LongDel - 1
			GOTO	SHORTDELAY3	;UNTIL LongDel = 0
			RETURN
			
			END