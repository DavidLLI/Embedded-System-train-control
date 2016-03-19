#include "coordinator.h"
#include "train.h"
#include "syscall.h"
#include "command.h"
#include "track_node.h"
#include "track_data.h"

#define COORDINATOR_PRI 20
#define TIME_DISPLAY_PRI 17
#define LOC_DISPLAY_PRI 18
#define SENSOR_PRI 14
#define TRAIN_COM_PRI 15


int findPath(int train_num, char *switchPos, track_node *src_node, int des_snum) {
    int switchCode = -1;

    if(src_node->ownedBy != train_num && src_node->ownedBy != 0) {
        return -1;
    }

    switch(src_node->type) {
        case NODE_SENSOR:
            if(des_snum == src_node->num) {
                return 0;
            } else if (train_num == src_node->ownedBy) {
                int ret = findPath(train_num, switchPos, src_node->edge[DIR_AHEAD], des_snum);
                if(ret != -1) switchCode = 0 + ret * 10;
            }
        case NODE_BRANCH:
            int retS = findPath(train_num, switchPos, src_node->edge[DIR_STRAIGHT], des_snum);
            int retC = findPath(train_num, switchPos, src_node->edge[DIR_STRAIGHT], des_snum);

            int sw_num = src_node->num;
            int index = -1;

            if(sw_num <= 18) {
                index = sw_num - 1;
            } else {
                index = sw_num - 135;
            }

            char pos = switchPos[index];

            if(pos == 's' && retS != -1) {
                switchCode += retS * 10;
            } else if
    }
}



int findPathDist(char *switchPos, track_node *src_node, int des_snum) {
    int distance = 0;

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
            //Printf(COM2, "\033[%d;%dH fint path dist exceed max, i = %d", 35, STATUS_COL + 5, i);
            break;
        }
    }
    return -1;
}

track_node* find_nxt_node(track_node* track, char *switchPos, track_node* src_node, int des_snum, int *interval_distance) {
    int distance = 0;
    track_node* nxt_node = 0;

    if(src_node == 0) {
        int t_i = 0;
        for(t_i = 0;t_i < TRACK_MAX; t_i++) {
            if(track[t_i].type == NODE_SENSOR && track[t_i].num == des_snum) {
                nxt_node = &(track[t_i]);
                *interval_distance = 0;
                return nxt_node;                      
            }
        }
        return 0;
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
                //Printf(COM2, "\033[%d;%dH find nxt node exceed max, dest is %d", STATUS_ROW, STATUS_COL + 5, des_snum);
                break;
            }
        }
        *interval_distance = -1;
        return 0;
    }
}

int find_dist_to_next_sensor(char *switchPos, track_node* src_node) {
    int distance = src_node->edge[DIR_AHEAD].dist;
    src_node = src_node->edge[DIR_AHEAD].dest;
    int i = 0;
    for(;;) {
        i++;
        switch(src_node->type) {
            case NODE_SENSOR:
                return distance;
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
        
        if(i >= 20) {
            return -1;
        }
    }
}

track_node* find_track_node(track_node* node_list, char schar, int sint) {
    int snum = (schar - 'A') * 16 + sint - 1;
    int t_i = 0;
    track_node* ret = 0;
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

void trainController(void) {
    RegisterAs("trainController");
    Create(COORDINATOR_PRI, &Coordinator);
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
                //Printf(COM2, "\033[%d;%dH\033[KtrainController: command sent", STATUS_ROW + 10, STATUS_COL);
        }
    }
}

typedef struct train_location_display_request {
    int type; // 0 for timer, 1 for Coordinator
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
    char cur_schar = 0;
    int cur_sint = 0;
    int cur_time = 0;
    int cur_velocity_10 = 0;

    int stop = 0;
    int stop_distance = 0;

    Printf(COM2, "\033[%d;0H\033[KCurrent Position of the train: ", LOCATION_ROW);

    char r;

    for(;;) {
        Receive(&recv_id, &req, sizeof(t_loc_req));
        Reply(recv_id, &r, sizeof(char));
        switch (req.type) {
            case 0: // Timer
                ;
                int temp_time = Time();
                int mm_int = cur_velocity_10 * (temp_time - cur_time) / 10;
                int mm_dec = cur_velocity_10 * (temp_time - cur_time) % 10;
                if (stop == 1) {
                    stop_distance -= (cur_velocity_10 * (temp_time - cur_time));
                    if (stop_distance <= 0) {
                        cur_velocity_10 = 0;
                    }
                }
                Printf(COM2, "\033[%d;%dH\033[K%c%d+%d.%d", LOCATION_ROW, LOCATION_COL, cur_schar, cur_sint, mm_int, mm_dec);
                break;
            case 1: // Coordinator sensor
                cur_schar = req.schar;
                cur_sint = req.sint;
                cur_time = Time();
                if (stop != 1) {
                    cur_velocity_10 = req.velocity_10;
                }
                break;
            case 2: // Coordinator speed to 0
                stop = 1;
                stop_distance = req.stop_distance;
                cur_velocity_10 = req.velocity_10;
                break;
            case 3: // Coordinator speed up
                stop = 0;
                cur_velocity_10 = 20;
                break;
        }
    }
}

