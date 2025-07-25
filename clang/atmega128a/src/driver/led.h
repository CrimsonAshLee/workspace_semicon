// #ifndef __LED_H__
// #define __LED_H__

// #include <avr/io.h>
// #include <stdint.h>

// #include <stdio.h>
// //#include <avr/io.h>
// #include <util/delay.h>

// #include "../common/def.h"


// // 포트에 대한 설정(방향-출력)
// //#define LED_DDR     DDRD
// //#define LED_PORT    PORTD

// // // 함수 원형 선언
// // void GPIO_Output(uint8_t data); 
// // void ledInit();
// // void ledShift(uint8_t i, uint8_t *data);

// typedef struct
// {
//     volatile uint8_t    *port; // 포인터는 선언되면 주소만 가질수있다
//     uint8_t             pinNumber;
// }LED;

// void ledInit(LED *led); //함수 선언
// void ledOn(LED *led);
// void ledOff(LED *led);

// void ledLeftShift();
// void ledRightShift();
// void ledFlower();
// void ledOdd();
// void ledEven();

// #endif /* __LED_H__ */


#ifndef __LED_H__
#define __LED_H__

#include "../common/def.h"

typedef struct
{
    volatile uint8_t    *port; // 포인터는 선언되면 주소만 가질수있다
    uint8_t             pinNumber;
}LED;

// void ledInit(LED *led); //함수 선언
void ledInit();
// void ledOn(LED *led);
void ledOn();
void ledOff(LED *led);

void ledLeftShift();
void ledRightShift();
void ledFlower();
void ledOdd();
void ledEven();

#endif /* __LED_H__ */