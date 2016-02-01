#include "bwio.h"
#include "taskDescriptor.h"
#include "kernelFunction.h"

#define FOREVER for(;;)

int main(int argc, char *argv[]) {

/*
	asm volatile (
		//enable mmu
		"MRC	p15, 0, r1, c1, c0, 0\n\t"
		"ORR	r1, r1, #0x1\n\t"
		"MCR	p15, 0, r1, c1, c0, 0\n\t"

		//enable D-cache
		"MRC     p15, 0, r1, c1, c0, 0\n\t"
       	"ORR     r0, r0, #(0x1 << 2)\n\t"
        "MCR     p15, 0, r1, c1, c0, 0\n\t"

        //enable L-cache
        "MRC     p15, 0, r1, c1, c0, 0\n\t"
       	"ORR     r1, r1, #(0x1 << 12)\n\t"
        "MCR     p15, 0, r1, c1, c0, 0"
		);
*/
	 									
	 


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

	// Message queue for each task id
	msg_info msg_queue[88*87];
	recv_buf recv_arr[88];
	recv_buf reply_arr[88];
	int msg_queue_len[88];
	int msg_queue_i;
	for(msg_queue_i = 0; msg_queue_i < 88; msg_queue_i++) {
		recv_arr[msg_queue_i].tid = 0;
		recv_arr[msg_queue_i].msg = 0;
		recv_arr[msg_queue_i].msglen = 0;
		reply_arr[msg_queue_i].tid = 0;
		reply_arr[msg_queue_i].msg = 0;
		reply_arr[msg_queue_i].msglen = 0;
		msg_queue_len[msg_queue_i] = 0;
	}

	// initialize
	bwsetfifo(COM2, OFF);
	initialize(td_pq, td_ary, &task_id_counter); // tds is an array of TDs
	asm volatile (
			".ltorg"
	);



	FOREVER {
		td *active = schedule(td_pq);

		if(active == 0) {
			bwputstr(COM2, "No more task to be scheduled. Kernel is exiting.\n\r");
			break;
		}

		asm volatile (
			".ltorg"
		);
		req request;
		//bwprintf(COM2,"ACTIVETE before\n\r");
		activate(active, &request);
		//bwprintf(COM2,"ACTIVETE after\n\r");
		request.task = active;
		asm volatile (
			".ltorg"
		);
		
		pq_movetoend(td_pq, active);

		handle(td_pq, td_ary, request, &task_id_counter);
		handle_msg_passing(td_ary, request, msg_queue, msg_queue_len, recv_arr, reply_arr);		
	}
	return 0;
}

