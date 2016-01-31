#ifndef __USERFUNCTION_H__
#define __USERFUNCTION_H__

#include "bwio.h"
#include "syscall.h"


void user() {

	bwprintf(COM2, "1--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Pass();

	bwprintf(COM2, "2--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Exit();
}


void first() {

	int ret;
	ret = Create(2, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(2, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(1, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(1, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	Exit();
}

#endif
