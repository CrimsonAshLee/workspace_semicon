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

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */

/* USER CODE END Variables */
/* Definitions for LED_TASK_1 */
osThreadId_t LED_TASK_1Handle;
const osThreadAttr_t LED_TASK_1_attributes = {
  .name = "LED_TASK_1",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for LED_TASK_2 */
osThreadId_t LED_TASK_2Handle;
const osThreadAttr_t LED_TASK_2_attributes = {
  .name = "LED_TASK_2",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */

/* USER CODE END FunctionPrototypes */

void LED_TASK_01(void *argument);
void LED_TASK_02(void *argument);

void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
  * @brief  FreeRTOS initialization
  * @param  None
  * @retval None
  */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */

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
  /* creation of LED_TASK_1 */
  LED_TASK_1Handle = osThreadNew(LED_TASK_01, NULL, &LED_TASK_1_attributes);

  /* creation of LED_TASK_2 */
  LED_TASK_2Handle = osThreadNew(LED_TASK_02, NULL, &LED_TASK_2_attributes);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

  /* USER CODE BEGIN RTOS_EVENTS */
  /* add events, ... */
  /* USER CODE END RTOS_EVENTS */

}

/* USER CODE BEGIN Header_LED_TASK_01 */
/**
  * @brief  Function implementing the LED_TASK_1 thread.
  * @param  argument: Not used
  * @retval None
  */
/* USER CODE END Header_LED_TASK_01 */
void LED_TASK_01(void *argument)
{
  /* USER CODE BEGIN LED_TASK_01 */
  /* Infinite loop */
  for(;;)  // oskenel 이후 125 ~ 162줄 무한 반복
  {
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);
    osDelay(500);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    osDelay(500);

    osDelay(1);
  }
  /* USER CODE END LED_TASK_01 */
}

/* USER CODE BEGIN Header_LED_TASK_02 */
/**
* @brief Function implementing the LED_TASK_2 thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_LED_TASK_02 */
void LED_TASK_02(void *argument)
{
  /* USER CODE BEGIN LED_TASK_02 */
  /* Infinite loop */
  for(;;)
  {
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_6, GPIO_PIN_SET);
    osDelay(1000);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_6, GPIO_PIN_RESET);
    osDelay(1000);

    osDelay(1);
  }
  /* USER CODE END LED_TASK_02 */
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */

