// #include "uart0_int.h"

// void UART0_Init()
// {
//     UBRR0H = 0X00;
//     UBRR0L = 0XCF;          //  207을 16진수로 표현
//     UCSR0A |= (1 << U2X0);      // 2배속

//     UCSR0B |= (1 << RXEN0) | (1 << TXEN0);  // 폴링일때 세팅(Tx, Rx Enable)
    
//     // 수신 인터럽트 때문에 추가 한거임
//     UCSR0B |= (1 < RXCIE0);                 // 수신 인터럽트 Enable
// }

// void UART0_Transmit(unsigned char data)
// {
//     while ( !( UCSR0A & (1 << UDRE0)) );    // 송신 가능 대기, UDR이 비어 있는지?
//     UDR0 = data;
// }

// unsigned char UART0_Receive()
// {
//     while ( !(UCSR0A & (1 << RXC0)) );      // 데이터 수신 대기
//     return UDR0;
// }

// while ( !(UCSR0A & (1 << RXC0)) );      // 데이터 수신 대기
//     return UDR0;

#include "uart0_int.h"

// 출력 스트림 설정
FILE OUTPUT = FDEV_SETUP_STREAM(UART_Transmit, NULL, _FDEV_SETUP_WRITE);


char rxBuff[100] = {0};
volatile uint8_t rxFlag  = 0;

ISR(USART0_RX_vect)
{
    static uint8_t rxHead = 0;
    uint8_t rxData = UDR0;

    if(rxData == '\n' || rxData == '\r')
    {
        rxBuff[rxHead] = '\0';
        rxHead = 0;
        rxFlag = 1;
    }
    else
    {
        rxBuff[rxHead] = rxData;
        rxHead++;     
    }
}


void UART_Init()
{
    UBRR0H = 0x00;
    UBRR0L = 0xCF;

    UCSR0A |= (1<<U2X0);
    UCSR0B |= (1<<RXEN0) | (1<<TXEN0) | (1<<RXCIE0);

    //UCSR0B |= (1<<RXCIE0);
}

void UART_Transmit(char data)
{
    while(!(UCSR0A & (1<<UDRE0)));
    UDR0 = data;
}

// 포인터 타입 맞추기용
// int UART_Transmit_Char(char data, FILE *stream)
// {
//     while (!(UCSR0A & (1 << UDRE0)));
//     UDR0 = data;
//     return 0;
// }


unsigned char UART_Receive()
{
    while(!(UCSR0A & (1<<RXC0)));
    return UDR0;
}

