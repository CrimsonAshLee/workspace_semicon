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
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#include "xgpio.h"

#define BTN_ADDR XPAR_AXI_GPIO_BTN_BASEADDR
#define BTN_CHANNEL 1

#define FND_ADDR XPAR_MYIP_FND_0_BASEADDR

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    XGpio btn_inst, fnd_inst; // 인스턴스 선언
    XGpio_Initialize(&btn_inst, BTN_ADDR);
    XGpio_SetDataDirection(&btn_inst, BTN_CHANNEL, 0xf);    // 버튼4개(1111)

    volatile unsigned int *fnd_cntr = (volatile unsigned int*)FND_ADDR;
    fnd_cntr[1] = 0;        // 여기 두줄에  = 이후 숫자 넣는거 이해 안감
    unsigned int data = 1234;    
    fnd_cntr[0] = 'data';      // 여기 포함 두줄
    uint32_t btn_data_old, btn_data_current, btn_data;
    
    while (1) {

        btn_data_old = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);
        msleep(5);

        btn_data_current = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);
        msleep(100);
        
        if (btn_data_old == btn_data_current) {
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
            btn_data = 0;
            fnd_cntr[0] = data;
        }
    }

    cleanup_platform();
    return 0;
}
