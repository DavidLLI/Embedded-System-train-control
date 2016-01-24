#include "taskDescriptor.h"
#include "syscall.h"
#include "bwio.h"


void first() {
	bwputstr(COM2, "first task enter.\n\r");
	bwputstr(COM2, "first task exit.\n\r");
}


void initialize(pair *td_pq, td *td_ary) {
	td *first = &(td_ary[0]);
	first->free = 0;
	first->id = 1;
	first->state = Ready;
	first->priority = 0;
	first->p_id = 0;
	first->stack_ptr = (void *) 0x7fff00;

	td_pq[0].td_head = &first;
	td_pq[0].td_tail = &first; 
}


td *schedule(pair *td_pq) {
	int schedule_i;
	for(schedule_i = 0; schedule_i < 32; schedule_i++) {
		pair p;
		p = td_pq[schedule_i];

		if(p.td_head != 0) {
			td *current_td = p.td_head;
			for(;;) {
				if(current_td == 0) break;

				if(current_td->state == Ready) return current_td;
				else current_td = current_td->td_nxt;
			}
		}
	}
	//no task to be scheduled
	return 0;
}

void pq_insert(pair *td_pq, td *td) {
	int priority = td->priority;
	struct taskDescriptor *tail = td_pq[priority].td_tail;
	struct taskDescriptor *head = td_pq[priority].td_head;
	if(tail != 0) {
		tail->td_nxt = td;
		td->td_prv = tail;
		td->td_nxt = 0;
		td_pq[priority].td_tail = td;
	} else {
		td_pq[priority].td_tail = td;
		td_pq[priority].td_head = td;
		td->td_prv = 0;
		td->td_nxt = 0;
	}
}

void pq_movetoend(pair *td_pq, td *td) {
	td->state = Ready;
	int priority = td->priority;

	struct taskDescriptor *tail = td_pq[priority].td_tail;
	struct taskDescriptor *head = td_pq[priority].td_head;

	if(td != tail) {

		if(td == head) {
			td_pq[priority].td_head = td->td_nxt;
		} else {
			(td->td_prv)->td_nxt = td->td_nxt;
		}

		td->td_prv = tail;

		tail->td_nxt = td;

		td_pq[priority].td_tail = td;

		td->td_nxt = 0;
	}
}


void pq_delete(pair *td_pq, td *td) {
	td->state = Zombie;
	int priority = td->priority;
	
	struct taskDescriptor *tail = td_pq[priority].td_tail;
	struct taskDescriptor *head = td_pq[priority].td_head;

	if(td == head && td == tail) {
		td_pq[priority].td_head = 0;
		td_pq[priority].td_tail = 0;
	} else if(td == head) {
		td_pq[priority].td_head = td->td_nxt;
		(td->td_nxt)->td_prv = 0;
	} else if(td == tail) {
		td_pq[priority].td_tail = td->td_prv;
		(td->td_prv)->td_nxt = 0;
	} else {
		(td->td_prv)->td_nxt = td->td_nxt; 
	}	
}


td* getTaskDes(td* td_ary) {
	int get_i;
	for(get_i = 0; get_i < 88; get_i++) {
		if(td_ary[get_i].free) {
			return &(td_ary[get_i]);
		}
	}
}

