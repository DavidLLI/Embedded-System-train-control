#ifndef __USERFUNCTION_H__
#define __USERFUNCTION_H__

#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ClockServer.h"
#include "ts7200.h"

#define MSG_LEN 4


void user() {
	bwprintf(COM2, "1--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Pass();

	bwprintf(COM2, "2--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Exit();
}

void idle() {
	for (;;) {
		//bwprintf(COM2, "idle\n\r");
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

	bwprintf(COM2, "first enter\n\r");

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

	
	bwprintf(COM2, "first enter\n\r");
	int i = 0;

	int ret;
	ret = Create(2, &second);
	bwprintf(COM2, "create second: %d\n\r", ret);

	
	ret = Create(31, &idle);
	bwprintf(COM2, "create idle: %d\n\r", ret);
	

	bwprintf(COM2, "First is calling AwaitEvent(%d)\n\r", timer3);
	ret  = AwaitEvent(timer3);
	bwprintf(COM2, "First returns from Await\n\r");

	int sender;
	char rev[10];

	bwprintf(COM2, "First receive\n\r");
	ret = Receive(&sender, rev , 4);

	char rpu[1];
	ret = Reply(sender, rpu, 4);
	bwprintf(COM2, "First after reply to senderID: %d\n\r", sender);
	

	Exit();
}
*/




#endif

