#include "coordinator.h"



#define TRAINCTRL_PRI 18
#define TIME_DISPLAY_PRI 17
#define LOC_DISPLAY_PRI 16
#define SENSOR_PRI 14
#define TRAIN_COM_PRI 15

#define TRAIN_MAX 2

#define TRAIN_NUM1 63
#define TRAIN_NUM2 58

#define DEBUG 1

typedef struct train_location_display_request {
    int type; // 0 for timer, 1 for Coordinator
    int train_num;
    char schar;
    int sint;
    int velocity_10;
    int stop_distance;
}t_loc_req;


void trainController(void) {
    int display_id = WhoIs("LocationDisplay");
    int recv_id = 0;

    t_req req;
    for (;;) {
        Receive(&recv_id, &req, sizeof(t_req));
        char c;
        Reply(recv_id, &c, sizeof(char));
        switch (req.type) {
            case 0:     // sp
                ;
                int train_num = 0;
                if (req.arg1 == 0) {
                    train_num = TRAIN_NUM1; 
                }
                if (req.arg1 == 1) {
                    train_num = TRAIN_NUM2;
                }
                Delay(req.delayTime);
                Printf(COM1, "%c%c", 0, train_num);
                Printf(COM2, "\033[%d;1H\033[KSet train %d to speed 0", STATUS_ROW, train_num);
                t_loc_req dis_req;
                dis_req.type = 2;
                dis_req.velocity_10 = 0;
                dis_req.stop_distance = 850;
                dis_req.train_num = req.arg1;
                char r;
                Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                break;
            case 1:     // sw
                Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", TRAINCTRL_ROW, req.arg1, req.arg2);
                if(req.arg2 == 'S' || req.arg2 == 's') {
                    Printf(COM1, "%c%c", 0x21, req.arg1);
                    req.arg2 = 's';
                } else if(req.arg2 == 'C' || req.arg2 == 'c') {
                    Printf(COM1, "%c%c", 0x22, req.arg1);
                    req.arg2 = 'c';
                }

                Printf(COM1, "%c", 32); //trun off solenoid
                break;
            case 2:     // rv
                ;
                if (req.arg1 == 0) {
                    train_num = TRAIN_NUM1; 
                }
                if (req.arg1 == 1) {
                    train_num = TRAIN_NUM2;
                }
                Printf(COM2, "\033[%d;1H\033[KReverse train %d", STATUS_ROW, train_num);
                //set speed to 0
                Printf(COM1, "%c%c", 0, train_num);
                Delay(500);

                //reverse
                Printf(COM1, "%c%c", 15, train_num);

                //set speed back
                Delay(50);
                Printf(COM1, "%c%c", req.arg2, train_num);
                Printf(COM2, "\033[%d;1H\033[KReaccelerate train %d to speed %d", STATUS_ROW, train_num, req.arg2);           
                break;
            case 3:     // tr
                ;
                train_num = 0;
                if (req.arg1 == 0) {
                    train_num = TRAIN_NUM1; 
                }
                if (req.arg1 == 1) {
                    train_num = TRAIN_NUM2;
                }
                
                Printf(COM2, "\033[%d;1H\033[KSet train %d to speed %d", STATUS_ROW, train_num, req.arg2);
                Printf(COM1, "%c%c", req.arg2, train_num);
                dis_req.type = 3;
                dis_req.velocity_10 = 20;
                dis_req.train_num = req.arg1; 
                Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));

        }
    }
}

void train_location_display_timer(void) {
    int display_id = MyParentTid();
    t_loc_req req;
    req.type = 0;
    char c;
    for (;;) {
        Delay(15);
        Send(display_id, &req, sizeof(t_loc_req), &c, sizeof(char));
    }
}

void train_location_display(void) {
    RegisterAs("LocationDisplay");
    Create(TIME_DISPLAY_PRI, train_location_display_timer);
    int recv_id = 0;
    t_loc_req req;
    char cur_schar[TRAIN_MAX];
    int cur_sint[TRAIN_MAX];
    int cur_time[TRAIN_MAX];
    int cur_velocity_10[TRAIN_MAX];

    int stop[TRAIN_MAX];
    int stop_distance[TRAIN_MAX];

    int init_i = 0;
    for (init_i = 0; init_i < TRAIN_MAX; init_i++) {
        cur_schar[init_i] = 0;
        cur_sint[init_i] = 0;
        cur_time[init_i] = 0;
        cur_velocity_10[init_i] = 0;
        stop[init_i] = 0;
        stop_distance[init_i] = 0;
    }

    int cur_train_num = 0;

    Printf(COM2, "\033[%d;0H\033[KCurrent Position of the train1: ", LOCATION_ROW);
    Printf(COM2, "\033[%d;0H\033[KCurrent Position of the train2: ", LOCATION_ROW + 1);

    char r;

    for(;;) {
        Receive(&recv_id, &req, sizeof(t_loc_req));
        Reply(recv_id, &r, sizeof(char));
        switch (req.type) {
            case 0: // Timer
                ;
                int p_i = 0;
                for (p_i = 0; p_i < TRAIN_MAX; p_i++) {
                    int temp_time = Time();
                    int mm_int = cur_velocity_10[p_i] * (temp_time - cur_time[p_i]) / 10;
                    int mm_dec = cur_velocity_10[p_i] * (temp_time - cur_time[p_i]) % 10;
                    if (stop[p_i] == 1) {
                        stop_distance[p_i] -= (cur_velocity_10[p_i] * 
                                            (temp_time - cur_time[p_i]));
                        if (stop_distance[p_i] <= 0) {
                            cur_velocity_10[p_i] = 0;
                        }
                    }
                    Printf(COM2, "\033[%d;%dH\033[K%c%d+%d.%d", 
                        LOCATION_ROW + p_i, LOCATION_COL, 
                        cur_schar[p_i], cur_sint[p_i], mm_int, mm_dec);
                }
                break;
            case 1: // Coordinator sensor
                cur_train_num = req.train_num;
                cur_schar[cur_train_num] = req.schar;
                cur_sint[cur_train_num] = req.sint;
                cur_time[cur_train_num] = Time();
                if (stop[cur_train_num] != 1) {
                    cur_velocity_10[cur_train_num] = req.velocity_10;
                }
                break;
            case 2: // Coordinator speed to 0
                cur_train_num = req.train_num;
                stop[cur_train_num] = 1;
                stop_distance[cur_train_num] = req.stop_distance;
                cur_velocity_10[cur_train_num] = req.velocity_10;
                break;
            case 3: // Coordinator speed up
                cur_train_num = req.train_num;
                stop[cur_train_num] = 0;
                cur_velocity_10[cur_train_num] = 20;
                break;
        }
    }
}

