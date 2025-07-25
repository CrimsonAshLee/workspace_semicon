// #include <stdio.h>
// #include <avr/io.h>
// #include <util/delay.h>


// int main()
// {
//     DDRD = 0xff;

//     while (1)
//     {
//         PORTD = 0x00;
//         _delay_ms(500);
//         PORTD = 0xff;
//         _delay_ms(500);
//     }
 
// }

// #define LED_DDR     DDRD
// #define LED_PORT    PORTD

// int main()
// {
//     LED_DDR = 0xff;         // D포트를 출력으로 설정
//     //LED_DDR = 0b11111111;

//     while(1)
//     {
//         for(uint8_t i = 0; i < 8; i++)
//         {
//             LED_PORT = (1 << i);
//             _delay_ms(3000);
//         }
//     }
// }


// uint8_t ledArr[]= {
//     0x00,   // 00000000
//     0x80,   // 10000000
//     0xc0,   // 11000000
//     0xE0,   // 11100000
//     0xF0,   // 11110000
//     0xF8,   // 11111000
//     0xFC,   // 11111100
//     0xFE,   // 11111110
//     0xFF,   // 11111111
//     0x7F,   // 01111111
//     0X3F,   // 00111111
//     0x1F,   // 00011111
//     0x0F,   // 00001111
//     0x07,   // 00000111
//     0x03,   // 00000011
//     0x01    // 00000001    
// };

// int main()
// {
//     DDRD = 0xFF;
//     uint8_t arrSize = sizeof(ledArr)/sizeof(ledArr[0]);
//     while(1)
//     {
//         for(uint8_t i = 0; i < arrSize; i++)
//         {
//             PORTD = ledArr[i];
//             _delay_ms(200);
//         }
//     }
// }

// 위에것 배열 안쓰고 다시 짜보기

// #define LED_DDR     DDRD
// #define LED_PORT    PORTD

// int main()
// {
//     LED_DDR = 0xff;

//     while(1)
//     {
//         for(uint8_t i = 0; i < 8; i++)
//         {
//             LED_PORT |= (1 << i);
//             _delay_ms(500);
//         }
//         for(uint8_t j = 0; j < 8; j++)
//         {
//             LED_PORT = (1 >> j);
//             _delay_ms(500);
//         }
//     }

// }

// #define LED_DDR     DDRD
// #define LED_PORT    PORTD

// int main()
// {
//     LED_DDR = 0xff; // 출력 설정 = 0b11111111

//     while(1)
//     {
//         //LED를 왼쪽으로 이동하면서 켜고 끄기
//         for(uint8_t i = 0; i < 8; i++)
//         {
//             LED_PORT = ((0x01 << i) | (0x80 >> i));
//             _delay_ms(500);
//         }

//         // // LED를 오른쪽으로 이동하면서 켜고 끄기
//         // for(uint8_t i = 0; i < 8; i++)
//         // {
//         //     LED_PORT = ((0x80 >> i) | (0x10 << i));
//         //     _delay_ms(500);
//         // }

//         for(uint8_t i = 0; i < 4; i++)
//         {
//             LED_PORT = ((0x80 >> i) | (0x01 << i));
//             _delay_ms(500);
//         }
//     }
// }


// // 함수를 만들어서 켜봅시다

// #define LED_DDR     DDRD
// #define LED_PORT    PORTD

// // LED 출력 함수
// void GPIO_Output(uint8_t data)      // LED 포트에 8비트 데이터를 매개변수로 받음
// {
//     LED_PORT = data;        // 매개변수를 통해서 받은 데이터를 LED포트에 대입함
// }

// // LED 초기화 함수
// void ledInit()
// {
//     LED_DDR = 0xff; // 포트D의 모든핀을 출력으로 설정
// }

// // 이동 함수
// void ledShift(uint8_t i, uint8_t *data) //  포인터 선언
// {
//     *data = ( 1 << i) | (1 << (7-i));
// }

// int main()
// {
//     ledInit();

//     uint8_t ledData = 0x81;    // 0b 10000001

