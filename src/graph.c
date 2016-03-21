#include "graph.h"

track_node* find_nxt_merge(track_node* track, char *switchPos, track_node* src_node) {
    int i = 0;
    for(;;) {
        i++;
        //Printf(COM2, "\033[%d;1H%s", 35 + i, src_node->name);
        //Delay(10);
        switch(src_node->type) {
            case NODE_MERGE:
                return src_node;
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
                    src_node = src_node->edge[DIR_STRAIGHT].dest;
                    break;
                case 'c':
                    src_node = src_node->edge[DIR_CURVED].dest;
                    break;
                }     
                break;
            case NODE_SENSOR:
                ;
                src_node = src_node->edge[DIR_AHEAD].dest;
            default:
                break;
        }
        
        if(i >= TRACK_MAX) {
            //Printf(COM2, "\033[%d;%dH find nxt node exceed max, dest is %d", STATUS_ROW, STATUS_COL + 5, des_snum);
            break;
        }
    }
    return 0;
}

track_node* find_nxt_sensor(track_node* track, char *switchPos, track_node* src_node) {
    int i = 0;
    for(;;) {
        i++;
        //Printf(COM2, "\033[%d;1H%s", 35 + i, src_node->name);
        //Delay(10);
        switch(src_node->type) {
            case NODE_SENSOR:
                return src_node;
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
                    src_node = src_node->edge[DIR_STRAIGHT].dest;
                    break;
                case 'c':
                    src_node = src_node->edge[DIR_CURVED].dest;
                    break;
                }     
                break;
            case NODE_MERGE:
                ;
                src_node = src_node->edge[DIR_AHEAD].dest;
                break;
            default:
                break;
        }
        
        if(i >= TRACK_MAX) {
            //Printf(COM2, "\033[%d;%dH find nxt node exceed max, dest is %d", STATUS_ROW, STATUS_COL + 5, des_snum);
            break;
        }
    }
    return 0;
}

int minDist(track_node *track, int *dist) {
    int minIndex = -1;
    int minDist = 999999999;

    int i;
    for(i = 0; i < 140; i++) {
        int tmp = dist[i];
        if(tmp < minDist && !(track[i].visited)) {
            minDist = tmp;
            minIndex = i;
        }
    }

    return minIndex;
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

track_node* find_track_node(track_node* node_list, int snum) {
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


int Dijkstra(int trainNum, track_node *track, track_node *src_node, int *dist, int *prev, track_node *des_node) {
    //create vertex set
    int i;
    for(i = 0; i < 140; i++) {
        track[i].visited = 0;
        dist[i] = 999999999;
        prev[i] = -1;
    }

    dist[src_node->index] = 0;


    for(i = 0; i < 140; i++) {
        int index = minDist(track, dist);
        if(index == -1) return 0;;

        track_node u = track[index];
        u.visited = 1;
        track[index] = u;
        //printf("%d, %s, %d, %d\n", index, u.name, u.visited, u.index);

        if(u.type == NODE_SENSOR && (u.num == des_node->num || u.num == (des_node->reverse)->num)) break;

        if(u.ownedBy == 0 || u.ownedBy == trainNum) {
            track_node *v = 0;
            int alt = 0;
            switch(u.type) {
                case NODE_BRANCH:
                    v = u.edge[DIR_STRAIGHT].dest;
                    alt = dist[index] + u.edge[DIR_STRAIGHT].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }

                    v = u.edge[DIR_CURVED].dest;
                    alt = dist[index] + u.edge[DIR_CURVED].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }
                    
                    break;
                case NODE_MERGE:
                    v = u.edge[DIR_AHEAD].dest;

                    alt = dist[index] + u.edge[DIR_AHEAD].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }

                    track_node *r = u.reverse;

                    v = r->edge[DIR_STRAIGHT].dest;
                    alt = dist[index] + r->edge[DIR_STRAIGHT].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }

                    v = r->edge[DIR_CURVED].dest;
                    alt = dist[index] + r->edge[DIR_CURVED].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }

                case NODE_EXIT:
                    break;
                default:
                    v = u.edge[DIR_AHEAD].dest;
                    //printf("%s\n", v->name);
                    alt = dist[index] + u.edge[DIR_AHEAD].dist;
                    if(alt < dist[v->index]) {
                        dist[v->index] = alt;
                        prev[v->index] = index;
                    }
                    break;
            }            
        } else {
            //printf("owned\n");
        }
    }

    return 1;
}


int getSwitchPath(track_node *track, switchPath *sp, int *index, int *dist, int* prev, track_node *des) {
    int u = des->index;
    int distance = 0;
    int distance2 = 0;
    int prv_u = -1;
    while(prev[u] != -1) { 
        track_node prv = track[prv_u];

        if(track[u].type == NODE_BRANCH) {
            track_node *s = track[u].edge[DIR_STRAIGHT].dest;
            track_node *c = track[u].edge[DIR_CURVED].dest;

            if(prv.num == s->num) {
                sp[*index].num = track[u].num;
                sp[*index].state = 's';
                sp[*index].reverse = 0;
                (*index)++;
            } else if(prv.num == c->num) {
                sp[*index].num = track[u].num;
                sp[*index].state = 'c';
                sp[*index].reverse = 0;
                (*index)++;
            } else {
            }
        }

        if(track[u].type == NODE_MERGE && prv.edge[DIR_AHEAD].dest->num != track[u].num) {
            track_node *r = track[u].reverse;
            track_node *s = r->edge[DIR_STRAIGHT].dest;
            track_node *c = r->edge[DIR_CURVED].dest;

            if(prv.num == s->num) {
                sp[*index].num = r->num;
                sp[*index].state = 's';
                sp[*index].reverse = 1;
                (*index)++;
            } else if(prv.num == c->num) {
                sp[*index].num = r->num;
                sp[*index].state = 'c';
                sp[*index].reverse = 1;
                (*index)++;
            } else {
            }
        }

        //printf("%d\n", *index);

        distance += dist[u];
        prv_u = u;
        u = prev[u];
    }

    if(distance2 == 0) {
        u = (des->reverse)->index;
        prv_u = -1;
        while(prev[u] != -1) { 
            track_node prv = track[prv_u];

            if(track[u].type == NODE_BRANCH) {
                track_node *s = track[u].edge[DIR_STRAIGHT].dest;
                track_node *c = track[u].edge[DIR_CURVED].dest;

                if(prv.num == s->num) {
                    sp[*index].num = track[u].num;
                    sp[*index].state = 's';
                    sp[*index].reverse = 0;
                    (*index)++;
                } else if(prv.num == c->num) {
                    sp[*index].num = track[u].num;
                    sp[*index].state = 'c';
                    sp[*index].reverse = 0;
                    (*index)++;
                } else {
                }
            }

            if(track[u].type == NODE_MERGE && prv.edge[DIR_AHEAD].dest->num != track[u].num) {
                track_node *r = track[u].reverse;
                track_node *s = r->edge[DIR_STRAIGHT].dest;
                track_node *c = r->edge[DIR_CURVED].dest;

                if(prv.num == s->num) {
                    sp[*index].num = r->num;
                    sp[*index].state = 's';
                    sp[*index].reverse = 1;
                    (*index)++;
                } else if(prv.num == c->num) {
                    sp[*index].num = r->num;
                    sp[*index].state = 'c';
                    sp[*index].reverse = 1;
                    (*index)++;
                } else {
                }
            }


            distance2 += dist[u];
            prv_u = u;
            u = prev[u];
        }        
    }

    if(distance != 0 && distance <= distance2) return distance;
    else if(distance2 != 0 && distance2 <= distance) return distance2;
    else return 0;
}
