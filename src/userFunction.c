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

void user(void) {
	Putc(COM2, 'u');

	Putc(COM1, 0x61);
	Putc(COM1, 0x60);
	Putc(COM1, 0x61);
	Putc(COM1, 0x60);
	Putc(COM1, 0x61);
	Putc(COM1, 0x60);

	Exit();
}

/*
void user(void) {
	Printf(COM2, "\033[2J");
	//Putc(COM2, 'a');
	//Printf(COM2, "Hello\n\r");
	//for(;;) {
		//char c = Getc(COM2);
		//Printf(COM2, "get return\n\r");
		//Delay(1);
		//char c = 'a'+ (i % 26);
		//Putc(COM2, 'c');		
	//}

	int min = 0;
	int sec = 0;
	int ms = 0;
	int cur_time = 0;
	int prev_time = 0;
	for (;;) {

		cur_time = Time();
		//bwprintf(COM2, "cur: %d prev: %d\n\r", cur_time, prev_time);
		//Printf(COM2, "cur_time: %d\n\r", cur_time);
		if (cur_time > prev_time) {

			ms += ((cur_time - prev_time) * 10);
			prev_time = cur_time;

			if (ms >= 1000) {
				
				ms -= 1000;
				sec++;
				if (sec > 60) {
					min++;
					sec -= 60;
				}
			}
			Printf(COM2, "\033[1;1HTime elapsed: %dm : %d.%ds", min, sec, ms / 10 );
		}
		
	}

	Exit();
}
*/

/*void bootstrap(void) {
	Create(1, &nameServer);		// 1
	Create(2, &clockServer);		// 2
	
	Create(31, &idle);			// 4
	Create(28, &COM2PutServer);	// 5
	Create(28, &COM2GetServer);	// 6

	Exit();
}*/

/*void user_init(void) {
	Create(6, &user);

	Exit();
}*/

void first(void) {
	Create(1, &nameServer);		// 1
	Create(3, &clockServer);		// 2
	
	Create(31, &idle);			// 4
	Create(26, &COM2PutServer);	// 5
	Create(5, &COM2GetServer);	// 6
	Create(9, &COM1PutServer);	// 5
	Create(5, &COM1GetServer);	// 6

	Create(29, &init);

	Exit();
}


