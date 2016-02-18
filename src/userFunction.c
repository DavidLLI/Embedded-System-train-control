#include "userFunction.h"
#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ClockServer.h"
#include "ts7200.h"

#define MSG_LEN 64


void idle(void) {
	for (;;) {

	}
}

void client(void) {
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

/*
void first(void) {

	bwprintf(COM2, "first\n\r");

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
*/


void send_task() {
	char send[] = "a";
	char reply[MSG_LEN];
	int actual_reply_size = 0;

	//timer init
	int *timer_load = (int *)TIMER2_BASE;
	*timer_load = *timer_load | 50000;

	int *timer_ctrl = (int *)(TIMER2_BASE + CRTL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;
	
	int *timer_value = (int *)(TIMER2_BASE + VAL_OFFSET);

	int time1 = *timer_value;

	actual_reply_size = Send(2, send, MSG_LEN, reply, MSG_LEN);

	int time2 = *timer_value;

	bwprintf(COM2, "first(), time: %d\n\r", time2 - time1);

	Exit();
}

void receive_and_reply_task() {
	char receive[MSG_LEN];
	int receive_size = MSG_LEN;
	int tid;
	receive_size = Receive(&tid, receive, MSG_LEN);
	char reply[] = "a";
	Reply(tid, reply, MSG_LEN);

	Exit();
}

void first() {

	bwputstr(COM2, "first enter\n\r");
	int ret;
	ret = Create(2, &send_task);
	bwprintf(COM2, "Created send, tid: %d\n\r", ret);

	ret = Create(1, &receive_and_reply_task);
	bwprintf(COM2, "Created receive, tid %d\n\r", ret);

	Exit();
}

