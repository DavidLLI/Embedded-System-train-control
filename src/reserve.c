#include "reserve.h"

void clear_reserve_arr(track_node** reserve_arr, int* rsv_count, int cur_train_num) {
    int i = 0;
	for (i = 0; i < rsv_count[cur_train_num]; i++) {
        (reserve_arr[i])->ownedBy = 0;
        (reserve_arr[i])->reverse->ownedBy = 0;
        Printf(COM2, "\033[%d;%dH     ", PATH_ROW + 2 + i, 
                                         PATH_COL + 20 * (cur_train_num));
    }
    rsv_count[cur_train_num] = 0;
}

int reserve_track(char* switchPos, track_node* src_node, track_node** reserve_arr, int* rsv_count, int cur_train_num, switchPath* sp, int sp_index) {
	int reserve_distance = 1200;
    track_node* reserve_node = src_node;
    while (reserve_distance > 0) {
        int reserve_train_num = 0;
        if (cur_train_num == 0) {
            reserve_train_num = TRAIN_NUM1;
        }
        else if (cur_train_num == 1) {
            reserve_train_num = TRAIN_NUM2;
        }

        if (reserve_node->ownedBy != 0 && reserve_node->ownedBy != reserve_train_num) { // reserve fail due to the track is owned by another train or the track is an exit
            return 0;
        }
        if (reserve_node->ownedBy != reserve_train_num) {
            // Reserve the track node
            reserve_node->ownedBy = reserve_train_num;
            reserve_node->reverse->ownedBy = reserve_train_num;
            
            Printf(COM2, "\033[%d;%dH%s", PATH_ROW + 2 + rsv_count[cur_train_num], 
                                          PATH_COL + 20 * (cur_train_num), reserve_node->name);
            reserve_arr[rsv_count[cur_train_num]] = reserve_node;
            rsv_count[cur_train_num]++;
        }
        
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
                int i = 0;
                for(i = 0; i < sp_index; i++) {
                    if(sw_num == sp[i].num && pos != sp[i].state) {
                        // set switch
                        Printf(COM2, "\033[%d;1H\033[KChange switch %d to %c", STATUS_ROW, sp[i].num, sp[i].state);
                        if(sp[i].state == 'S' || sp[i].state == 's') {
                            Printf(COM1, "%c%c", 0x21, sp[i].num);
                            switchPos[index] = 's';
                            Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 's');
                            if (sw_num == 153 || sw_num == 155) {
                                Printf(COM1, "%c%c", 0x22, sw_num + 1);
                                switchPos[index + 1] = 'c';
                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 3, SWITCH_COL, 'c');
                            }
                            else if (sw_num == 154 || sw_num == 156) {
                                Printf(COM1, "%c%c", 0x22, sw_num - 1);
                                switchPos[index - 1] = 'c';
                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 1, SWITCH_COL, 'c');
                            }
                        } else if(sp[i].state == 'C' || sp[i].state == 'c') {
                            Printf(COM1, "%c%c", 0x22, sp[i].num);
                            switchPos[index] = 'c';
                            Printf(COM2, "\033[%d;%dH\033[K%c", index + 2, SWITCH_COL, 'c');
                            if (sw_num == 153 || sw_num == 155) {
                                Printf(COM1, "%c%c", 0x21, sw_num + 1);
                                switchPos[index + 1] = 's';
                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 3, SWITCH_COL, 's');
                            }
                            else if (sw_num == 154 || sw_num == 156) {
                                Printf(COM1, "%c%c", 0x21, sw_num - 1);
                                switchPos[index - 1] = 's';
                                Printf(COM2, "\033[%d;%dH\033[K%c", index + 1, SWITCH_COL, 's');
                            }
                        }

                        Printf(COM1, "%c", 32); //trun off solenoid                                             
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
    return 1;
}

void stop_train(int train_id, int cur_train_num, int delayTime) {
	t_req train_req;
    train_req.type = 0;
    train_req.delayTime = delayTime;
    train_req.arg1 = cur_train_num;
    char reply_c;
    Send(train_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
}

void resume_train(int train_id, int cur_train_num, int speed) {
	t_req train_req;
    train_req.type = 3;
    train_req.arg1 = cur_train_num;
    train_req.arg2 = speed;
    char reply_c;
    Send(train_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
}

void reverse_train(int train_id, int cur_train_num, int speed) {
    t_req train_req;
    train_req.type = 2;
    train_req.arg1 = cur_train_num;
    train_req.arg2 = speed;
    char reply_c;
    Send(train_id, &train_req, sizeof(t_req), &reply_c, sizeof(char));
}