void Coordinator(void) {
    int trainCtrl_id = WhoIs("trainController");
    RegisterAs("Coordinator");

    int display_id = Create(LOC_DISPLAY_PRI, &train_location_display);
    
    track_node track[TRACK_MAX];
    init_trackb(track);

    char switchPos[22];
    int s_i;
    for(s_i = 0; s_i < 22; s_i++) {
        switchPos[s_i] = 'c';
    }

    int stop_distance[15];
    stop_distance[0] = 0;
    stop_distance[1] = 0;
    stop_distance[2] = 0;
    stop_distance[3] = 0;
    stop_distance[4] = 0;
    stop_distance[5] = 0;
    stop_distance[6] = 0;
    stop_distance[7] = 0;
    stop_distance[8] = 465;
    stop_distance[9] = 535;
    stop_distance[10] = 611;
    stop_distance[11] = 708;
    stop_distance[12] = 750;
    stop_distance[13] = 850;
    stop_distance[14] = 870;
    int cur_record_velocity = 0;

    int cur_schar = 'A';
    int cur_sint = 0;
    int cur_snum = 0;

    Create(SENSOR_PRI, &sensorData);
    Create(TRAIN_COM_PRI, &trainCommunication);

    int sensorTriggerTime = 0;
    int sensorTiggerElapsedTime = 0;

    int prev_time = 0;
    int cur_velocity_int = 0;
    int cur_velocity_dec = 0;
    int cur_velocity_10 = 65;
    track_node* prev_node = 0;
    track_node* cur_node = 0;

    int sp = 0;
    int des_snum = 0;
    int des_dist = 0;

    int expected_time = 0;

    for(;;) {

        int rcv_id;
        trainReq req;
        char r = 'a';
        Receive(&rcv_id, &req, sizeof(trainReq));
        

        switch(req.src) {
            case 's':
                ;
                char prv_schar = cur_schar;
                int prv_sint = cur_sint;
                cur_schar = req.schar;
                cur_sint = req.sint;
                
                prev_time = sensorTriggerTime;
                sensorTriggerTime = Time();
                Reply(rcv_id, &r, sizeof(char));
                
                if(expected_time != 0) {
                    Printf(COM2, "\033[%d;%dH\033[KSensor %c%d, tick diff %d", 
                        TRAIN_TIME_ROW, TRAIN_TIME_COL, prv_schar, prv_sint, sensorTriggerTime - expected_time);                    
                } else {
                    Printf(COM2, "\033[%d;%dH\033[KCalculation error: expected time = 0", TRAIN_TIME_ROW, TRAIN_TIME_COL);
                }
                

                
                cur_snum = (cur_schar - 'A') * 16 + cur_sint - 1;

                int interval_distance = 0;
                track_node* tmp_node = 0;
                tmp_node = find_nxt_node(track, switchPos, prev_node, cur_snum, &interval_distance);

                if(tmp_node > 0) {
                    prev_node = cur_node;
                    cur_node = tmp_node;

                    if (prev_node != 0 && interval_distance != 0) {
                        // update current velocity
                        cur_velocity_int = interval_distance / (sensorTriggerTime - prev_time);
                        cur_velocity_dec = interval_distance % (sensorTriggerTime - prev_time);
                        cur_velocity_dec = cur_velocity_dec * 10 / (sensorTriggerTime - prev_time);
                        cur_velocity_10 = cur_velocity_int * 10 + cur_velocity_dec;
                        
                        Printf(COM2, "\033[%d;%dH\033[Kcur speed %d, time %d, distance %d", SPEED_ROW, SPEED_COL, cur_velocity_10, sensorTriggerTime - prev_time, interval_distance);

                        // expected prv time
                        int next_dist = find_dist_to_next_sensor(switchPos, cur_node);

                        if(next_dist != 0) {
                            expected_time = sensorTriggerTime + (next_dist * 10) / cur_velocity_10;
                        } else {
                            expected_time = 0;                      
                        }
                                          
                    }

                    t_loc_req dis_req;
                    dis_req.type = 1;
                    dis_req.schar = cur_schar;
                    dis_req.sint = cur_sint;
                    dis_req.velocity_10 = cur_velocity_10;
                    Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));

                    if(sp) {
                        int distance = findPathDist(switchPos, cur_node, des_snum);
                        if(distance < 1500 && distance > stop_distance[cur_record_velocity]) {
                            sp = 0;

                            int delayTime = ((distance + des_dist - stop_distance[cur_record_velocity]) * 10) / cur_velocity_10;

                            sensorTiggerElapsedTime = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime + sensorTriggerTime;
                            char reply_c;
                            Send(trainCtrl_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            
                            dis_req.type = 2;
                            dis_req.velocity_10 = cur_velocity_10;
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
                            dis_req.velocity_10 = cur_velocity_10 / 2;
                            dis_req.stop_distance = stop_distance[cur_record_velocity];
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                        }
                        else {
                            t_loc_req dis_req;
                            dis_req.type = 3;
                            dis_req.velocity_10 = cur_velocity_10;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                        }
                        cur_record_velocity = req.arg1;
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
                        track_node* src_node = cur_node;

                        int snum = (req.schar - 'A') * 16 + req.sint - 1;

                        int distance = findPathDist(switchPos, src_node, snum);
                        //Printf(COM2, "\033[%d;%dH\033[KCoordinator: %s-->%c%d, distance: %d", STATUS_ROW + 5, STATUS_COL, src_node->name, req.schar, req.sint, distance + req.arg2);

                        if(distance == -1) {
                            //Printf(COM2, "\033[%d;%dH\033[Kdistance = -1", STATUS_ROW + 6, STATUS_COL);
                        } else if(distance < stop_distance[cur_record_velocity]) {
                            //src_node = cur_node;
                            track_node* new_src_node = find_track_node(track, req.schar, req.sint);

                            int al_distance = new_src_node->edge[DIR_AHEAD].dist;
                            new_src_node = new_src_node->edge[DIR_AHEAD].dest;
                            al_distance += findPathDist(switchPos, new_src_node, snum) + distance;
                            if(al_distance < 1500) {
                                int delayTime = ((al_distance + req.arg2 - stop_distance[cur_record_velocity]) * 10) / cur_velocity_10;

                                sensorTiggerElapsedTime = Time();
                                t_req train_req;
                                train_req.type = 0;
                                train_req.delayTime = delayTime - sensorTiggerElapsedTime + sensorTriggerTime;
                                char reply_c;
                                Send(trainCtrl_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                                //Printf(COM2, "\033[%d;%dH\033[KsensorTriggerTime: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, sensorTriggerTime, sensorTiggerElapsedTime);                                
                            } else {
                                sp = 1;
                                des_snum = snum;
                                des_dist = req.arg2;                                
                            }                     

                        } else if(distance < 1500) {
                            int delayTime = ((distance + req.arg2 - stop_distance[cur_record_velocity]) * 10) / cur_velocity_10;

                            sensorTiggerElapsedTime = Time();
                            t_req train_req;
                            train_req.type = 0;
                            train_req.delayTime = delayTime - sensorTiggerElapsedTime + sensorTriggerTime;
                            char reply_c;
                            Send(trainCtrl_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
                            t_loc_req dis_req;
                            dis_req.type = 2;
                            dis_req.velocity_10 = cur_velocity_10;
                            dis_req.stop_distance = distance;
                            Send(display_id, &dis_req, sizeof(t_loc_req), &r, sizeof(char));
                            //Printf(COM2, "\033[%d;%dH\033[Ktime1: %d, sensorTiggerElapsedTime: %d", STATUS_ROW + 6, STATUS_COL, time1, sensorTiggerElapsedTime);
                        } else {
                            sp = 1;
                            des_snum = snum;
                            des_dist = req.arg2;
                        }


                        /*
                        sp_char = req.schar;
                        sp_int = req.sint;
                        stop = 1;
                        */
                        Reply(rcv_id, &r, sizeof(char));
                        break;
                }
                break;
        }
    }
}

