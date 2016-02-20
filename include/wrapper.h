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


typedef char *va_list;

#define __va_argsiz(t)	\
		(((sizeof(t) + sizeof(int) - 1) / sizeof(int)) * sizeof(int))

#define va_start(ap, pN) ((ap) = ((va_list) __builtin_next_arg(pN)))

#define va_end(ap)	((void)0)

#define va_arg(ap, t)	\
		 (((ap) = (ap) + __va_argsiz(t)), *((t*) (void*) ((ap) - __va_argsiz(t))))

#define COM1	0
#define COM2	1

#define ON	1
#define	OFF	0

int setfifo(int channel, int state);

int setspeed(int channel, int speed);


int RegisterAs(char *name);

int WhoIs(char *name);

int Getc(int channel);

int Putc(int channel, char ch);

int Time(void);

int Delay(int ticks);

int DelayUntil(int ticks);

void Printf(int channel, char *format, ...);


#endif
