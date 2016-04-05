#include "newCoordinator.c"

#define SENSOR_PRI 14
#define TRAIN_COM_PRI 15
#define TRAINCTRL_PRI 18

#define TRAIN_NUM1 63
#define TRAIN_NUM2 58

#define COMMAND_BF_SIZE 10

void trainController(void) {

}

void coordinator(void) {
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

    char prv_schar[TRAIN_MAX];
    int prv_sint[TRAIN_MAX];
    int cur_schar[TRAIN_MAX];
    int cur_sint[TRAIN_MAX];
    int cur_snum[TRAIN_MAX];

    Create(SENSOR_PRI, &sensorData);
    Create(TRAIN_COM_PRI, &trainCommunication);

    int sensorTriggerTime[TRAIN_MAX];
    int sensorTiggerElapsedTime[TRAIN_MAX];
    int expected_time[TRAIN_MAX];

    int prev_time[TRAIN_MAX];
    int cur_velocity_10[TRAIN_MAX];

    track_node* prev_node[TRAIN_MAX];
    track_node* cur_node[TRAIN_MAX];

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

    // Command buffer
    trainC* bf[TRAIN_MAX];
    trainC bf1[COMMAND_BF_SIZE];
    trainC bf2[COMMAND_BF_SIZE];
    bf[0] = bf1;
    bf[1] = bf2;
    int bf_count[TRAIN_MAX];
    int rd_index[TRAIN_MAX];
    int wr_index[TRAIN_MAX];

    // Train waiting for sensor
    int wait_for_sensor[TRAIN_MAX];

    int init_i = 0;
    for (init_i = 0; init_i < TRAIN_MAX; init_i++) {
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
        wait_for_sensor[init_i] = 0;
    }

    Printf(COM2, "\033[%d;%dHReserved by A: ", PATH_ROW + 1, PATH_COL);
    Printf(COM2, "\033[%d;%dHReserved by B: ", PATH_ROW + 1, PATH_COL + 20);

    for (;;) {
    	int recv_id;
    	trainReq req;
    	Receive(&recv_id, &req, sizeof(trainReq));

    	switch(req.type) {
    		// Sensor report from the sensor task
    		case SENSOR:
    		char r = 'a';
    			Reply(recv_id, &r, sizeof(char));
    			char tmp_schar = req.arg1;
    			int tmp_sint = req.arg2;
    			int tmp_snum = (tmp_schar - 'A') * 16 + tmp_sint - 1;
                track_node* tmp_node = find_track_node(track, tmp_snum);

                // train TRAIN_NUM1 is not registered
                if (cur_node[0] == 0) {
                    cur_train_num = 0;
                }
                // next sensor as expected
                else if (find_nxt_sensor(switchPos, cur_node[0]) == tmp_node && 
                         tmp_node->ownedBy == TRAIN_NUM1 &&
                         reversing[0] == 0) { 
                    cur_train_num = 0;
                }
                // next next sensor as expected
                else if (find_nxt_sensor(switchPos, find_nxt_sensor(switchPos, cur_node[0])) == tmp_node &&
                         tmp_node->ownedBy == TRAIN_NUM1 &&
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
                         tmp_node->ownedBy == TRAIN_NUM1) {
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
                cur_schar[cur_train_num] = tmp_schar;
                cur_sint[cur_train_num] = tmp_sint;
                
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

                } else {
                    Printf(COM2, "\033[%d;%dH\033[KNode not found", SPEED_ROW, SPEED_COL);
                }

    			break;
    		// TR command form trainCom
    		case TR:

    			break;
    	}
    }
}