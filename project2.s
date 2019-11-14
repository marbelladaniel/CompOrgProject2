{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\
.globl main #starting point: must be global\
\
\
# user program code\
\
\
#STEPS\
#1 user inputs string of 10 characters in ASCII\
#2 take in one character at a time and check if it is within range\
#3 if it is within range, convert to decimal\
#4 if it is out of range, change value of register to zero\
#5 add decimal value in registers to the sum and output final answer\
\
#N = (26 + (02898856 % 11)) = 30\
#M = 30 - 10 = 20 \
\
.data 	# user program data \
\
endprompt:\
.asciiz "\\n"	#starts new line\
\
askinput:\
.space 40 	#creates the base for a 10 character string \
\
prompt:\
	.asciiz "		\\n"\
	.text	 	#enables text input / output\
\
main:\
		li $v0, 4		#print prompt\
		la $a0, prompt\
		syscall\
		li $v0, 8		#store string values \
		li $a1, 11 	 	#space for 11 characters (including null)\
		la $a0, askinput 	#load address askinput and store it\
		syscall\
		move $t0, $zero		#storing zero initial register\
		li $t5, 0		#creating register for sum \
\
lp: \
		\
        	bge $t0, 10, endit	 #branch to endit once register >= 11\
		lb $t1, ($a0)   	 #load char from array into t1\
		addi $a0, $a0, 1		 #increment address\
		addi $t0, $t0, 1		#incrementing space		\
\
	ble $t1, 47, specialchar	#branch to specialchar label if char is less than 0\
	ble $t1, 57, whiledecimal	#branch to whiledecimal label if char is <= 9\
	ble $t1, 84, whileupper		#banch to whileupper label if char is <='t'\
	ble $t1, 116, whilelower	#branch to whilelower label if char is <='T'\
	ble $t1, 127, whileabove	#branch to whileabive label when char surpasses alphabet\
\
	specialchar:\
	sub $t2, $t1, $t1	#setting special character value to zero \
	add $t5, $t5, $t1	#add value of register to sum \
	j lp 	\
	\
	whiledecimal:\
	sub $t1, $t1, 48	#subtract 48 from ASCII value to get decimal value\
	add $t5, $t5, $t1	#adding decimal value to sum register\
	j lp  \
\
	whileupper:\
	ble $t1, 64, lp		#covering base cases\
	sub $t1, $t1, 84	#subtract 84 from ASCII value to get decimal value of uppercase 'T'\
	add $t5, $t5, $t1	#add decimal value to sum \
	j lp \
\
	whilelower:\
	ble $t1 96, lp		#covering base cases\
	sub $t1, $t1, 116	#add decimal value to the sum \
	add $t5, $t5, $t1	#add decimal value to the sum \
	\
	j lp \
\
	whileabove:\
	sub $t2, $t1, $t1	#setting special character value to zero \
	add $t5, $t5, $t1	#add value of register to sum \
	j lp\
\
	endit:\
	li $v0, 4	      	#print\
	la $a0, endprompt\
	syscall  		#print askinput	\
	li $v0, 1\
	move $a0, $t5		#printsum\
	syscall\
	li $v0, 10		#terminate call \
	syscall\
\
	\
\
}