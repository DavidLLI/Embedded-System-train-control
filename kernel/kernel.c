#include "bwio.h"
#include "taskDescriptor.h"
#include "kernelFunction.h"

#define FOREVER for(;;)

int main(int argc, char *argv[]) {

	// declare kernel data structures
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
	initialize(td_pq, td_ary); // tds is an array of TDs
	bwsetfifo(COM2, OFF);

	FOREVER {
		bwputstr(COM2, "loop start.\n\r");
		td *active = schedule(td_pq);
		bwputstr(COM2, "schedule return.\n\r");
		if(active == 0) {
			bwputstr(COM2, "No more task to be scheduled. Kernel is exiting.\n\r");
			break;
		}

		req request;
		activate(active, &request);
		bwputstr(COM2, "activate return.\n\r");

		handle(td_pq, td_ary, request);
		bwputstr(COM2, "handle return.\n\r");
	}
	return 0;
}

