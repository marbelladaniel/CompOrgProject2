{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww14000\viewh18000\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\
.globl main #starting point: must be global \
\
#user program code\
\
\
\
\
.data\
\
Ask input:\
.space 4000\
\
Prompt: \
	.asciiz \'93\\n\'94\
	.text		#enables text input/output\
\
 main:\
\
	li $v0, 4		#print prompt\
	la $a0, prompt\
	sys call\
\
	l\
\
}