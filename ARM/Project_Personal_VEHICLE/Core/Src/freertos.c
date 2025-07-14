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

#include "motor.h"
#include "usart.h"

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart2;

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */

extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart2;
uint8_t rx_data;

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

/* USER CODE END FunctionPrototypes */

void L_MOTOR_TASK01(void *argument);
void R_MOTOR_TASK01(void *argument);

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

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */

