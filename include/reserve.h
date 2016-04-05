#ifndef __RESERVE_H__
#define __RESERVE_H__

#include "coordinator.h"

void clear_reserve_arr(track_node** reserve_arr, int* rsv_count, int cur_train_num);

int reserve_track(char* switchPos, track_node* src_node, track_node** reserve_arr, int* rsv_count, int cur_train_num, switchPath* sp, int sp_index); // 0 for fail, 1 for success

void stop_train(int train_id, int cur_train_num, int delayTime);

void resume_train(int train_id, int cur_train_num, int speed);

void reverse_train(int train_id, int cur_train_num, int speed);

#endif
