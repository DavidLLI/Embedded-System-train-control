#ifndef __SYSCALL_H__
#define __SYSCALL_H__

#include "taskDescriptor.h"
#include "bwio.h"

void myMemCpy(void *dest, void *src, int n)
{
   // Typecast src and dest addresses to (char *)
   char *csrc = (char *) src;
   char *cdest = (char *) dest;
 
   // Copy contents of src[] to dest[]
   int i;
   for (i=0; i<n; i++)
       cdest[i] = csrc[i];
}

int myAtoi(char *str)
{
    int res = 0; // Initialize result
    int sign = 0;
  
    // Iterate through all characters of input string and
    // update result
    if(str[0] == '-') {
    	sign = 1;
    }

    if(sign) {
    	int i;
		for (i = 1; str[i] != '\0'; ++i) {
	    	 res = res*10 + str[i] - '0';
	    }
	    res *= -1;	
    } else {
    	int i;
	    for (i = 0; str[i] != '\0'; ++i) {
	    	 res = res*10 + str[i] - '0';
	    }    	
    }

       
  
    // return result.
    return res;
}

int myStrcmp(const char* s1, const char* s2)
{
    while(*s1 && (*s1==*s2))
        s1++,s2++;
    return *(const unsigned char*)s1-*(const unsigned char*)s2;
}

void reverse(char s[], int length) {
     int i, j;
     char c;
 
     for (i = 0, j = length-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
}

void myItoa(int n, char s[]) {
     int i, sign;
 
     if ((sign = n) < 0)  /* record sign */
         n = -n;          /* make n positive */
     i = 0;
     do {       /* generate digits in reverse order */
         s[i++] = n % 10 + '0';   /* get next digit */
     } while ((n /= 10) > 0);     /* delete it */
     if (sign < 0)
         s[i++] = '-';
     s[i] = '\0';
     reverse(s, i);
}

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


int Send(int tid, void *msg, int msglen, void *reply, int replylen) {
	asm volatile (
		"stmfd sp!, {r4-r9, fp}"
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
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
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
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
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
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
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
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
	);

	asm volatile (
		"swi #1"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
	);

	asm volatile (
		"swi #2"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, fp}"
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
		"stmfd sp!, {r4-r9, fp}"
	);

	asm volatile (
		"swi #3"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, fp}"
	);
}


void Exit() {
	asm volatile (
		"stmfd sp!, {r4-r9, fp}"
	);

	asm volatile (
		"swi #4"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9, fp}"
	);
}

int RegisterAs(char *name) {
	struct ns_request r;
	r.type = 0;
	r.tid = MyTid();

	myMemCpy(r.name, name, 32);

	//bwprintf(COM2, "reg %s %d\n\r", name, sizeof(name)/sizeof(char));

	char msg[sizeof(struct ns_request)];

	myMemCpy(msg, &r, sizeof(struct ns_request));

	char reply[32];

	//bwprintf(COM2, "reg before send\n\r");
	int ret = Send(1, msg, sizeof(struct ns_request), reply, 32);
	if(ret != 32) bwprintf(COM2, "RegisterAs(), Send error.\n\r");
	//bwprintf(COM2, "reg after send\n\r");

	return myAtoi(reply);

}


int WhoIs(char *name) {
	struct ns_request r;
	r.type = 1;

	myMemCpy(r.name, name, 32);

	char msg[sizeof(struct ns_request)];

	myMemCpy(msg, &r, sizeof(struct ns_request));

	char reply[32];

	//bwprintf(COM2, "who before send\n\r");
	int ret = Send(1, msg, sizeof(struct ns_request), reply, 32);
	if(ret != 32) bwprintf(COM2, "WhoIs(), Send error.\n\r");
	//bwprintf(COM2, "who after send\n\r");

	return myAtoi(reply);
}

#endif

