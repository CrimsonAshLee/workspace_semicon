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
#include <sys/_types.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "header"

#define TXTLCD_ADDR XPAR_MYIP_IIC_TXTLCD_0_BASEADDR

void lcdCommand(uint8_t command, unsigned int *txtlcd_instance){
    while(txtlcd_instance[3]);  // busy가 3
    txtlcd_instance[0] = 0x27;
    txtlcd_instance[1] = command;
    txtlcd_instance[2] = 0x01;
    while(txtlcd_instance[3]);  // 여기 두줄 없으면 send가 계속 1이라서 안됨
    txtlcd_instance[2] = 0;     // 여기까지 두줄
}
void lcdData(uint8_t data, unsigned int *txtlcd_instance){
    while(txtlcd_instance[3]);
    txtlcd_instance[0] = 0x27;
    txtlcd_instance[1] = data;
    txtlcd_instance[2] = 0x03;
    while(txtlcd_instance[3]);
    txtlcd_instance[2] = 0;
}
void i2cLcd_Init()
{
  msleep(50);
  lcdCommand(0x33, txtlcd_instance);
  msleep(5);
  lcdCommand(0x32, txtlcd_instance);
  msleep(5);
  lcdCommand(0x28, txtlcd_instance);
  msleep(5);
  lcdCommand(0x0c, txtlcd_instance);
  msleep(5);
  lcdCommand(0x06, txtlcd_instance);
  msleep(5);
  lcdCommand(0x01, txtlcd_instance);    //약 2ms 필요
  msleep(2);
}
void lcdString(char *str, unsigned int *txtlcd_instance)
{
  while(*str)lcdData(*str++, txtlcd_instance);
}
void moveCursor(uint8_t row, uint8_t col, unsigned int *txtlcd_instance)
{
  lcdCommand(0x80 | row <<6 | col, txtlcd_instance);
}
void Display_clear()
{
  lcdCommand(0x01);
  usleep(2000); // 반드시 딜레이 줘야함
}


int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    volatile unsigned int *txtlcd_instance = (volatile unsigned int*)TXTLCD_ADDR;
    i2cLcd_Init(txtlcd_instance);

    // 명령보내는 함수
    lcdString("Humidity   : 11", txtlcd_instance);
    moveCursor(1, 0, txtlcd_instance);
    lcdString("Teperature : 11", txtlcd_instance);

    while (1) {
        
    }
    cleanup_platform();
    return 0;
}
