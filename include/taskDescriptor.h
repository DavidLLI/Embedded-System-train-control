#ifndef __TASKDESCRIPTOR_H__
#define __TASKDESCRIPTOR_H__

enum tsk_state {
	Ready,
	Active,
	Zombie,
	Send_Blk,
	Recv_Blk,
	Reply_Blk,
	Event_Blk,

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
	int swi_hwi;
	
	struct taskDescriptor *td_prv;
	struct taskDescriptor *td_nxt;
} td;


typedef struct pair {
	td *td_head;
	td *td_tail;
} pair;



td *schedule(pair *td_pq);

void pq_insert(pair *td_pq, td *td);

void pq_movetoend(pair *td_pq, td *td);


void pq_delete(pair *td_pq, td *td);


td* getTaskDes(td* td_ary);




#endif