//     while(1)
//     {
//         for(uint8_t i = 0; i < 8; i++)
//         {
//             ledShift(i, &ledData);
//             GPIO_Output(ledData);
//             _delay_ms(400);
//         }
//         // GPIO_Output(0x00);
//         // _delay_ms(500);
//         // GPIO_Output(0xff);
//         // _delay_ms(500);
//     }
// }

//====
// 함수를 만들어서 켜봅시다

// #define LED_DDR     DDRD
// #define LED_PORT    PORTD

// // LED 출력 함수
// void GPIO_Output(uint8_t data)      // LED 포트에 8비트 데이터를 매개변수로 받음
// {
//     LED_PORT = data;        // 매개변수를 통해서 받은 데이터를 LED포트에 대입함
// }

// // LED 초기화 함수
// void ledInit()
// {
//     LED_DDR = 0xff; // 포트D의 모든핀을 출력으로 설정
// }

// // 이동 함수
// void ledShift(uint8_t i, uint8_t *data) //  포인터 선언
// {
//     *data = ( 1 << i) | (1 << (7-i));
// }

// #include "led.h"

// int main()
// {
//     ledInit();

//     uint8_t ledData = 0x81;    // 0b 10000001

//     while(1)
//     {
//         for(uint8_t i = 0; i < 8; i++)
//         {
//             ledShift(i, &ledData);
//             GPIO_Output(ledData);
//             _delay_ms(400);
//         }
//         // GPIO_Output(0x00);
//         // _delay_ms(500);
//         // GPIO_Output(0xff);
//         // _delay_ms(500);
//     }
// }

// int main()
// {
//     LED led;
//     led.port = &PORTD;
//     led.pinNumber = 0;

//     ledInit(&led);

//     while(1)
//     {
//         ledOn(&led);
//         _delay_ms(500);
//         ledOff(&led);
//         _delay_ms(500);
//     }
// }

// ex) 바로 위의 예제의 출력은 1번 led가 점등되는데 이것을 오른쪽으로 밀어보자

// int main()
// {
//     LED led;
//     led.port = &PORTD;
//     // led.pinNumber = 0;

//     ledInit(&led);

//     while(1)
//     {
//         //for(led.pinNumber = 0; led.pinNumber < 8; led.pinNumber ++)
//         //{
//            // ledInit(&led);
//             ledOn(&led);
//             _delay_ms(500);
//             ledOff(&led);
//             _delay_ms(500);
//         //}
    
//     }
// }

// int main()
// {
//     uint8_t fndNumber[] = {
//         0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x27, 0x7F, 0x67
//     };

//     //int count = 0;  // C언어에서는 4바이트이지만 펌웨어에서(여기)는 2바이트
//     uint16_t count = 0;
//     DDRA = 0xff;    // FND를 연결한 포트
    
//     while(1)
//     {
//         PORTA = fndNumber[count];
//         count = (count + 1) % 10;   // 몫이 아닌 나머지

//         _delay_ms(500);
//     }
// }

// FND 4개 짜리

// #define FND_DATA_DDR    DDRB    // 실질적인 데이터 포트
// #define FND_SELECT_DDR  DDRC    // 디지트 선택 포트
// #define FND_DATA_PORT   PORTB
// #define FND_SELECT_PORT PORTC

// void FND_Display(uint16_t data);    // 아래에 만든 함수의 원형 선언

// int main()
// {
//     FND_DATA_DDR = 0xFF;        // 데이터 포트 출력으로 설정        (PORTB : 0 ~ 7)
//     FND_SELECT_DDR = 0xff;      // 디지트 선택 포트 출력 설정       (PORTC : 0 ~ 3)
//     FND_SELECT_PORT = 0x00;     // 디지트 선택 포트 초기값 0 설정

//     uint16_t count = 0;         // 16bit(0~65535)
//     uint32_t timeTick = 0;      // 32bit (0 ~ 42억 언저리)
//     uint32_t prevTime = 0;

//     while(1)
//     {
//         FND_Display(count);
//         if(timeTick - prevTime >= 100)   // 100ms 가 지날 때 마다 count값을 1 증가
//         {
//             prevTime = timeTick;        // 현재 시간을 prevTime에 저장
//             count++;
//         }
//         _delay_ms(1);                   // 1밀리 대기
//         timeTick++;                     // timeTick를 1ms 증가 시킴
//     }
// }

