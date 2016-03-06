#ifndef __TRAIN_H__
#define __TRAIN_H__

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

typedef struct trainRequest {
	char src; // 't' - train, 's' - sensor;
	int type;
	int arg1;
	int arg2;
	char schar;
	int sint;
} trainReq;

void init(void);

void train_application(void);

void timer(void);

void sensorData(void);

void trainCommunication(void);

void handelSP(void);

#endif
