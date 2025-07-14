/*
 * ultrasonic.h
 *
 *  Created on: Jul 6, 2025
 *      Author: user8
 */


#ifndef INC_ULTRASONIC_H_
#define INC_ULTRASONIC_H_

#include "main.h"
#include "tim.h"
#include "gpio.h"
#include "delay_us.h"

//extern uint8_t distance; // 초음파 1개 일때
extern uint8_t distance_center;
extern uint8_t distance_left;
extern uint8_t distance_right;

////void HCSR04_TRIG(void); // 초음파 1개 일때
//// TRIG 함수 (센서 각각)
void HCSR04_TRIG_CENTER(void);
void HCSR04_TRIG_LEFT(void);
void HCSR04_TRIG_RIGHT(void);

//void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim);

#endif
