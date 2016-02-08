#ifndef __USERFUNCTION_H__
#define __USERFUNCTION_H__

#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ClockServer.h"
#include "ts7200.h"

#define MSG_LEN 4


void idle() {
	for (;;) {

	}
}

void client() {
	char temp = ' ';
	int re[2];
	Send(0, &temp, sizeof(char), re, sizeof(int) * 2);
	int i = 0;
	int tid = MyTid();
	for (i = 0; i < re[1]; i++) {
		//bwprintf(COM2, "Tid: %d before\n\r", tid);
		Delay(re[0]);
		bwprintf(COM2, "Tid: %d delayed %d ticks for %d time(s)\n\r", tid, re[0], i + 1);
	}
	bwprintf(COM2, "Client exiting\n\r");
	Exit();
}

void first() {

	int id_temp = 0;
	id_temp = Create(1, &nameServer);
	id_temp = Create(1, &clockServer);
	id_temp = Create(2, &clockNotifier);
	int idIdle = Create(31, &idle);
	int id1 = Create(3, &client);
	int id2 = Create(4, &client);
	int id3 = Create(5, &client);
	int id4 = Create(6, &client);
	int temp;
	char c;
	Receive(&temp, &c, sizeof(char));
	Receive(&temp, &c, sizeof(char));
	Receive(&temp, &c, sizeof(char));
	Receive(&temp, &c, sizeof(char));
	int re1[2];
	re1[0] = 10;
	re1[1] = 20;
	int re2[2];
	re2[0] = 23;
	re2[1] = 9;
	int re3[2];
	re3[0] = 33;
	re3[1] = 6;
	int re4[2];
	re4[0] = 71;
	re4[1] = 3;
	Reply(id1, re1, sizeof(int) * 2);
	Reply(id2, re2, sizeof(int) * 2);
	Reply(id3, re3, sizeof(int) * 2);
	Reply(id4, re4, sizeof(int) * 2);

	Exit();
}


/*
void first() {

	bwprintf(COM2, "first\n\r");

	
	//set load
	int *timer_load = (int *)TIMER2_BASE;
	int *timer_ctrl = (int *)(TIMER2_BASE + CRTL_OFFSET);
	int *timer_value = (int *)(TIMER2_BASE + VAL_OFFSET);

	//set control bit
	
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;

	unsigned int counter = 0;

	*timer_load = *timer_load | 50799;
	int last = 50800;
	int value = 0;
	volatile int i = 0;
	for(i = 0; i < 100000; i++) {
		value = *timer_value;
		if(value >= 50800) {
			counter++;
			//bwprintf(COM2, "wrap around\n\r");
			last = value;
		}
	}
	

	bwprintf(COM2, "%d\n\r", counter);
	
	

	Exit();
}

*/



#endif

