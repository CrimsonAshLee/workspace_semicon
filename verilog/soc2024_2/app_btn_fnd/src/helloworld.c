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

#include <stdint.h>
#include <stdio.h>
#include <sys/_intsup.h>
#include <sys/_types.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xparameters.h"
#include "xgpio.h"

#define BTN_ADDR XPAR_AXI_GPIO_BTN_BASEADDR // 버튼 주소
#define BTN_CHANNEL 1

#define FND_ADDR XPAR_AXI_GPIO_FND_BASEADDR // fnd 주소
#define COM_CHANNEL 1
#define SEG_CHANNEL 2

volatile unsigned int FND_font[16] = {
    0b11000000, 0b11111001, 0b10100100, 0b10110000,
    0b10011001, 0b10010010, 0b10000010, 0b11111000,
    0b10000000, 0b10010000, 0b10001000, 0b10000011,
    0b11000110, 0b10100001, 0b10000110, 0b10001110
};  // 배열 초기화에는 ; 필수   // 16개 필요 배열 사용

volatile unsigned int FND_digit[4] = {
    0b1110, 0b1101, 0b1011, 0b0111
};// 1의자리 10의자리 100의자리 1000의자리

volatile unsigned FND[4];   // 가상의 FND

void FND_update(unsigned int data){
    FND[0] = FND_font[data % 10];
    FND[1] = FND_font[data / 10 % 10];      // 10으로 나는 몫에 10으로 나눈 나머지
    FND[2] = FND_font[data / 100 % 10];     // 100으로 나눈 몫에 10으로 나눈 나머지       
    FND[3] = FND_font[data / 1000 % 10];    // 1000으로 나눈 몫에 10으로 나눈 나머지
    return; // void 라서 안써도됨
}  // 함수처리

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    XGpio btn_inst, fnd_inst; // 인스턴스 선언
    XGpio_Initialize(&btn_inst, BTN_ADDR);
    XGpio_SetDataDirection(&btn_inst, BTN_CHANNEL, 0xf);    // 버튼4개(1111)

    XGpio_Initialize(&fnd_inst, FND_ADDR);  // FND 초기화
    XGpio_SetDataDirection(&fnd_inst, COM_CHANNEL, 0);
    XGpio_SetDataDirection(&fnd_inst, SEG_CHANNEL, 0);


    uint32_t btn_data;  // 버튼입력 데이터를 저장할 곳
    uint32_t data = 2468;   // fnd 출력할 값
    uint32_t cnt = 0;
    uint32_t btn_valid = 0;
    while (1) {
        if (cnt >= 250) {
            cnt = 0;
            data++;
            FND_update(++data);
        }
        // 함수 처리시 주석 처리하고 void FND_update()
        // FND[0] = FND_font[data % 10];
        // FND[1] = FND_font[data / 10 % 10];      // 10으로 나는 몫에 10으로 나눈 나머지
        // FND[2] = FND_font[data / 100 % 10];     // 100으로 나눈 몫에 10으로 나눈 나머지       
        // FND[3] = FND_font[data / 1000 % 10]; 

        else cnt++;

        for(int i = 0; i < 4; i++){
            XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[i]);
            XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND[i]);
            msleep(1);  // 1ms delay
        }
        
        ///// for 문 사용 시 주석처리
        // XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[0]);
        // XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND_font[4]);
        // msleep(1);  // 1ms delay

        // XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[1]);
        // XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND_font[3]);
        // msleep(1);  // 1ms delay

        // XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[2]);
        // XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND_font[2]);
        // msleep(1);  // 1ms delay

        // XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[3]);
        // XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND_font[1]);
        // msleep(1);  // 1ms delay
        ///////

        ///// fnd 사용 시 주석처리, 버튼입력 받을시에 사용
        // print("hello\n");
        // btn_data = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);   // 버튼 값 읽는 것
        // printf("Button value : %x\n", btn_data);
        // sleep(1);
        /////

        btn_valid = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);
        msleep(1);
        
        if (btn_valid) {
            btn_data = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);  // 버튼 값 읽는 것
        }
        else {
            switch (btn_data) {
                case 1: data++;
                    break;
                case 2: data = data + 2;
                    break;
                case 4: data = data - 2;
                    break;
                case 8: data--;
                    break;
            }
            FND_update(data);
            btn_data = 0;
        }
        
    }

    cleanup_platform();
    return 0;
}
