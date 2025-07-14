/*
 * led.c
 *
 *  Created on: Jun 12, 2025
 *      Author: user8
 */

#include "led.h"


LED_CONTROL led[8]=
    {
        {GPIOC, GPIO_PIN_9, 1, 0},
        {GPIOB, GPIO_PIN_8, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOB, GPIO_PIN_9, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOA, GPIO_PIN_5, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOA, GPIO_PIN_6, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOA, GPIO_PIN_7, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOB, GPIO_PIN_6, GPIO_PIN_SET, GPIO_PIN_RESET},
        {GPIOC, GPIO_PIN_7, GPIO_PIN_SET, GPIO_PIN_RESET}
    };

void ledOn(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
  {
    HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
  }
}

void ledOff(uint8_t num)
{
  for(uint8_t i = 0; i < num; i++)
    {
      HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    }
}

void ledToggle(uint8_t num)
{

}


void ledLeftshift(uint8_t num)
{
    for(uint8_t i = 0; i < num; i++)
    {
        HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].onState);
        HAL_Delay(100);
        HAL_GPIO_WritePin(led[i].port, led[i].pinNumber, led[i].offState);
    }
}


void ledRightshift(uint8_t num)
{
    for(uint8_t i = num; i > 0; i--)
    {
        HAL_GPIO_WritePin(led[i-1].port, led[i-1].pinNumber, led[i-1].onState);
        HAL_Delay(100);
        HAL_GPIO_WritePin(led[i-1].port, led[i-1].pinNumber, led[i-1].offState);
    }
}

void ledFlower(uint8_t)
{

}
