#ifndef __GRAPH_H__
#define __GRAPH_H__

#include "track_data.h"


typedef struct switchPath {
	int num;
	char state;
	int reverse;
} switchPath;


int findPathDist(char *switchPos, track_node *src_node, int des_snum);

track_node* find_nxt_node(track_node* track, char *switchPos, track_node* src_node, int des_snum, int *interval_distance);

int find_dist_to_next_sensor(char *switchPos, track_node* src_node);

track_node* find_track_node(track_node* node_list, int snum);

int Dijkstra(int trainNum, track_node *track, track_node *src_node, int *dist, int *prev, track_node *des_node);

int getSwitchPath(track_node *track, switchPath *sp, int *index, int *dist, int* prev, track_node *des);

track_node* find_nxt_merge(track_node* track, char *switchPos, track_node* src_node);

track_node* find_nxt_sensor(track_node* track, char *switchPos, track_node* src_node);



#endif

