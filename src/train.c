#include "train.h"


#define TIMER_PRI 17
#define TRAINCTRL_PRI 16



void init(void) {
	Printf(COM2, "\033[2J");

	Printf(COM2, "\033[%d;%dH", SWITCH_ROW + 0, 10);
	Printf(COM2, "Previous:");

	Printf(COM2, "\033[%d;%dH", SWITCH_ROW + 1, 11);
	Printf(COM2, "Current:");

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
		Printf(COM2, "\033[%d;1H\033[KInitializing...... It will take around 5 seconds", STATUS_ROW);

		if(switchIndex >= 18) switchNum = switchIndex + 135;
		else switchNum = switchIndex + 1;

		//send command
		//if (switchNum == 10 || switchNum == 16) {
			//Printf(COM1, "%c%c%c", 33, (char) switchNum, 32);
			//print to COM2
			//Printf(COM2, "\033[%d;%dHs", SWITCH_ROW + switchIndex, SWITCH_COL);
		//}
		//else {
			Printf(COM1, "%c%c%c", 34, (char) switchNum, 32);
			//print to COM2
			Printf(COM2, "\033[%d;%dHc", SWITCH_ROW + switchIndex, SWITCH_COL);
		//}

		

		//Delay(15);
	}

	Create(TIMER_PRI, &timer);

	Delay(500);
	Printf(COM2, "\033[%d;1H\033[KInitialization Compelete. Let's go Thomas.", STATUS_ROW);

	Create(TRAINCTRL_PRI, &trainController1);

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
		int idle = IdlePct();
		int pct = ((idle / 50) / cur_time);
		int remain = ((idle / 50) % cur_time);
		remain = remain * 100 / cur_time;
		Printf(COM2, "\033[%d;1H\033[K%d.%d", IDLE_ROW, pct, remain);

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
			Printf(COM2, "\033[1;1H\033[K%d:%d.%d", min, sec, ms / 100 );
		}
	}

	Exit();
}

void sensorData(void) {
	int CoordinatorId = WhoIs("Coordinator");
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

	char bit = 0;
	char last_bit_mask = 0;
	int j = 0;
	char sensor_data_array[10];
	char sensor_data = 0;
	int num_of_sensor = 0;

	/*
	char sc1 = 'E';
	int sn1 = 6;
	char sc2 = 'B';
	int sn2 = 16;
	int time1 = 0;
	int time2 = 0;
	*/

	for (;;) {
//		if (recv_counter == 80) {
			//Delay(3);
			Printf(COM1, "%c", 192);
			Printf(COM1, "%c", 0x85);
			recv_counter = 0;
			//cur_time = Time();
//		}	

		int s_i = 0;
		for (s_i = 0; s_i < 10; s_i++) {
			sensor_data_array[s_i] = Getc(COM1);
		}
		
		for (s_i = 0; s_i < 10; s_i++) {
			sensor_data = sensor_data_array[s_i];
			for (i = 0; i < 8; i++) {
				bit = (sensor_data >> i);
				last_bit_mask = 1;
				bit = (bit & last_bit_mask);
				if (bit == 1 && all_sensors[recv_counter] == 0) {

					int n = (recv_counter % 16) + 1;
					if (n <= 8) {
						n = 9 - n;
					}
					else if (n > 8) {
						n = 17 - n + 8;
					}
					char c = (recv_counter / 16) + 'A';

					trainReq req;
					req.src = 's';
					req.schar = c;
					req.sint = n;
					char r;

					Send(CoordinatorId, &req, sizeof(trainReq), &r, sizeof(char));

					/*
					if (c == sc1 && n == sn1) time1 = Time();
					if (c == sc2 && n == sn2) {
						time2 = Time();
						Printf(COM2, "\033[%d;%dH%d", STATUS_ROW + 3, STATUS_COL, time2 - time1);
					}
					*/

					all_sensors[recv_counter] = 1;
					if (read_pos == 2) {
						
						rts[0] = rts[1];
						rts[1] = recv_counter;
					}
					else {
						rts[read_pos] = recv_counter;
						read_pos = read_pos + 1;
					}
					for (j = 0; j < read_pos; j++) {
						num_of_sensor = (rts[j] % 16) + 1;
						if (num_of_sensor <= 8) {
							num_of_sensor = 9 - num_of_sensor;
						}
						else if (num_of_sensor > 8) {
							num_of_sensor = 17 - num_of_sensor + 8;
						}
						//Printf(COM2, "\033[%d;%dH   ", SENSOR_ROW + j, SENSOR_COL);
						if (num_of_sensor >= 10) {
							Printf(COM2, "\033[%d;%dH%c%d", SENSOR_ROW + j, SENSOR_COL, (rts[j] / 16) + 'A', num_of_sensor);
						}
						else {
							Printf(COM2, "\033[%d;%dH%c0%d", SENSOR_ROW + j, SENSOR_COL, (rts[j] / 16) + 'A', num_of_sensor);
						}
					}
				}
				else if (bit == 0 && all_sensors[recv_counter] == 1) {
					all_sensors[recv_counter] = 0;
				}
				recv_counter = recv_counter + 1;
			}
		}
	}
	Exit();
}	

