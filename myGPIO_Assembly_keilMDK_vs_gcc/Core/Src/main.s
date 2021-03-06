
.cpu cortex-m4
.syntax unified

//RCC_BASE			EQU		0x40023800
.equ RCC_BASE,0x40023800

//AHB1ENR_OFFSET 		EQU		0x30
.equ AHB1ENR_OFFSET,0x30

//RCC_AHB1ENR			EQU		RCC_BASE + AHB1ENR_OFFSET
.equ RCC_AHB1ENR,RCC_BASE + AHB1ENR_OFFSET

//GPIOA_BASE			EQU		0x40020000
.equ GPIOA_BASE,0x40020000

//GPIOA_MODER_OFFSET	EQU		0x00
.equ GPIOA_MODER_OFFSET,0x00

//GPIOA_MODER			EQU		GPIOA_BASE + GPIOA_MODER_OFFSET
.equ GPIOA_MODER,GPIOA_BASE + GPIOA_MODER_OFFSET

//GPIOA_ODR_OFFSET	EQU		0x14
.equ GPIOA_ODR_OFFSET,0x14

//GPIOA_ODR			EQU		GPIOA_BASE + GPIOA_ODR_OFFSET
.equ GPIOA_ODR,GPIOA_BASE + GPIOA_ODR_OFFSET

//GPIOC_BASE			EQU		0x40020800
.equ  GPIOC_BASE,0x40020800

//GPIOC_MODER_OFFSET	EQU		0x00
.equ GPIOC_MODER_OFFSET,0x00

//GPIOC_MODER			EQU		GPIOC_BASE + GPIOC_MODER_OFFSET
.equ GPIOC_MODER,GPIOC_BASE + GPIOC_MODER_OFFSET

//GPIOC_IDR_OFFSET	EQU     0x10
.equ GPIOC_IDR_OFFSET,0x10

//GPIOC_IDR			EQU		GPIOC_BASE + GPIOC_IDR_OFFSET
.equ GPIOC_IDR,GPIOC_BASE + GPIOC_IDR_OFFSET


//Using the bit-set-reset-register
//GPIOA_BSRR_OFFSET	EQU		0x18
.equ GPIOA_BSRR_OFFSET,0x18

//GPIOA_BSRR			EQU		GPIOA_BASE	+ GPIOA_BSRR_OFFSET
.equ GPIOA_BSRR,GPIOA_BASE	+ GPIOA_BSRR_OFFSET

//BSRR_5_SET			EQU		1 << 5
.equ BSRR_5_SET,1 << 5

//BSRR_5_RESET		EQU		1 << 21
.equ BSRR_5_RESET,1 << 21

//GPIOA_EN			EQU		1<<	0
.equ GPIOA_EN,1<<	0

//GPIOC_EN			EQU		1<<	2
.equ GPIOC_EN,1<<	2

//MODER5_OUT			EQU		1 << 10
.equ MODER5_OUT,1 << 10

//LED_ON				EQU		1 << 5
.equ LED_ON,1 << 5

//LED_OFF				EQU		0 << 5
.equ LED_OFF,0 << 5

//BTN_ON				EQU		0x0000
.equ  BTN_ON,0x0000

//BTN_PIN				EQU		0x2000
.equ BTN_PIN,0x2000

//BTN_OFF				EQU		0x2000
.equ BTN_OFF,0x2000



					.section .text //AREA		|.text|,CODE,READONLY,ALIGN=2
									//THUMB
									//ENTRY
					.globl main		 //EXPORT	__main

main:
					BL		GPIO_Init

loop:
					BL		get_input
					CMP		R0,#BTN_ON
					BEQ		turn_led_on
					CMP		R0,#BTN_OFF
					BEQ		turn_led_off

					B		loop



turn_led_off:
					LDR		R2,=GPIOA_BSRR
					MOV		R1,BSRR_5_RESET
					STR		R1,[R2]
					B		loop


turn_led_on:
					LDR		R2,=GPIOA_BSRR
					MOV		R1,#BSRR_5_SET
					STR		R1,[R2]
					B		loop

get_input:
					LDR		R1,=GPIOC_IDR
					LDR		R0,[R1]
					AND		R0,R0,#BTN_PIN
					BX		LR

GPIO_Init:
					//RCC->AHB1ENR  |=GPIOA_EN
					LDR 	R0,=RCC_AHB1ENR
					LDR  	R1,[R0]
					ORR		R1,#GPIOA_EN
					STR		R1,[R0]

					//GPIOA->MODER |=MODER5_OUT
					LDR		R0,=GPIOA_MODER
					LDR		R1,[R0]
					ORR		R1,#MODER5_OUT
					STR		R1,[R0]

					//Push button clock init
					//RCC->AHB1ENR |=GPIOC_EN

					LDR		R0,=RCC_AHB1ENR
					LDR		R1,[R0]
					ORR		R1,#GPIOC_EN
					STR		R1,[R0]

					BX		LR



					.align	//ALIGN
					.end 	//END





