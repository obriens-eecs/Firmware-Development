/*
 * uart.h
 *
 *  Created on: Sep. 21, 2021
 *      Author: sean_
 */

#ifndef UART_H_
#define UART_H_
#include <stdint.h>

#include "stm32f4xx.h"

void uart2_tx_init(void);
char uart2_read(void);
void uart2_rxtx_init(void);
void uart2_rxtx_interrupt_init(void);

#define SR_RXNE     (1U<<5)


#endif /* UART_H_ */
