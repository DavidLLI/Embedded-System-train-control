#ifndef __COORDINATOR_H__
#define __COORDINATOR_H__

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

#define TRACE_ROW 1
	#define TRACE_COL 52

#define TRAIN_TIME_ROW 33
	#define TRAIN_TIME_COL 1

typedef struct Train_Request {
	char type;
	int delayTime;
}t_req;

void Coordinator(void);

void trainController(void);

#endif

