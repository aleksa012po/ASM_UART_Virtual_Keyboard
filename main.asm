;
; UART_VirtuelnaKlavijatura.asm
;
; Created: 27.9.2022. 09:57:57
; Author : Aleksandar Bogdanovic
;
/*Arduino Asembler, Napraviti virtualnu klavijaturu u smislu da 
sviramo na tastaturi a da se cuje odgovarajuci ton na Arduinu 
i zvucniku preko tranzistorskog pojacivaca.*/

.include "m328pdef.inc"
.org 0x0000
rjmp init

// Delay podesavanja
// r16 i r17 su korisceni za macro tone
.def spolj_loop = r18
.def unutr_H_loop = r27
.def unutr_L_loop = r28
.equ value = 39998
// r20, r21 i r31 su korisceni za delay_ton
// r24, r25 za inicijalizaciju i proveru

// Podesavanja tonova
.equ _c4 = 239 ;(16000000 / 256) / 261.63(frequency of C) - 1
.equ _d4 = 213 ;(16000000 / 256) / 293.66(frequency of D) - 1
.equ _e4 = 190 ;(16000000 / 256) / 329.63(frequency of E) - 1
.equ _f4 = 179 ;(16000000 / 256) / 349.23(frequency of F) - 1
.equ _g4 = 159 ;(16000000 / 256) / 392.00(frequency of G) - 1
.equ _a4 = 141 ;(16000000 / 256) / 440.00(frequency of A) - 1
.equ _b4 = 126 ;(16000000 / 256) / 493.88(frequency of B) - 1
.equ _c5 = 118 ;(16000000 / 256) / 523.25(frequency of C) - 1

// PWM duzina
.equ c4_ = 120 ;(16000000 / 256) / 261.63 / 2(frequency of C) - 1
.equ d4_ = 107 ;(16000000 / 256) / 293.66 / 2(frequency of D) - 1
.equ e4_ = 95 ;(16000000 / 256) / 329.63 / 2(frequency of E) - 1
.equ f4_ = 90 ;(16000000 / 256) / 349.23 / 2(frequency of F) - 1
.equ g4_ = 80 ;(16000000 / 256) / 392.00 / 2(frequency of G) - 1
.equ a4_ = 71 ;(16000000 / 256) / 440.00 / 2(frequency of A) - 1
.equ b4_ = 63 ;(16000000 / 256) / 493.88 / 2(frequency of B) - 1
.equ c5_ = 59 ;(16000000 / 256) / 523.25 / 2(frequency of C) - 1

.macro tone
	ldi r16, 0b00100011
	out TCCR0A, r16
	ldi r16, 0b00001100
	out TCCR0B, r16
	ldi r16, @0
	out OCR0A, r16
	ldi r17, @1
	out OCR0B, r17
	sbi DDRD, 5
.endmacro

.macro mute
	cbi DDRD, 5
.endmacro

.macro delay_ton
	ldi  r19, 25
    ldi  r20, 90
    ldi  r31, 178
L1: dec  r31
    brne L1
    dec  r20
    brne L1
    dec  r19
    brne L1
.endmacro

init:
	clr r24								
	sts UCSR0A, r24						
	sts UBRR0H, r24						
	ldi r24, 103						
	sts UBRR0L, r24								// Baud rate 9600
	ldi r24, (1<<RXEN0) | (1<<TXEN0)	
	sts UCSR0B, r24								// Enable RxB and TxB
	ldi r24, (1<<UCSZ00) | (1<<UCSZ01)	
	sts UCSR0C, r24								// 8bit char
	
			
check:
	lds r25, UCSR0A						
	sbrs r25, RXC0
	jmp check


// Mora ASCII u HTerm ili Putty
citanje_pisanje:
	lds r26, UDR0						
	sts UDR0, r26
	rjmp tonovi
	rjmp init

tonovi:
	ldi r30, 113
	cpse r26, r30
	rjmp W
	rjmp keyQ
W:
	ldi r30, 119
	cpse r26, r30
	rjmp E
	rjmp keyW
E:
	ldi r30, 101
	cpse r26, r30
	rjmp R
	rjmp keyE
R:	
	ldi r30, 114
	cpse r26, r30
	rjmp T
	rjmp keyR
T:
	ldi r30, 116
	cpse r26, r30
	rjmp RZ
	rjmp keyT
RZ:
	ldi r30, 122
	cpse r26, r30
	rjmp U
	rjmp keyZ
U:
	ldi r30, 117	
	cpse r26, r30
	rjmp I
	rjmp keyU
I:
	ldi r30, 105
	cpse r26, r30
	rjmp CH
	rjmp keyI
CH:
	jmp check


keyQ:
	tone _c4, c4_ //C
	delay_ton
	mute
	jmp check

keyW:
	tone _d4, d4_ //D
	delay_ton
	mute
	jmp check

keyE:
	tone _e4, e4_ //E
	delay_ton
	mute
	jmp check

keyR:
	tone _f4, f4_ //F
	delay_ton
	mute
	jmp check

keyT:
	tone _g4, g4_ //G
	delay_ton
	mute
	jmp check

keyZ:
	tone _a4, a4_ //A
	delay_ton
	mute
	jmp check

keyU:
	tone _b4, b4_ //B
	delay_ton
	mute
	jmp check

keyI:
	tone _c5, c5_ //C2
	delay_ton
	mute
	jmp check

