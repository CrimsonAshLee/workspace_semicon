/*
 * ultrasonic.c
 *
 *  Created on: Jul 6, 2025
 *      Author: user8
 */

#include "ultrasonic.h"

//uint16_t IC_Val1_C = 0, IC_Val2_C = 0;
//uint16_t IC_Val1_L = 0, IC_Val2_L = 0;
//uint16_t IC_Val1_R = 0, IC_Val2_R = 0;
//
//uint8_t capture_flag_C = 0;
//uint8_t capture_flag_L = 0;
//uint8_t capture_flag_R = 0;
//
//uint16_t echoTime_C, echoTime_L, echoTime_R;
//uint8_t distance_center = 0;
//uint8_t distance_left = 0;
//uint8_t distance_right = 0;


void HCSR04_TRIG_CENTER(void)
{
  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
//  delay_us(10);
  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim2, TIM_IT_CC1);
}

void HCSR04_TRIG_LEFT(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_4, GPIO_PIN_RESET);
  delay_us(10);
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_4, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC1);
}

void HCSR04_TRIG_RIGHT(void)
{
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_5, GPIO_PIN_RESET);
  delay_us(10);
  HAL_GPIO_WritePin(GPIOB, GPIO_PIN_5, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC2);
}


//void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
//{
//
//  // CENTER
//  if (htim->Instance == TIM2 && htim->Channel == HAL_TIM_ACTIVE_CHANNEL_1)
//  {
//    if (capture_flag_C == 0)
//    {
//      IC_Val1_C = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_1);
//      capture_flag_C = 1;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_FALLING);
//    }
//    else
//    {
//      IC_Val2_C = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_1);
//      __HAL_TIM_SET_COUNTER(htim, 0);
//      echoTime_C = (IC_Val2_C > IC_Val1_C) ? (IC_Val2_C - IC_Val1_C) : ((0xFFFF - IC_Val1_C) + IC_Val2_C);
//      distance_center = echoTime_C / 58;
//      capture_flag_C = 0;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_RISING);
//      __HAL_TIM_DISABLE_IT(htim, TIM_IT_CC1);
//    }
//  }
//
//  // LEFT
//  else if (htim->Instance == TIM4 && htim->Channel == HAL_TIM_ACTIVE_CHANNEL_1)
//  {
//    if (capture_flag_L == 0)
//    {
//      IC_Val1_L = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_1);
//      capture_flag_L = 1;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_FALLING);
//    }
//    else
//    {
//      IC_Val2_L = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_1);
//      __HAL_TIM_SET_COUNTER(htim, 0);
//      echoTime_L = (IC_Val2_L > IC_Val1_L) ? (IC_Val2_L - IC_Val1_L) : ((0xFFFF - IC_Val1_L) + IC_Val2_L);
//      distance_left = echoTime_L / 58;
//      capture_flag_L = 0;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_RISING);
//      __HAL_TIM_DISABLE_IT(htim, TIM_IT_CC1);
//    }
//  }
//
//  // RIGHT
//  else if (htim->Instance == TIM4 && htim->Channel == HAL_TIM_ACTIVE_CHANNEL_2)
//  {
//    if (capture_flag_R == 0)
//    {
//      IC_Val1_R = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_2);
//      capture_flag_R = 1;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_2, TIM_INPUTCHANNELPOLARITY_FALLING);
//    }
//    else
//    {
//      IC_Val2_R = HAL_TIM_ReadCapturedValue(htim, TIM_CHANNEL_2);
//      __HAL_TIM_SET_COUNTER(htim, 0);
//      echoTime_R = (IC_Val2_R > IC_Val1_R) ? (IC_Val2_R - IC_Val1_R) : ((0xFFFF - IC_Val1_R) + IC_Val2_R);
//      distance_right = echoTime_R / 58;
//      capture_flag_R = 0;
//      __HAL_TIM_SET_CAPTUREPOLARITY(htim, TIM_CHANNEL_2, TIM_INPUTCHANNELPOLARITY_RISING);
//      __HAL_TIM_DISABLE_IT(htim, TIM_IT_CC2);
//    }
//  }
//}
