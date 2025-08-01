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

// PA5 TRIG
#define TRIG_PORT GPIOA
#define TRIG_PIN GPIO_PIN_5

//// LEFT
//#define TRIG_PORT_L GPIOB
//#define TRIG_PIN_L GPIO_PIN_4
//
//// RIGHT
//#define TRIG_PORT_R GPIOB
//#define TRIG_PIN_R GPIO_PIN_5

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

volatile uint8_t bluetooth_rx_data = 0; // 블루투스
volatile uint8_t debug_rx_data = 0;     // 디버그 UART

volatile uint8_t currentState = 0; // 0: Manual, 1: Auto

volatile uint8_t safeDistance_C = 35;
volatile uint8_t safeDistance_L = 15;
volatile uint8_t safeDistance_R = 15;

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
/* Definitions for MOTOR_TASK */
osThreadId_t MOTOR_TASKHandle;
const osThreadAttr_t MOTOR_TASK_attributes = {
  .name = "MOTOR_TASK",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for Ultrasonic */
osThreadId_t UltrasonicHandle;
const osThreadAttr_t Ultrasonic_attributes = {
  .name = "Ultrasonic",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for MANUAL */
osThreadId_t MANUALHandle;
const osThreadAttr_t MANUAL_attributes = {
  .name = "MANUAL",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};
/* Definitions for AUTO */
osThreadId_t AUTOHandle;
const osThreadAttr_t AUTO_attributes = {
  .name = "AUTO",
  .stack_size = 128 * 4,
  .priority = (osPriority_t) osPriorityNormal,
};

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */

void MeasureSingleSensor(uint8_t sensor_channel)
{
    // 타이머 카운터 초기화는 HCSR04_TRIG에서 이미 수행됩니다.
    // __HAL_TIM_SET_COUNTER(&htim4, 0);

  if (sensor_channel == 1)
  { // Left
    __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC1);
  }
  else if (sensor_channel == 2)
  { // Right
    __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC2);
  }
  else if (sensor_channel == 3)
  { // Center
    __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC3);
  }

  // HCSR04_TRIG를 호출하여 모든 센서를 동시에 트리거
  // 하지만, 위에서 특정 센서의 ECHO 인터럽트만 활성화했으므로 해당 센서의 값만 캡처됩니다.
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_RESET);
  delay_us(2);
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_SET);
  delay_us(10);
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_RESET);

  // 에코 펄스 수신을 위해 충분히 대기
  // osDelay(30); // 이 함수를 호출하는 곳에서 딜레이를 제공할 예정
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
  if (huart->Instance == USART1) // 블루투스 (UART1)
  {

    HAL_UART_Receive_IT(&huart1, &bluetooth_rx_data, sizeof(bluetooth_rx_data));
  }
  else if (huart->Instance == USART2) // 디버그 (UART2)
  {


      HAL_UART_Receive_IT(&huart2, &debug_rx_data, sizeof(debug_rx_data));

      // printf("Received from debug: %c\r\n", debug_rx_cmd);
  }
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
//      __HAL_TIM_SET_COUNTER(&htim4, 0);

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
//      __HAL_TIM_SET_COUNTER(&htim4, 0);

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
//      __HAL_TIM_SET_COUNTER(&htim4, 0);

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
      printf("C2: %lu, Echo: %lu, Dist: %d\r\n", IC_Value2_C, echoTime_C, distance_C); // 디버깅용
    }
  }
}

void HCSR04_TRIG(void)
{
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_RESET);
  delay_us(2);
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_SET);
  delay_us(10);
  HAL_GPIO_WritePin(TRIG_PORT, TRIG_PIN, GPIO_PIN_RESET);

  __HAL_TIM_SET_COUNTER(&htim4, 0);

//  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC1);
//  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC2);
//  __HAL_TIM_ENABLE_IT(&htim4, TIM_IT_CC3);
}


/* USER CODE END FunctionPrototypes */

void MOTOR_TASK01(void *argument);
void Ultrasonic01(void *argument);
void MANUAL01(void *argument);
void AUTO01(void *argument);

void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
  * @brief  FreeRTOS initialization
  * @param  None
  * @retval None
  */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */

  HAL_UART_Receive_IT(&huart1, &bluetooth_rx_data, sizeof(bluetooth_rx_data)); // 블루투스
  HAL_UART_Receive_IT(&huart2, &debug_rx_data, sizeof(debug_rx_data));         // 디버그

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
  /* creation of MOTOR_TASK */
  MOTOR_TASKHandle = osThreadNew(MOTOR_TASK01, NULL, &MOTOR_TASK_attributes);

  /* creation of Ultrasonic */
  UltrasonicHandle = osThreadNew(Ultrasonic01, NULL, &Ultrasonic_attributes);

  /* creation of MANUAL */
  MANUALHandle = osThreadNew(MANUAL01, NULL, &MANUAL_attributes);

  /* creation of AUTO */
  AUTOHandle = osThreadNew(AUTO01, NULL, &AUTO_attributes);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

  /* USER CODE BEGIN RTOS_EVENTS */
  /* add events, ... */
  /* USER CODE END RTOS_EVENTS */

}

