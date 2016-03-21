#include "coordinator.h"



#define COORDINATOR_PRI 10
#define TIME_DISPLAY_PRI 17
#define LOC_DISPLAY_PRI 18
#define SENSOR_PRI 14
#define TRAIN_COM_PRI 15

#define TRAIN_MAX 2

#define DEBUG 1



void trainController1(void) {
    RegisterAs("trainController");
    Create(COORDINATOR_PRI, &Coordinator);
    int recv_id = 0;
    t_req req;
    for (;;) {
        Receive(&recv_id, &req, sizeof(t_req));
        char c;
        Reply(recv_id, &c, sizeof(char));
        switch (req.type) {
            case 0:
                Delay(req.delayTime);
                Printf(COM1, "%c%c", 0, 63);
                break;
            case 1:
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
            case 2:
                Printf(COM2, "\033[%d;1H\033[KReverse train %d", TRAINCTRL_ROW, req.arg1);
                //set speed to 0
                Printf(COM1, "%c%c", 0, req.arg1);
                Delay(500);

                //reverse
                Printf(COM1, "%c%c", 15, req.arg1);

                //set speed back
                Delay(10);
                Printf(COM1, "%c%c", req.arg2, req.arg1);            
                break;

        }
    }
}

typedef struct train_location_display_request {
    int type; // 0 for timer, 1 for Coordinator
    int train_num;
    char schar;
    int sint;
    int velocity_10;
    int stop_distance;
}t_loc_req;

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
    int trainCtrl_id1 = WhoIs("trainController");
    RegisterAs("Coordinator");

    int display_id = Create(LOC_DISPLAY_PRI, &train_location_display);
    
    track_node track[TRACK_MAX];
    init_trackb(track);

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
    int sp = 0;
    int des_snum = 0;
    int des_dist = 0;

    int expected_time[TRAIN_MAX];

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
    }


    for(;;) {

        int rcv_id;
        trainReq req;
        char r = 'a';
        Receive(&rcv_id, &req, sizeof(trainReq));
        
        switch(req.src) {
            case 's':
                ;

                char tmp_schar = req.schar;
                int tmp_sint = req.sint;
                int tmp_snum = (tmp_schar - 'A') * 16 + tmp_sint - 1;
                track_node* tmp_node = find_track_node(track, tmp_snum);
                int interval_distance = 0;

                // train 63 is not registered
                if (cur_node[0] == 0) {
                    cur_node[0] = tmp_node;
                    cur_train_num = 0;
                }
                // next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[0]) == tmp_node) { 
                    cur_train_num = 0;
                }
                // self-reverse sensor as expected
                else if (cur_node[0]->reverse == tmp_node) {
                    cur_train_num = 0;
                }
                // reverse and next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[0]->reverse) == tmp_node) {
                    cur_train_num = 0;
                }
                // Merge and reverse as expected
                else if (find_nxt_sensor(switchPos, 
                                         find_nxt_merge(switchPos, cur_node[0])->reverse)) {
                    cur_train_num = 0;
                }
                // train 68 is not registered
                else if (cur_node[1] == 0) {
                    cur_node[1] = tmp_node;
                    cur_train_num = 1;
                }
                // next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[1]) == tmp_node) { 
                    cur_train_num = 1;
                }
                // self-reverse sensor as expected
                else if (cur_node[1]->reverse == tmp_node) {
                    cur_train_num = 1;
                }
                // reverse and next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[1]->reverse) == tmp_node) {
                    cur_train_num = 1;
                }
                // Merge and reverse as expected
                else if (find_nxt_sensor(switchPos, 
                                         find_nxt_merge(switchPos, cur_node[1])->reverse)) {
                    cur_train_num = 1;
                }
                else {
                    break;
                }

                prv_schar[cur_train_num] = cur_schar[cur_train_num];
                prv_sint[cur_train_num] = cur_sint[cur_train_num];
                cur_schar[cur_train_num] = req.schar;
                cur_sint[cur_train_num] = req.sint;
                
                prev_time[cur_train_num] = sensorTriggerTime[cur_train_num];
                sensorTriggerTime[cur_train_num] = Time();
                Reply(rcv_id, &r, sizeof(char));
                
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

                
                //track_node* tmp_node = 0;

                cur_node[cur_train_num] = find_nxt_node(track, switchPos, 
                                                        prev_node[cur_train_num], cur_snum[cur_train_num], 
                                                        &interval_distance);

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

                    if(sp) {
                        int distance = findPathDist(switchPos, cur_node[cur_train_num], des_snum);
                        if(distance < 1500 && distance > stop_distance1[cur_record_velocity[cur_train_num]]) {
                            sp = 0;

                            int delayTime = ((distance + des_dist - stop_distance1[cur_record_velocity[cur_train_num]]) * 10) / 
                                             cur_velocity_10[cur_train_num];

                            sensorTiggerElapsedTime[cur_train_num] = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime[cur_train_num] + 
                                                    sensorTriggerTime[cur_train_num];
                            char reply_c;
                            Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            
                            dis_req.type = 2;
                            dis_req.velocity_10 = cur_velocity_10[cur_train_num];
                            dis_req.stop_distance = distance;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                           // Printf(COM2, "\033[%d;%dH\033[KCoordinator: sp sent at dist %d", STATUS_ROW + 9, STATUS_COL, distance);
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
                        if (req.arg1 == 0) {
                            t_loc_req dis_req;
                            dis_req.type = 2;
                            dis_req.velocity_10 = cur_velocity_10[cur_train_num] / 2;
                            dis_req.stop_distance = stop_distance1[cur_record_velocity[cur_train_num]];
                            dis_req.train_num = req.train_num;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                        }
                        else {
                            t_loc_req dis_req;
                            dis_req.type = 3;
                            dis_req.velocity_10 = cur_velocity_10[cur_train_num];
                            dis_req.train_num = req.train_num;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                        }
                        cur_record_velocity[req.train_num] = req.arg1;
                        Reply(rcv_id, &r, sizeof(char));
                        
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

                        if(req.arg2 == 's') {
                            switchPos[index] = 's';
                        } else if(req.arg2 == 'c') {
                            switchPos[index] = 'c';
                        }

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
                                Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                //Printf(COM2, "\033[%d;%dH\033[KsensorTriggerTime: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, sensorTriggerTime, sensorTiggerElapsedTime);                                
                            } else {
                                sp = 1;
                                des_snum = snum;
                                des_dist = req.arg2;                                
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
                            Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            t_loc_req dis_req;
                            dis_req.type = 2;
                            dis_req.velocity_10 = cur_velocity_10[cur_train_num];
                            dis_req.stop_distance = distance;
                            dis_req.train_num = cur_train_num;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                            //Printf(COM2, "\033[%d;%dH\033[Ktime1: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, time1, sensorTiggerElapsedTime);
                        } else {
                            sp = 1;
                            des_snum = snum;
                            des_dist = req.arg2;
                        }

                        Reply(rcv_id, &r, sizeof(char));
                        break;
                    case 9:
                        ;
                        int trainNum = req.train_num;
                        src_node = 0;

                        if(trainNum == 63) {
                            src_node = cur_node[0];
                        } else if(trainNum == 68) {
                            src_node = cur_node[1];
                        }

                        int des = (req.schar - 'A') * 16 + req.sint - 1;
                        track_node *des_node = find_track_node(track, des);

                        Printf(COM2, "\033[%d;1H\033[Kfind path from %s to %s", COORD_ROW, src_node->name, des_node->name);

                        int dist[140];
                        int prev[140];

                        int ret = 0;

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

                        if(distance1 < distance2) {
                            int i;
                            for(i = 0; i < sp1_index; i++) {
                                Printf(COM2, "\033[%d;%dH\033[K%d, %c", 5+i, PATH_COL, sp1[i].num, sp1[i].state);

                                /*
                                // reverse after merge
                                if(sp1[sp1_index].reverse) {
                                    t_req train_req;
                                    train_req.type = 2;
                                    train_req.arg1 = trainNum;
                                    if(trainNum == 63) {
                                        train_req.arg2 = cur_record_velocity[0];
                                    } else {
                                        train_req.arg2 = cur_record_velocity[1];
                                    }
                                    

                                    char reply_c;
                                    Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));                                    
                                }
                                */

                                index = -1;
                                if(sp1[i].num <= 18) {
                                    index = sp1[i].num - 1;
                                } else {
                                    index = sp1[i].num - 135;
                                }

                                if(sp1[i].state != switchPos[index]) {
                                    // set switch
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
                            }
                        } else {

                            int speed = 0;
                            if(trainNum == 63) {
                                speed = cur_record_velocity[0];
                            } else {
                                speed = cur_record_velocity[1];
                            }

                            Printf(COM2, "\033[%d;1H\033[KReverse train %d", TRAINCTRL_ROW, trainNum);
                            //set speed to 0
                            Printf(COM1, "%c%c", 0, trainNum);
                            Delay(500);

                            //reverse
                            Printf(COM1, "%c%c", 15, trainNum);

                            //set speed back
                            Delay(10);
                            Printf(COM1, "%c%c", speed, trainNum);                            
                            
                            int i;
                            for(i = 0; i < sp2_index; i++) {
                                /*
                                // reverse after merge
                                if(sp2[sp2_index].reverse) {
                                    t_req train_req;
                                    train_req.type = 2;
                                    train_req.arg1 = trainNum;
                                    if(trainNum == 63) {
                                        train_req.arg2 = cur_record_velocity[0];
                                    } else {
                                        train_req.arg2 = cur_record_velocity[1];
                                    }
                                    
                                    char reply_c;
                                    Send(trainCtrl_id1, &train_req, sizeof(t_req), &reply_c, sizeof(char));                                    
                                }
                                */
                                
                                index = -1;
                                if(sp2[i].num <= 18) {
                                    index = sp2[i].num - 1;
                                } else {
                                    index = sp2[i].num - 135;
                                }

                                //change switch if needed
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
                            }
                        }

                        sp = 1;
                        des_snum = des;
                        des_dist = 0;                  

                        Reply(rcv_id, &r, sizeof(char));
                        break;                        
                }
                break;
        }
    }
}

