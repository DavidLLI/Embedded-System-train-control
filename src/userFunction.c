#include "userFunction.h"
#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ClockServer.h"
#include "ts7200.h"
#include "ioServer.h"

#define MSG_LEN 64


void idle(void) {
	for (;;) {

	}
}

void user(void) {
	Putc(COM2, 'a');
	bwprintf(COM2, "user exit\n\r");
	Exit();
}


void first(void) {

	int id_temp = 0;
	id_temp = Create(1, &nameServer);		// 1
	id_temp = Create(1, &clockServer);		// 2
	id_temp = Create(2, &clockNotifier);	// 3
	id_temp = Create(31, &idle);			// 4
	id_temp = Create(3, &COM2PutServer);	// 5
	id_temp = Create(4, &COM2PutNotifier);	// 6
	id_temp = Create(5, &user);				// 7

	bwprintf(COM2, "first exit\n\r");
	Exit();
}