/* USER CODE BEGIN Header_MOTOR_TASK01 */
/**
  * @brief  Function implementing the MOTOR_TASK thread.
  * @param  argument: Not used
  * @retval None
  */
/* USER CODE END Header_MOTOR_TASK01 */
void MOTOR_TASK01(void *argument)
{
  /* USER CODE BEGIN MOTOR_TASK01 */
  /* Infinite loop */
  for(;;)
  {
    osDelay(1);
  }
  /* USER CODE END MOTOR_TASK01 */
}

/* USER CODE BEGIN Header_Ultrasonic01 */
/**
* @brief Function implementing the Ultrasonic thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_Ultrasonic01 */
void Ultrasonic01(void *argument)
{
  /* USER CODE BEGIN Ultrasonic01 */
  /* Infinite loop */
  for(;;)
  {
    // 각 센서를 순차적으로 트리거하고 측정
    MeasureSingleSensor(3); // 중앙 센서 측정
    osDelay(1);   // 에코 수신 대기 (딜레이 증가)
    MeasureSingleSensor(1); // 왼쪽 센서 측정
    osDelay(1);   // 에코 수신 대기 (딜레이 증가)
    MeasureSingleSensor(2); // 오른쪽 센서 측정
    osDelay(1);   // 에코 수신 대기 (딜레이 증가)

    // 모든 센서 측정 완료 후 거리 출력 (AUTO01에서도 출력하므로, 여기서 출력은 선택 사항)
    // printf("Ultrasonic01: C:%d cm, L:%d cm, R:%d cm \r\n", distance_C, distance_L, distance_R);

    // 전체 센서 측정 주기를 조절
    osDelay(200); // 다음 측정 사이의 충분한 딜레이 (이전 150ms보다 늘려서 안정성 추구)

//    HCSR04_TRIG();
//    printf("c: %d cm, l: %d cm, r: %d cm \r\n", distance_C, distance_L, distance_R);
//    osDelay(300);
  }
  /* USER CODE END Ultrasonic01 */
}

/* USER CODE BEGIN Header_MANUAL01 */
/**
* @brief Function implementing the MANUAL thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_MANUAL01 */
void MANUAL01(void *argument)
{
  /* USER CODE BEGIN MANUAL01 */
  /* Infinite loop */
  for(;;)
  {
    if (currentState == 0)
       {
         if (bluetooth_rx_data != 0)
         {
           switch (bluetooth_rx_data)
           {
             case 'F':
               forwardMoveNormal();
               break;
             case 'B':
               backwordMove();
               break;
             case 'L':
               leftMove();
               break;
             case 'R':
               rightMove();
               break;
             case 'X':
               stopMove();
//               printf("Mode: Manual (Stopped)\r\n");
               break;
             case 'S':
               stopMove();
               break;
             case 'Y':
               currentState = 1;
               stopMove(); // 모드 전환 시 정지
//               printf("Mode: Auto\r\n");
               break;
           }
           bluetooth_rx_data;
         }
       }
       osDelay(50);
  }
  /* USER CODE END MANUAL01 */
}

