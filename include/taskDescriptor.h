#ifndef __TASKDESCRIPTOR_H__
#define __TASKDESCRIPTOR_H__


//#include "userFunction.h"
#include "syscall.h"

enum tsk_state {
	Ready,
	Active,
	Zombie
};

typedef struct taskDescriptor {
	int free;
	
	unsigned int id;
	enum tsk_state state;
	unsigned int priority;
	unsigned int p_id;

	unsigned int stack_ptr;
	unsigned int SPSR;
	int rtn_value;
	
	struct taskDescriptor *td_prv;
	struct taskDescriptor *td_nxt;
} td;


typedef struct pair {
	td *td_head;
	td *td_tail;
} pair;


void user() {
	//bwprintf(COM2, "enter user()\n\r");

	bwprintf(COM2, "1--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Pass();

	bwprintf(COM2, "2--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Exit();
}


void first() {
	//bwputstr(COM2, "Enter first()\n\r");

	int ret;
	ret = Create(2, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(2, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(0, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	ret = Create(0, &user);
	bwprintf(COM2, "Created: %d\n\r", ret);

	bwputstr(COM2, "FirstUserTask: exiting\n\r");
	Exit();
}

void initialize(pair *td_pq, td *td_ary, int *task_id_counter) {
	// set up first task
	td *td1 = &(td_ary[0]);

	td1->free = 0;
	td1->id = *task_id_counter;
	td1->state = Ready;
	td1->priority = 1;
	td1->p_id = 0;
	td1->stack_ptr = 0x7fff00;
	td1->SPSR = 0xd0;
	td1->rtn_value = 0;

	int usr_entry_point = (int) (&first + 0x00218000);

	*((int *)td1->stack_ptr) = usr_entry_point;
	*((int *)td1->stack_ptr - 1) = 0x7fff00;
	td1->stack_ptr -= 4;

	//bwprintf(COM2, "%x\n\r", td1->stack_ptr);

	td_pq[td1->priority].td_head = td1;
	td_pq[td1->priority].td_tail = td1; 

	(*task_id_counter)++;

	// Set up swi table
	int *handler_addr = (int *) 0x28;
	int swi_handler_addr = 0;
	asm volatile (
		"ldr ip, =__SWI_HANDLER"
	);
	asm volatile (
		"mov %0, ip"
		:"=r"(swi_handler_addr)
	);
	*handler_addr = swi_handler_addr + 0x00218000;	
}


td *schedule(pair *td_pq) {
	//bwputstr(COM2, "schedule\n\r");
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
	//bwprintf(COM2, "insert--id: %d, pri: %d\n\r", td->id, td->priority);
	int priority = td->priority;
	struct taskDescriptor *tail = td_pq[priority].td_tail;
	if(tail != 0) {
		tail->td_nxt = td;
		td->td_prv = tail;
		td->td_nxt = 0;
		td_pq[priority].td_tail = td;
	} else {
		//bwputstr(COM2, "tail == 0\n\r");
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
		//bwputstr(COM2, "move\n\r");
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
	return 0;
}




#endif

