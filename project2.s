{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 ArialMT;\f2\froman\fcharset0 Times-Roman;
}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww14160\viewh18000\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\
.globl main #starting point: must be global\
\
\
# user program code\
\
\
\
\pard\pardeftab720\sl400\partightenfactor0

\f1\fs29\fsmilli14667 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 .data
\f2\fs24 \

\f1\fs29\fsmilli14667 	data: .space 1001
\f2\fs24 \

\f1\fs29\fsmilli14667 	output: .asciiz "\\n"
\f2\fs24 \

\f1\fs29\fsmilli14667 	notvalid: .asciiz "Invalid input"
\f2\fs24 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 .text\
\
\
\
main:\
		
\f1\fs29\fsmilli14667 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 	#asks for input
\f2\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f1\fs29\fsmilli14667 \cf2 	li $v0, 8
\f2\fs24 \

\f1\fs29\fsmilli14667 	la $a0, data
\f2\fs24 \

\f1\fs29\fsmilli14667 	li $a1, 1001
\f2\fs24 \

\f1\fs29\fsmilli14667 	syscall
\f2\fs24 \

\f1\fs29\fsmilli14667 	jal before
\f2\fs24 \

\f1\fs29\fsmilli14667 	j finish
\f2\fs24 \

\f1\fs29\fsmilli14667 before:\
\
#removing leading spaces\

\f2\fs24 \

\f1\fs29\fsmilli14667 	la $t0,data
\f2\fs24 \

\f1\fs29\fsmilli14667 	add $t0,$t0,$t1
\f2\fs24 \

\f1\fs29\fsmilli14667 	lb $s0, ($t0)
\f2\fs24 \

\f1\fs29\fsmilli14667 	beq $s0, 0, finish
\f2\fs24 \

\f1\fs29\fsmilli14667 	beq $s0, 9, skip
\f2\fs24 \

\f1\fs29\fsmilli14667 	beq $s0, 32, skip
\f2\fs24 \

\f1\fs29\fsmilli14667 	move $t6, $t1
\f2\fs24 \

\f1\fs29\fsmilli14667 	j during
\f2\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 	\
\
	
\f1\fs29\fsmilli14667 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 skip:
\f2\fs24 \
\pard\pardeftab720\sl400\partightenfactor0

\f1\fs29\fsmilli14667 \cf2 	addi $t1, $t1,1
\f2\fs24 \

\f1\fs29\fsmilli14667 	j before
\f2\fs24 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 \
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