#ifndef __SYSCALL_H__
#define __SYSCALL_H__


enum sys_request {
	create, 		// 0
	mytid,			// 1
	myparentid,		// 2
	pass,			// 3
	exit			// 4
};

struct ns_request {
	int type;		// 0 -- RegisterAs, 1 -- WhoIs
	int tid;
	char name[32]; 	// max length of name is 32
};

enum event {
	timer3,
};


int Send(int tid, void *msg, int msglen, void *reply, int replylen);

int Receive(int *tid, void *msg, int msglen);

int Reply(int tid, void *reply, int replylen);

int Create(int priority, void (*code) ());

int MyTid(void);

int MyParentTid(void);

void Pass(void);

void Exit(void);

int RegisterAs(char *name);

int WhoIs(char *name);

int AwaitEvent(int event);


#endif

