#ifndef __SYSCALL_H__
#define __SYSCALL_H__

#include "wrapper.h"

enum sys_request {
	create, 		// 0
	mytid,			// 1
	myparentid,		// 2
	pass,			// 3
	exit			// 4
};


enum event {
	timer3,
	rcv1,
	xmt1,
	rcv2,
	xmt2,
};



int Send(int tid, void *msg, int msglen, void *reply, int replylen);

int Receive(int *tid, void *msg, int msglen);

int Reply(int tid, void *reply, int replylen);

int Create(int priority, void (*code) ());

int MyTid(void);

int MyParentTid(void);

void Pass(void);

void Exit(void);

int AwaitEvent(int event);

#endif

