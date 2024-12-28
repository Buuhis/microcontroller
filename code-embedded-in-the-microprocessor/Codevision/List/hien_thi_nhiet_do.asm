
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega16
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _count=R4
	.DEF _index=R6

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x30:
	.DB  0x0,0x0
_0x0:
	.DB  0xD,0xA,0x0,0x63,0x6F,0x75,0x6E,0x74
	.DB  0x3A,0x0,0x6C,0x65,0x64,0x31,0x20,0x6F
	.DB  0x6E,0x0,0x6C,0x65,0x64,0x31,0x20,0x6F
	.DB  0x66,0x66,0x0,0x6C,0x65,0x64,0x32,0x20
	.DB  0x6F,0x6E,0x0,0x6C,0x65,0x64,0x32,0x20
	.DB  0x6F,0x66,0x66,0x0,0x6C,0x65,0x64,0x33
	.DB  0x20,0x6F,0x6E,0x0,0x6C,0x65,0x64,0x33
	.DB  0x20,0x6F,0x66,0x66,0x0,0x6C,0x65,0x64
	.DB  0x34,0x20,0x6F,0x6E,0x0,0x6C,0x65,0x64
	.DB  0x34,0x20,0x6F,0x66,0x66,0x0,0x6C,0x65
	.DB  0x64,0x35,0x20,0x6F,0x6E,0x0,0x6C,0x65
	.DB  0x64,0x35,0x20,0x6F,0x66,0x66,0x0,0x6C
	.DB  0x65,0x64,0x36,0x20,0x6F,0x6E,0x0,0x6C
	.DB  0x65,0x64,0x36,0x20,0x6F,0x66,0x66,0x0
	.DB  0x6C,0x65,0x64,0x37,0x20,0x6F,0x6E,0x0
	.DB  0x6C,0x65,0x64,0x37,0x20,0x6F,0x66,0x66
	.DB  0x0,0x6C,0x65,0x64,0x38,0x20,0x6F,0x6E
	.DB  0x0,0x6C,0x65,0x64,0x38,0x20,0x6F,0x66
	.DB  0x66,0x0,0x73,0x65,0x74,0x20,0x74,0x69
	.DB  0x6D,0x65,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x03
	.DW  _0x6
	.DW  _0x0*2

	.DW  0x07
	.DW  _0xE
	.DW  _0x0*2+3

	.DW  0x03
	.DW  _0xE+7
	.DW  _0x0*2

	.DW  0x08
	.DW  _0x15
	.DW  _0x0*2+10

	.DW  0x09
	.DW  _0x15+8
	.DW  _0x0*2+18

	.DW  0x08
	.DW  _0x15+17
	.DW  _0x0*2+27

	.DW  0x09
	.DW  _0x15+25
	.DW  _0x0*2+35

	.DW  0x08
	.DW  _0x15+34
	.DW  _0x0*2+44

	.DW  0x09
	.DW  _0x15+42
	.DW  _0x0*2+52

	.DW  0x08
	.DW  _0x15+51
	.DW  _0x0*2+61

	.DW  0x09
	.DW  _0x15+59
	.DW  _0x0*2+69

	.DW  0x08
	.DW  _0x15+68
	.DW  _0x0*2+78

	.DW  0x09
	.DW  _0x15+76
	.DW  _0x0*2+86

	.DW  0x08
	.DW  _0x15+85
	.DW  _0x0*2+95

	.DW  0x09
	.DW  _0x15+93
	.DW  _0x0*2+103

	.DW  0x08
	.DW  _0x15+102
	.DW  _0x0*2+112

	.DW  0x09
	.DW  _0x15+110
	.DW  _0x0*2+120

	.DW  0x08
	.DW  _0x15+119
	.DW  _0x0*2+129

	.DW  0x09
	.DW  _0x15+127
	.DW  _0x0*2+137

	.DW  0x09
	.DW  _0x15+136
	.DW  _0x0*2+146

	.DW  0x02
	.DW  0x06
	.DW  _0x30*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <stdio.h>
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <string.h>
;#include <stdlib.h>
;#include <math.h>
;
;#define MAX_STRING_LENGTH 20
;#define ADC_VREF_TYPE 0x00
;
;volatile int ticks = 0;
;unsigned long tram, chuc, dvi;
;unsigned long adc_out;
;unsigned long nhiet_do;
;unsigned int count;
;char receivedData[MAX_STRING_LENGTH];
;int index = 0;
;
;void uart_char_send(unsigned char chr);  //chuong trinh con phat mot ky tu
;void uart_string_send(unsigned char *txt);  //chuong trinh con phat mot chuoi ky tu
;void check_string(char *receivedData);
;
;interrupt [EXT_INT0] void ext_int0_isr(void);  // External Interrupt 0 service routine
;interrupt [TIM1_COMPA] void timer1_compa_isr(void);
;interrupt [USART_RXC] void usart_rx_isr(void);
;
;unsigned int read_adc(unsigned char adc_input);  // Read the AD conversion result
;
;
;void main(void)
; 0000 001F {

	.CSEG
_main:
; 0000 0020 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0021 DDRA=0x00;
	OUT  0x1A,R30
; 0000 0022 
; 0000 0023 // Port B initialization
; 0000 0024 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In
; 0000 0025 // State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T
; 0000 0026 PORTB=0x00;
	OUT  0x18,R30
; 0000 0027 DDRB=0x02;
	LDI  R30,LOW(2)
	OUT  0x17,R30
; 0000 0028 
; 0000 0029 // Port C initialization
; 0000 002A // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 002B // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 002C PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 002D DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 002E 
; 0000 002F // Port D initialization
; 0000 0030 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=Out
; 0000 0031 // State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=0
; 0000 0032 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0033 DDRD=0x02;
	LDI  R30,LOW(2)
	OUT  0x11,R30
; 0000 0034 
; 0000 0035 // Timer/Counter 1 initialization
; 0000 0036 // Clock source: System Clock
; 0000 0037 // Clock value: 8000.000 kHz
; 0000 0038 // Mode: Normal top=0xFFFF
; 0000 0039 // OC1A output: Discon.
; 0000 003A // OC1B output: Discon.
; 0000 003B // Noise Canceler: Off
; 0000 003C // Input Capture on Falling Edge
; 0000 003D // Timer1 Overflow Interrupt: Off
; 0000 003E // Input Capture Interrupt: Off
; 0000 003F // Compare A Match Interrupt: On
; 0000 0040 // Compare B Match Interrupt: Off
; 0000 0041 TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 0042 TCCR1B=0x0C;
	LDI  R30,LOW(12)
	OUT  0x2E,R30
; 0000 0043 TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 0044 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0045 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0046 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0047 
; 0000 0048 
; 0000 0049 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 004A TIMSK=0x10;
	LDI  R30,LOW(16)
	OUT  0x39,R30
; 0000 004B 
; 0000 004C // External Interrupt(s) initialization
; 0000 004D // INT0: On
; 0000 004E // INT0 Mode: Rising Edge
; 0000 004F // INT1: Off
; 0000 0050 // INT2: Off
; 0000 0051 GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0052 MCUCR=0x03;
	LDI  R30,LOW(3)
	OUT  0x35,R30
; 0000 0053 MCUCSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0054 GIFR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 0055 
; 0000 0056 // USART initialization
; 0000 0057 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0058 // USART Receiver: On
; 0000 0059 // USART Transmitter: On
; 0000 005A // USART Mode: Asynchronous
; 0000 005B // USART Baud Rate: 9600
; 0000 005C UCSRA=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 005D UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 005E UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 005F UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0060 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0061 
; 0000 0062 // ADC initialization
; 0000 0063 // ADC Clock frequency: 1000.000 kHz
; 0000 0064 // ADC Voltage Reference: AREF pin
; 0000 0065 // ADC Auto Trigger Source: ADC Stopped
; 0000 0066 ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0067 ADCSRA=0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
; 0000 0068 
; 0000 0069 // Global enable interrupts
; 0000 006A #asm("sei")
	sei
; 0000 006B 
; 0000 006C 
; 0000 006D while (1)
_0x3:
; 0000 006E     {
; 0000 006F 
; 0000 0070         adc_out = read_adc(0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	STS  _adc_out,R30
	STS  _adc_out+1,R31
	STS  _adc_out+2,R22
	STS  _adc_out+3,R23
; 0000 0071         nhiet_do = adc_out*500/1023;
	__GETD2N 0x1F4
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3FF
	CALL __DIVD21U
	STS  _nhiet_do,R30
	STS  _nhiet_do+1,R31
	STS  _nhiet_do+2,R22
	STS  _nhiet_do+3,R23
; 0000 0072         chuc = nhiet_do/10;
	CALL SUBOPT_0x0
	CALL __DIVD21U
	CALL SUBOPT_0x1
; 0000 0073         dvi = (nhiet_do%10);
	CALL SUBOPT_0x0
	CALL __MODD21U
	CALL SUBOPT_0x2
; 0000 0074 
; 0000 0075 
; 0000 0076         //uart_string_send("nhiet do la:");
; 0000 0077         uart_char_send(chuc + 0x30);
	CALL SUBOPT_0x3
; 0000 0078         uart_char_send(dvi + 0x30);
; 0000 0079         uart_string_send("\r\n");
	__POINTW1MN _0x6,0
	CALL SUBOPT_0x4
; 0000 007A 
; 0000 007B         delay_ms(200);
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 007C 
; 0000 007D     }
	RJMP _0x3
; 0000 007E }
_0x7:
	RJMP _0x7

	.DSEG
_0x6:
	.BYTE 0x3
;
;
;
;
;void uart_char_send(unsigned char chr)
; 0000 0084 {

	.CSEG
_uart_char_send:
; 0000 0085     while (!(UCSRA & (1<<UDRE)))   //cho den khi bit UDRE = 1
;	chr -> Y+0
_0x8:
	SBIS 0xB,5
; 0000 0086     {
; 0000 0087 
; 0000 0088     };
	RJMP _0x8
; 0000 0089     UDR = chr;
	LD   R30,Y
	OUT  0xC,R30
; 0000 008A }
	RJMP _0x20A0002
;
;
;void uart_string_send(unsigned char *txt)
; 0000 008E {
_uart_string_send:
; 0000 008F     unsigned char n, i;
; 0000 0090     n = strlen(txt); //dem so ky tu
	ST   -Y,R17
	ST   -Y,R16
;	*txt -> Y+2
;	n -> R17
;	i -> R16
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	MOV  R17,R30
; 0000 0091         for (i = 0; i < n; i++)
	LDI  R16,LOW(0)
_0xC:
	CP   R16,R17
	BRSH _0xD
; 0000 0092         {
; 0000 0093             uart_char_send(txt[i]); //phat du lieu
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R30,X
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 0094         }
	SUBI R16,-1
	RJMP _0xC
_0xD:
; 0000 0095 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0001
;
;
;
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 009A {
_ext_int0_isr:
	CALL SUBOPT_0x5
; 0000 009B     count++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 009C 
; 0000 009D     tram = count/ 100;
	MOVW R26,R4
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	STS  _tram,R30
	STS  _tram+1,R31
	STS  _tram+2,R22
	STS  _tram+3,R23
; 0000 009E     chuc = (count % 100)/ 10;
	MOVW R26,R4
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __MODW21U
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x1
; 0000 009F     dvi = count % 10;
	MOVW R26,R4
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x2
; 0000 00A0 
; 0000 00A1 
; 0000 00A2     uart_string_send("count:");
	__POINTW1MN _0xE,0
	CALL SUBOPT_0x4
; 0000 00A3     uart_char_send(tram + 0x30);
	LDS  R30,_tram
	SUBI R30,-LOW(48)
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 00A4     uart_char_send(chuc + 0x30);
	CALL SUBOPT_0x3
; 0000 00A5     uart_char_send(dvi + 0x30);
; 0000 00A6 
; 0000 00A7     uart_string_send("\r\n");
	__POINTW1MN _0xE,7
	CALL SUBOPT_0x4
; 0000 00A8 }
	RJMP _0x2F

	.DSEG
_0xE:
	.BYTE 0xA
;
;
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 00AC {

	.CSEG
_timer1_compa_isr:
	ST   -Y,R26
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 00AD     PORTB ^= (1 << PORTB1);
	IN   R30,0x18
	LDI  R26,LOW(2)
	EOR  R30,R26
	OUT  0x18,R30
; 0000 00AE }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R26,Y+
	RETI
;
;
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 00B2 {
_usart_rx_isr:
	CALL SUBOPT_0x5
; 0000 00B3     char data = UDR;
; 0000 00B4     uart_char_send(data);
	ST   -Y,R17
;	data -> R17
	IN   R17,12
	ST   -Y,R17
	RCALL _uart_char_send
; 0000 00B5 
; 0000 00B6     if (data == '\n' || data == '\r')
	CPI  R17,10
	BREQ _0x10
	CPI  R17,13
	BRNE _0xF
_0x10:
; 0000 00B7     {
; 0000 00B8         receivedData[index] = '\0';
	LDI  R26,LOW(_receivedData)
	LDI  R27,HIGH(_receivedData)
	ADD  R26,R6
	ADC  R27,R7
	LDI  R30,LOW(0)
	ST   X,R30
; 0000 00B9         check_string(receivedData);
	LDI  R30,LOW(_receivedData)
	LDI  R31,HIGH(_receivedData)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _check_string
; 0000 00BA 
; 0000 00BB         index = 0;
	CLR  R6
	CLR  R7
; 0000 00BC     }
; 0000 00BD     else
	RJMP _0x12
_0xF:
; 0000 00BE     {
; 0000 00BF         if (index < MAX_STRING_LENGTH - 1)
	LDI  R30,LOW(19)
	LDI  R31,HIGH(19)
	CP   R6,R30
	CPC  R7,R31
	BRGE _0x13
; 0000 00C0         {
; 0000 00C1             receivedData[index++] = data;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	SBIW R30,1
	SUBI R30,LOW(-_receivedData)
	SBCI R31,HIGH(-_receivedData)
	ST   Z,R17
; 0000 00C2         }
; 0000 00C3     }
_0x13:
_0x12:
; 0000 00C4 }
	LD   R17,Y+
_0x2F:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;
;
;void check_string(char *receivedData)
; 0000 00C9 {
_check_string:
; 0000 00CA     if (strstr(receivedData, "led1 on") != NULL)
;	*receivedData -> Y+0
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,0
	CALL SUBOPT_0x7
	BREQ _0x14
; 0000 00CB     {
; 0000 00CC         PORTC |= 0b00000001;
	SBI  0x15,0
; 0000 00CD     }
; 0000 00CE     if (strstr(receivedData, "led1 off") != NULL)
_0x14:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,8
	CALL SUBOPT_0x7
	BREQ _0x16
; 0000 00CF     {
; 0000 00D0         PORTC &= ~0b00000001;
	CBI  0x15,0
; 0000 00D1     }
; 0000 00D2     if (strstr(receivedData, "led2 on") != NULL)
_0x16:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,17
	CALL SUBOPT_0x7
	BREQ _0x17
; 0000 00D3     {
; 0000 00D4         PORTC |= 0b00000010;
	SBI  0x15,1
; 0000 00D5     }
; 0000 00D6     if (strstr(receivedData, "led2 off") != NULL)
_0x17:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,25
	CALL SUBOPT_0x7
	BREQ _0x18
; 0000 00D7     {
; 0000 00D8         PORTC &= ~0b00000010;
	CBI  0x15,1
; 0000 00D9     }
; 0000 00DA     if (strstr(receivedData, "led3 on") != NULL)
_0x18:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,34
	CALL SUBOPT_0x7
	BREQ _0x19
; 0000 00DB     {
; 0000 00DC         PORTC |= 0b00000100;
	SBI  0x15,2
; 0000 00DD     }
; 0000 00DE     if (strstr(receivedData, "led3 off") != NULL)
_0x19:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,42
	CALL SUBOPT_0x7
	BREQ _0x1A
; 0000 00DF     {
; 0000 00E0         PORTC &= ~0b00000100;
	CBI  0x15,2
; 0000 00E1     }
; 0000 00E2     if (strstr(receivedData, "led4 on") != NULL)
_0x1A:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,51
	CALL SUBOPT_0x7
	BREQ _0x1B
; 0000 00E3     {
; 0000 00E4         PORTC |= 0b00001000;
	SBI  0x15,3
; 0000 00E5     }
; 0000 00E6     if (strstr(receivedData, "led4 off") != NULL)
_0x1B:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,59
	CALL SUBOPT_0x7
	BREQ _0x1C
; 0000 00E7     {
; 0000 00E8         PORTC &= ~0b00001000;
	CBI  0x15,3
; 0000 00E9     }
; 0000 00EA     if (strstr(receivedData, "led5 on") != NULL)
_0x1C:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,68
	CALL SUBOPT_0x7
	BREQ _0x1D
; 0000 00EB     {
; 0000 00EC         PORTC |= 0b00010000;
	SBI  0x15,4
; 0000 00ED     }
; 0000 00EE     if (strstr(receivedData, "led5 off") != NULL)
_0x1D:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,76
	CALL SUBOPT_0x7
	BREQ _0x1E
; 0000 00EF     {
; 0000 00F0         PORTC &= ~0b00010000;
	CBI  0x15,4
; 0000 00F1     }
; 0000 00F2     if (strstr(receivedData, "led6 on") != NULL)
_0x1E:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,85
	CALL SUBOPT_0x7
	BREQ _0x1F
; 0000 00F3     {
; 0000 00F4         PORTC |= 0b00100000;
	SBI  0x15,5
; 0000 00F5     }
; 0000 00F6     if (strstr(receivedData, "led6 off") != NULL)
_0x1F:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,93
	CALL SUBOPT_0x7
	BREQ _0x20
; 0000 00F7     {
; 0000 00F8         PORTC &= ~0b00100000;
	CBI  0x15,5
; 0000 00F9     }
; 0000 00FA     if (strstr(receivedData, "led7 on") != NULL)
_0x20:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,102
	CALL SUBOPT_0x7
	BREQ _0x21
; 0000 00FB     {
; 0000 00FC         PORTC |= 0b01000000;
	SBI  0x15,6
; 0000 00FD     }
; 0000 00FE     if (strstr(receivedData, "led7 off") != NULL)
_0x21:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,110
	CALL SUBOPT_0x7
	BREQ _0x22
; 0000 00FF     {
; 0000 0100         PORTC &= ~0b01000000;
	CBI  0x15,6
; 0000 0101     }
; 0000 0102     if (strstr(receivedData, "led8 on") != NULL)
_0x22:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,119
	CALL SUBOPT_0x7
	BREQ _0x23
; 0000 0103     {
; 0000 0104         PORTC |= 0b10000000;
	SBI  0x15,7
; 0000 0105     }
; 0000 0106     if (strstr(receivedData, "led8 off") != NULL)
_0x23:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,127
	CALL SUBOPT_0x7
	BREQ _0x24
; 0000 0107     {
; 0000 0108         PORTC &= ~0b10000000;
	CBI  0x15,7
; 0000 0109     }
; 0000 010A 
; 0000 010B 
; 0000 010C     if (strncmp(receivedData, "set time", 8) == 0)
_0x24:
	CALL SUBOPT_0x6
	__POINTW1MN _0x15,136
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(8)
	ST   -Y,R30
	CALL _strncmp
	CPI  R30,0
	BREQ PC+3
	JMP _0x25
; 0000 010D     {
; 0000 010E         ticks = atoi(receivedData + 9);
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,9
	ST   -Y,R31
	ST   -Y,R30
	CALL _atoi
	CALL SUBOPT_0x8
; 0000 010F 
; 0000 0110         ticks = (ticks < 5) ? ticks : 5;
	LDS  R26,_ticks
	LDS  R27,_ticks+1
	SBIW R26,5
	BRGE _0x26
	CALL SUBOPT_0x9
	RJMP _0x27
_0x26:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
_0x27:
	CALL SUBOPT_0x8
; 0000 0111         ticks = (ticks > 0.5) ? ticks : 0.5;
	CALL SUBOPT_0x9
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F000000
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+3
	JMP  _0x29
	CALL SUBOPT_0x9
	RJMP _0x2A
_0x29:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
_0x2A:
	CALL SUBOPT_0x8
; 0000 0112 
; 0000 0113         // Convert time to ticks
; 0000 0114         ticks = (int)floor(ticks * 8000000 / 256);
	LDS  R26,_ticks
	LDS  R27,_ticks+1
	CALL __CWD2
	__GETD1N 0x7A1200
	CALL __MULD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x100
	CALL __DIVD21
	CALL __CDF1
	CALL __PUTPARD1
	CALL _floor
	CALL __CFD1
	CALL SUBOPT_0x8
; 0000 0115 
; 0000 0116         OCR1AH = (unsigned char)(ticks >> 8);
	CALL SUBOPT_0x9
	CALL __ASRW8
	OUT  0x2B,R30
; 0000 0117         OCR1AL = (unsigned char)ticks;
	LDS  R30,_ticks
	OUT  0x2A,R30
; 0000 0118     }
; 0000 0119 }
_0x25:
	ADIW R28,2
	RET

	.DSEG
_0x15:
	.BYTE 0x91
;
;
;
;unsigned int read_adc(unsigned char adc_input)
; 0000 011E {

	.CSEG
_read_adc:
; 0000 011F ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	LD   R30,Y
	OUT  0x7,R30
; 0000 0120 // Delay needed for the stabilization of the ADC input voltage
; 0000 0121 delay_us(10);
	__DELAY_USB 27
; 0000 0122 // Start the AD conversion
; 0000 0123 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 0124 // Wait for the AD conversion to complete
; 0000 0125 while ((ADCSRA & 0x10)==0);
_0x2C:
	SBIS 0x6,4
	RJMP _0x2C
; 0000 0126 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 0127 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
_0x20A0002:
	ADIW R28,1
	RET
; 0000 0128 }
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strncmp:
    clr  r22
    clr  r23
    ld   r24,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strncmp0:
    tst  r24
    breq strncmp1
    dec  r24
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strncmp1
    tst  r22
    brne strncmp0
strncmp3:
    clr  r30
    ret
strncmp1:
    sub  r22,r23
    breq strncmp3
    ldi  r30,1
    brcc strncmp2
    subi r30,2
strncmp2:
    ret
_strstr:
    ldd  r26,y+2
    ldd  r27,y+3
    movw r24,r26
strstr0:
    ld   r30,y
    ldd  r31,y+1
strstr1:
    ld   r23,z+
    tst  r23
    brne strstr2
    movw r30,r24
    rjmp strstr3
strstr2:
    ld   r22,x+
    cp   r22,r23
    breq strstr1
    adiw r24,1
    movw r26,r24
    tst  r22
    brne strstr0
    clr  r30
    clr  r31
strstr3:
	JMP  _0x20A0001

	.CSEG
_atoi:
   	ldd  r27,y+1
   	ld   r26,y
__atoi0:
   	ld   r30,x
	ST   -Y,R30
	CALL _isspace
   	tst  r30
   	breq __atoi1
   	adiw r26,1
   	rjmp __atoi0
__atoi1:
   	clt
   	ld   r30,x
   	cpi  r30,'-'
   	brne __atoi2
   	set
   	rjmp __atoi3
__atoi2:
   	cpi  r30,'+'
   	brne __atoi4
__atoi3:
   	adiw r26,1
__atoi4:
   	clr  r22
   	clr  r23
__atoi5:
   	ld   r30,x
	ST   -Y,R30
	CALL _isdigit
   	tst  r30
   	breq __atoi6
   	movw r30,r22
   	lsl  r22
   	rol  r23
   	lsl  r22
   	rol  r23
   	add  r22,r30
   	adc  r23,r31
   	lsl  r22
   	rol  r23
   	ld   r30,x+
   	clr  r31
   	subi r30,'0'
   	add  r22,r30
   	adc  r23,r31
   	rjmp __atoi5
__atoi6:
   	movw r30,r22
   	brtc __atoi7
   	com  r30
   	com  r31
   	adiw r30,1
__atoi7:
   	adiw r28,2
   	ret

	.DSEG

	.CSEG

	.CSEG
_ftrunc:
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
_floor:
	CALL SUBOPT_0xA
	CALL __PUTPARD1
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL SUBOPT_0xA
	RJMP _0x20A0001
__floor1:
    brtc __floor0
	CALL SUBOPT_0xA
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x20A0001:
	ADIW R28,4
	RET

	.CSEG
_isdigit:
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'0'
    brlo isdigit0
    cpi  r31,'9'+1
    brlo isdigit1
isdigit0:
    clr  r30
isdigit1:
    ret
_isspace:
    ldi  r30,1
    ld   r31,y+
    cpi  r31,' '
    breq isspace1
    cpi  r31,9
    brlo isspace0
    cpi  r31,13+1
    brlo isspace1
isspace0:
    clr  r30
isspace1:
    ret

	.DSEG
_ticks:
	.BYTE 0x2
_tram:
	.BYTE 0x4
_chuc:
	.BYTE 0x4
_dvi:
	.BYTE 0x4
_adc_out:
	.BYTE 0x4
_nhiet_do:
	.BYTE 0x4
_receivedData:
	.BYTE 0x14
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	LDS  R26,_nhiet_do
	LDS  R27,_nhiet_do+1
	LDS  R24,_nhiet_do+2
	LDS  R25,_nhiet_do+3
	__GETD1N 0xA
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	STS  _chuc,R30
	STS  _chuc+1,R31
	STS  _chuc+2,R22
	STS  _chuc+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	STS  _dvi,R30
	STS  _dvi+1,R31
	STS  _dvi+2,R22
	STS  _dvi+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	LDS  R30,_chuc
	SUBI R30,-LOW(48)
	ST   -Y,R30
	CALL _uart_char_send
	LDS  R30,_dvi
	SUBI R30,-LOW(48)
	ST   -Y,R30
	JMP  _uart_char_send

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _uart_string_send

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x5:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x6:
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x7:
	ST   -Y,R31
	ST   -Y,R30
	CALL _strstr
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	STS  _ticks,R30
	STS  _ticks+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	LDS  R30,_ticks
	LDS  R31,_ticks+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	CALL __GETD1S0
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULD12:
	RCALL __CHKSIGND
	RCALL __MULD12U
	BRTC __MULD121
	RCALL __ANEGD1
__MULD121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

;END OF CODE MARKER
__END_OF_CODE:
