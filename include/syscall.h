#ifndef __SYSCALL_H__
#define __SYSCALL_H__

#include "taskDescriptor.h"
#include "bwio.h"


enum sys_request {
	create, 		// 0
	mytid,			// 1
	myparentid,		// 2
	pass,			// 3
	exit			// 4
};


int Create(int priority, void (*code) ()) {
	asm volatile (
		"mov r1, %0"
		: "=r" (priority)
	);

	asm volatile (
		"mov r2, %0"
		: "=r" (code)
	);

	asm volatile (
		"swi #0"
	);

	int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);
	return rtn;		
}


int MyTid() {	
	asm volatile (
		"swi #1"
	);

	int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;	
}


int MyParentTid() {
	asm volatile (
		"swi #2"
	);

	int rtn;
	asm volatile (
		"mov %0, r0"
		: "=r" (rtn)
	);

	return rtn;
}


void Pass() {
	asm volatile (
		"swi #3"
	);
}


void Exit() {
	asm volatile (
		"swi #4"
	);
}

#endif

