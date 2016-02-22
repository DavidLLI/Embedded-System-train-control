#include "train.h"
#include "syscall.h"
#include "command.h"

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
	Putc(COM1, 0x60);

	int switchIndex = 0;
	int switchNum = 0;

	for(switchIndex = 0; switchIndex < 22; switchIndex++) {
		Printf(COM2, "\033[%d;1H\033[KInitializing......", STATUS_ROW);

		if(switchIndex >= 18) switchNum = switchIndex + 135;
		else switchNum = switchIndex + 1;

		//send command
		Printf(COM1, "%c%c%c", 34, (char) switchNum, 32);

		//print to COM2
		Printf(COM2, "\033[%d;%dHC", SWITCH_ROW + switchIndex, SWITCH_COL);

		if(switchIndex == 22)  {
			Printf(COM2, "\033[%d;1H\033[KInitialization Compelete. Let's go Thomas.", STATUS_ROW);
		}

		//Delay(15);
	}

	Create(17, &timer);
	Create(16, &sensorData);
	Create(17, &trainCommunication);

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

void sensorData(void) {

	int i = 0;
	char all_sensors[80];
	for (i = 0; i < 80; i++) {
		all_sensors[i] = 0;
	}
	int recv_counter = 80;
	int rts[15];
	for(i = 0; i < 15; i++) {
		rts[i] = 0;
	}
	int read_pos = 0;

	for (;;) {
		Delay(1);
		if (recv_counter == 80) {
			Putc(COM1, 0x85);
			recv_counter = 0;
		}	
		char sensor_data = 0;
		sensor_data = Getc(COM1);
		
		for (i = 0; i < 8; i++) {
			char bit = (sensor_data >> i);
			char last_bit_mask = 1;
			bit = (bit & last_bit_mask);
			if (bit == 1 && all_sensors[recv_counter] == 0) {
				all_sensors[recv_counter] = 1;
				if (read_pos == 10) {
					int j = 0;
					for (j = 1; j < 10; j++) {
						rts[j - 1] = rts[j];
					}
					rts[9] = recv_counter;
				}
				else {
					rts[read_pos] = recv_counter;
					read_pos = read_pos + 1; 
				}
				int j = 0;
				for (j = 0; j < read_pos; j++) {
					int num_of_sensor = (rts[j] % 16) + 1;
					if (num_of_sensor <= 8) {
						num_of_sensor = 9 - num_of_sensor;
					}
					else if (num_of_sensor > 8) {
						num_of_sensor = 17 - num_of_sensor + 8;
					}
					Printf(COM2, "\033[%d;%dH   ", SENSOR_ROW + j, SENSOR_COL);
					Printf(COM2, "\033[%d;%dH%c%d", SENSOR_ROW + j, SENSOR_COL, (rts[j] / 16) + 'A', num_of_sensor);
				}
			}
			else if (bit == 0 && all_sensors[recv_counter] == 1) {
				all_sensors[recv_counter] = 0;
			}
			recv_counter = recv_counter + 1;
		}
	}
	Exit();
}	

void trainCommunication(void) {
	char cmd[50];
	int cmd_i = 0;
	for(cmd_i = 0; cmd_i < 50; cmd_i++) {
		cmd[cmd_i] = 0;
	}

	int end = 0;
	int lastSpeed = 0;
	int quit = 0;
	

	//-----------------------
	//read from terminals
	//-----------------------
	for(;;) {
		Delay(1);
		for(;;) {
			char c = Getc(COM2);

			if(c == '\r') {
				cmd[end] = c;
				end++;
				break;
			}

			if(c == 8 && end > 0) {
				end--;
				cmd[end] = 0;
			} else if(c != 8){
				cmd[end] = c;
				end++;
			}

			if(end > 50) {
				Printf(COM2, "\033[%d;1H\033[KCommand too long. Command buffer is cleared.", STATUS_ROW);
				int clear_i = 0;
				for(clear_i = 0; clear_i < 50; clear_i++) {
					cmd[clear_i] = 0;
				}
				end = 0;
			}				

			Printf(COM2, "\033[%d;1H\033[K%s", CMD_ROW, cmd);			
		}

		int cmd_type; // 1 - tr; 2 - rv; 3 - sw; 4 - q; 5 - invalid
		int cmd_arg1;
		int cmd_arg2;

		parse_command(cmd, &cmd_type, &cmd_arg1, &cmd_arg2);

		switch(cmd_type) {
			case 1: //tr
				Printf(COM2, "\033[%d;1H\033[KSet train %d to speed %d", STATUS_ROW, cmd_arg1, cmd_arg2);

				Printf(COM1, "%c%c", cmd_arg2, cmd_arg1);

				lastSpeed = cmd_arg2;			
				break;
			case 2: //rv
				Printf(COM2, "\033[%d;1H\033[KReverse train %d", STATUS_ROW, cmd_arg1);

				//set speed to 0
				
				Putc(COM1, 0); 			//speed
				Putc(COM1, cmd_arg1); 	//train number


				//reverse
				Delay(500);
				Putc(COM1, 15); 			//reverse
				Putc(COM1, cmd_arg1); 	//train number

				//set speed back
				Delay(10);
				Putc(COM1, lastSpeed); 	//speed
				Putc(COM1, cmd_arg1); 	//train number												
				break;	
			case 3: //sw
				Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, cmd_arg1, cmd_arg2);

				if(cmd_arg2 == 'S' || cmd_arg2 == 's') {
					Putc(COM1, 0x21); //straight
				} else if(cmd_arg2 == 'C' || cmd_arg2 == 'c') {
					Putc(COM1, 0x22); //curve
				}
				
				Putc(COM1, cmd_arg1); //switch number

				int row = 0;
				if(cmd_arg1 <= 18) {
					row = cmd_arg1;
				} else {
					row = cmd_arg1 - 134;
				}

				Printf(COM2, "\033[%d;%dH\033[K%c", row + 1, SWITCH_COL, cmd_arg2);

				Delay(15);
				Putc(COM1, 32); //trun off solenoid
				break;
			case 4: //q
				Printf(COM2, "\033[%d;1H\033[KQuit", STATUS_ROW);
				quit = 1;
				break;
			case 5: //invalid
				Printf(COM2, "\033[%d;1H\033[KInvalid Command", STATUS_ROW);
				break;
			case 6: //go
				Printf(COM2, "\033[%d;1H\033[KGo", STATUS_ROW);
				Putc(COM1, 0x60);
				break;
			case 7: //stop
				Printf(COM2, "\033[%d;1H\033[KStop", STATUS_ROW);
				Putc(COM1, 0x61);
				break;
		}

		if(quit) break;

		int clear_i = 0;
		for(clear_i = 0; clear_i < 50; clear_i++) {
			cmd[clear_i] = 0;
		}
		end = 0;
	}

	int idlePct = IdlePct();

	Printf(COM2, "Idle percentage: %d\n\r", idlePct);

	KExit();
}


