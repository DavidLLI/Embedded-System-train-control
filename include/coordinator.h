#ifndef __COORDINATOR_H__
#define __COORDINATOR_H__

#include "graph.h"
#include "train.h"
#include "syscall.h"
#include "command.h"
#include "track_node.h"
#include "track_data.h"

#define TIME_ROW 1
	#define TIME_COL 1
#define SENSOR_ROW 2
	#define SENSOR_COL 20
#define SWITCH_ROW 2
	#define SWITCH_COL 48

#define CMD_ROW 29
	#define CMD_COL 1

#define STATUS_ROW 31
	#define STATUS_COL 1

#define IDLE_ROW 32
	#define IDLE_COL 1

#define TRAIN_TIME_ROW 33
	#define TRAIN_TIME_COL 1

#define SPEED_ROW 34
	#define SPEED_COL 1

#define LOCATION_ROW 35
	#define LOCATION_COL 33

typedef struct Train_Request {
	char type;
	int delayTime;
	char arg1;
	char arg2;
}t_req;


void Coordinator(void);

void trainController1(void);

#endif

