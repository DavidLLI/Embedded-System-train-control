#include "train.h"
#include "coordinator.h"
#include "syscall.h"
#include "command.h"
#include "track_node.h"
#include "track_data.h"

/*
int findPathDist(char *switchPos, track_node *src_node, char des_char, int des_int) {
    int distance = 0;
    int des_snum = (des_char - 'A') * 16 + des_int - 1;

    int i = 0;
    for(;;) {
        i++;
        //Printf(COM2, "\033[%d;1H%s", 35 + i, src_node->name);
       	//Delay(10);
        switch(src_node->type) {
            case NODE_SENSOR:
                if(des_snum == src_node->num) {
                    return distance;
                } else {
                    distance += src_node->edge[DIR_AHEAD].dist;
                    src_node = src_node->edge[DIR_AHEAD].dest;
                }
                break;
            case NODE_BRANCH:
                ;
                int sw_num = src_node->num;
                int index = -1;

                if(sw_num <= 18) {
                    index = sw_num - 1;
                } else {
                    index = sw_num - 135;
                }

                char pos = switchPos[index];

				//Printf(COM2, "\033[%d;%dH %d, %d, %c", i, TRACE_COL, sw_num, index, pos);
                switch(pos) {
                case 's':
                    distance += src_node->edge[DIR_STRAIGHT].dist;
                    src_node = src_node->edge[DIR_STRAIGHT].dest;
                    break;
                case 'c':
                    distance += src_node->edge[DIR_CURVED].dist;
                    src_node = src_node->edge[DIR_CURVED].dest;
                    break;
                }     
                break;
            case NODE_MERGE:
                distance += src_node->edge[DIR_AHEAD].dist;
                src_node = src_node->edge[DIR_AHEAD].dest;
                break;
        }
        
        if(i >= TRACK_MAX) {
            Printf(COM2, "\033[%d;%dH fint path dist exceed max, i = %d", 35, STATUS_COL + 5, i);
            break;
        }
    }
    return -1;
}

typedef struct Train_Request {
	char type;
	int delayTime;
}t_req;

void trainController(void) {
	int recv_id = 0;
	t_req train_req;
	for (;;) {
		Receive(&recv_id, &train_req, sizeof(t_req));
		char c;
		Reply(recv_id, &c, sizeof(char));
		switch (train_req.type) {
			case 0:
				Delay(train_req.delayTime);
				Printf(COM1, "%c%c", 0, 63);
		}

	}
}

track_node* find_track_node(track_node* node_list, char schar, int sint) {
	int snum = (schar - 'A') * 16 + sint - 1;
	int t_i = 0;
	track_node* ret;
	for(t_i = 0;t_i < TRACK_MAX; t_i++) {
	    if(node_list[t_i].type == NODE_SENSOR) {
	        if(node_list[t_i].num == snum) {
	            ret = &(node_list[t_i]);
	            break;
	        }                       
	    }
	}
	return ret;
}

track_node* find_nxt_node(track_node* track, char *switchPos, track_node* src_node, int des_snum, int *interval_distance) {
	int distance = 0;
	track_node* nxt_node = 0;

	if(src_node == 0) {
		int t_i = 0;
		for(t_i = 0;t_i < TRACK_MAX; t_i++) {
		    if(track[t_i].type == NODE_SENSOR) {
		        if(track[t_i].num == des_snum) {
		            nxt_node = &(track[t_i]);
		            *interval_distance = 0;
		            return nxt_node;
		        }                       
		    }
		}		
	} else {
		int i = 0;
	    for(;;) {
	        i++;
	        //Printf(COM2, "\033[%d;1H%s", 35 + i, src_node->name);
	       	//Delay(10);
	        switch(src_node->type) {
	            case NODE_SENSOR:
	                if(des_snum == src_node->num) {
	                	*interval_distance = distance;
	                    return src_node;
	                } else {
	                    distance += src_node->edge[DIR_AHEAD].dist;
	                    src_node = src_node->edge[DIR_AHEAD].dest;
	                }
	                break;
	            case NODE_BRANCH:
	                ;
	                int sw_num = src_node->num;
	                int index = -1;

	                if(sw_num <= 18) {
	                    index = sw_num - 1;
	                } else {
	                    index = sw_num - 135;
	                }

	                char pos = switchPos[index];

					//Printf(COM2, "\033[%d;%dH %d, %d, %c", i, TRACE_COL, sw_num, index, pos);
	                switch(pos) {
	                case 's':
	                    distance += src_node->edge[DIR_STRAIGHT].dist;
	                    src_node = src_node->edge[DIR_STRAIGHT].dest;
	                    break;
	                case 'c':
	                    distance += src_node->edge[DIR_CURVED].dist;
	                    src_node = src_node->edge[DIR_CURVED].dest;
	                    break;
	                }     
	                break;
	            case NODE_MERGE:
	                distance += src_node->edge[DIR_AHEAD].dist;
	                src_node = src_node->edge[DIR_AHEAD].dest;
	                break;
	        }
	        
	        if(i >= TRACK_MAX) {
	            Printf(COM2, "\033[%d;%dH find nxt node exceed max, i = %d", 35, STATUS_COL + 5, i);
	            break;
	        }
	    }
	    *interval_distance = -1;
	    return 0;
	}

	
}

void handleSP(void) {
	RegisterAs("handleSP");
	
	track_node track[TRACK_MAX];
	init_trackb(track);

	char switchPos[22];
	int s_i;
	for(s_i = 0; s_i < 22; s_i++) {
		switchPos[s_i] = 'c';
	}

	//track_node *cur_node = 0;
	int cur_schar = 'a';
	int cur_sint = 0;

	Create(17, &sensorData);
	Create(18, &trainCommunication);
	int train1_id = Create(12, &trainController);

	//int stop = 0;
	//int sp_char = 'a';
	//int sp_int = 0;

	int time1 = 0;
	int time2 = 0;

	int prev_time = 0;
	int cur_velocity_int = 0;
	int cur_velocity_dec = 0;
	int cur_velocity_10 = 65;
	track_node* prev_node = 0;
	track_node* cur_node = 0;

	int total_data_count = 1;
	int total_velocity = 65;

	for(;;) {

		//if(stop && sp_char == cur_schar && sp_int == cur_sint) {
		//	Printf(COM1, "%c%c", 0, 63);
		//	stop = 0;
		//}

		int rcv_id;
		trainReq req;
		char r = 'a';
		Receive(&rcv_id, &req, sizeof(trainReq));
		

		switch(req.src) {
			case 's':
				prev_time = time1;
				time1 = Time();
				Reply(rcv_id, &r, sizeof(char));
				
				prev_node = cur_node;
				int cur_snum = (req.schar - 'A') * 16 + req.sint - 1;

				int interval_distance = 0;

				cur_node = find_nxt_node(track, switchPos, prev_node, cur_snum, &interval_distance);
				if (prev_node != 0 && interval_distance != 0) {
					cur_velocity_int = interval_distance / (time1 - prev_time);
					cur_velocity_dec = interval_distance % (time1 - prev_time);
					cur_velocity_dec = cur_velocity_dec * 10 / (time1 - prev_time);
					cur_velocity_10 = cur_velocity_int * 10 + cur_velocity_dec;
					total_velocity += cur_velocity_10;
					total_data_count++;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~				
					//cur_velocity_10 /= total_data_count;
					cur_velocity_10 = total_velocity/total_data_count;
					Printf(COM2, "\033[%d;%dH\033[Kcur speed %d", STATUS_ROW + 9, STATUS_COL, cur_velocity_10);

				}
				
				
				
				//if(cur_node != 0) {
				//	updateCurNode(track, cur_node, schar, sint);
				//} else {
				//	char shiwei = '0' + sint / 10;
				//	char gewei = '0' + sint % 10;
				//
				//	int i = 0;
				//	for(i = 0;i < TRACK_MAX; i++) {
				//		if(track[i].type == NODE_SENSOR) {
				//			if(nameEqual(track[i].name, schar, sint)) {
				//				cur_node = track[i];
				//				break;
				//			}						
				//		}
				//	}
				//}
				
				break;
			case 't':
				switch(req.type) {
					case 3:
						;
						int index = -1;
						if(req.arg1 <= 18) {
							index = req.arg1 - 1;
						} else {
							index = req.arg1 - 135;
						}

						//switchPos[index] = req.arg2;

						Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, req.arg2);

						if(req.arg2 == 's') {
							switchPos[index] = 's';
						} else if(req.arg2 == 'c') {
							switchPos[index] = 'c';
						} else {
							Printf(COM2, "\033[%d;%dH\033[Kerror pos: %c", index + 2, SWITCH_COL, req.arg2);
						}

						Reply(rcv_id, &r, sizeof(char));
						break;
					case 8:
						;
						track_node* src_node = 0;
						//src_node = find_track_node(track, cur_schar, cur_sint);

						int distance = findPathDist(switchPos, cur_node, req.schar, req.sint);
						//Printf(COM2, "\033[35;1HSource node name: %s", src_node->name);
						Printf(COM2, "\033[%d;%dH\033[K%s-->%c%d, distance: %d", STATUS_ROW + 5, STATUS_COL, src_node->name, req.schar, req.sint, distance + req.arg2);

						if(distance == -1) {
							Printf(COM2, "\033[%d;%dH\033[Kdistance = -1", STATUS_ROW + 6, STATUS_COL);
						} else if(distance < 850){
							src_node = find_track_node(track, req.schar, req.sint);
							int al_distance = src_node->edge[DIR_AHEAD].dist;
							src_node = src_node->edge[DIR_AHEAD].dest;
							al_distance += findPathDist(switchPos, src_node, req.schar, req.sint) + distance;							
							int delayTime = ((al_distance + req.arg2 - 850) * 10) / 65;

							time2 = Time();
							t_req train_req;
							train_req.type = 0;
							train_req.delayTime = delayTime - time2 + time1;
							char reply_c;
							//Send(train1_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
							Delay(train_req.delayTime);
							//Printf(COM1, "%c%c", 0, 63);
							Printf(COM2, "\033[%d;%dH\033[Ktime1: %d, time2: %d", STATUS_ROW + 6, STATUS_COL, time1, time2);
						} else {
							int delayTime = ((distance + req.arg2 - 850) * 10) / 65;

							time2 = Time();
							t_req train_req;
							train_req.type = 0;
							train_req.delayTime = delayTime - time2 + time1;
							char reply_c;
							//Send(train1_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
							Delay(train_req.delayTime);
							//Printf(COM1, "%c%c", 0, 63);
							Printf(COM2, "\033[%d;%dH\033[Ktime1: %d, time2: %d", STATUS_ROW + 6, STATUS_COL, time1, time2);
							
						}


						
						//sp_char = req.schar;
						//sp_int = req.sint;
						//stop = 1;
						
						Reply(rcv_id, &r, sizeof(char));
						break;
				}
				break;
		}
	}
}
*/

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

	Create(17, &timer);

	Delay(500);
	Printf(COM2, "\033[%d;1H\033[KInitialization Compelete. Let's go Thomas.", STATUS_ROW);

	Create(16, &trainController);

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
		Printf(COM2, "\033[%d;1H\033[K%d.%d", CMD_ROW + 3, pct, remain);

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
	int handleSPID = WhoIs("Coordinator");
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
		//Delay(3);
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

					Send(handleSPID, &req, sizeof(trainReq), &r, sizeof(char));

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
	int handleSPID = WhoIs("Coordinator");
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
				Send(handleSPID, &req, sizeof(trainReq), &r, sizeof(char));

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

				//Delay(15);
				Printf(COM1, "%c", 32); //trun off solenoid

				req.src = 't';
				req.type = 3;
				req.arg1 = cmd_arg1;				
				Send(handleSPID, &req, sizeof(trainReq), &r, sizeof(char));
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

				Send(handleSPID, &req, sizeof(trainReq), &r, sizeof(char));
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

	KExit();
}




