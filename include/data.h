#ifndef __DATA_H__
#define __DATA_H__

enum tsk_state {
	Ready,
	Active,
	Zombie
};


typedef struct taskDescriptor {
	unsigned int id;
	enum tsk_state state;
	unsigned int priority;
	unsigned int p_id;
	void *stack_ptr;
	unsigned int SPSR;
	int rtn_value;
	struct taskDescriptor *td_prv;
	struct taskDescriptor *td_nxt;
} td;


typedef struct pair {
	td *td_head;
	td *td_tail;
} pair;


td *schedule(pair *td_pq) {
	int schedule_i;
	for(schedule_i = 0; schedule_i < 32; schedule_i++) {
		pair *p;
		*p = td_pq[schedule_i];

		if(p->td_head != 0) {
			td *current_td = p->td_head;
			for(;;) {
				if(current_td == 0) break;

				if(current_td->state == Ready) return current_td;
				else current_td = current_td->td_nxt;
			}
		}
	}

	//no task to be scheduled
	return (td*) -1;
}



#endif

