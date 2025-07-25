#include "lcd.h"

void LCD_Data(uint8_t data)
{
    LCD_DATA_PORT = data;
}

void LCD_Data_4Bit(uint8_t data)    // 4비트 짜리
{
    LCD_DATA_PORT = (LCD_DATA_PORT & 0x0f) | (data & 0xf0); // 상위 4비트 추출, 전송
    LCD_EnablePin();
    LCD_DATA_PORT = (LCD_DATA_PORT & 0x0f) | ((data & 0x0f) << 4);
    LCD_EnablePin();
}

void LCD_WritePin()
{
    LCD_RW_PORT &= ~(1 << LCD_RW);      // RW핀을 LOW로 설정해서 쓰기모드로...
    // 만약에 읽기라면?
    // LCD_RW_PORT |= (1 << LCD_RW);
}

void LCD_EnablePin()
{
    LCD_E_PORT &= ~(1 << LCD_E);    // E핀을 LOW로 설정
    LCD_E_PORT |= (1 << LCD_E);     // E핀을 HIGH로
    LCD_E_PORT &= ~(1 << LCD_E);    // 다시 LOW로
    _delay_us(1600);                // 일정시간 대기
}

void LCD_WriteCommand(uint8_t commandData)
{
    LCD_RS_PORT &= ~(1 << LCD_RS);  // RS핀을 LOW로 설정해서 명령어 모드
    LCD_WritePin();                 // LCD 쓰기모드
    //LCD_Data(commandData);          // 명령어 전송 -> 8비트 짜리
    LCD_Data_4Bit(commandData);       // 명령어 전송 -> 4비트 짜리
    
    // 동작신호 주석처리
    // 왜: ???? 위에서 보내고 있음
    //LCD_EnablePin();                // LCD 동작 신호 -> 8비트에서는 반드시있어야함
}

void LCD_WriteData(uint8_t charData)
{
    LCD_RS_PORT |= (1 << LCD_RS);   // RS핀을 HIGH로 설정해서 데이터 모드
    LCD_WritePin();                 // LCD 쓰기모드
    LCD_Data_4Bit(charData);             // 데이터 전송
    //LCD_EnablePin();                // LCD 동작 신호
}

void LCD_GotoXY(uint8_t row, uint8_t col)
{
    col %= 16;  // 열 인덱스를 0~15까지 제한(16개 열)
    row %= 2;   // 행 인덱스를 0~1까지 제한(2개 행)
    
    uint8_t address = (0x40 * row) + col;   // 주소계산
    uint8_t command = 0x80 + address;       // 주소값을 알리는 커맨드
    LCD_WriteCommand(command);              // 주소를 설정한 커맨드를 LCD로 전송함
}

void LCD_WriteString(char *string)
{
    for(uint8_t i = 0; string[i]; i++)
    {
        LCD_WriteData(string[i]);
    }
}

void LCD_WriteStringXY(uint8_t row, uint8_t col, char *string)
{
    LCD_GotoXY(row, col);
    LCD_WriteString(string);
}

void LCD_Init()
{
    LCD_DATA_DDR = 0xff;            // 데이터핀 출력 설정
    LCD_RS_DDR |= (1 << LCD_RS);    // RS핀 출력설정
    LCD_RW_DDR |= (1 << LCD_RW);    // RW핀 출력 설정
    LCD_E_DDR |= (1 << LCD_E);      // Enable핀 출력 설정

    // 8비트 inint
    // _delay_ms(20);                  // 초기화 대기 시간 (충분한 시간 필요)
    // LCD_WriteCommand(COMMAND_8BIT_MODE); // funtion set
    // _delay_ms(5);
    // LCD_WriteCommand(COMMAND_8BIT_MODE);
    // _delay_ms(5);                       // 100us지만 5ms 상관없음
    // LCD_WriteCommand(COMMAND_8BIT_MODE);
    // LCD_WriteCommand(COMMAND_8BIT_MODE);
    // LCD_WriteCommand(COMMAND_DISPLAY_OFF);
    // LCD_WriteCommand(COMMAND_DISPLAY_CLEAR);
    // LCD_WriteCommand(COMMAND_DISPLAY_0N);   // 데이터 시트에서 요거만 내가 집어넣은거임
    // LCD_WriteCommand(COMMAND_ENTRY_MODE);

    // 4비트 inint
    _delay_ms(20);                  // 초기화 대기 시간 (충분한 시간 필요)
    LCD_WriteCommand(0x03); // funtion set
    _delay_ms(5);
    LCD_WriteCommand(0x03);
    _delay_ms(5);                       // 100us지만 5ms 상관없음
    LCD_WriteCommand(0x03);
    LCD_WriteCommand(0x02);
    LCD_WriteCommand(COMMAND_4BIT_MODE);
    LCD_WriteCommand(COMMAND_DISPLAY_OFF);
    LCD_WriteCommand(COMMAND_DISPLAY_CLEAR);
    LCD_WriteCommand(COMMAND_DISPLAY_0N);   // 데이터 시트에서 요거만 내가 집어넣은거임
    LCD_WriteCommand(COMMAND_ENTRY_MODE);

}
