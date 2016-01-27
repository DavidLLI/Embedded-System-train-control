#include "bwio.h"
#include "taskDescriptor.h"
#include "kernelFunction.h"

#define FOREVER for(;;)

int main(int argc, char *argv[]) {

	// declare kernel data structures
	int task_id_counter = 0;

	pair td_pq[32]; // task priority queue
	int td_pq_i;
	for(td_pq_i = 0; td_pq_i < 32; td_pq_i++) {
		td_pq[td_pq_i].td_head = 0;
		td_pq[td_pq_i].td_tail = 0;
	}

	td td_ary[88]; // task descriptor array
	int td_ary_i;
	for(td_ary_i = 0; td_ary_i < 88; td_ary_i++) {
		td_ary[td_ary_i].free = 1;
	}

	// initialize
	bwsetfifo(COM2, OFF);
	initialize(td_pq, td_ary, &task_id_counter); // tds is an array of TDs
	

	
	FOREVER {
		td *active = schedule(td_pq);
		if(active == 0) {
			bwputstr(COM2, "No more task to be scheduled. Kernel is exiting.\n\r");
			break;
		} else {
			
		}

		req request;
		activate(active, &request);
		request.task = active;

		pq_movetoend(td_pq, active);

		handle(td_pq, td_ary, request, &task_id_counter);		
	}
	return 0;
}

