/* THIS FILE IS GENERATED CODE -- DO NOT EDIT */
#ifndef __TRACK_DATA_H__
#define __TRACK_DATA_H__

#include "track_node.h"

// The track initialization functions expect an array of this size.
#define TRACK_MAX 144

void init_tracka(track_node *track);
void init_trackb(track_node *track);

int nameEqual(const char *name, char schar, int sint);
//int findPathDist(char *switchPos, track_node *src_node, char des_char, int des_int, int dist);

#endif
