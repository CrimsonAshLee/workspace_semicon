/*
 * motor.c
 *
 *  Created on: Jul 3, 2025
 *      Author: user8
 */


#include "motor.h"

// 좌측 모터 방향제어 (IN = PB0, IN2 = PB1)
void L_Motor_Forward(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_0, GPIO_PIN_SET); // IN1
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET); // IN2
}

void L_Motor_Backward(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_0, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_SET);
}

// 우측 모터 방향제어 (IN = PB2. IN4 = PB10)
void R_Motor_Forward(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_2, GPIO_PIN_SET); // IN3
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_10, GPIO_PIN_RESET); // IN4
}

void R_Motor_Backward(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_2, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_10, GPIO_PIN_SET);
}

// 속도 제어 (PWM)
//void Set_L_Motor_Speed(uint8_t speed_percent)
//{
//  uint32_t pwm = (speed_percent * (__HAL_TIM_GET_AUTORELOAD(&htim3))) / 100;
//  __HAL_TIM_SET_COMPARE(&htim3, TIM_CHANNEL_1, pwm); // 좌 :ch1
//}
//
//void Set_R_Motor_Speed(uint8_t speed_percent)
//{
//  uint32_t pwm = (speed_percent * (__HAL_TIM_GET_AUTORELOAD(&htim3))) / 100;
//  __HAL_TIM_SET_COMPARE(&htim3, TIM_CHANNEL_2 , pwm); // 좌 :ch1
//}

void Set_L_Motor_PWM(uint32_t pwm_value)
{
  TIM3->CCR1 = pwm_value;
}

void Set_R_Motor_PWM(uint32_t pwm_value)
{
  TIM3->CCR2 = pwm_value;
}

void L_Motor_Stop(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_0, GPIO_PIN_RESET);  // IN1
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_1, GPIO_PIN_RESET);  // IN2
  Set_L_Motor_PWM(0);  // PWM도 0
}

void R_Motor_Stop(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_2, GPIO_PIN_RESET);  // IN3
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_10, GPIO_PIN_RESET); // IN4
  Set_R_Motor_PWM(0);
}















