#ifndef UART0_H
#define UART0_H

#include "../common/def.h"

void UART0_Init();
void UART0_Transmit(unsigned char data);
unsigned char UART0_Receive();

#endif /* UART0_H */