/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : freertos.c
  * Description        : Code for freertos applications
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2025 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "FreeRTOS.h"
#include "task.h"
#include "main.h"
#include "cmsis_os.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

#include "stdio.h"
#include "motor.h"
#include "usart.h"
#include "delay_us.h"
#include "tim.h"
#include "gpio.h"

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart2;

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

// CENTER
#define TRIG_PORT_C GPIOA
#define TRIG_PIN_C GPIO_PIN_5

// LEFT
#define TRIG_PORT_L GPIOB
#define TRIG_PIN_L GPIO_PIN_4

// RIGHT
#define TRIG_PORT_R GPIOB
#define TRIG_PIN_R GPIO_PIN_5

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

#ifdef __GNUC__
/* With GCC small printf (option LD Linker->Libraries->Small printf
 * set to 'Yes') calls __io_putchar() */
#define PUTCHAR_PROTOTYPE int  __io_putchar(int ch)
#else
#define PUTCHAR_PROTOTYPE int  fputc(int ch, FILE *f)
#endif /* __GNUC__*/

/** @brief Retargets the C library printf function to the USART.
 *  @param None
 *  @retval None
 */
PUTCHAR_PROTOTYPE
{
  /* Place your implementation of fputc here */
  /* e.g. write a character to the USART2 and Loop
     until the end of transmission */
  if(ch == '\n')
    HAL_UART_Transmit(&huart2, (uint8_t*) "\r", 1, 0xFFFF);
    HAL_UART_Transmit(&huart2, (uint8_t*) &ch, 1, 0xFFFF);
}

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */

extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart2;
uint8_t rx_data;

// 중앙
uint16_t IC_Value1_C = 0;
uint16_t IC_Value2_C = 0;
uint16_t echoTime_C = 0;
uint8_t captureFlag_C = 0;
uint8_t distance_C = 0;

// LEFT
uint16_t IC_Value1_L = 0;
uint16_t IC_Value2_L = 0;
uint16_t echoTime_L = 0;
uint8_t captureFlag_L = 0;
uint8_t distance_L = 0;

// RIGHT
uint16_t IC_Value1_R = 0;
uint16_t IC_Value2_R = 0;
uint16_t echoTime_R = 0;
uint8_t captureFlag_R = 0;
uint8_t distance_R = 0;

