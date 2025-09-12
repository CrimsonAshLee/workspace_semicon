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
#include "sleep.h"

#define PWM_ADDR XPAR_MYIP_PWM_0_BASEADDR

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    volatile unsigned int *pwm_instance = (volatile unsigned int*)PWM_ADDR;

    unsigned int pwm = 0;
    char updown_flag = 1;   // 이름지을때 앞 0, 뒤 1 처럼 일관성을 유지하면 편함
    while (1) {
        if (pwm >= 255) {
            updown_flag = 0;
        }
        else if (pwm <= 10) {
            updown_flag = 1;
        }
        if (updown_flag) {
            pwm++;
        }
        else {
            pwm--;
        }
        msleep(1);
        pwm_instance[0] = pwm;
    }

    cleanup_platform();
    return 0;
}
