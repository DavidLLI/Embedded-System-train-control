#include "bwio.h"
#include "taskDescriptor.h"
#include "kernelFunction.h"
#include "ts7200.h"

#define FOREVER for(;;)


int main(int argc, char *argv[]) {

	
	asm volatile (
		// enable cache
		"MRC	p15, 0, r1, c1, c0, 0\n\t"
		"ORR	r1, r1, #0x1\n\t" //enable mmu
       	"ORR     r1, r1, #(0x1 << 2)\n\t" //enable D-cache
       	"ORR     r1, r1, #(0x1 << 12)\n\t" //enable L-cache
        "MCR     p15, 0, r1, c1, c0, 0"
	);

	 									
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
		td_ary[td_ary_i].td_prv = 0;
		td_ary[td_ary_i].td_nxt = 0;
	}
	

	// blocked tasks
	struct blk_td blk_ary[88];
	struct blk_pair pair;
	pair.head = 0;
	pair.tail = 0;

	asm volatile (
			".ltorg"
		);

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

	asm volatile (
			".ltorg"
	);
	// initialize
	//bwprintf(COM2, "init start\n\r");
	bwsetfifo(COM2, OFF);
	initialize(td_pq, td_ary, &task_id_counter); // tds is an array of TDs
	asm volatile (
			".ltorg"
	);
	//bwprintf(COM2, "init return\n\r");

	int for_i;
	for(;;) {
		td *active = schedule(td_pq);


		if(active == 0) {
			bwputstr(COM2, "No more task to be scheduled. Kernel is exiting.\n\r");
			break;
		}

		asm volatile (
			".ltorg"
		);
		req request;

		activate(active, &request);

		request.task = active;
		asm volatile (
			".ltorg"
		);
		
		pq_movetoend(td_pq, active);

		handle(td_pq, td_ary, request,&task_id_counter);
		handle_msg_passing(td_ary, request, msg_queue, msg_queue_len, recv_arr, reply_arr);
		handle_block(blk_ary, &pair, request);
		asm volatile (
			".ltorg"
		);
		//bwprintf(COM2, "handle return\n\r");

	}
	
	

	return 0;
}