// void FND_Display(uint16_t data)     // FND에 숫자를 표출하는 함수
// {
//     static uint8_t position = 0;    // 디지트 포지션
//     uint8_t fndData[10] = 
//     {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x27, 0x7F, 0x67};

//     switch (position)   // 조건식(판단식) ==> 정수값
//     {
//     case 0:
//         // 첫번째 자리의 FND데이터를 출력하기 위해 0번핀 LOW, 1, 2, 3번핀 HIGH
//         FND_SELECT_PORT &= ~(1 << 0);                       // 0번핀 LOW
//         FND_SELECT_PORT |= (1 << 1) | (1 << 2) | (1 << 3);  // 1, 2, 3번핀 HIGH
//         // 입력된 데이트의 천의 자리를 구해서 해당  FND데이터를 출력
//         FND_DATA_PORT = fndData[data/1000];
//         break;

//     case 1:
//         // 두번째 자리의 FND데이터를 출력하기 위해 1번핀 LOW, 0, 2, 3번핀 HIGH
//         FND_SELECT_PORT &= ~(1 << 1);                       // 1번핀 LOW
//         FND_SELECT_PORT |= (1 << 0) | (1 << 2) | (1 << 3);  // 0, 2, 3번핀 HIGH
//         // 입력된 데이트의 천의 자리를 구해서 해당  FND데이터를 출력
//         FND_DATA_PORT = fndData[(data/100)%10];
//         break;

//     case 2:
//         // 세번째 자리의 FND데이터를 출력하기 위해 2번핀 LOW, 0, 1, 3번핀 HIGH
//         FND_SELECT_PORT &= ~(1 << 2);                       // 2번핀 LOW
//         FND_SELECT_PORT |= (1 << 0) | (1 << 1) | (1 << 3);  // 0, 1, 3번핀 HIGH
//         // 입력된 데이트의 천의 자리를 구해서 해당  FND데이터를 출력
//         FND_DATA_PORT = fndData[(data/10)%10];
//         break;

//     case 3:
//         // 네번째 자리의 FND데이터를 출력하기 위해 3번핀 LOW, 0, 1, 2번핀 HIGH
//         FND_SELECT_PORT &= ~(1 << 3);                       // 3번핀 LOW
//         FND_SELECT_PORT |= (1 << 0) | (1 << 1) | (1 << 2);  // 0, 1, 2번핀 HIGH
//         // 입력된 데이트의 천의 자리를 구해서 해당  FND데이터를 출력
//         FND_DATA_PORT = fndData[data%10];
//         break;
//     }
//     position++;     // 다음 자리로 이동하기 위해서 position을 증가
//     position = position % 4;    // 4자리수 출력한 후에 다시 첫번째로 돌아가기 위해

    
// }

// ex) 버튼 1개로 누르면 불들어오고 떼면 꺼짐

// Button PORTG에 연결 2,3,4
// Pull-Up 저항 연결

// int main()
// {
//     DDRD = 0xff;        // LED Bar 연결된곳

//     DDRG &= ~(1 << 2);  // PORTG 2번 핀을 입력으로 설정

//     while(1)
//     {
//         if(PING & (1 << 2))
//         {
//             PORTD = 0x00;
//         }
//         else
//         {
//             PORTD = 0xff;
//         }
//     }

// }

// ex) 버튼 1번으로 켜고 3번으로 끄기
// int main()
// {
//     DDRD = 0xff;        // LED Bar 연결된곳

//     DDRG &= ~((1 << 2) | (1 << 3) | (1 << 4));  

//     uint8_t buttonData;

//     while(1)
//     {
//         buttonData = PING;
//         if((buttonData & (1 << 2)) == 0)
//         {
//             PORTD = 0xff;
//         }
//         if((buttonData & (1 << 3)) == 0)
//         {
//             //ledLeftShift();
//         }
//         if((buttonData & (1 << 4)) == 0)
//         {
//             PORTD = 0x00;
//         }
//     }

// }

