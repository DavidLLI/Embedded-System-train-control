#ifndef __USERFUNCTION_H__
#define __USERFUNCTION_H__

#include "bwio.h"
#include "syscall.h"


void user() {
	//bwprintf(COM2, "enter user()\n\r");

	bwprintf(COM2, "1--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Pass();

	bwprintf(COM2, "2--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Exit();
}

void send_task() {
	char *send = "Hello there";
	char reply[50];
	int actual_reply_size = 0;
	bwprintf(COM2, "Before message is sent\n\r");
	actual_reply_size = Send(2, send, 12, reply, 50);
	bwprintf(COM2, "Reply is: %s with length %d.\n\r", reply, actual_reply_size);
	Exit();
}

void receive_and_reply_task() {
	char receive[20];
	int receive_size = 0;
	int tid;
	bwprintf(COM2, "Trying to receive a message\n\r");
	receive_size = Receive(&tid, receive, 20);
	bwprintf(COM2, "Message received from tid%d: %s with size %d.\n\r", tid, receive, receive_size);
	char *reply = "Hello received";
	Reply(1, reply, 15);
	Exit();
}

void first() {
	//bwputstr(COM2, "Enter first()\n\r");

	int ret;
	ret = Create(2, &send_task);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(1, &receive_and_reply_task);
	bwprintf(COM2, "Created: %d\n\r", ret);

	Exit();
}

#endif