/* USER CODE BEGIN Header_AUTO01 */
/**
* @brief Function implementing the AUTO thread.
* @param argument: Not used
* @retval None
*/
/* USER CODE END Header_AUTO01 */
void AUTO01(void *argument)
{
  /* USER CODE BEGIN AUTO01 */
  /* Infinite loop */
  for(;;)
  {
    if (currentState == 1) // 현재 상태가 자율주행 모드일 때
       {
         // 디버깅을 위해 printf 활성화 추천!
//         printf("Auto Logic: C:%d cm, L:%d cm, R:%d cm \r\n", distance_C, distance_L, distance_R);

         // 1. 전방 장애물 감지 로직 시작 (중앙 센서의 safeDistance_C 사용)
         if (distance_C < safeDistance_C && distance_C != 0) // 중앙 센서 거리가 safeDistance_C보다 가깝고, 0이 아닐 때
         {
           stopMove();    // 일단 정지합니다.
           osDelay(300);  // 300ms 동안 정지.

           // **정지 후 센서 값 다시 측정 (중요!)**
           // 순차적으로 다시 측정하여 간섭을 줄이려 시도
           MeasureSingleSensor(3); osDelay(50); // 중앙 센서 다시 측정 (딜레이 증가)
           MeasureSingleSensor(1); osDelay(50); // 왼쪽 센서 다시 측정 (딜레이 증가)
           MeasureSingleSensor(2); osDelay(50); // 오른쪽 센서 다시 측정 (딜레이 증가)
//           printf("After Stop: C:%d cm, L:%d cm, R:%d cm \r\n", distance_C, distance_L, distance_R); // 재측정 값 확인

           // 2. 장애물 회피 로직 시작 (각 센서의 safeDistance_C, safeDistance_L, safeDistance_R 사용)
           // 모든 방향이 막혔을 때 로직을 가장 먼저 판단하여 후진 우선
           if (distance_C < safeDistance_C && distance_L < safeDistance_L && distance_R < safeDistance_R &&
               distance_C != 0 && distance_L != 0 && distance_R != 0)
           {
//             printf("All directions blocked. Backing up and retry.\r\n");
             backwordMove(); // 후진
             osDelay(1000);  // 1초 후진
             stopMove();     // 정지
             osDelay(300);   // 정지 후 안정화

             // 후진 후 다시 센서 측정하여 최신 상황 파악
             MeasureSingleSensor(3); osDelay(50);
             MeasureSingleSensor(1); osDelay(50);
             MeasureSingleSensor(2); osDelay(50);
//             printf("After Back: C:%d cm, L:%d cm, R:%d cm \r\n", distance_C, distance_L, distance_R);

             // 후진 후에도 여전히 막혀있다면, 덜 막힌 쪽으로 크게 회전 시도
             if (distance_L > distance_R) // 왼쪽이 더 멀면
             {
               leftMove();
               osDelay(1500); // 더 길게 회전 시도 (예: 1.5초)
             }
             else // 오른쪽이 더 멀거나 같으면
             {
               rightMove();
               osDelay(1500); // 더 길게 회전 시도
             }
             stopMove();     // 회전 후 정지
             osDelay(300);   // 회전 후 안정화 시간
           }
           // 전방은 막혔지만, 양옆 중 한 곳 이상이 뚫려있을 때
           else if (distance_L > safeDistance_L && distance_R > safeDistance_R) // 전방만 막히고 양쪽 모두 여유 있을 때
           {
//             printf("Obstacle Front. Both sides clear. Choosing turn direction.\r\n");
             if (distance_L > distance_R) // 왼쪽이 더 멀면
             {
               leftMove();
               osDelay(700);
             }
             else // 오른쪽이 더 멀거나 같으면
             {
               rightMove();
               osDelay(700);
             }
             stopMove();
             osDelay(200);
           }
           else if (distance_L > safeDistance_L) // 왼쪽만 여유 있을 때 (오른쪽이 막히고 왼쪽만 뚫려있음)
           {
//             printf("Obstacle Front/Right. Turning Left.\r\n");
             leftMove();
             osDelay(500);
             stopMove();
             osDelay(100);
           }
           else if (distance_R > safeDistance_R) // 오른쪽만 여유 있을 때 (왼쪽이 막히고 오른쪽만 뚫려있음)
           {
//             printf("Obstacle Front/Left. Turning Right.\r\n");
             rightMove();
             osDelay(500);
             stopMove();
             osDelay(100);
           }
           else // 이 조건에 도달했다면 모든 방향이 막힌 경우 (위의 "All directions blocked"에서 처리되지 않았다면)
           {
//               printf("Unclear obstacle situation. Backing up short.\r\n");
               backwordMove();
               osDelay(500); // 짧게 후진
               stopMove();
               osDelay(200);
           }
         }
         else // 전방에 장애물 없음 (distance_C >= safeDistance_C 또는 distance_C == 0)
         {
//           printf("Clear path. Moving Forward.\r\n");
           forwardMoveNormal(); // 앞으로 전진
         }

         // 모드 전환 명령 확인 (AUTO 모드 중)
         if (bluetooth_rx_data == 'X') // 'X' 명령이 수신되면 수동 모드로 전환
         {
           currentState = 0;
           stopMove(); // 모드 전환 시 정지
//           printf("Mode: Manual\r\n");
           bluetooth_rx_data = 0; // 명령 처리 후 변수 초기화
         }
       }
       osDelay(50); // 이 태스크는 50ms마다 한 번씩 실행되도록 CPU 시간을 양보합니다.
  }
  /* USER CODE END AUTO01 */
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */

