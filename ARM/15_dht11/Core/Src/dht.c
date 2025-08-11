/*
 * dht.c
 *
 *  Created on: Jul 1, 2025
 *      Author: wonhyeok
 */


#include "dht.h"


void dht11Init(DHT11 *dht, GPIO_TypeDef *port, uint16_t pin) {
	dht->port = port;	// 시그널선의 포트
	dht->pin = pin;		// 시그널선의 핀

}

void dht11GPIOMode(DHT11 *dht, uint8_t mode) {
	GPIO_InitTypeDef GPIO_InitStruct = {0};
	// 출력모드 설정
	if(mode == OUTPUT) {
		GPIO_InitStruct.Pin = dht->pin;
		GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
		GPIO_InitStruct.Pull = GPIO_NOPULL;
		GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
		HAL_GPIO_Init(dht->port, &GPIO_InitStruct);
	}
	// 입력모드 설정
	else if(mode == INPUT) {
		GPIO_InitStruct.Pin = dht->pin;
		GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
		GPIO_InitStruct.Pull = GPIO_NOPULL;
		GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
		HAL_GPIO_Init(dht->port, &GPIO_InitStruct);
	}

}

uint8_t dhtRead(DHT11 *dht) {
	bool ret = true;		// 반환값 변수(기본값 true)

	uint16_t timeTick = 0;	// 시간측정 변수
	uint8_t pulse[40] = {0};// 40비트 데이터 저장용 변수(8비트 + 8비트 + 8비트 + 8비트 + 8비트)

	uint8_t humVal1 = 0, humVal2 = 0;		// 습도 변수 (정수. 소수)
	uint8_t tempVal1 = 0, tempVal2 = 0;		// 온도 변수 (정수. 소수)
	uint8_t parityVal = 0;					// 체크섬  변수

	HAL_TIM_Base_Start(&htim11);	// 딜레이 함수 사용을 위해

	// 통신 신호 전송(시작)
	dht11GPIOMode(dht, OUTPUT);		// output 모드 세팅
	HAL_GPIO_WritePin(dht->port, dht->pin, GPIO_PIN_RESET);
	HAL_Delay(20);	// wait for at least 18ms
	HAL_GPIO_WritePin(dht->port, dht->pin, GPIO_PIN_SET);
	delay_us(30);
	dht11GPIOMode(dht, INPUT);		// input 모드 세팅

	// dht11의 응답신호 대기
	__HAL_TIM_SET_COUNTER(&htim11, 0);
	while(HAL_GPIO_ReadPin(dht->port, dht->pin) == GPIO_PIN_RESET) {
		if(__HAL_TIM_GET_COUNTER(&htim11) > 100) {
			printf("TIMEOUT DURING RESPONSE\r\n");
			break;
		}
	}

	__HAL_TIM_SET_COUNTER(&htim11, 0);
	while(HAL_GPIO_ReadPin(dht->port, dht->pin) == GPIO_PIN_SET) {
			if(__HAL_TIM_GET_COUNTER(&htim11) > 100) {
				printf("TIMEOUT DURING VOLTAGE PULLUP\r\n");
				break;
			}
		}

	// 데이터 수신
	for(uint8_t i = 0; i < 40; i++) {
		while(HAL_GPIO_ReadPin(dht->port, dht->pin) == GPIO_PIN_RESET);	// low 50us 대기
		__HAL_TIM_SET_COUNTER(&htim11, 0);
		while(HAL_GPIO_ReadPin(dht->port, dht->pin) == GPIO_PIN_SET) {	// high 신호 대기
			timeTick = __HAL_TIM_GET_COUNTER(&htim11);	// high 신호 시간 측정

			// 신호 길이에 따른 0 or 1 구분
			if(timeTick > 20 && timeTick < 30) {
				pulse[i] = 0;
			}
			else if(timeTick > 65 && timeTick < 85) {
				pulse[i] = 1;
			}
		}
	}
	HAL_TIM_Base_Stop(&htim11);

	// 온습도 데이터 처리
	for(uint8_t i = 0; i < 8; i++) {
		humVal1 = (humVal1 << 1) + pulse[i];	// 습도데이터 상위 8비트(정수)
	}
	for(uint8_t i = 8; i < 16; i++) {
		humVal2 = (humVal2 << 1) + pulse[i];	// 습도데이터 하위 8비트(소수)
	}
	for(uint8_t i = 16; i < 24; i++) {
		tempVal1 = (tempVal1 << 1) + pulse[i];	// 온도데이터 상위 8비트(정수)
	}
	for(uint8_t i = 24; i < 32; i++) {
		tempVal2 = (tempVal2 << 1) + pulse[i];	// 온도데이터 하위 8비트(정수)
	}
	for(uint8_t i = 32; i < 40; i++) {
		parityVal = (parityVal << 1) + pulse[i];	// 패리티 8비트(정수)
	}

	// 구조체에 데이터 입력
	dht->temperature = tempVal1;	// 온도데이터 저장
	dht->humidity = humVal1;		// 습도데이터 저장

	// 데이터 무결성 검증
	uint8_t checksum = humVal1 + humVal2 + tempVal1 + tempVal2;
	if(checksum != parityVal) {
		printf("CHECKSUM ERROR \r\n");
		ret = false;
	}

	return ret;
}

