/*
 * motor.h
 *
 *  Created on: Jul 3, 2025
 *      Author: user8
 */

#ifndef INC_MOTOR_H_
#define INC_MOTOR_H_

#include "main.h"
#include "tim.h"

void Motor_Stop(void);

void motorInit();
void forwardMoveFast();
void forwardMoveNormal();
void forwardMoveSlow();
void backwordMove();
void stopMove();
void rightMove();
void leftMove();


#endif /* INC_MOTOR_H_ */
