#include "ap.h"

// void apInit()
// {
//     //
// }

// void apMain()
// {
//     LED_DDR = 0xff;
    
//     // 버튼 관련 변수 선언 (기능별 분류)
//     BUTTON btnOn;
//     BUTTON btnOff;
//     BUTTON btnToggle;

//     buttonInit(&btnOn, &BUTTON_DDR, &BUTTON_PIN, BUTTON_ON);        // 변수주소, DDR주소, PIN주소, 0번핀
//     buttonInit(&btnOff, &BUTTON_DDR, &BUTTON_PIN, BUTTON_OFF);
//     buttonInit(&btnToggle, &BUTTON_DDR, &BUTTON_PIN, BUTTON_TOGGLE);

//     while(1)
//     {
//          if(buttonGetState(&btnOn) == RELEASED)      // getstate는 현재 상태가 어떤지 물어보는것
//         {
//             LED_PORT = 0xff;
//         }

//         if(buttonGetState(&btnOff) == RELEASED)
//         {
//             LED_PORT = 0x00;
//         }

//         if(buttonGetState(&btnToggle) == RELEASED)
//         {
//             LED_PORT ^= 0xff;
//         }
//     }
// }

// ISR(INT4_vect)
// {
//     ledOn
//     // PORTD = 0xff;
// }

// ISR(INT5_vect)
// {
//     PORTD = 0X00;
// }

// void apMain()
// {
//     ledInit();
//     // DDRD = 0xff;
    
//     sei();              // 전역 인터럽트 인에이블

//     // EICRB = 0x0E;       // INT4 하강엣지, INT5 상승엣지
//     EICRB |= (1 << ISC51) | (1 << ISC50) | (1 << ISC41);

//     // EIMSK = 0x30;       // INT4, INT5 Interrupt Enable
//     EIMSK |= (1 << INT5) | (1<<INT4);

    
    
//     DDRD = 0xff;        // D포트출력


//     while(1)
//     {

//     }
// }


// 6월 2일
// void apMain()
// {
//     DDRB = 0xff;        // PB4를 통해서 주파수를 출력해야 하니까
//     TCCR0 = 0x1D;       // 레지스터 세팅 (CTC 모드, 토글모드, 분주비 64)
//     TCCR0 |= (1 << WGM01) | (1 << COM00) | (1 << CS02);
    
//     OCR0 = 249;

//     while(1)
//     {
//         while((TIFR & 0x02) == 0)
//         {


//         };
//         TIFR = 0x02;
//         OCR0 = 249;

//     }
// }

// ISR(TIMER0_OVF_vect)
// (
//     LED_PORT ^= LED_PORT;
// )


// void apMain()
// {
//     DDRD = 0xff;        // 보기 위해서 D포트를 출력
//     PORTD = 0;
//     //TCCR0 = 0X05;
//     TCCR0 |= (1 << CS02) | (1 << CS00);
    
//     TCNT0 = 131;

//     while(1)
//     {
//         while((TIFR & 0x01) == 0)
//         {


//         };
//         PORTD = ~PORTD;
//         TCNT0 = 131;
//         TIFR = 0x01;   

//     }
// }

// void apMain()
// {
//     //DDRD = 0xff;        // B포트 전체 출력
//     DDRB |= (1 << PB4); // PB4 포트만 출력 설정

//     TCCR0 |= (1 << WGM00) | (1 << COM01) | (1 << WGM01) | (1 << CS02);
//     //  TCCR0 = 0x6C;
    
//     OCR0 = 32;

//     while(1)
//     {
//         // for(uint8_t i = 0; i <= 255; i++)
//         // {
//         // OCR0 = i;
//         // _delay_ms(10);
//         // }
//     }
// }

// void apMain()
// {
//     DDRB |= (1 << PB5)        // PB5 포트만 출력 설정

//     // 16bit past PWM 설정 64분주 50Hz
//     TCCR1A |= (1 << COM1A1) | (1 << WGM11);
//     TCCR1B |= (1 << WGM13) | (1 << WGM12) | (1 << CS11) | (1 << CS10);
    
//     ICR1 = 2439;        // TOP값 
//     //OCR1A = 2500;

