#include "train.h"
#include "syscall.h"

#define TIME_ROW 1
	#define TIME_COL 1
#define SENSOR_ROW 2
	#define SENSOR_COL 20
#define SWITCH_ROW 2
	#define SWITCH_COL 48

#define CMD_ROW 29
	#define CMD_COL 1

#define STATUS_ROW 31
	#define STATUS_COL 1

void init(void) {
	Printf(COM2, "\033[2J");

	int square_sensor;
	for(square_sensor = 0; square_sensor < 10; square_sensor++) {
		Printf(COM2, "\033[%d;%dH", SWITCH_ROW + square_sensor, 17);
		Printf(COM2, "|");
	}

	Printf(COM2, "\033[%d;1H", CMD_ROW + 1);
	Printf(COM2, "--------------------------");

	int square_switch;
	for(square_switch = 0; square_switch < 22; square_switch++) {
		Printf(COM2, "\033[%d;%dH", square_switch + SENSOR_ROW, 40);
		Printf(COM2, "|  ");
		if(square_switch < 18) {
			Printf(COM2, "%d", square_switch + 1);
		} else {
			Printf(COM2, "%d", square_switch + 135);
		}

		if(square_switch < 9) {
			Printf(COM2, ":   ?");
		} else if(square_switch < 18) {
			Printf(COM2, ":  ?");
		} else {
			Printf(COM2, ": ?");
		}
		
	}

	int switchIndex = 0;
	int switchNum = 0;

	for(switchIndex = 0; switchIndex < 22; switchIndex++) {
		Printf(COM2, "\033[%d;1H\033[KInitializing......", STATUS_ROW);

		if(switchIndex >= 18) switchNum = switchIndex + 135;
		else switchNum = switchIndex + 1;

		//send command
		Putc(COM1, 34);
		Putc(COM1, (char) switchNum);

		//print to COM2
		Printf(COM2, "\033[%d;%dHC", SWITCH_ROW + switchIndex, SWITCH_COL);

		if(switchIndex == 22)  {
			Printf(COM2, "\033[%d;1H\033[KInitialization Compelete. Let's go Thomas.", STATUS_ROW);
		}

		Delay(15);
	}

	Create(16, &timer);

	Exit();
}


void timer(void) {
	int min = 0;
	int sec = 0;
	int ms = 0;
	int cur_time = 0;
	int prev_time = 0;

	for (;;) {
		Delay(10);
		cur_time = Time();
		if (cur_time > prev_time) {

			ms += ((cur_time - prev_time) * 10);
			prev_time = cur_time;

			if (ms >= 1000) {
				ms -= 1000;
				sec++;
				if (sec >= 60) {
					min++;
					sec -= 60;
				}
			}
			Printf(COM2, "\033[1;1H\033[K%dm:%d.%ds", min, sec, ms / 100 );
		}
	}

	Exit();
}

