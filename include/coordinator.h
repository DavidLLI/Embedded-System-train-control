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

#define COORD_ROW 39

#define TRAINCTRL_ROW 37
	#define TRAINCTRL_COL 1

#define PATH_ROW 38
	#define PATH_COL 1

typedef struct Train_Request {
	char type;
	int delayTime;
	char arg1;
	char arg2;
}t_req;

typedef struct trainRequest {
	char src; // 't' - train, 's' - sensor;
	int type;
	int arg1;
	int arg2;
	char schar;
	int sint;
	int train_num;
} trainReq;


void Coordinator(void);

void trainController(void);

#endif

