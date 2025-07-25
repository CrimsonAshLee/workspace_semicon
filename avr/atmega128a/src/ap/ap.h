// #ifndef __AP_H__
// #define __AP_H__

// #include "../driver/led.h"
// #include "../driver/button.h"
// #include "../driver/lcd.h"
// // #include "../driver/uart0.h"     // 폴링방식 UART 헤더
// #include "../driver/uart0_int.h"    // 인터럽트 UART 헤더

// // 출력 스트림 설정 (stdio.h에 있음)
// FILE OUTPUT = FDEV_SETUP_STREAM(UART0_Transmit, NULL, _FDEV_SETUP_WRITE);

// char rxBuff[100] = {0}; // 수신버퍼
// uint8_t rxFlag = 0;     // 수신완료 플래그

// ISR(USART0_TX_vect)     // 수신 인터럽트 핸들러
// {
//     static uint8_t rxHead = 0;          // 수신된 데이터의 인덱스
//     uint8_t rxData = UDR0;              // 수신된 데이터
//     if(rxData == '\n' || rxData == '\r')    // 만약 수신 데이터가 개행이나 리턴이면
//     {
//         rxBuff[rxHead] = '\0';          // 수신된 문자열 마지막에 널문자 추가
//         rxHead = 0;                     // 인덱스 초기화
//         rxFlag = 1;                     // 문자열 수신 플래그 설정
//     }
//     else                                // 아니면 계속 받음
//     {
//         rxBuff[rxHead] = rxData;        // 버퍼에 수신된 데이터 추가
//         rxHead++;                       // 인덱스 증가
//     }
// }

// void apInit();
// void apMain();


// #endif /* __AP_H__ */

//======

#ifndef __AP_H__
#define __AP_H__


#include "../driver/led.h"
#include "../driver/button.h"
#include "../driver/lcd.h"
//#include "../driver/uart0.h"      // 폴링방식 UART 헤더
#include "../driver/uart0_int.h"    // 인터럽트 UART 헤더



void apInit();
void apMain();



#endif /* __AP_H__ */