// where is the led connected?
// Port: A
//Pin: 5
#include <stdint.h>
#define PERIPH_BASE 		(0x40000000UL)

#define AHB1PERIPH_OFSSET 	(0x00020000UL)
#define AHB1PERIPH_BASE  	(PERIPH_BASE + AHB1PERIPH_OFSSET)

#define GPIOA_OFSSET 		(0x0000UL)  // 0x0000 0000
#define GPIOA_BASE 			(AHB1PERIPH_BASE + GPIOA_OFSSET)

#define RCC_OFFSET 			(0x3800UL)
#define RCC_BASE			(AHB1PERIPH_BASE + RCC_OFFSET)
#define GPIOAEN 			(1U<<0)

#define PIN5 				(1U<<5)
#define LED_PIN    			PIN5

#define __IO volatile

typedef struct
{
	volatile uint32_t MODER; /* GPIO port mode register, Address offset: 0x00 */
	volatile uint32_t DUMMY[4];
	volatile uint32_t ODR; /* GPIO port output data register, Address offset: 0x14 */

} GPIO_TypeDef;

typedef struct
{
	volatile uint32_t DUMMY[12];
	volatile uint32_t AHB1ENR; /* RCC AHB1 peripheral clock register, Address offset: 0x30 */

} RCC_TypeDef;

#define RCC  		((RCC_TypeDef*) RCC_BASE)
#define GPIOA		((GPIO_TypeDef*) GPIOA_BASE)


int main(void)
{
	/*Enable clock access to GPIOA*/

	RCC->AHB1ENR |= GPIOAEN;
	/*Set PA5 as output pin*/

	GPIOA->MODER |= (1U<<10);
	GPIOA->MODER &=~(1U<<11);

	while(1)
	{

		GPIOA->ODR ^= LED_PIN;
		for(int i =0; i<100000; i++){}
	}
}