/* USER CODE END Variables */
/* Definitions for L_MOTOR_TASK */
osThreadId_t L_MOTOR_TASKHandle;
const osThreadAttr_t L_MOTOR_TASK_attributes = {
  .name = "L_MOTOR_TASK",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for R_MOTOR_TASK */
osThreadId_t R_MOTOR_TASKHandle;
const osThreadAttr_t R_MOTOR_TASK_attributes = {
  .name = "R_MOTOR_TASK",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityLow,
};
/* Definitions for CENTER_SONIC */
osThreadId_t CENTER_SONICHandle;
const osThreadAttr_t CENTER_SONIC_attributes = {
  .name = "CENTER_SONIC",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for LEFT_SONIC */
osThreadId_t LEFT_SONICHandle;
const osThreadAttr_t LEFT_SONIC_attributes = {
  .name = "LEFT_SONIC",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for RIGHT_SONIC */
osThreadId_t RIGHT_SONICHandle;
const osThreadAttr_t RIGHT_SONIC_attributes = {
  .name = "RIGHT_SONIC",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
//  if (huart->Instance == USART2)
//  {
  HAL_UART_Receive_IT(&huart2, &rx_data, sizeof(rx_data));  // 다음 수신 준비 // 디버그용
  HAL_UART_Receive_IT(&huart1, &rx_data, sizeof(rx_data));  // 블루투스
    switch (rx_data)
    {
      case 'F':
        L_Motor_Forward();
        R_Motor_Forward();
        Set_L_Motor_PWM(700);
        Set_R_Motor_PWM(700);
        break;
      case 'B':
        L_Motor_Backward();
        R_Motor_Backward();
        Set_L_Motor_PWM(700);
        Set_R_Motor_PWM(700);
        break;
      case 'L':
        L_Motor_Backward();
        R_Motor_Forward();
        Set_L_Motor_PWM(200);
        Set_R_Motor_PWM(600);
        break;
      case 'R':
        L_Motor_Forward();
        R_Motor_Backward();
        Set_L_Motor_PWM(600);
        Set_R_Motor_PWM(200);
        break;
      case 'X':
        L_Motor_Stop();
        R_Motor_Stop();
        break;
      case 'S':
        L_Motor_Stop();
        R_Motor_Stop();
        break;
    }


//  }
}

void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
{
  if(htim->Channel == HAL_TIM_ACTIVE_CHANNEL_2) // RIGHT
  {
    if(captureFlag_R == 0)  // 아직 캡처를 안했다면
    {
      IC_Value1_R = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_2);
      captureFlag_R = 1;    // 캡처 했음 !!!
      // 캡처에 대한 극성을 라이징에서 폴링으로 바꿈
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_2, TIM_INPUTCHANNELPOLARITY_FALLING);
    }
    else if(captureFlag_R == 1) // 캡처를 했다면
    {
      IC_Value2_R = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_2);
      __HAL_TIM_SET_COUNTER(&htim4, 0);

      if(IC_Value2_R > IC_Value1_R)
      {
        echoTime_R = IC_Value2_R - IC_Value1_R;
      }
      else if(IC_Value1_R > IC_Value2_R)
      {
        echoTime_R = (0xffff - IC_Value1_R) + IC_Value2_R;
      }
      distance_R = echoTime_R / 58;
      captureFlag_R = 0;
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_2, TIM_INPUTCHANNELPOLARITY_RISING);
      __HAL_TIM_DISABLE_IT(&htim4, TIM_IT_CC2);
    }
  }

  if(htim->Channel == HAL_TIM_ACTIVE_CHANNEL_1) // LEFT
  {
    if(captureFlag_L == 0)  // 아직 캡처를 안했다면
    {
      IC_Value1_L = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_1);
      captureFlag_L = 1;    // 캡처 했음 !!!
      // 캡처에 대한 극성을 라이징에서 폴링으로 바꿈
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_FALLING);
    }
    else if(captureFlag_L == 1) // 캡처를 했다면
    {
      IC_Value2_L = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_1);
      __HAL_TIM_SET_COUNTER(&htim4, 0);

      if(IC_Value2_L > IC_Value1_L)
      {
        echoTime_L = IC_Value2_L - IC_Value1_L;
      }
      else if(IC_Value1_L > IC_Value2_L)
      {
        echoTime_L = (0xffff - IC_Value1_L) + IC_Value2_L;
      }
      distance_L = echoTime_L / 58;
      captureFlag_L = 0;
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_RISING);
      __HAL_TIM_DISABLE_IT(&htim4, TIM_IT_CC1);
    }
  }

  if(htim->Channel == HAL_TIM_ACTIVE_CHANNEL_3) // CENTER
  {
    if(captureFlag_C == 0)  // 아직 캡처를 안했다면
    {
      IC_Value1_C = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_3);
      captureFlag_C = 1;    // 캡처 했음 !!!
      // 캡처에 대한 극성을 라이징에서 폴링으로 바꿈
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_3, TIM_INPUTCHANNELPOLARITY_FALLING);
    }
    else if(captureFlag_C == 1) // 캡처를 했다면
    {
      IC_Value2_C = HAL_TIM_ReadCapturedValue(&htim4, TIM_CHANNEL_3);
      __HAL_TIM_SET_COUNTER(&htim4, 0);

      if(IC_Value2_C > IC_Value1_C)
      {
        echoTime_C = IC_Value2_C - IC_Value1_C;
      }
      else if(IC_Value1_C > IC_Value2_C)
      {
        echoTime_C = (0xffff - IC_Value1_C) + IC_Value2_C;
      }
      distance_C = echoTime_C / 58;
      captureFlag_C = 0;
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim4, TIM_CHANNEL_3, TIM_INPUTCHANNELPOLARITY_RISING);
      __HAL_TIM_DISABLE_IT(&htim4, TIM_IT_CC3);
    }
  }
}

void HCSR04_TRIG_C(void)
{
  HAL_GPIO_WritePin(TRIG_PORT_C, TRIG_PIN_C, GPIO_PIN_RESET);
  delay_us(10);
  HAL_GPIO_WritePin(TRIG_PORT_C, TRIG_PIN_C, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC3);
}

void HCSR04_TRIG_L(void)
{
  HAL_GPIO_WritePin(TRIG_PORT_L, TRIG_PIN_L, GPIO_PIN_RESET);
  delay_us(10);
  HAL_GPIO_WritePin(TRIG_PORT_L, TRIG_PIN_L, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC1);
}

void HCSR04_TRIG_R(void)
{
  HAL_GPIO_WritePin(TRIG_PORT_R, TRIG_PIN_R, GPIO_PIN_RESET);
  delay_us(10);
  HAL_GPIO_WritePin(TRIG_PORT_R, TRIG_PIN_R, GPIO_PIN_SET);

  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC2);
}

/* USER CODE END FunctionPrototypes */

void L_MOTOR_TASK01(void *argument);
void R_MOTOR_TASK01(void *argument);
void CENTER_SONIC01(void *argument);
void LEFT_SONIC01(void *argument);
void RIGHT_SONIC01(void *argument);

