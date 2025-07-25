#ifndef __LCD_H__
#define __LCD_H__

#include "../common/def.h"

// LCD핀에 대한 정의
#define LCD_DATA_DDR       DDRF
#define LCD_DATA_PORT      PORTF

#define LCD_RS_DDR         DDRE
#define LCD_RW_DDR         DDRE
#define LCD_E_DDR          DDRE
#define LCD_RS_PORT        PORTE
#define LCD_RW_PORT         PORTE
#define LCD_E_PORT          PORTE
#define LCD_RS              7
#define LCD_RW              6
#define LCD_E               5

// 명령어 셋팅
#define COMMAND_DISPLAY_CLEAR   0X01
#define COMMAND_DISPLAY_0N      0X0C
#define COMMAND_DISPLAY_OFF     0X08
#define COMMAND_ENTRY_MODE      0X06
#define COMMAND_8BIT_MODE       0X38
// 4비트 모드 추가
#define COMMAND_4BIT_MODE       0x28

void LCD_Data(uint8_t data);        // 8비트 짜리
void LCD_Data_4Bit(uint8_t data);   // 4비트 짜리
void LCD_WritePin();
void LCD_EnablePin();
void LCD_WriteCommand(uint8_t commandData);
void LCD_WriteData(uint8_t charData);
void LCD_GotoXY(uint8_t row, uint8_t col);
void LCD_WriteString(char *string);
void LCD_WriteStringXY(uint8_t row, uint8_t col, char *string);
void LCD_Init();

#endif /* __LCD_H__ */