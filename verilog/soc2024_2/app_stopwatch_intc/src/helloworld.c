/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xintc.h"
#include "xuartlite.h"
#include "xil_exception.h"      // 예외처리
#include "xiic.h"
#include "sleep.h"


#define UART_ADDR XPAR_AXI_UARTLITE_0_BASEADDR
#define BTN_ADDR XPAR_AXI_GPIO_0_BASEADDR
#define INTC_ADDR XPAR_XINTC_0_BASEADDR
#define IIC_ADDR XPAR_AXI_IIC_0_BASEADDR
#define STOPWATCH_ADDR XPAR_MYIP_STOP_WATCH_0_BASEADDR

#define UART_VEC_ID XPAR_FABRIC_AXI_UARTLITE_0_INTR
#define BTN_VECT_ID XPAR_FABRIC_AXI_GPIO_0_INTR

#define BTN_CHANNEL 1

XGpio btn_instance;
XIntc intc_instance;
XUartLite uart_instance;
XIic iic_instance;
volatile unsigned int *stopwatch_instance = (volatile unsigned int*)STOPWATCH_ADDR;
// 이것으로 인해 while문 안에서 flag가 필요없어짐

unsigned int btn_value;
char lap_flag = 0;
char clear_flag = 0;

void btn_isr(void *CallBackRef);    // 내가 호출하는게 아니라 시스템이 호출하는것임
void RecvHandler(void *CallBackRef, unsigned int EventData);
void SendHandler(void *CallBackRef, unsigned int EventData);
void lcdCommand(uint8_t command);
void lcdData(uint8_t data);
void i2cLcd_Init();
void lcdString(char *str);
void moveCursor(uint8_t row, uint8_t col);
void Display_clear();
int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    XUartLite_Initialize(&uart_instance, UART_ADDR) ;
    XGpio_Initialize(&btn_instance, BTN_ADDR);
    XIntc_Initialize(&intc_instance, INTC_ADDR);

    XGpio_SetDataDirection(&btn_instance, BTN_CHANNEL,0b1111);
    XIntc_Connect(&intc_instance, UART_VEC_ID, 
        (XInterruptHandler)XUartLite_InterruptHandler, // 함수는 있는데 내용이 없는 빈껍데기라서 만들어줘야함
        (void *)&uart_instance);
    XIntc_Connect(&intc_instance, BTN_VECT_ID, 
        (XInterruptHandler)btn_isr, 
        (void *)&btn_instance);

    XIntc_Enable(&intc_instance, UART_VEC_ID);
    XIntc_Enable(&intc_instance, BTN_VECT_ID);
    XIntc_Start(&intc_instance, XIN_REAL_MODE); // AVR에서의 SEI 복습

    XGpio_InterruptEnable(&btn_instance, BTN_CHANNEL);  // 둘중에 어떤거 쓸꺼냐?
    XGpio_InterruptGlobalEnable(&btn_instance);

    XUartLite_SetRecvHandler(&uart_instance, 
        RecvHandler, &uart_instance);  // RecvHandler 함수 이름이 주소다.
    XUartLite_SetSendHandler(&uart_instance, 
        SendHandler, &uart_instance);  // SendHandler 함수 이름이 주소다.
    XUartLite_EnableInterrupt(&uart_instance);
    
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, 
            (Xil_ExceptionHandler)XIntc_InterruptHandler, 
            &intc_instance);
    Xil_ExceptionEnable();

    XIic_Initialize(&iic_instance, IIC_ADDR);

    // volatile unsigned int *stopwatch_instance = (volatile unsigned int*)STOPWATCH_ADDR;
    // 전역변수로 변경

    i2cLcd_Init();
    lcdString("    00:00:00");
    // uint8_t btn_value;   // 전역변수로 받은게 있어서 얘는 빼줌
    // uint8_t btn_flag = 0;   // 눌렀을때 한번만 토글되게 하려고 사용함, 변수 자체가 필요없어짐(isr)
    while (1) {
        // if (btn_value == 0) { 필요없어질 문장(isr)
        //     btn_flag = 0;
        // }
        // else if (btn_value == 0b0001 && btn_flag == 0) {    // 이 if문은 isr안에 들어있어도됨
        //     btn_flag = 1;
        //     stopwatch_instance[0] = stopwatch_instance[0] ^ 0b0001;   // 1번 버튼과 토글
        // }
        // else if (btn_value == 0b0010 && btn_flag == 0) { // 왼쪽버튼 : lap, 이 문장도 isr로 이동
        //     btn_flag = 1;
        //     stopwatch_instance[0] = stopwatch_instance[0] | 0b0010;
        //     usleep(1);
        //     stopwatch_instance[0] = stopwatch_instance[0] & 0b1101;
        //     moveCursor(1, 4);
        //     // if (lap_cnt == 0) {
        //     //     moveCursor(1, 0);
        //     //     lcdString("I ");
        //     //     lap_cnt = 1;
        //     // }
        //     // else if (lap_cnt == 1) {
        //     //     moveCursor(1, 8);
        //     //     lcdString("II ");
        //     //     lap_cnt = 0;
        //     // }
        //     lcdData(stopwatch_instance[4]/10%10 + '0');
        //     lcdData(stopwatch_instance[4]%10 + '0');
        //     lcdData(':');
        //     lcdData(stopwatch_instance[5]/10%10 + '0');
        //     lcdData(stopwatch_instance[5]%10 + '0');
        //     lcdData(':');
        //     lcdData(stopwatch_instance[6]/10%10 + '0');
        //     lcdData(stopwatch_instance[6]%10 + '0');
        //     msleep(1);
        // }
        // // 오른쪽 버튼 입력이 들어오면 clear
        // else if (btn_value == 0b0100 && btn_flag == 0) { // 이 문장 또한 isr로 옮기기. 
        //     btn_flag = 1;
        //     stopwatch_instance[0] = stopwatch_instance[0] | 0b0100;   // Clear 기능 활성화 (2번 비트 1로 설정)
        //     usleep(1);
        //     stopwatch_instance[0] = stopwatch_instance[0] & 0b1010;   // Clear 기능 비활성화 (2번 비트 0으로 설정)
            
        //     Display_clear();
        //     // moveCursor(0, 0);
        //     // lcdString("00:00");
        //     // lap_cnt = 0;
        // }
        if (lap_flag) {
            lap_flag = 0;
            stopwatch_instance[0] = stopwatch_instance[0] | 0b0010;
            usleep(1);
            stopwatch_instance[0] = stopwatch_instance[0] & 0b1101;
            moveCursor(1, 4);
            lcdData(stopwatch_instance[4]/10%10 + '0');
            lcdData(stopwatch_instance[4]%10 + '0');
            lcdData(':');
            lcdData(stopwatch_instance[5]/10%10 + '0');
            lcdData(stopwatch_instance[5]%10 + '0');
            lcdData(':');
            lcdData(stopwatch_instance[6]/10%10 + '0');
            lcdData(stopwatch_instance[6]%10 + '0');
            msleep(1);
        }
        if (clear_flag) {
            clear_flag = 0;
            stopwatch_instance[0] = stopwatch_instance[0] | 0b0100;   // Clear 기능 활성화 (2번 비트 1로 설정)
            usleep(1);
            stopwatch_instance[0] = stopwatch_instance[0] & 0b1010;   // Clear 기능 비활성화 (2번 비트 0으로 설정)
            Display_clear();
        }
        moveCursor(0, 4);
        lcdData(stopwatch_instance[1]/10%10 + '0');
        lcdData(stopwatch_instance[1]%10 + '0');
        lcdData(':');
        lcdData(stopwatch_instance[2]/10%10 + '0');
        lcdData(stopwatch_instance[2]%10 + '0');
        lcdData(':');
        lcdData(stopwatch_instance[3]/10%10 + '0');
        lcdData(stopwatch_instance[3]%10 + '0');
        msleep(1);
    }
    cleanup_platform();
    return 0;
}
// isr은 오래머물면 안되고 빨리 빠져나와야함. 그래서 delay나 lcddata는 시간이 꽤 걸려서 while문으로 빼줬다.
// isr은 뭔가 처리할것이 생기면 처리해야될것은 표시(flag)만 해두고 while문안에서 처리한다.
void btn_isr(void *CallBackRef){    // 버튼이 눌리면 동작하는 isr
    // unsigned int btn_value;  //  전역변수로 추가해줘서 주석처리
    // print("Button interrupt\n");
    XGpio *Gpio_ptr = (XGpio *)CallBackRef;
    btn_value = XGpio_DiscreteRead(Gpio_ptr, BTN_CHANNEL);  // 이거 실수로 안써줬다가 버튼 안먹었음
    if (btn_value == 0b0001) {    // 이 if문은 isr안에 들어있어도됨
        stopwatch_instance[0] = stopwatch_instance[0] ^ 0b0001;   // 1번 버튼과 토글
    }   // stopwatch_instance를 전역변수로 변경
    else if (btn_value == 0b0010) { // 왼쪽버튼 : lap, flag남기고 내용은 while문으로 이동
        lap_flag = 1;   // set
    }
    // 오른쪽 버튼 입력이 들어오면 clear
    else if (btn_value == 0b0100) { // flag남기고 내용은 while문으로 이동
        clear_flag = 1; 
    }

//////////////////////////////////////////////////////////////////////////////
    // btn_value = XGpio_DiscreteRead(Gpio_ptr, BTN_CHANNEL);
    // if (btn_value == 1) {   //  falling은 0
    //     print("Button 0 Rising\n");
    //     // rising edge 발생 했을 때의 내용 쓰기
    // }
    // else if (btn_value == 2) {
    //     print("Button 1 Rising\n");
    // }
    // else if (btn_value == 0) {
    //     print("Button 1 Falling\n");
    // }       
//////////////////////////////////////////////////////////////////////////////
    
    XGpio_InterruptClear(&btn_instance, BTN_CHANNEL);
}
void RecvHandler(void *CallBackRef, unsigned int EventData){
    u8 rxData;  // 수신데이터 저장 변수
    XUartLite_Recv(&uart_instance, &rxData, 1);
    printf("recv %c\n", rxData);
    return;
}
void SendHandler(void *CallBackRef, unsigned int EventData){
    
    return;
}
void lcdCommand(uint8_t command)
{
  uint8_t high_nibble, low_nibble;
  uint8_t data_array[4];
  high_nibble = command & 0xf0;
  low_nibble = (command <<4) & 0xf0;
  data_array[0] = high_nibble | 0x04 | 0x08;   
  data_array[1] = high_nibble | 0x00 | 0x08;   
  data_array[2] = low_nibble | 0x04 | 0x08;    
  data_array[3] = low_nibble | 0x00 | 0x08;    
  XIic_Send(iic_instance.BaseAddress, 0x27, 
        data_array, 4, XIIC_STOP);
  usleep(50);
}

void lcdData(uint8_t data)
{
  uint8_t high_nibble, low_nibble;
  uint8_t data_array[4];
  high_nibble = data & 0xf0;
  low_nibble = (data << 4) & 0xf0;
  data_array[0] = high_nibble |0x05 |0x08;
  data_array[1] = high_nibble |0x01 |0x08;
  data_array[2] = low_nibble |0x05 |0x08;
  data_array[3] = low_nibble |0x01 |0x08;
  XIic_Send(iic_instance.BaseAddress, 0x27, data_array, 4, XIIC_STOP);
  usleep(50);
}

void i2cLcd_Init()
{
  msleep(50);
  lcdCommand(0x33);
  msleep(5);
  lcdCommand(0x32);
  msleep(5);
  lcdCommand(0x28);
  msleep(5);
  lcdCommand(0x0c);
  msleep(5);
  lcdCommand(0x06);
  msleep(5);
  lcdCommand(0x01);    //약 2ms 필요
  msleep(2);
}

void lcdString(char *str)
{
  while(*str)lcdData(*str++);
}

void moveCursor(uint8_t row, uint8_t col)
{
  lcdCommand(0x80 | row <<6 | col);
}

void Display_clear()
{
  lcdCommand(0x01);
  usleep(2000);
}