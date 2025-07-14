/*
 * led.h
 *
 *  Created on: Jun 12, 2025
 *      Author: user8
 */

#ifndef INC_LED_H_
#define INC_LED_H_

#include "main.h"

typedef struct
{
  GPIO_TypeDef  *port;
  uint16_t      pinNumber;
  GPIO_PinState onState;
  GPIO_PinState offState;
}LED_CONTROL;

void ledOn(uint8_t num);
void ledOff(uint8_t num);
void ledToggle(uint8_t num);


void ledLeftshift(uint8_t);
void ledRightshift(uint8_t);
void ledFlower(uint8_t);

#endif /* INC_LED_H_ */
