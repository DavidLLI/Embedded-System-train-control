#include "userFunction.h"
#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ClockServer.h"
#include "ts7200.h"
#include "ioServer.h"
#include "train.h"

#define MSG_LEN 64


void idle(void) {
	for (;;) {
		
	}
}


void first(void) {
	Create(1, &nameServer);		// 1
	Create(3, &clockServer);		// 2
	
	Create(31, &idle);			// 4
	Create(27, &COM2PutServer);	// 5
	Create(28, &COM2GetServer);	// 6
	Create(7, &COM1PutServer);	// 5
	Create(6, &COM1GetServer);	// 6

	Create(29, &init);

	Exit();
}