//     while(1)
//     {
//       OCR1A = 110;          // -90 degree
//       _delay_ms(1000);
//       OCR1A = 500;
//       _delay_ms(1000);      // +90 degree
//     }
// }


// 6월 4일 fan project

// void apInit()
// {
// }

// #define BUTTON_PIN_STOP 0
// #define BUTTON_PIN_SLOW 1
// #define BUTTON_PIN_FAST 2
// #define BUTTON_PIN_SERVON 3
// #define BUTTON_PIN_SERVOFF 4

// void apMain()
// {
//     // 버튼 객체 선언
//     BUTTON btnFanStop;
//     BUTTON btnFanSlow;
//     BUTTON btnFanFast;
//     BUTTON btnServOn;
//     BUTTON btnServOff;

//     // FND에 표시할 숫자 패턴 배열
//     uint8_t fndNumber[] = {
//         0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x27, 0x7F, 0x67};

//     // 각 버튼 초기화 (주소, DDR, PIN, 핀번호)
//     buttonInit(&btnFanStop, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_STOP);
//     buttonInit(&btnFanSlow, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_SLOW);
//     buttonInit(&btnFanFast, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_FAST);
//     buttonInit(&btnServOn, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_SERVON);
//     buttonInit(&btnServOff, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_SERVOFF);

//     DDRD = 0xFF; // FND 포트 출력 설정
//     DDRA = 0xFF; // 숫자 표시 포트 출력 설정

//     // 팬(PWM) 출력 설정
//     DDRB |= (1 << PB4); // PB4 출력
//     // TCCR0 = 0x6C; // Fast PWM, Non-inverting, 분주비 256
//     // TCCR0 = 0b01101100;
//     TCCR0 |= (1 << WGM00) | (1 << COM01) | (1 << WGM01) | (1 << CS02);

//     DDRB |= (1 << PB5); // PB5 출력 (서보)
//     // 16비트 PWM(서보) 설정, 64분주, 50Hz
//     TCCR1A |= (1 << COM1A1) | (1 << WGM11);
//     TCCR1B |= (1 << WGM13) | (1 << WGM12) | (1 << CS11) | (1 << CS10);
//     ICR1 = 4999; // TOP 값 (20ms 주기)

//     // 서보 회전 상태 변수
//     // uint8_t sevo_state = 0;
//     // int sevo_count = 0;

//     uint8_t servoEnalbed = 0; // 서보모터 상태 변수
//     int servoPos = 105; // 서보모터 듀티값 초기값
//     int servoDiret = 5; // 서보모터 증감값 초기값

//     // OCR0 = 0;  // 팬 정지

//     while (1)
//     {
//         // 서보 동작 상태일 때 회전값 증가
//         // if (sevo_state == 1)
//         // {
//         //     if (sevo_count == 500)
//         //     {
//         //         sevo_count = 0;
//         //     }
//         //     OCR1A = sevo_count; // 서보 PWM 듀티 변경
//         //     sevo_count++;
//         //     _delay_ms(8);
//         // }

//         // 팬 정지 버튼
//         if (buttonGetState(&btnFanStop) == ACT_PUSH)
//         {
//             PORTD = 0x00; // FND off
//             _delay_ms(50);
//             PORTA = fndNumber[0]; // 숫자 0 표시
//             _delay_ms(50);
//             OCR1A = 0; // 서보 정지
//             OCR0 = 0;  // 팬 정지
//             _delay_ms(30);
//         }

//         // 팬 저속 버튼
//         if (buttonGetState(&btnFanSlow) == ACT_PUSH)
//         {
//             OCR0 = 180; // 팬 PWM 70%
//             _delay_ms(50);
//             PORTD = 0b10000000; // FND 표시
//             _delay_ms(50);
//             PORTA = fndNumber[1]; // 숫자 1 표시
//             _delay_ms(50);
//         }

//         // 팬 고속 버튼
//         if (buttonGetState(&btnFanFast) == ACT_PUSH)
//         {
//             PORTD = 0b11000000; // FND 표시
//             _delay_ms(50);
//             PORTA = fndNumber[2]; // 숫자 2 표시
//             _delay_ms(50);
//             OCR0 = 255; // 팬 PWM 100%
//             _delay_ms(50);
//         }