void trainCommunication(void) {
	int CoordinatorId = WhoIs("Coordinator");
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

		//Delay(1);
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
		char ssr_char;
		int ssr_int;

		parse_command(cmd, &cmd_type, &cmd_arg1, &cmd_arg2, &ssr_char, &ssr_int);

		trainReq req;
		char r;

		switch(cmd_type) {
			case 1: //tr
				Printf(COM2, "\033[%d;1H\033[KSet train %d to speed %d", STATUS_ROW, cmd_arg1, cmd_arg2);
				req.src = 't';
				req.type = 1;
				req.arg1 = cmd_arg2;
				if (cmd_arg1 == 63) {
					req.train_num = 0;
				}
				else if (cmd_arg1 == 68) {
					req.train_num = 1;
				}
				Send(CoordinatorId, &req, sizeof(trainReq), &r, sizeof(char));

				Printf(COM1, "%c%c", cmd_arg2, cmd_arg1);

				lastSpeed = cmd_arg2;			
				break;
			case 2: //rv
				Printf(COM2, "\033[%d;1H\033[KReverse train %d", STATUS_ROW, cmd_arg1);

				//set speed to 0
				Printf(COM1, "%c%c", 0, cmd_arg1);
				Delay(500);

				//reverse
				Printf(COM1, "%c%c", 15, cmd_arg1);

				//set speed back
				Delay(10);
				Printf(COM1, "%c%c", lastSpeed, cmd_arg1);											
				break;	
			case 3: //sw
				Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, cmd_arg1, cmd_arg2);

				if(cmd_arg2 == 'S' || cmd_arg2 == 's') {
					Printf(COM1, "%c%c", 0x21, cmd_arg1);
					req.arg2 = 's';
				} else if(cmd_arg2 == 'C' || cmd_arg2 == 'c') {
					Printf(COM1, "%c%c", 0x22, cmd_arg1);
					req.arg2 = 'c';
				}

				Printf(COM1, "%c", 32); //trun off solenoid

				req.src = 't';
				req.type = 3;
				req.arg1 = cmd_arg1;				
				Send(CoordinatorId, &req, sizeof(trainReq), &r, sizeof(char));
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
				Printf(COM1, "%c", 0x60);
				break;
			case 7: //stop
				Printf(COM2, "\033[%d;1H\033[KStop", STATUS_ROW);
				Printf(COM1, "%c", 0x61);
				break;
			case 8: //sp (sensor) (distance past sensor)
				Printf(COM2, "\033[%d;1H\033[KStop train at %d mm ahead sensor %c%d", STATUS_ROW, cmd_arg2, ssr_char, ssr_int);
				req.src = 't';
				req.type = 8;
				req.arg2 = cmd_arg2;
				req.schar = ssr_char;
				req.sint = ssr_int;

				Send(CoordinatorId, &req, sizeof(trainReq), &r, sizeof(char));
				break;
			case 9: //gt (sensor number) (train number)
				Printf(COM2, "\033[%d;1H\033[KLet train %d go to sensor %c%d", STATUS_ROW, cmd_arg2, ssr_char, ssr_int);
				req.src = 't';
				req.type = 9;
				req.train_num = cmd_arg2;
				req.schar = ssr_char;
				req.sint = ssr_int;

				Send(CoordinatorId, &req, sizeof(trainReq), &r, sizeof(char));
				break;	

		}
		Printf(COM2, "\033[%d;1H\033[K", CMD_ROW);

		if(quit) break;

		int clear_i = 0;
		for(clear_i = 0; clear_i < 50; clear_i++) {
			cmd[clear_i] = 0;
		}
		end = 0;
	}

	Printf(COM2, "\033[2J");

	Delay(1);

	KExit();
}




