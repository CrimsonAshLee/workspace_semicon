#ifndef __BUTTON_H__            // guard로 불러옴
#define __BUTTON_H__

#include "../common/def.h"

// #include <avr/io.h>
// #include <stdint.h>
// #include <stdio.h>
// #include <util/delay.h>     // 4~7줄 led.c에서 가져옴

#define LED_DDR         DDRD
#define LED_PORT        PORTD
#define BUTTON_DDR      DDRG
#define BUTTON_PIN      PING
#define BUTTON_ON       2
#define BUTTON_OFF      3
#define BUTTON_TOGGLE   4

enum {PUSHED, RELEASED};    // 생긴건 배열이지만 변수(변수보단 define 개념에 가까움)를 정수값으로 대체해서 많이 씀. 
                            //마우스 오버해보면 숫자가 몇인지 알게됨.
enum {NO_ACT, ACT_PUSH, ACT_RELEASE};

// enum
// {
//     Monday,             // 시작번호를 부여하면 다음 숫자는 정수 하나씩 증가함
//     Tuesday,
//     Wendsday,
//     Thursday,
//     Friday,
//     Saturday,
//     Sundady
// };

typedef struct _button
{
    volatile uint8_t    *ddr;       // 레지스터에 입력, 읽어온다든가 하는건 volatile을 붙여서 최적화 금지 //포인터 변수 선언
    volatile uint8_t    *pin;       // pin 이라는 레지스터에서 값을 읽어옴
    uint8_t             btnPin;     // bit
    uint8_t             prevState;  // 
}BUTTON;

void buttonInit(BUTTON *button, volatile uint8_t *ddr, volatile uint8_t *pin, uint8_t pinNumber); // 함수의 원형 선언;
uint8_t buttonGetState(BUTTON *button);

#endif /* __BUTTON_H__ */