void Coordinator(void) {
    int trainCtrl_id[2];
    trainCtrl_id[0] = Create(TRAINCTRL_PRI, &trainController);
    trainCtrl_id[1] = Create(TRAINCTRL_PRI, &trainController);
    RegisterAs("Coordinator");

    int display_id = Create(LOC_DISPLAY_PRI, &train_location_display);
    
    track_node track[TRACK_MAX];
    init_tracka(track);

    int track_i = 0;
    for (track_i = 0; track_i < TRACK_MAX; track_i++) {
        if(track[track_i].type == NODE_EXIT) {
            track[track_i].ownedBy = 99;
        }
    }

    char switchPos[22];
    int s_i;
    for(s_i = 0; s_i < 22; s_i++) {
        switchPos[s_i] = 'c';
    }

    int cur_train_num = 0;

    int stop_distance1[15];
    stop_distance1[0] = 0;
    stop_distance1[1] = 0;
    stop_distance1[2] = 0;
    stop_distance1[3] = 0;
    stop_distance1[4] = 0;
    stop_distance1[5] = 0;
    stop_distance1[6] = 0;
    stop_distance1[7] = 0;
    stop_distance1[8] = 465;
    stop_distance1[9] = 535;
    stop_distance1[10] = 611;
    stop_distance1[11] = 708;
    stop_distance1[12] = 750;
    stop_distance1[13] = 850;
    stop_distance1[14] = 870;
    int cur_record_velocity[TRAIN_MAX];

    char prv_schar[TRAIN_MAX];
    int prv_sint[TRAIN_MAX];
    int cur_schar[TRAIN_MAX];
    int cur_sint[TRAIN_MAX];
    int cur_snum[TRAIN_MAX];



    Create(SENSOR_PRI, &sensorData);
    Create(TRAIN_COM_PRI, &trainCommunication);

    int sensorTriggerTime[TRAIN_MAX];
    int sensorTiggerElapsedTime[TRAIN_MAX];

    int prev_time[TRAIN_MAX];
    int cur_velocity_10[TRAIN_MAX];
    track_node* prev_node[TRAIN_MAX];
    track_node* cur_node[TRAIN_MAX];

    // stop at sensor snum
    int sp[2];
    int des_snum[4];
    int des_dist[2];

    int expected_time[TRAIN_MAX];

    // Reserve
    track_node** reserve[TRAIN_MAX];
    track_node* reserve1[20];
    track_node* reserve2[20];
    reserve[0] = reserve1;
    reserve[1] = reserve2;
    int rsv_count[TRAIN_MAX];
    int train_stuck[TRAIN_MAX];

    // swith path
    switchPath spT1[22];
    switchPath spT2[22];
    int spT1_index = 0;
    int spT2_index = 0;    

    // Sensor attribution
    int reversing[TRAIN_MAX];

    int init_i = 0;
    for (init_i = 0; init_i < TRAIN_MAX; init_i++) {
        cur_record_velocity[init_i] = 0;
        prv_schar[init_i] = 0;
        prv_sint[init_i] = 0;
        cur_schar[init_i] = 0;
        cur_sint[init_i] = 0;
        cur_snum[init_i] = 0;
        sensorTriggerTime[init_i] = 0;
        sensorTiggerElapsedTime[init_i] = 0;
        prev_time[init_i] = 0;
        cur_velocity_10[init_i] = 0;
        prev_node[init_i] = 0;
        cur_node[init_i] = 0;
        expected_time[init_i] = 0;
        rsv_count[init_i] = 0;
        train_stuck[init_i] = 0;
        reversing[init_i] = 0;
    }

    Printf(COM2, "\033[%d;%dHReserved by A: ", PATH_ROW + 1, PATH_COL);
    Printf(COM2, "\033[%d;%dHReserved by B: ", PATH_ROW + 1, PATH_COL + 20);

    for(;;) {

        int rcv_id;
        trainReq req;
        char r = 'a';
        Receive(&rcv_id, &req, sizeof(trainReq));

        
        switch(req.src) {
            case 's':
                Reply(rcv_id, &r, sizeof(char));


                char tmp_schar = req.schar;
                int tmp_sint = req.sint;
                int tmp_snum = (tmp_schar - 'A') * 16 + tmp_sint - 1;
                track_node* tmp_node = find_track_node(track, tmp_snum);
                int interval_distance = 0;

                

                // train TRAIN_NUM1 is not registered
                if (cur_node[0] == 0) {
                    cur_train_num = 0;
                }
                // next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[0]) == tmp_node && 
                         find_nxt_sensor(switchPos, cur_node[0])->ownedBy == TRAIN_NUM1 &&
                         reversing[0] == 0) { 
                    cur_train_num = 0;
                }
                // next next sensor as expected
                else if (find_nxt_sensor(switchPos, find_nxt_sensor(switchPos, cur_node[0])) == tmp_node &&
                         find_nxt_sensor(switchPos, find_nxt_sensor(switchPos, cur_node[0]))->ownedBy == TRAIN_NUM1 &&
                         reversing[0] == 0) { 
                    cur_train_num = 0;
                }
                // self-reverse sensor as expected
                else if (cur_node[0]->reverse == tmp_node && reversing[0] == 1 &&
                         cur_node[0]->reverse->ownedBy == TRAIN_NUM1) {
                    cur_train_num = 0;
                    reversing[0] = 0;
                }
                // reverse and next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[0]->reverse) == tmp_node && reversing[0] == 1 &&
                         find_nxt_sensor(switchPos, cur_node[0]->reverse)->ownedBy == TRAIN_NUM1) {
                    cur_train_num = 0;
                    reversing[0] = 0;
                }
                // Merge and reverse as expected
                /*else if (find_nxt_sensor(switchPos, 
                                         find_nxt_merge(switchPos, cur_node[0])->reverse)) {
                    cur_train_num = 0;
                }*/
                // train TRAIN_NUM2 is not registered
                else if (cur_node[1] == 0) {
                    cur_train_num = 1;
                }
                // next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[1]) == tmp_node && reversing[1] == 0) {
                    cur_train_num = 1;
                }
                // next next sensor as expected
                else if (find_nxt_sensor(switchPos, find_nxt_sensor(switchPos, cur_node[1])) == tmp_node &&
                         reversing[1] == 0) { 
                    cur_train_num = 1;
                }
                // self-reverse sensor as expected
                else if (cur_node[1]->reverse == tmp_node && reversing[1] == 1) {
                    cur_train_num = 1;
                    reversing[1] = 0;
                }
                // reverse and next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[1]->reverse) == tmp_node && reversing[1] == 1) {
                    cur_train_num = 1;
                    reversing[1] = 0;
                }
                // Merge and reverse as expected
                /*else if (find_nxt_sensor(switchPos, 
                                         find_nxt_merge(switchPos, cur_node[1])->reverse)) {
                    cur_train_num = 1;
                }*/
                else {
                    Printf(COM2, "\033[%d;%dH\033[KSensor discarded", PATH_ROW, PATH_COL);
                    break;
                }
                

                prv_schar[cur_train_num] = cur_schar[cur_train_num];
                prv_sint[cur_train_num] = cur_sint[cur_train_num];
                cur_schar[cur_train_num] = req.schar;
                cur_sint[cur_train_num] = req.sint;
                
                prev_time[cur_train_num] = sensorTriggerTime[cur_train_num];
                sensorTriggerTime[cur_train_num] = Time();
                
                if(expected_time[cur_train_num] != 0) {
                    Printf(COM2, "\033[%d;%dH\033[KSensor %c%d, tick diff %d", 
                        TRAIN_TIME_ROW, TRAIN_TIME_COL, prv_schar[cur_train_num], 
                        prv_sint[cur_train_num], sensorTriggerTime[cur_train_num] - expected_time[cur_train_num]);                    
                } else {
                    Printf(COM2, "\033[%d;%dH\033[KCalculation error: expected time = 0", 
                        TRAIN_TIME_ROW, TRAIN_TIME_COL);
                }
                

                prev_node[cur_train_num] = cur_node[cur_train_num];
                cur_snum[cur_train_num] = (cur_schar[cur_train_num] - 'A') * 16 + cur_sint[cur_train_num] - 1;

                // Update current node for train cur_train_num
                cur_node[cur_train_num] = tmp_node;
                
                //Printf(COM2, "\033[%d;%dH\033[KNext sensor: %s", PATH_ROW, PATH_COL, find_nxt_sensor(switchPos, cur_node[cur_train_num])->name);


                // Reserve track nodes
                int i_r = 0;
                for (i_r = 0; i_r < TRAIN_MAX; i_r++) {
                    if (cur_node[i_r] == 0) {
                        continue;
                    }
                    int i = 0;
                    track_node** tmp = reserve[i_r];
                    for (i = 0; i < rsv_count[i_r]; i++) {
                        (tmp[i])->ownedBy = 0;
                        (tmp[i])->reverse->ownedBy = 0;
                        Printf(COM2, "\033[%d;%dH     ", PATH_ROW + 2 + i, 
                                                         PATH_COL + 20 * (i_r));
                    }
                    rsv_count[i_r] = 0;
                    int reserve_distance = 1200;
                    track_node* reserve_node = cur_node[i_r];
                    while (reserve_distance > 0 && reserve_node->type != NODE_EXIT) {
                        int reserve_train_num = 0;
                        if (i_r == 0) {
                            reserve_train_num = TRAIN_NUM1;
                        }
                        else if (i_r == 1) {
                            reserve_train_num = TRAIN_NUM2;
                        }
                        if (reserve_node->ownedBy != 0 && reserve_node->ownedBy != reserve_train_num) { // Stop since node is reserved by the other train
                            if (reserve_node->ownedBy == 99) {
                                t_req train_req;
                                train_req.type = 2;
                                train_req.arg2 = cur_record_velocity[i_r];
                                train_req.arg1 = i_r;
                                char reply_c;
                                Send(trainCtrl_id[i_r], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                reversing[i_r] = 1;
                                train_stuck[i_r] = 0;
                            }
                            else {
                                t_req train_req;
                                train_req.type = 0;
                                train_req.delayTime = 0;
                                train_req.arg1 = i_r;
                                char reply_c;
                                Send(trainCtrl_id[i_r], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                train_stuck[i_r] = 1;
                            }
                            
                            if (train_stuck[0] == 1 && train_stuck[1] == 1) {
                                t_req train_req;
                                train_req.type = 2;
                                train_req.arg2 = cur_record_velocity[1];
                                train_req.arg1 = 1;
                                char reply_c;
                                Send(trainCtrl_id[1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                train_stuck[1] = 0;
                                reversing[1] = 1;
                            }
                            break;
                        }
                        // Reserve the track node
                        reserve_node->ownedBy = reserve_train_num;
                        reserve_node->reverse->ownedBy = reserve_train_num;
                        
                        Printf(COM2, "\033[%d;%dH%s", PATH_ROW + 2 + rsv_count[i_r], 
                                                      PATH_COL + 20 * (i_r), reserve_node->name);
                        tmp[rsv_count[i_r]] = reserve_node;
                        rsv_count[i_r]++;

                        switch (reserve_node->type) {
                            case NODE_ENTER:
                                reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                break;
                            case NODE_SENSOR:
                                reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                break;
                            case NODE_MERGE:
                                reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                break;
                            case NODE_BRANCH:
                                ;
                                int sw_num = reserve_node->num;

                                int index = -1;

                                if(sw_num <= 18) {
                                    index = sw_num - 1;
                                } else {
                                    index = sw_num - 135;
                                }

                                char pos = switchPos[index];

                                // change switch if needed
                                if(reserve_train_num == TRAIN_NUM1) {
                                    for(i = 0; i < spT1_index; i++) {
                                        if(sw_num == spT1[i].num && pos != spT1[i].state) {
                                            // set switch
                                            Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, spT1[i].num, spT1[i].state);
                                            if(spT1[i].state == 'S' || spT1[i].state == 's') {
                                                Printf(COM1, "%c%c", 0x21, spT1[i].num);
                                                switchPos[index] = 's';
                                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 's');
                                            } else if(spT1[i].state == 'C' || spT1[i].state == 'c') {
                                                Printf(COM1, "%c%c", 0x22, spT1[i].num);
                                                switchPos[index] = 'c';
                                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 'c');
                                            }

                                            Printf(COM1, "%c", 32); //trun off solenoid                                             
                                        }
                                    }
                                } else if(reserve_train_num == TRAIN_NUM2) {
                                    for(i = 0; i < spT2_index; i++) {
                                        if(sw_num == spT2[i].num && pos != spT2[i].state) {
                                            // set switch
                                            Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, spT2[i].num, spT2[i].state);
                                            if(spT2[i].state == 'S' || spT2[i].state == 's') {
                                                Printf(COM1, "%c%c", 0x21, spT2[i].num);
                                                switchPos[index] = 's';
                                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 's');
                                            } else if(spT2[i].state == 'C' || spT2[i].state == 'c') {
                                                Printf(COM1, "%c%c", 0x22, spT2[i].num);
                                                switchPos[index] = 'c';
                                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 'c');
                                            }

                                            Printf(COM1, "%c", 32); //trun off solenoid                                             
                                        }
                                    }
                                }

                                pos = switchPos[index];
                                //Printf(COM2, "\033[%d;%dH %d, %d, %c", i, TRACE_COL, sw_num, index, pos);
                                switch(pos) {
                                case 's':
                                    reserve_distance -= reserve_node->edge[DIR_STRAIGHT].dist;
                                    reserve_node = reserve_node->edge[DIR_STRAIGHT].dest;
                                    break;
                                case 'c':
                                    reserve_distance -= reserve_node->edge[DIR_CURVED].dist;
                                    reserve_node = reserve_node->edge[DIR_CURVED].dest;
                                    break;
                                }     
                                break;
                            
                        }
                    }

                    if (reserve_distance <= 0 && train_stuck[i_r] == 1) {
                        t_req train_req;
                        train_req.type = 3;
                        train_req.arg1 = i_r;
                        train_req.arg2 = cur_record_velocity[i_r];
                        char reply_c;
                        Send(trainCtrl_id[i_r], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                        train_stuck[i_r] = 0;
                    }
                }
                //track_node* tmp_node = 0;

                //cur_node[cur_train_num] = tmp_node;

                interval_distance = findPathDist(switchPos, prev_node[cur_train_num], cur_node[cur_train_num]->num);

                if(cur_node[cur_train_num] > 0) {
                    
                    if (prev_node[cur_train_num] != 0 && interval_distance != 0) {
                        // update current velocity
                        cur_velocity_10[cur_train_num] = interval_distance * 10 / 
                                                        (sensorTriggerTime[cur_train_num] - prev_time[cur_train_num]);
                        
                        //Printf(COM2, "\033[%d;%dH\033[Kcur speed %d, time %d, distance %d", 
                            //SPEED_ROW, SPEED_COL, cur_velocity_10[cur_train_num], 
                            //sensorTriggerTime[cur_train_num] - prev_time[cur_train_num], interval_distance);

                        // expected prv time
                        int next_dist = find_dist_to_next_sensor(switchPos, cur_node[cur_train_num]);

                        if(next_dist != 0) {
                            expected_time[cur_train_num] = sensorTriggerTime[cur_train_num] + 
                                                            (next_dist * 10) / cur_velocity_10[cur_train_num];
                        } else {
                            expected_time[cur_train_num] = 0;                      
                        }
                                          
                    }

                    t_loc_req dis_req;
                    dis_req.type = 1;
                    dis_req.schar = cur_schar[cur_train_num];
                    dis_req.sint = cur_sint[cur_train_num];
                    dis_req.velocity_10 = cur_velocity_10[cur_train_num];
                    dis_req.train_num = cur_train_num;
                    Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));

                    if(sp[cur_train_num]) {
                        int distance = findPathDist(switchPos, cur_node[cur_train_num], des_snum[cur_train_num * 2]);
                        int distance_rev = findPathDist(switchPos, cur_node[cur_train_num], des_snum[cur_train_num * 2 + 1]);
                        if(distance < (stop_distance1[cur_record_velocity[cur_train_num]]) * 2 && distance > stop_distance1[cur_record_velocity[cur_train_num]]) {
                            sp[cur_train_num] = 0;

                            int delayTime = ((distance + des_dist[cur_train_num] - stop_distance1[cur_record_velocity[cur_train_num]]) * 10) / 
                                             cur_velocity_10[cur_train_num];

                            sensorTiggerElapsedTime[cur_train_num] = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.arg1 = cur_train_num;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime[cur_train_num] + 
                                                    sensorTriggerTime[cur_train_num];
                            char reply_c;
                            Send(trainCtrl_id[cur_train_num], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            
                           // Printf(COM2, "\033[%d;%dH\033[KCoordinator: sp sent at dist %d", STATUS_ROW + 9, STATUS_COL, distance);
                        } else if (distance_rev < (stop_distance1[cur_record_velocity[cur_train_num]]) * 2 && distance_rev > stop_distance1[cur_record_velocity[cur_train_num]]) {
                            sp[cur_train_num] = 0;

                            int delayTime = ((distance_rev + des_dist[cur_train_num] - stop_distance1[cur_record_velocity[cur_train_num]]) * 10) / 
                                             cur_velocity_10[cur_train_num];

                            sensorTiggerElapsedTime[cur_train_num] = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.arg1 = cur_train_num;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime[cur_train_num] + 
                                                    sensorTriggerTime[cur_train_num];
                            char reply_c;
                            Send(trainCtrl_id[cur_train_num], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                                      
                        }
                    }
                } else {
                    Printf(COM2, "\033[%d;%dH\033[KNode not found", SPEED_ROW, SPEED_COL);
                }

                break;
            case 't':
                switch(req.type) {
                    case 1: // TR
                        ;
                        t_req train_req;
                        if (req.arg1 == 0) {
                            train_req.type = 0;
                            train_req.delayTime = 0;
                            if (req.train_num == TRAIN_NUM1) {
                                train_req.arg1 = 0;
                            }
                            else if (req.train_num == TRAIN_NUM2) {
                                train_req.arg1 = 1;
                            }
                            
                            char reply_c;
                            Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                        }
                        else {
                            train_req.type = 3;
                            train_req.arg2 = req.arg1;
                            if (req.train_num == TRAIN_NUM1) {
                                train_req.arg1 = 0;
                            }
                            else if (req.train_num == TRAIN_NUM2) {
                                train_req.arg1 = 1;
                            }
                            
                            char reply_c;
                            Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                        }
                        cur_record_velocity[train_req.arg1] = req.arg1;
                        Reply(rcv_id, &r, sizeof(char));
                        
                        break;
                    case 2: // RV
                        ;
                        train_req.type = 2;
                        if (req.train_num == TRAIN_NUM1) {
                            train_req.arg1 = 0;
                        }
                        else if (req.train_num == TRAIN_NUM2) {
                            train_req.arg1 = 1;
                        }
                        train_req.arg2 = cur_record_velocity[train_req.arg1];
                        Reply(rcv_id, &r, sizeof(char));
                        char reply_c;
                        Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                        reversing[train_req.arg1] = 1;

                        // Reserve the track
                        int i = 0;
                        track_node** tmp = reserve[train_req.arg1];
                        for (i = 0; i < rsv_count[train_req.arg1]; i++) {
                            (tmp[i])->ownedBy = 0;
                            (tmp[i])->reverse->ownedBy = 0;
                            Printf(COM2, "\033[%d;%dH     ", PATH_ROW + 2 + i, 
                                                             PATH_COL + 20 * (train_req.arg1));
                        }
                        rsv_count[train_req.arg1] = 0;
                        int reserve_distance = 1200;
                        track_node* reserve_node = cur_node[train_req.arg1]->reverse;
                        while (reserve_distance > 0 && reserve_node->type != NODE_EXIT) {
                            int reserve_train_num = 0;
                            if (train_req.arg1 == 0) {
                                reserve_train_num = TRAIN_NUM1;
                            }
                            else if (train_req.arg1 == 1) {
                                reserve_train_num = TRAIN_NUM2;
                            }
                            if (reserve_node->ownedBy != 0 && reserve_node->ownedBy != reserve_train_num) { // Stop since node is reserved by the other train
                                t_req train_req;
                                train_req.type = 0;
                                train_req.delayTime = 0;
                                train_req.arg1 = train_req.arg1;
                                char reply_c;
                                Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                train_stuck[train_req.arg1] = 1;
                                if (train_stuck[0] == 1 && train_stuck[1] == 1) {
                                    train_req.type = 2;
                                    train_req.arg2 = cur_record_velocity[1];
                                    train_req.arg1 = 1;
                                    char reply_c;
                                    Send(trainCtrl_id[1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                    train_stuck[1] = 0;
                                    reversing[1] = 1;
                                }
                                break;
                            }
                            // Reserve the track node
                            reserve_node->ownedBy = reserve_train_num;
                            reserve_node->reverse->ownedBy = reserve_train_num;
                            
                            Printf(COM2, "\033[%d;%dH%s", PATH_ROW + 2 + rsv_count[train_req.arg1], 
                                                          PATH_COL + 20 * (train_req.arg1), reserve_node->name);
                            tmp[rsv_count[train_req.arg1]] = reserve_node;
                            rsv_count[train_req.arg1]++;

                            switch (reserve_node->type) {
                                case NODE_ENTER:
                                    reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                    reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                    break;
                                case NODE_SENSOR:
                                    reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                    reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                    break;
                                case NODE_MERGE:
                                    reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                    reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                    break;
                                case NODE_BRANCH:
                                    ;
                                    int sw_num = reserve_node->num;
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
                                        reserve_distance -= reserve_node->edge[DIR_STRAIGHT].dist;
                                        reserve_node = reserve_node->edge[DIR_STRAIGHT].dest;
                                        break;
                                    case 'c':
                                        reserve_distance -= reserve_node->edge[DIR_CURVED].dist;
                                        reserve_node = reserve_node->edge[DIR_CURVED].dest;
                                        break;
                                    }     
                                    break;
                                
                            }
                        }

                        if (reserve_distance <= 0 && train_stuck[train_req.arg1] == 1) {
                            t_req train_req;
                            train_req.type = 3;
                            train_req.arg1 = train_req.arg1;
                            train_req.arg2 = cur_record_velocity[train_req.arg1];
                            char reply_c;
                            Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            train_stuck[train_req.arg1] = 0;
                        }

                        break;
                    case 3: // SW
                        ;
                        int index = -1;
                        if(req.arg1 <= 18) {
                            index = req.arg1 - 1;
                        } else {
                            index = req.arg1 - 135;
                        }

                        Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, req.arg2);
                        Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, req.arg1, req.arg2);
                        
                        if(req.arg2 == 's') {
                            Printf(COM1, "%c%c", 0x21, req.arg1);
                            switchPos[index] = 's';
                        } else if(req.arg2 == 'c') {
                            Printf(COM1, "%c%c", 0x22, req.arg1);
                            switchPos[index] = 'c';
                        }
                        Printf(COM1, "%c", 32); //trun off solenoid

                        Reply(rcv_id, &r, sizeof(char));
                        break;
                    case 8: //SP
                        ;
                        track_node* src_node = cur_node[cur_train_num];

                        int snum = (req.schar - 'A') * 16 + req.sint - 1;

                        int distance = findPathDist(switchPos, src_node, snum);
                        //Printf(COM2, "\033[%d;%dH\033[KCoordinator: %s-->%c%d, distance: %d", STATUS_ROW + 5, STATUS_COL, src_node->name, req.schar, req.sint, distance + req.arg2);

                        if(distance == -1) {
                            //Printf(COM2, "\033[%d;%dH\033[Kdistance = -1", STATUS_ROW + 6, STATUS_COL);
                        } else if(distance < stop_distance1[cur_record_velocity[cur_train_num]]) {
                            //src_node = cur_node;
                            track_node* new_src_node = find_track_node(track, snum);

                            int al_distance = new_src_node->edge[DIR_AHEAD].dist;
                            new_src_node = new_src_node->edge[DIR_AHEAD].dest;
                            al_distance += findPathDist(switchPos, new_src_node, snum) + distance;
                            if(al_distance < 1500) {
                                int delayTime = ((al_distance + req.arg2 - stop_distance1[cur_record_velocity[cur_train_num]]) * 10) / 
                                                cur_velocity_10[cur_train_num];

                                sensorTiggerElapsedTime[cur_train_num] = Time();
                                t_req train_req;
                                train_req.type = 0;
                                train_req.delayTime = delayTime - sensorTiggerElapsedTime[cur_train_num] + 
                                                        sensorTriggerTime[cur_train_num];
                                char reply_c;
                                Send(trainCtrl_id[0], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                //Printf(COM2, "\033[%d;%dH\033[KsensorTriggerTime: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, sensorTriggerTime, sensorTiggerElapsedTime);                                
                            } else {
                                sp[cur_train_num] = 1;
                                des_snum[cur_train_num] = snum;
                                des_dist[cur_train_num] = req.arg2;                              
                            }                     

                        } else if(distance < 1500) {
                            int delayTime = ((distance + req.arg2 - stop_distance1[cur_record_velocity[cur_train_num]]) * 10) / 
                                            cur_velocity_10[cur_train_num];

                            sensorTiggerElapsedTime[cur_train_num] = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime[cur_train_num] + 
                                                    sensorTriggerTime[cur_train_num];
                            char reply_c;
                            Send(trainCtrl_id[0], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            
                            //Printf(COM2, "\033[%d;%dH\033[Ktime1: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, time1, sensorTiggerElapsedTime);
                        } else {
                            sp[cur_train_num] = 1;
                            des_snum[cur_train_num] = snum;
                            des_dist[cur_train_num] = req.arg2;
                        }

                        Reply(rcv_id, &r, sizeof(char));
                        break;

                    case 9:
                        ;

                        int trainNum = req.train_num;
                        if(trainNum == TRAIN_NUM1) {
                            cur_train_num = 0;
                        } else if(trainNum == TRAIN_NUM2) {
                            cur_train_num = 1;
                        }
                        src_node = 0;

                        

                        src_node = cur_node[cur_train_num];
                        int des = (req.schar - 'A') * 16 + req.sint - 1;
                        track_node *des_node = find_track_node(track, des);

                        Printf(COM2, "\033[%d;1H\033[Kfind path from %s to %s", COORD_ROW, src_node->name, des_node->name);

                        int dist[140];
                        int prev[140];

                        int ret = 0;

                        if(trainNum == TRAIN_NUM1) {
                            for(i = 0; i < 22; i++) {
                                spT1[i].num = 0;
                                spT1[i].state = 'a';
                            }
                            spT1_index = 0;
                        } else if(trainNum == TRAIN_NUM2) {
                            for(i = 0; i < 22; i++) {
                                spT2[i].num = 0;
                                spT2[i].state = 'a';
                            }
                            spT2_index = 0;
                        }                        

                        // case 1,  src: +
                        switchPath sp1[22];
                        int sp1_index = 0;
                        int distance1 = 0;

                        ret = Dijkstra(trainNum, track, src_node, dist, prev, des_node);
                        if(ret) {
                            distance1 = getSwitchPath(track, sp1, &sp1_index, dist, prev, des_node);
                        } else {
                            distance1 = 999999999;
                        }
  
                        // case 2,  src: -
                        switchPath sp2[22];
                        int sp2_index = 0;
                        int distance2 = 0;

                        ret = Dijkstra(trainNum, track, src_node->reverse, dist, prev, des_node);
                        if(ret) {
                            distance2 = getSwitchPath(track, sp2, &sp2_index, dist, prev, des_node);
                        } else {
                            distance2 = 999999999;
                        }

                        if(distance1 < distance2 && distance1 > (stop_distance1[cur_record_velocity[cur_train_num]]) * 2) {
                            
                            for(i = 0; i < sp1_index; i++) {
                                // copy to spT
                                if(trainNum == TRAIN_NUM1) {
                                    spT1[i].num = sp1[i].num;
                                    spT1[i].state = sp1[i].state;
                                    spT1_index++;
                                } else if(trainNum == TRAIN_NUM2) {
                                    spT2[i].num = sp1[i].num;
                                    spT2[i].state = sp1[i].state;
                                    spT2_index++;
                                }

                                Printf(COM2, "\033[%d;%dH%d, %c", PATH_ROW + 2 + i, PATH_COL + 29, sp1[i].num, sp1[i].state);


                                /*
                                // reverse after merge
                                if(sp1[sp1_index].reverse) {
                                    t_req train_req;
                                    train_req.type = 2;
                                    train_req.arg1 = trainNum;
                                    if(trainNum == TRAIN_NUM1) {
                                        train_req.arg2 = cur_record_velocity[0];
                                    } else {
                                        train_req.arg2 = cur_record_velocity[1];
                                    }
                                    

                                    char reply_c;
                                    Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));                                    
                                }
                                */
                                /*
                                // set switch
                                index = -1;
                                if(sp1[i].num <= 18) {
                                    index = sp1[i].num - 1;
                                } else {
                                    index = sp1[i].num - 135;
                                }

                                if(sp1[i].state != switchPos[index]) {
                                    
                                    Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", TRAINCTRL_ROW, sp1[i].num, sp1[i].state);
                                    if(sp1[i].state == 'S' || sp1[i].state == 's') {
                                        Printf(COM1, "%c%c", 0x21, sp1[i].num);
                                        sp1[i].state = 's';
                                    } else if(sp1[i].state == 'C' || sp1[i].state == 'c') {
                                        Printf(COM1, "%c%c", 0x22, sp1[i].num);
                                        sp1[i].state = 'c';
                                    }

                                    if(sp1[i].state == 's') {
                                        switchPos[index] = 's';
                                    } else if(sp1[i].state == 'c') {
                                        switchPos[index] = 'c';
                                    }

                                    Printf(COM1, "%c", 32); //trun off solenoid                                    
                                }
                                */
                            }
                            // Accelerate the train
                            train_req.type = 3;
                            train_req.arg2 = cur_record_velocity[cur_train_num];
                            train_req.arg1 = cur_train_num;
                            
                            Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            // Accelerate the train done
                        } else {

                              


                            // Reserve the track
                            int i = 0;
                            track_node** tmp = reserve[cur_train_num];
                            for (i = 0; i < rsv_count[cur_train_num]; i++) {
                                (tmp[i])->ownedBy = 0;
                                (tmp[i])->reverse->ownedBy = 0;
                                Printf(COM2, "\033[%d;%dH     ", PATH_ROW + 2 + i, 
                                                                 PATH_COL + 20 * (cur_train_num));
                            }
                            rsv_count[cur_train_num] = 0;
                            int reserve_distance = 1200;
                            track_node* reserve_node = cur_node[cur_train_num]->reverse;
                            while (reserve_distance > 0 && reserve_node->type != NODE_EXIT) {
                                int reserve_train_num = 0;
                                if (cur_train_num == 0) {
                                    reserve_train_num = TRAIN_NUM1;
                                }
                                else if (cur_train_num == 1) {
                                    reserve_train_num = TRAIN_NUM2;
                                }
                                if (reserve_node->ownedBy != 0 && reserve_node->ownedBy != reserve_train_num) { // Stop since node is reserved by the other train
                                    if (reserve_node->ownedBy == 99) {
                                        train_req.type = 2;
                                        train_req.arg2 = cur_record_velocity[cur_train_num];
                                        train_req.arg1 = cur_train_num;
                                        char reply_c;
                                        Send(trainCtrl_id[cur_train_num], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                        reversing[cur_train_num] = 1;
                                        train_stuck[cur_train_num] = 0;
                                    }
                                    else {
                                        t_req train_req;
                                        train_req.type = 0;
                                        train_req.delayTime = 0;
                                        train_req.arg1 = cur_train_num;
                                        char reply_c;
                                        Send(trainCtrl_id[cur_train_num], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                        train_stuck[cur_train_num] = 1;
                                    }
                                    if (train_stuck[0] == 1 && train_stuck[1] == 1) {
                                        train_req.type = 2;
                                        train_req.arg2 = cur_record_velocity[1];
                                        train_req.arg1 = 1;
                                        char reply_c;
                                        Send(trainCtrl_id[1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                        train_stuck[1] = 0;
                                        reversing[1] = 1;
                                    }
                                    break;
                                }
                                // Reserve the track node
                                reserve_node->ownedBy = reserve_train_num;
                                reserve_node->reverse->ownedBy = reserve_train_num;
                                
                                Printf(COM2, "\033[%d;%dH%s", PATH_ROW + 2 + rsv_count[cur_train_num], 
                                                              PATH_COL + 20 * (cur_train_num), reserve_node->name);
                                tmp[rsv_count[cur_train_num]] = reserve_node;
                                rsv_count[cur_train_num]++;

                                switch (reserve_node->type) {
                                    case NODE_ENTER:
                                        reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                        reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                        break;
                                    case NODE_SENSOR:
                                        reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                        reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                        break;
                                    case NODE_MERGE:
                                        reserve_distance -= reserve_node->edge[DIR_AHEAD].dist;
                                        reserve_node = reserve_node->edge[DIR_AHEAD].dest;
                                        break;
                                    case NODE_BRANCH:
                                        ;
                                        int sw_num = reserve_node->num;
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
                                            reserve_distance -= reserve_node->edge[DIR_STRAIGHT].dist;
                                            reserve_node = reserve_node->edge[DIR_STRAIGHT].dest;
                                            break;
                                        case 'c':
                                            reserve_distance -= reserve_node->edge[DIR_CURVED].dist;
                                            reserve_node = reserve_node->edge[DIR_CURVED].dest;
                                            break;
                                        }     
                                        break;
                                    
                                }
                            }

                            if (reserve_distance <= 0 && train_stuck[cur_train_num] == 1) {
                                t_req train_req;
                                train_req.type = 3;
                                train_req.arg1 = cur_train_num;
                                train_req.arg2 = cur_record_velocity[cur_train_num];
                                char reply_c;
                                Send(trainCtrl_id[cur_train_num], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                train_stuck[cur_train_num] = 0;
                            }

                            
                            for(i = 0; i < sp2_index; i++) {
                                // copy to spT
                                if(trainNum == TRAIN_NUM1) {
                                    spT1[i].num = sp2[i].num;
                                    spT1[i].state = sp2[i].state;
                                    spT1_index++;
                                } else if(trainNum == TRAIN_NUM2) {
                                    spT2[i].num = sp2[i].num;
                                    spT2[i].state = sp2[i].state;
                                    spT2_index++;
                                }

                                Printf(COM2, "\033[%d;%dH%d, %c", PATH_ROW + 2, PATH_COL + 29, sp2[i].num, sp2[i].state);



                                /*
                                // reverse after merge
                                if(sp2[sp2_index].reverse) {
                                    t_req train_req;
                                    train_req.type = 2;
                                    train_req.arg1 = trainNum;
                                    if(trainNum == TRAIN_NUM1) {
                                        train_req.arg2 = cur_record_velocity[0];
                                    } else {
                                        train_req.arg2 = cur_record_velocity[1];
                                    }
                                    
                                    char reply_c;
                                    Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));                                    
                                }
                                */

                                //change switch if needed
                                /*
                                index = -1;
                                if(sp2[i].num <= 18) {
                                    index = sp2[i].num - 1;
                                } else {
                                    index = sp2[i].num - 135;
                                }

                                
                                if(sp2[i].state != switchPos[index]) {
                                    // set switch
                                    Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", TRAINCTRL_ROW, sp2[i].num, sp2[i].state);
                                    if(sp2[i].state == 'S' || sp2[i].state == 's') {
                                        Printf(COM1, "%c%c", 0x21, sp2[i].num);
                                        sp2[i].state = 's';
                                    } else if(sp2[i].state == 'C' || sp2[i].state == 'c') {
                                        Printf(COM1, "%c%c", 0x22, sp2[i].num);
                                        sp2[i].state = 'c';
                                    }

                                    if(sp2[i].state == 's') {
                                        switchPos[index] = 's';
                                    } else if(sp2[i].state == 'c') {
                                        switchPos[index] = 'c';
                                    }

                                    Printf(COM1, "%c", 32); //trun off solenoid                                    
                                }
                                */
                            }
                            //reverse the train
                            t_req train_req;
                            train_req.type = 2;
                            if(trainNum == TRAIN_NUM1) {
                                train_req.arg1 = 0;
                                train_req.arg2 = cur_record_velocity[0];
                            } else {
                                train_req.arg1 = 1;
                                train_req.arg2 = cur_record_velocity[1];
                            }
                            
                            char reply_c;
                            Send(trainCtrl_id[train_req.arg1], &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            reversing[train_req.arg1] = 1;  
                        }
                        int des_rev = (des_node->reverse)->num;
                        sp[cur_train_num] = 1;
                        des_snum[cur_train_num * 2] = des;
                        des_snum[cur_train_num * 2 + 1] = des_rev;
                        des_dist[cur_train_num] = 0;                 

                        Reply(rcv_id, &r, sizeof(char));
                        break;                       
                }
                break;
        }
    }
}



void randomDest(void) {
    int rcv_id = 0;
    for (;;) {
        int trainNum = 0;
        Receive(&rcv_id, &trainNum, sizeof(int));
        Reply(rcv_id, &trainNum, sizeof(int));

        int t = Time();
        
        trainReq req;
        char r;
        req.src = 't';
        req.type = 9;
        req.train_num = trainNum;
        req.schar = 'A' + t % 4;
        req.sint = 1 + (t / 4) % 15;

        Send(rcv_id, &req, sizeof(trainReq), &r, sizeof(char));                    
    }
}
