
#include <P16F84A.inc>
		
		__CONFIG	    _XT_OSC &	_CP_OFF	&   _WDT_OFF	&   _PWRTE_ON

TRISADIRECTION	    EQU	    B'00000000'	    ;constants to be used again and again;
TRISBDIRECTION	    EQU	    B'00000000'	    ;constants to be used again and again;
	    
        
	    CBLOCKx0C  ; Used to create variables (global variables)
		DELAY
		ENDC         ;(end varible declartions)
	    
		    ORG	    0		    ;
Initialise  
			BSF	       STATUS,RP0 ;bit 5 (bsf set to 1 and used to create inputs and output) rp0 is used to switch banks
            
			MOVLW      TRISADIRECTION ; moving constant to w register;
			MOVWF	   TRISA           ;moving from W register to trisA used to set inputs or outputs.(This makes TrisA all outputs (0));
			MOVLW	   TRISBDIRECTION	
			MOVWF	   TRISB
			BCF	         STATUS,RP0              ;Switch back to bank 0;
			
MAIN		       
 
                  BSF      PORTA,0  
		          BSF      PORTA,1
		          BSF      PORTA,2
                  CALL     SHORTDEL
		     
		          BCF      PORTA,2
                  BCF      PORTA,1
		          BCF      PORTA,0    
		          CALL     SHORTDEL
        GOTO      MAIN 
			
            
            
SHORTDEL		 MOVLW   D'255'
			     MOVWF   DELAY
			
SHORTDELDO		DECFSZ  DELAY,F
			    GOTO    SHORTDELDO
			    RETURN
			
			END
			
