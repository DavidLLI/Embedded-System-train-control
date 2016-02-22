#include "syscall.h"
//#include "bwio.h"
#include "helper.h"
#include "ts7200.h"



int Send(int tid, void *msg, int msglen, void *reply, int replylen) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	volatile int temp = tid;
	asm volatile (
		"mov r4, %0"
		: "=r" (temp)
	);

	temp = (int) msg;
	asm volatile (
		"mov r5, %0"
		: "=r" (temp)
	);

	temp = msglen;
	asm volatile (
		"mov r6, %0"
		: "=r" (temp)
	);

	temp = (int) reply;
	asm volatile (
		"mov r7, %0"
		: "=r" (temp)
	);

	temp = replylen;
	asm volatile (
		"mov r8, %0"
		: "=r" (temp)
	);

	asm volatile (
		"swi #5"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;
}

int Receive(int *tid, void *msg, int msglen) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	volatile int temp = (int)tid;
	asm volatile (
		"mov r4, %0"
		: "=r" (temp)
	);

	temp = (int) msg;
	asm volatile (
		"mov r5, %0"
		: "=r" (temp)
	);

	temp = msglen;
	asm volatile (
		"mov r6, %0"
		: "=r" (temp)
	);

	asm volatile (
		"swi #6"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;
}

int Reply(int tid, void *reply, int replylen) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	volatile int temp = tid;
	asm volatile (
		"mov r4, %0"
		: "=r" (temp)
	);

	temp = (int) reply;
	asm volatile (
		"mov r5, %0"
		: "=r" (temp)
	);

	temp = replylen;
	asm volatile (
		"mov r6, %0"
		: "=r" (temp)
	);

	asm volatile (
		"swi #7"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;
}

int Create(int priority, void (*code) ()) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	volatile int temp = priority;
	asm volatile (
		"mov r4, %0"
		: "=r" (temp)
	);

	temp = (int) code;
	asm volatile (
		"mov r5, %0"
		: "=r" (temp)
	);

	asm volatile (
		"swi #0"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;		
}


int MyTid() {	
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #1"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;	
}


int MyParentTid() {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #2"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;
}


void Pass() {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #3"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);
}


void Exit() {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #4"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);
}



int AwaitEvent(int event) {

	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	volatile int temp = event;
	asm volatile (
		"mov r4, %0"
		: "=r" (temp)
	);


	asm volatile (
		"swi #8"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;
}


int IdlePct(void) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #10"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;	
}

int KExit(void) {
	asm volatile (
		"stmfd sp!, {r4-r9, lr}"
	);

	asm volatile (
		"swi #11"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, lr}"
	);

	volatile int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;	
}

