#ifndef __COORDINATOR_H__
#define __COORDINATOR_H__

#include "graph.h"
#include "train.h"
#include "syscall.h"
#include "command.h"
#include "track_node.h"
#include "track_data.h"
#include "reserve.h"
#include "project.h"

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

#define TRAINCTRL_PRI 18

#define TIME_DISPLAY_PRI 17

#define LOC_DISPLAY_PRI 16

#define SENSOR_PRI 14

#define TRAIN_COM_PRI 15

#define PROJECT_PRI 9

#define TIMER_PRI 17

#define COORDINATOR_PRI 10

typedef struct Train_Request {
	char type;
	int delayTime;
	char arg1;
	char arg2;
}t_req;


void Coordinator(void);

void trainController(void);

#endif

