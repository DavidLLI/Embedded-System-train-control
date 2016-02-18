#ifndef __CLOCKSERVER_H__
#define __CLOCKSERVER_H__


typedef struct waitTid {
	int time_counter;
	int tid;
}wtid;

typedef struct clockMessage {
	int type;
	int ticks;
}clockMsg;


// Type 0
int Time (void);

// Type 1
int Delay(int ticks);

// Type 2
int DelayUntil(int ticks);

void add_wtid(wtid *task_arr, int *task_counter, int time_counter, int tid);

void clockNotifier(void);

void clockServer(void);


#endif
