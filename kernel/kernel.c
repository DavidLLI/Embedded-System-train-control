#include "contextSwitch.h"
#include "taskDescriptor.h"
#include "kernelFunction.h"
#include "ts7200.h"
#include "syscall.h"
//#include "bwio.h"


#define FOREVER for(;;)


int main(int argc, char *argv[]) {

	asm volatile (
		// enable cache
		"MRC	p15, 0, r1, c1, c0, 0\n\t"
		"ORR	r1, r1, #0x1\n\t" 			//enable mmu
       	"ORR	r1, r1, #(0x1 << 2)\n\t" 	//enable D-cache
       	"ORR	r1, r1, #(0x1 << 12)\n\t" 	//enable L-cache
        "MCR	p15, 0, r1, c1, c0, 0"
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

	// initialize
	//bwprintf(COM2, "init start\n\r");
	setfifo(COM1, OFF);
	setfifo(COM2, OFF);
	setspeed(COM1, 2400);

	//set stop bits
	int *bits = (int *) (UART1_BASE + UART_LCRH_OFFSET);
	*bits = *bits | STP2_MASK;

	initialize(td_pq, td_ary, &task_id_counter); // tds is an array of TDs

	//set load
	volatile int *timer_load = (int *)TIMER2_BASE;
	volatile int *timer_ctrl = (int *)(TIMER2_BASE + CRTL_OFFSET);
	volatile int *timer_value = (int *)(TIMER2_BASE + VAL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;

	volatile unsigned int idle_counter = 0; //0.01ms
	volatile unsigned int task_counter = 1;

	int exit = 0;

	int asserted = 1;

	FOREVER {

		// schedule
		//bwprintf(COM2, "before schedule\n\r");
		td *active = schedule(td_pq);

		req request;

		if(active->priority == 31) {
			*timer_load = 5079;
		}

		// active
		
		activate(active, &request);

		if(active->priority == 31) {
			int current = *timer_value;	

			volatile int interval = 5079 - current;
			idle_counter += (interval / 5);
		}
		

		request.task = active;

		switch(request.type) {
			case idleStat:
				request.task->rtn_value = idle_counter;
				break;
			case kexit:
				exit = 1;
				break;
			default:
				break;
		}

		if(exit) break;

		pq_movetoend(td_pq, active);

		//handle
		handle(td_pq, td_ary, request, &task_id_counter);
		handle_msg_passing(td_ary, request, msg_queue, msg_queue_len, recv_arr, reply_arr);
		handle_block(blk_ary, &pair, request, &asserted);


		//bwprintf(COM2, "handle return\n\r");

	}

	return;
}

