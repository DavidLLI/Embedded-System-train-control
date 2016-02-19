#ifndef __CLOCKSERVER_H__
#define __CLOCKSERVER_H__


typedef struct waitTid {
	int time_counter;
	int tid;
}wtid;




void add_wtid(wtid *task_arr, int *task_counter, int time_counter, int tid);

void clockNotifier(void);

void clockServer(void);


#endif