//         // 서보 동작 시작 버튼
//         if (buttonGetState(&btnServOn) == ACT_PUSH)
//         {
//             PORTD = 0b11100000; // FND 표시
//             _delay_ms(50);
//             PORTA = fndNumber[3]; // 숫자 3 표시
//             _delay_ms(50);

//             servoEnalbed = 1; // 서보 동작 시작
//         }

//         // 서보 동작 정지 버튼
//         if (buttonGetState(&btnServOff) == ACT_PUSH)
//         {
//             PORTD = 0b11110000; // FND 표시
//             _delay_ms(50);
//             PORTA = fndNumber[4]; // 숫자 4 표시
//             _delay_ms(50);

//             servoEnalbed = 0; // 서보 동작 정지

//             OCR1A = 0; // 서보 PWM 0
//             _delay_ms(10);
//         }

//         if (servoEnalbed == 1) {            // 서보모터 상태가 1(켜짐)이면
//             servoPos += servoDiret;         // 서보모터 듀티값을 증감값만큰 더해서 저장(초기값 370 + 5), 회전 시작

//             if(servoPos >= 635) {           // 현재 서보모터 각도가 -90도를 찍었거나 넘었으면
//                 servoPos = 635;             // -90도로 설정해 준 다음
//                 servoDiret = -5;            // 증감값 초기(+5)에서 -5로 변경
//             }
//             else if (servoPos < 105) {      // 현재 서보모터 각도가 +90도를 넘었으면
//                 servoPos = 105;             // +90도로 설정해 준 다음
//                 servoDiret = 5;             // 증감값을 +5로 변경
//             }

//             OCR1A = servoPos;               //위 연산값을 16비트 PWM OC레지스터에 듀티값에 넣고
//         }
//         _delay_ms(10);                      // 부드러운 연산(회전)을 위해 딜레이 걸어줌
//     }
// }

// #if 0
// void apMain()
// {

//     // sei();      // 전역 인터럽트 인에이블

//     // //EICRB = 0x0E;   // INT4 하강엣지 , INT5 상승엣지
//     // EICRB |= (1<<ISC51) | (1<<ISC50) | (1<<ISC41);
//     // //EIMSK = 0x30;   // INT4 , INT5 Interrupt Enable
//     // EIMSK |= (1<<INT5) | (1<<INT4);

//     // [DDRD = 0xff;    // d포트출력

//     // DDRD = 0xff; // PB4 를 통해서 주파수를 출력
//     // // TCCR0 = 0x1C;   // 레지스터 셋팅(CTC 모드 , 토글모드 , 분주비 64)
//     // PORTD = 0;
//     // TCCR0 |= (1 << COM00) | (1 << CS02);

//     // // OCR0 = 249;
//     // TCNT0 = 131;]
//     // DDRB |= (1 << PB5);

//     // 16bit past PWM 설정 64분주 50Hz
//     // TCCR1A |= (1 << COM1A1) | (1 << WGM11);
//     // TCCR1B |= (1 << WGM13) | (1 << WGM12) | (1 << CS11) | (1 << CS10);

//     // ICR1 = 999; // TOP 값
//     // OCR1A = 2500;
//      DDRB |= (1<<PB4);   // PB4포트만 출력
//     TCCR0 |= (1<<WGM00) | (1<<COM01) | (1<<CS02) | (1<<WGM01) ;
//     // TCCR0 =0x6C;

//     OCR0 = 200;

//     while (1)
//     {

//         BUTTON btnStop;
//         BUTTON btnTwo;
//         BUTTON btnThree;
//         BUTTON btnFour;
//         BUTTON btnFive;

//         uint8_t fndNumber[] = {
//             0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x27, 0x7F, 0x67};

//         buttonInit(&btnStop, &BUTTON_DDR, &BUTTON_PIN, BUTTON_STOP); // 변수주소, DDR주소, PIN주소, 0번핀
//         buttonInit(&btnTwo, &BUTTON_DDR, &BUTTON_PIN, BUTTON_TWO);
//         buttonInit(&btnThree, &BUTTON_DDR, &BUTTON_PIN, BUTTON_PIN_FAST);
//         buttonInit(&btnFour, &BUTTON_DDR, &BUTTON_PIN, BUTTON_FOUR);
//         buttonInit(&btnFive, &BUTTON_DDR, &BUTTON_PIN, BUTTON_FIVE);