//5월 30일
// Button PORTG 에 연결 2,3,4
// pull-up 저항 연결

// #include "../src/driver/led.h"
// #include "../src/driver/button.h"

// button.h 로
// #define LED_DDR         DDRD
// #define LED_PORT        PORTD
// #define BUTTON_DDR      DDRG
// #define BUTTON_PIN      PING
// #define BUTTON_ON       2
// #define BUTTON_OFF      3
// #define BUTTON_TOGGLE   4

// enum {PUSHED, RELEASED};    // 생긴건 배열이지만 변수(변수보단 define 개념에 가까움)를 정수값으로 대체해서 많이 씀. 
//                             //마우스 오버해보면 숫자가 몇인지 알게됨.
// enum {NO_ACT, ACT_PUSH, ACT_RELEASE};

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

// typedef struct _button
// {
//     volatile uint8_t    *ddr;       // 레지스터에 입력, 읽어온다든가 하는건 volatile을 붙여서 최적화 금지 //포인터 변수 선언
//     volatile uint8_t    *pin;       // pin 이라는 레지스터에서 값을 읽어옴
//     uint8_t             btnPin;     // bit
//     uint8_t             prevState;  // 
// }BUTTON;

// button.c 로
// void buttonInit(BUTTON *button, volatile uint8_t *ddr, volatile uint8_t *pin, uint8_t pinNumber)
// {
//     button->ddr = ddr;      // ddr 위치 다른거 잘 확인하기. 왼쪽인 구조체 안에있는 ddr
//     button->pin = pin;
//     button->btnPin = pinNumber;
//     button->prevState = RELEASED;   // 초기화 상태로 아무것도 안누른 상태
//     *button->ddr &= ~(1 << button->btnPin);   // 버튼 핀을 입력으로 설정
// }

// // BUTTON *button -->> ddr, pin 주소를 받기위해서
// uint8_t buttonGetState(BUTTON *button)
// {
//     uint8_t curState = *button->pin & (1<<button->btnPin);      // 버튼의 상태를 읽어옴

//     if((curState == PUSHED) && (button->prevState == RELEASED))     // 버튼을 안누른 상태에서 누르면 
//                                                                     // 1이었다가 누르면 0이됨 (pull-up저항)
//     {
//         _delay_ms(50);                  // debounce code
//         button->prevState = PUSHED;     // 버튼의 상태를 누름으로 변경
//         return ACT_PUSH;                // 버튼이 눌렸음을 반환
//     }
//     else if((curState != PUSHED) && (button->prevState == PUSHED))  // 버튼을 누른 상태에서 손을 떼면
//     {
//         _delay_ms(50);
//         button->prevState = RELEASED;   // 버튼 상태를 안누름으로 변경
//         return ACT_RELEASE;             // 버튼이 떨어졌음을 반환
//     }
//     return NO_ACT;                      // if와 else if 아무것도 안했을때
// }

// int main()
// {
    // LED_DDR = 0xff;
    
    // // 버튼 관련 변수 선언 (기능별 분류)
    // BUTTON btnOn;
    // BUTTON btnOff;
    // BUTTON btnToggle;

    // buttonInit(&btnOn, &BUTTON_DDR, &BUTTON_PIN, BUTTON_ON);        // 변수주소, DDR주소, PIN주소, 0번핀
    // buttonInit(&btnOff, &BUTTON_DDR, &BUTTON_PIN, BUTTON_OFF);
    // buttonInit(&btnToggle, &BUTTON_DDR, &BUTTON_PIN, BUTTON_TOGGLE);

    // while(1)
    // {
        
        // if(buttonGetState(&btnOn) == RELEASED)      // getstate는 현재 상태가 어떤지 물어보는것
        // {
        //     LED_PORT = 0xff;
        // }

        // if(buttonGetState(&btnOff) == RELEASED)
        // {
        //     LED_PORT = 0x00;
        // }

        // if(buttonGetState(&btnToggle) == RELEASED)
        // {
        //     LED_PORT ^= 0xff;
        // }
//     }
// }

#include "src/ap/ap.h"

int main()
{
    apInit();
    apMain();

    while(1)
    {

    }
}
