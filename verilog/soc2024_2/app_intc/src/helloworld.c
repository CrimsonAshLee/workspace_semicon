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
#include <sys/_intsup.h>
#include <xil_types.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xintc.h"
#include "xuartlite.h"
#include "xil_exception.h"      // 예외처리


#define UART_ADDR XPAR_AXI_UARTLITE_0_BASEADDR
#define BTN_ADDR XPAR_AXI_GPIO_0_BASEADDR
#define INTC_ADDR XPAR_XINTC_0_BASEADDR

#define UART_VEC_ID XPAR_FABRIC_AXI_UARTLITE_0_INTR
#define BTN_VECT_ID XPAR_FABRIC_AXI_GPIO_0_INTR

#define BTN_CHANNEL 1

XGpio btn_instance;
XIntc intc_instance;
XUartLite uart_instance;

void btn_isr(void *CallBackRef);    // 내가 호출하는게 아니라 시스템이 호출하는것임
void RecvHandler(void *CallBackRef, unsigned int EventData);
void SendHandler(void *CallBackRef, unsigned int EventData);
int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application\n");
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


    while (1) {
    
    }

    cleanup_platform();
    return 0;
}

void btn_isr(void *CallBackRef){
    unsigned int btn_value;
    print("Button interrupt\n");
    XGpio *Gpio_ptr = (XGpio *)CallBackRef;
    btn_value = XGpio_DiscreteRead(Gpio_ptr, BTN_CHANNEL);
    if (btn_value == 1) {   //  falling은 0
        print("Button 0 Rising\n");
        // rising edge 발생 했을 때의 내용 쓰기
    }
    else if (btn_value == 2) {
        print("Button 1 Rising\n");
    }
    else if (btn_value == 0) {
        print("Button 1 Falling\n");
    }       
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