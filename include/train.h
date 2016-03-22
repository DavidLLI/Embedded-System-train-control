#ifndef __TRAIN_H__
#define __TRAIN_H__

#include "coordinator.h"
#include "syscall.h"
#include "command.h"

enum train_cmd {
	tr,
	rv,
	sw,
	q,
	invalid,
	go,
	stop,
	sp,
};


void init(void);

void train_application(void);

void timer(void);

void sensorData(void);

void trainCommunication(void);

void handelSP(void);

#endif
