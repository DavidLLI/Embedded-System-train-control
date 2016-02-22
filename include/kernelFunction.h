#ifndef __KERNELFUNCTION_H__
#define __KERNELFUNCTION_H__


#include "taskDescriptor.h"
#include "msgPassing.h"
#include "contextSwitch.h"


struct blk_td {
	int tid;
	int event_type;
	td *task;

	struct blk_td* nxt;
	struct blk_td* prv;
};

struct blk_pair {
	struct blk_td *head;
	struct blk_td *tail;
};

void handle(pair *td_pq, td *td_ary, req request, int *task_id_counter);


void handle_msg_passing(td *td_ary, req request, 
						msg_info* msg_queue, int *msg_queue_len, 
						recv_buf* recv_arr, recv_buf* reply_arr);


void handle_block(struct blk_td *blk_ary, struct blk_pair *pair, req request, int* asserted);

#endif

