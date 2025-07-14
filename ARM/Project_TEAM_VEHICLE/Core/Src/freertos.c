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
#include "ultrasonic.h"
#include "tim.h"
#include "gpio.h"


/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

//extern UART_HandleTypeDef huart1; // 블루투스
//extern UART_HandleTypeDef huart2; // debug
//extern uint8_t distance;  // 초음파 센서

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

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
//extern UART_HandleTypeDef huart2;
extern uint8_t distance;
uint8_t rx_data;

uint16_t IC_Val1_C = 0, IC_Val2_C = 0;
uint16_t IC_Val1_L = 0, IC_Val2_L = 0;
uint16_t IC_Val1_R = 0, IC_Val2_R = 0;

uint8_t capture_flag_C = 0;
uint8_t capture_flag_L = 0;
uint8_t capture_flag_R = 0;

uint16_t echoTime_C, echoTime_L, echoTime_R;
uint8_t distance_center = 0;
uint8_t distance_left = 0;
uint8_t distance_right = 0;

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
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for Sonic_Center */
osThreadId_t Sonic_CenterHandle;
const osThreadAttr_t Sonic_Center_attributes = {
  .name = "Sonic_Center",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for DriveTask */
osThreadId_t DriveTaskHandle;
const osThreadAttr_t DriveTask_attributes = {
  .name = "DriveTask",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for Sonic_Left */
osThreadId_t Sonic_LeftHandle;
const osThreadAttr_t Sonic_Left_attributes = {
  .name = "Sonic_Left",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for Sonic_Right */
osThreadId_t Sonic_RightHandle;
const osThreadAttr_t Sonic_Right_attributes = {
  .name = "Sonic_Right",
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
  if(htim->Channel == HAL_TIM_ACTIVE_CHANNEL_1)
  {
    if(capture_flag_C == 0)  // 아직 캡처를 안했다면
    {
      IC_Val1_C = HAL_TIM_ReadCapturedValue(&htim2, TIM_CHANNEL_1);
      capture_flag_C = 1;    // 캡처 했음 !!!
      // 캡처에 대한 극성을 라이징에서 폴링으로 바꿈
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim2, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_FALLING);
    }
    else if(capture_flag_C == 1) // 캡처를 했다면
    {
      IC_Val2_C = HAL_TIM_ReadCapturedValue(&htim2, TIM_CHANNEL_1);
      __HAL_TIM_SET_COUNTER(&htim2, 0);

      if(IC_Val2_C > IC_Val1_C)
      {
        echoTime_C = IC_Val2_C - IC_Val1_C;
      }
      else if(IC_Val1_C > IC_Val2_C)
      {
        echoTime_C = (0xffff - IC_Val1_C) + IC_Val2_C;
      }
      distance_center = echoTime_C / 58;
      capture_flag_C = 0;
      __HAL_TIM_SET_CAPTUREPOLARITY(&htim2, TIM_CHANNEL_1, TIM_INPUTCHANNELPOLARITY_RISING);
      __HAL_TIM_DISABLE_IT(&htim2, TIM_IT_CC1);
    }
  }
}

/* USER CODE END FunctionPrototypes */

void L_MOTOR_TASK01(void *argument);
void R_MOTOR_TASK01(void *argument);
void Sonic_Center01(void *argument);
void DriveTask01(void *argument);
void Sonic_Left01(void *argument);
void Sonic_Right01(void *argument);

void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
  * @brief  FreeRTOS initialization
  * @param  None
  * @retval None
  */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */

  HAL_UART_Receive_IT(&huart1, &rx_data, sizeof(rx_data));
  HAL_UART_Receive_IT(&huart2, &rx_data, sizeof(rx_data));

  HAL_TIM_Base_Start(&htim11);

  HAL_TIM_IC_Start_IT(&htim2, TIM_CHANNEL_1);
  HAL_TIM_IC_Start_IT(&htim4, TIM_CHANNEL_1);
  HAL_TIM_IC_Start_IT(&htim4, TIM_CHANNEL_2);

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

  /* creation of Sonic_Center */
  Sonic_CenterHandle = osThreadNew(Sonic_Center01, NULL, &Sonic_Center_attributes);

  /* creation of DriveTask */
  DriveTaskHandle = osThreadNew(DriveTask01, NULL, &DriveTask_attributes);

  /* creation of Sonic_Left */
  Sonic_LeftHandle = osThreadNew(Sonic_Left01, NULL, &Sonic_Left_attributes);

  /* creation of Sonic_Right */
  Sonic_RightHandle = osThreadNew(Sonic_Right01, NULL, &Sonic_Right_attributes);

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

/* USER CODE BEGIN Header_Sonic_Center01 */
/**
* @brief Function implementing the Sonic_Center thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_Sonic_Center01 */
void Sonic_Center01(void *argument)
{
  /* USER CODE BEGIN Sonic_Center01 */
  /* Infinite loop */
  for(;;)
  {
    int aaa;
    aaa = 1;

//    HCSR04_TRIG_CENTER();
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    delay_us(10);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);

    __HAL_TIM_ENABLE_IT(&htim2, TIM_IT_CC1);
    aaa = 2;
    osDelay(100);
  }
  /* USER CODE END Sonic_Center01 */
}

/* USER CODE BEGIN Header_DriveTask01 */
/**
* @brief Function implementing the DriveTask thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_DriveTask01 */
void DriveTask01(void *argument)
{
  /* USER CODE BEGIN DriveTask01 */

//  printf("Center: %d cm, Left: %d cm, Right: %d cm\r\n", distance_center, distance_left, distance_right);

  /* Infinite loop */
  for(;;)
  {
    printf("Center: %d cm, Left: %d cm, Right: %d cm\r\n", distance_center, distance_left, distance_right);
    if (distance_center > 25)
    {
      L_Motor_Forward();
      R_Motor_Forward();
      Set_L_Motor_PWM(600);
      Set_R_Motor_PWM(600);
    }
    else
    {
      if (distance_left > distance_right)
      {
        // 왼쪽 넓으면 왼쪽 회전
        L_Motor_Backward();
        R_Motor_Forward();
      }
      else
      {
        // 오른쪽 넓으면 오른쪽 회전
        L_Motor_Forward();
        R_Motor_Backward();
      }
      Set_L_Motor_PWM(600);
      Set_R_Motor_PWM(600);
      osDelay(400);  // 회전 시간
    }
    osDelay(100);

  }
  /* USER CODE END DriveTask01 */
}

/* USER CODE BEGIN Header_Sonic_Left01 */
/**
* @brief Function implementing the Sonic_Left thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_Sonic_Left01 */
void Sonic_Left01(void *argument)
{
  /* USER CODE BEGIN Sonic_Left01 */


  /* Infinite loop */
  for(;;)
  {
//    HCSR04_TRIG_LEFT();
    osDelay(100);
  }
  /* USER CODE END Sonic_Left01 */
}

/* USER CODE BEGIN Header_Sonic_Right01 */
/**
* @brief Function implementing the Sonic_Right thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_Sonic_Right01 */
void Sonic_Right01(void *argument)
{
  /* USER CODE BEGIN Sonic_Right01 */


  /* Infinite loop */
  for(;;)
  {
//    HCSR04_TRIG_RIGHT();
    osDelay(100);
  }
  /* USER CODE END Sonic_Right01 */
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */

