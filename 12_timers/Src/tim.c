#include "stm32f4xx.h"


#define TIM2EN 			(1U<<0)
#define CR1_CEN			(1U<<0)


void tim2_1h_init(void)
{

	/*Enable clock access to tim2*/
	RCC->AHB1ENR |= TIM2EN;

	/*Set prescaler value*/
	TIM2->PSC = 1600 - 1; // 16 000 000 / 1 600 = 10 000

	/*Set auto-reload value*/
	TIM2->ARR = 10000;    // 10 000 / 10 000 = 1

	/*Clear counter*/
	TIM2->CNT = 0;

	/*Enable timer*/
	TIM2->CR1 = CR1_CEN;

}
