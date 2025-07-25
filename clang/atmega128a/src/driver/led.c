// 함수에 대한 정의는 led.c 파일에 저장
#include "led.h"



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
//     *data = ( 1 << i) | (1 << (7-i)); //주소안에 우항의 값을 대입
// }

// void ledInit(LED *led)      // 매개변수로 포인터 변수 선언
// {
//     // LED_DDR = 0xff;

//     *(led->port - 1) |= 0xff;
    // *(led->port - 1) |= (1 << led->pinNumber);            // port는 주소
    // DDR 레지스터는 PORT 레지스터보다 1 낮게 위치하므로 (Resister summary 참조)
    // *(led->port - 1) 을 이용해서 PORT에서 DDR로 접근
    // | = (1 << led->pinNumber)를 OR연산을 통해서
    // led->pinNumber로 지정된 포트를 출력으로 설정!!!
// }
// void ledOn(LED *led)
// {
//     // 해당 핀 (내가 원하는 자리!!) HIGH로 설정해서 LED ON
//     *(led->port) |= (1 << led->pinNumber);
// }

void ledInit()
{
   // LED_DDR = 0xff;
}

void ledOn()
{
    PORTD = 0xff;
}

void ledOff(LED *led)
{
    // 해당 핀 (내가 원하는 자리!!) LOW로 설정해서 LED OFF
    *(led->port) &= ~(1 << led->pinNumber);
}