void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
  * @brief  FreeRTOS initialization
  * @param  None
  * @retval None
  */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */

  HAL_UART_Receive_IT(&huart2, &rx_data, sizeof(rx_data));
  HAL_UART_Receive_IT(&huart1, &rx_data, sizeof(rx_data));

  /* USER CODE END Init */

  /* USER CODE BEGIN RTOS_MUTEX */
  /* add mutexes, ... */
  /* USER CODE END RTOS_MUTEX */

  /* USER CODE BEGIN RTOS_SEMAPHORES */
  /* add semaphores, ... */
  /* USER CODE END RTOS_SEMAPHORES */

  /* USER CODE BEGIN RTOS_TIMERS */
  /* start timers, add new ones, ... */
  /* USER CODE END RTOS_TIMERS */

  /* USER CODE BEGIN RTOS_QUEUES */
  /* add queues, ... */
  /* USER CODE END RTOS_QUEUES */

  /* Create the thread(s) */
  /* creation of L_MOTOR_TASK */
  L_MOTOR_TASKHandle = osThreadNew(L_MOTOR_TASK01, NULL, &L_MOTOR_TASK_attributes);

  /* creation of R_MOTOR_TASK */
  R_MOTOR_TASKHandle = osThreadNew(R_MOTOR_TASK01, NULL, &R_MOTOR_TASK_attributes);

  /* creation of CENTER_SONIC */
  CENTER_SONICHandle = osThreadNew(CENTER_SONIC01, NULL, &CENTER_SONIC_attributes);

  /* creation of LEFT_SONIC */
  LEFT_SONICHandle = osThreadNew(LEFT_SONIC01, NULL, &LEFT_SONIC_attributes);

  /* creation of RIGHT_SONIC */
  RIGHT_SONICHandle = osThreadNew(RIGHT_SONIC01, NULL, &RIGHT_SONIC_attributes);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

  /* USER CODE BEGIN RTOS_EVENTS */
  /* add events, ... */
  /* USER CODE END RTOS_EVENTS */

}

/* USER CODE BEGIN Header_L_MOTOR_TASK01 */
/**
  * @brief  Function implementing the L_MOTOR_TASK thread.
  * @param  argument: Not used
  * @retval None
  */
/* USER CODE END Header_L_MOTOR_TASK01 */
void L_MOTOR_TASK01(void *argument)
{
  /* USER CODE BEGIN L_MOTOR_TASK01 */

  HAL_TIM_PWM_Start(&htim3, TIM_CHANNEL_1); // 좌측 PWM 시작
//  HAL_UART_Receive_IT(&huart2, &rx_data, sizeof(rx_data));  // UART 수신 시작
  /* Infinite loop */
  for(;;)
  {
    osDelay(100);  // 아무것도 하지 않고 대기
  }
  /* USER CODE END L_MOTOR_TASK01 */
}

/* USER CODE BEGIN Header_R_MOTOR_TASK01 */
/**
* @brief Function implementing the R_MOTOR_TASK thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_R_MOTOR_TASK01 */
void R_MOTOR_TASK01(void *argument)
{
  /* USER CODE BEGIN R_MOTOR_TASK01 */
  HAL_TIM_PWM_Start(&htim3, TIM_CHANNEL_2); // 우측 PWM 시작
  /* Infinite loop */
  for(;;)
  {
    osDelay(100);  // 아무것도 하지 않고 대기
  }
  /* USER CODE END R_MOTOR_TASK01 */
}

/* USER CODE BEGIN Header_CENTER_SONIC01 */
/**
* @brief Function implementing the CENTER_SONIC thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_CENTER_SONIC01 */
void CENTER_SONIC01(void *argument)
{
  /* USER CODE BEGIN CENTER_SONIC01 */
  /* Infinite loop */
  for(;;)
  {
//    HCSR04_TRIG_C();
//    printf("C : %d cm\r\n",distance_C);
//    osDelay(500);
  }
  /* USER CODE END CENTER_SONIC01 */
}

/* USER CODE BEGIN Header_LEFT_SONIC01 */
/**
* @brief Function implementing the LEFT_SONIC thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_LEFT_SONIC01 */
void LEFT_SONIC01(void *argument)
{
  /* USER CODE BEGIN LEFT_SONIC01 */
  /* Infinite loop */
  for(;;)
  {
//    HCSR04_TRIG_L();
//    printf("L : %d cm\r\n",distance_L);
//    osDelay(500);
  }
  /* USER CODE END LEFT_SONIC01 */
}

/* USER CODE BEGIN Header_RIGHT_SONIC01 */
/**
* @brief Function implementing the RIGHT_SONIC thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_RIGHT_SONIC01 */
void RIGHT_SONIC01(void *argument)
{
  /* USER CODE BEGIN RIGHT_SONIC01 */
  /* Infinite loop */
  for(;;)
  {
    HCSR04_TRIG_R();
    printf("R : %d cm\r\n",distance_R);
    osDelay(500);
  }
  /* USER CODE END RIGHT_SONIC01 */
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */

