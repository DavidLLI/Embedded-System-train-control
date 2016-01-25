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
	int temp = priority;
	asm volatile (
		"mov r1, %0"
		: "=r" (temp)
	);

	temp = code;
	asm volatile (
		"mov r2, %0"
		: "=r" (temp)
	);

	asm volatile (
		"stmfd sp!, {fp}"
	);

	asm volatile (
		"swi #0"
	);

	asm volatile (
		"ldmfd sp!, {fp}"
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
		"stmfd sp!, {fp}"
	);

	asm volatile (
		"swi #1"
	);

	asm volatile (
		"ldmfd sp!, {fp}"
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
		"stmfd sp!, {fp}"
	);

	asm volatile (
		"swi #2"
	);

	asm volatile (
		"ldmfd sp!, {fp}"
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
		"stmfd sp!, {fp}"
	);

	asm volatile (
		"swi #3"
	);

	asm volatile (
		"ldmfd sp!, {fp}"
	);
}


void Exit() {
	asm volatile (
		"stmfd sp!, {fp}"
	);

	asm volatile (
		"swi #4"
	);

	asm volatile (
		"ldmfd sp!, {fp}"
	);
}

#endif

