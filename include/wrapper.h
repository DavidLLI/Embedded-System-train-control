#ifndef __WRAPPER_H__
#define __WRAPPER_H__

typedef struct ioRequest {
	int type;
	char ch;
}ioReq;

struct ns_request {
	int type;		// 0 -- RegisterAs, 1 -- WhoIs
	int tid;
	char name[32]; 	// max length of name is 32
};

typedef struct clockMessage {
	int type;
	int ticks;
}clockMsg;

int RegisterAs(char *name);

int WhoIs(char *name);

int Getc(int channel);

int Putc(int channel, char ch);

int Time(void);

int Delay(int ticks);

int DelayUntil(int ticks);


#endif
