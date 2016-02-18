#ifndef __CONTEXTSWITCH_H__
#define __CONTEXTSWITCH_H__

#include "taskDescriptor.h"

#define STACK_BASE 0x7ff000
#define STACK_SPACE 0x1000

typedef struct request {
	int type;
	td *task;
	int arg1;
	int arg2;
	int arg3;
	int arg4;
	int arg5;
} req;


void activate(td* tds, req *request);

void initialize(pair *td_pq, td *td_ary, int *task_id_counter);

#endif