//         DDRD = 0xFF; // fnd port
//         DDRA = 0xFF;

//         DDRB |= (1 << PB4); // PB4포트만 출력
//         TCCR0 |= (1 << WGM00) | (1 << COM01) | (1 << WGM01) | (1 << CS02);
//         OCR0 = 64; // 127, 200

//         while (1)
//         {
//             if (buttonGetState(&btnStop) == ACT_PUSH)
//             {
//                 // TODO:

//                 PORTD = 0b00000000;
//                 _delay_ms(50);
//                 // 1. 숫자 0으로 표기
//                 PORTA = fndNumber[0];
//                 _delay_ms(50);
//                 OCR1A = 0;
//                 OCR0 = 0;
//                 _delay_ms(30);

//                 //
//             }

//             if (buttonGetState(&btnTwo) == ACT_PUSH)
//             {
//                 PORTD = 0b11000000;
//                 _delay_ms(50);
//                 // 1. 숫자 1으로 표기
//                 PORTA = fndNumber[2];
//                 _delay_ms(50);
//                 // 강도 70%
//                 OCR0 = 65;
//                 _delay_ms(30);
//             }

//             if (buttonGetState(&btnThree) == ACT_PUSH)
//             {
//                 PORTD = 0b11100000;
//                 _delay_ms(50);
//                 // 1. 숫자 3으로 표기
//                 PORTA = fndNumber[3];
//                 _delay_ms(50);
//                 // 강도 100%
//             }

//             if (buttonGetState(&btnFour) == ACT_PUSH)
//             {
//                 PORTD = 0b11110000;
//                 _delay_ms(50);
//                 PORTA = fndNumber[4];
//                 _delay_ms(50);

//                 // 회전 반복문
//                 for (int i = 0; i < 500; i++)
//                 {

//                     for (int j = 0; j < 500; j++)
//                     {
//                         OCR1A = j;
//                         _delay_ms(10);
//                     }
//                     if (buttonGetState(&btnStop) == ACT_PUSH)
//                     {
//                         PORTD = 0b00000000;
//                         _delay_ms(50);
//                         // 1. 숫자 0으로 표기
//                         PORTA = fndNumber[0];
//                         OCR1A = 0;
//                     }
//                 }
//             }

//             if (buttonGetState(&btnFive) == ACT_PUSH)
//             {
//                 PORTD = 0b11111000;
//                 _delay_ms(50);
//                 PORTA = fndNumber[5];
//                 _delay_ms(50);
//             }
//         }
//     }
// }
// #endif
// ============================ 최종본 ============================

// void apInit()
// {

// }

// void apMain()
// {
//     LCD_Init();

//     // LCD_GotoXY(0,0);
//     // LCD_WriteString("Hello LCD");
//     // LCD_GotoXY(1,0);
//     // LCD_WriteString("Hello AVR");

//     char buff[30];
//     sprintf(buff, "Hello Atmega128A"); //""에 있는걸 buff에 집어넣음
//     LCD_WriteStringXY(0,0,buff);
//     uint16_t count = 0;

//     while (1)
//     {
//         sprintf(buff, "count : %d", count++);
//         LCD_WriteStringXY(1, 2, buff);
//         _delay_ms(100);
//     }
    
// }

// void apInit()
// {

// }

// void apMain()
// {
//     UART0_Init();

//     uint8_t rxDate; // 수신 데이터
    

//     while (1)
//     {
//        UART0_Transmit(UART0_Receive());
//     }
    
// }
//===
// void apInit()
// {

// }

// void apMain()
// {
//     extern FILE OUTPUT;
//     extern uint8_t rxFlag;
    
//     UART0_INT_Init();

//     uint8_t rxDate; // 수신 데이터
    

//     while (1)
//     {
//         if(rxFlag == 1)     // 문자열 수신이 완료된 경우
//     {
//         rxFlag = 0;

//     }
//     }
    
// }

//==

#include "ap.h"



void apInit()
{

}

void apMain()
{

    stdout = &OUTPUT;
    
    UART_Init();   
    sei();

    while (1)
    {
        if(rxFlag == 1)
        {
            rxFlag = 0;             
            printf(rxBuff);
        }
    }        
}