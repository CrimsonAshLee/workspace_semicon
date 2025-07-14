/*
 * motor.h
 *
 *  Created on: Jul 3, 2025
 *      Author: user8
 */

#ifndef INC_MOTOR_H_
#define INC_MOTOR_H_

#include "main.h"
#include "tim.h"

// 방향 제어
void L_Motor_Forward(void);
void L_Motor_Backward(void);
void R_Motor_Forward(void);
void R_Motor_Backward(void);

// 속도 제어
//void Set_L_Motor_Speed(uint8_t speed);
//void Set_R_Motor_Speed(uint8_t speed);
void Set_L_Motor_PWM(uint32_t pwm_value);
void Set_R_Motor_PWM(uint32_t pwm_value);

// 정지
void L_Motor_Stop(void);
void R_Motor_Stop(void);

#endif /* INC_MOTOR_H_ */
