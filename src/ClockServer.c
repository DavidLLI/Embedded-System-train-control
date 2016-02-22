#include "ClockServer.h"
#include "syscall.h"
//#include "bwio.h"


void add_wtid(wtid *task_arr, int *task_counter, int time_counter, int tid) {
	//bwprintf(COM2, "Before adding task to delay queue\n\r");
	int i = 0;
	for (i = 0; i < *task_counter; i++) {
		if (task_arr[i].time_counter > time_counter) {
			break;
		}
	}
	if (i == *task_counter) {
		task_arr[*task_counter].time_counter = time_counter;
		task_arr[*task_counter].tid = tid;
	}
	else {
		int pos = i;
		for (i = *task_counter; i > pos; i--) {
			task_arr[i].time_counter = task_arr[i - 1].time_counter;
			task_arr[i].tid = task_arr[i - 1].tid;
		}
		task_arr[pos].time_counter = time_counter;
		task_arr[pos].tid = tid;
	}
	(*task_counter)++;
	//bwprintf(COM2, "Task added to delay queue\n\r");
}

void clockNotifier(void) {
	//bwprintf(COM2, "clock notifier start\n\r");
	int timer_tid = MyParentTid();
	for (;;) {
		//bwprintf(COM2, "notifier before await\n\r");
		AwaitEvent(timer3);
		//bwprintf(COM2, "notifier after await\n\r");
		clockMsg msg;
		msg.type = 3;
		char c;
		Send(timer_tid, &msg, sizeof(struct clockMessage), &c, sizeof(char));
	}
}

void clockServer(void) {

	Create(2, &clockNotifier);
	//bwprintf(COM2, "clock server start\n\r");
	RegisterAs("ClockServer");
	//bwprintf(COM2, "before clcokserver tid\n\r");
	
	int ticksElapsed = 0;
	wtid task_arr[88];
	int task_counter = 0;
	clockMsg recv_buffer;
	int recv_tid = 0;
	char c = ' ';
	for (;;) {
		//bwprintf(COM2, "before receive\n\r");
		Receive(&recv_tid, &recv_buffer, sizeof(struct clockMessage));
		//bwprintf(COM2, "clock server request received\n\r");
		//bwprintf(COM2, "request type: %d\n\r", recv_buffer.type);
		if (recv_buffer.type == 3) {
			ticksElapsed++;
			Reply(recv_tid, &c, sizeof(char));
			//bwprintf(COM2, "Current ticks: %d\n\r", ticksElapsed);
			//bwprintf(COM2, "task_counter: %d\n\r", task_counter);
			//bwprintf(COM2, "first task's counter: %d\n\r", task_arr[0].time_counter);
			if (task_counter != 0 && task_arr[0].time_counter <= ticksElapsed) {
				int i = 0;
				for (i = 0; i < task_counter; i++) {
					//bwprintf(COM2, "Task %d delayed until %d, current %d\n\r", task_arr[i].tid, task_arr[i].time_counter, ticksElapsed);
					if (task_arr[i].time_counter <= ticksElapsed) {
						Reply(task_arr[i].tid, &c, sizeof(char));
					}
					else {
						break;
					}
				}
				int pos = i;
				for (; i < task_counter; i++) {
					task_arr[i - pos].time_counter = task_arr[i].time_counter;
					task_arr[i - pos].tid = task_arr[i].tid;
				}
				task_counter = task_counter - pos;
			}
		}
		else {
			switch(recv_buffer.type) {
				case 0:
					Reply(recv_tid, &ticksElapsed, sizeof(int));
					break;
				case 1:
					add_wtid(task_arr, &task_counter, recv_buffer.ticks + ticksElapsed, recv_tid);
					break;
				case 2:
					if (recv_buffer.ticks >= ticksElapsed) {
						add_wtid(task_arr, &task_counter, recv_buffer.ticks, recv_tid);
					}
					else {
						Reply(recv_tid, &c, sizeof(char));
					}
					break;
				default:
					break;
			}
		}
	}
}

