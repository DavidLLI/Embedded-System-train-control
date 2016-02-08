#ifndef __KERNELFUNCTION_H__
#define __KERNELFUNCTION_H__



#include "userFunction.h"
#include "taskDescriptor.h"
#include "msgPassing.h"
#include "syscall.h"
#include "ts7200.h"

#define STACK_BASE 0x7ff000
#define STACK_SPACE 0x1000



typedef struct request {
	int type;
	td *task;
	int arg1;
	int arg2;
	int arg3;
	int arg4;
	int arg5;
} req;


void activate(td* tds, req *request) {
	// Install spsr of the active task
	volatile int temp = 0;
	volatile int active_spsr = tds->SPSR;
	asm volatile (
		"msr spsr, %0"
		:"=r"(active_spsr)
	);
	// save kernel registers
	asm volatile (
		"stmfd	sp!, {r4-r9}\n\r"
		"stmfd	sp!, {fp}\n\r"
	);
	// Change to system mode
	asm volatile (
		"msr CPSR_c, #0xdf"
	);
	
	// Put sp, spsr, rtn_value
	volatile unsigned int temp_stack_ptr = (unsigned int) tds->stack_ptr;
	asm volatile (
		"mov sp, %0"
		:"=r"(temp_stack_ptr)
	);
	
	// Pop user register from user stack
	asm volatile(
		"ldmfd	sp, {sp, lr}"
	);
	
	asm volatile (
		"mov ip, lr"
	);

	// Return to svc mode
	asm volatile (
		"msr cpsr, #0xd3"
	);

	asm volatile (
		"mov lr, ip"
	);
	
	volatile int *VIC2xIntEnable = (int *) (VIC2_BASE + VICxIntEnable_OFFSET);
	*VIC2xIntEnable = 524288;

	
	// Put return value into r0
	volatile int rtn_value = tds->rtn_value;
	asm volatile (
		"mov r0, %0"
		:"=r"(rtn_value)
	);

	// Pop user register from user stack
	asm volatile(
		"msr CPSR_c, #0xdf\n\t"
		"ldmfd	sp!, {r1-r12, lr}\n\t"
		"msr cpsr, #0xd3"
	);

	asm volatile (
		"movs pc, lr"
	);


	
	////////////////////////////////////////////////
	////////////////////////////////////////////////
	////////////////////////////////////////////////

	// IRQ Handler
	//asm volatile ( "__IRQ_HANDLER:" );

	// SWI Handler
	asm volatile ( "__SWI_HANDLER:" );

	asm volatile (
		"stmfd sp!, {r0}\n\t"
		"mrs r0, CPSR\n\t"
		"cmp r0, #0xd2\n\t"
		"ldmfd sp!, {r0}\n\t"
		"msr CPSR_c, #0xdf\n\t"
		"stmfd sp!, {r1-r12, lr}\n\t"
		"msr cpsr, #0xd3\n\t"
		"bne __SWI_MODE__\n\t"
		"msr CPSR_c, #0xd2\n\t"
		"mov ip, lr\n\t"
		"msr CPSR_c, #0xd3\n\t"
		"mov lr, ip\n\t"
		"__SWI_MODE__:"

	);

	// Pop kernel register from the stack (Automatic)
	asm volatile (
		"ldmfd sp!, {fp}"
	);
	
	// Fill in request and argument
	asm volatile (
		"mov %0, r0"
		:"=r"(temp)
	);
	*VIC2xIntEnable = 0;

	volatile int *VIC1xIRQStatus = (int *) (VIC1_BASE + VICxIRQStatus_OFFSET);
	volatile int *VIC2xIRQStatus = (int *) (VIC2_BASE + VICxIRQStatus_OFFSET);
	volatile int status1 = *VIC1xIRQStatus;
	volatile int status2 = *VIC2xIRQStatus;

	volatile int *VIC1xIntEnClear = (int *) (VIC1_BASE + VICxIntEnClear_OFFSET);
	volatile int *VIC2xIntEnClear = (int *) (VIC2_BASE + VICxIntEnClear_OFFSET);
	*VIC1xIntEnClear = 0xffffffff;
	*VIC2xIntEnClear = 0xffffffff;
	tds->rtn_value = temp;


	asm volatile (
		"mov %0, r4"
		:"=r"(temp)
	);
	request->arg1 = temp;

	asm volatile (
		"mov %0, r5"
		:"=r"(temp)
	);
	request->arg2 = temp;

	asm volatile (
		"mov %0, r6"
		:"=r"(temp)
	);
	request->arg3 = temp;

	asm volatile (
		"mov %0, r7"
		:"=r"(temp)
	);
	request->arg4 = temp;

	asm volatile (
		"mov %0, r8"
		:"=r"(temp)
	);
	request->arg5 = temp;

	

	if(status1 || status2) {
		//bwprintf(COM2, "interrupt\n\r");
		request->type = 9;
		request->arg1 = status1;
		request->arg2 = status2;
		volatile int *timer_clr = (int *) (TIMER3_BASE + CLR_OFFSET);
		*timer_clr = 1;
	} else {
		asm volatile (
			"ldr %0, [lr, #-4]"
			:"=r"(request->type)
		);

		request->type = request->type & 0x00ffffff;		
	}

	

	// Acquire lr
	asm volatile(
		"mov ip, lr"
	);
	// Change to system state
	asm volatile (
		"msr cpsr, #0xdf"
	);
	// Overwrite lr with lr_value
	asm volatile (
		"mov lr, ip"
	);
	// Push user register onto stack
	asm volatile(
		"mov ip, sp"
	);
	asm volatile (
		"stmfd sp!, {ip, lr}"
	);
	// Acquire stack pointer
	asm volatile (
		"mov ip, sp"
	);
	// Return to supervisor mode
	asm volatile (
		"msr cpsr, #0xd3"
	);

	asm volatile (
		"ldmfd sp!, {r4-r9}"
	);

	asm volatile (
		"mov %0, ip"
		:"=r"(temp)
	);
	// Acquire SPSR
	volatile int spsr_value = 0;
	asm volatile (
		"mrs %0, spsr"
		:"=r"(spsr_value)
	);
	
	// put sp and spsr into td
	tds->stack_ptr = temp;
	tds->SPSR = spsr_value;
}

void initialize(pair *td_pq, td *td_ary, int *task_id_counter) {
	// set up first task
	volatile td *td1 = &(td_ary[0]);

	td1->free = 0;
	td1->id = *task_id_counter;
	td1->state = Ready;
	td1->priority = 0;
	td1->p_id = 0;
	td1->stack_ptr = STACK_BASE;
	td1->SPSR = 0x50; // normal d0, irq 50
	td1->rtn_value = 0;

	volatile int usr_entry_point = (int) (&first + 0x00218000);


	td1->stack_ptr -= 48;
	*((int *)td1->stack_ptr) = usr_entry_point;
	*((int *)td1->stack_ptr - 1) = STACK_BASE;
	td1->stack_ptr -= 4;


	//bwprintf(COM2, "%x\n\r", td1->stack_ptr);

	td_pq[td1->priority].td_head = td1;
	td_pq[td1->priority].td_tail = td1; 

	(*task_id_counter)++;

	// Set up swi table
	volatile int *handler_addr = (int *) 0x28;
	volatile int *irq_handler = (int *) 0x38;
	volatile int swi_handler_addr = 0;

	asm volatile (
		"ldr ip, =__SWI_HANDLER"
	);
	asm volatile (
		"mov %0, ip"
		:"=r"(swi_handler_addr)
	);

	*handler_addr = swi_handler_addr + 0x00218000;
	*irq_handler = swi_handler_addr + 0x00218000;

	//enable IRQ
	int *VIC2xIntEnable = (int *) (VIC2_BASE + VICxIntEnable_OFFSET);
	*VIC2xIntEnable = 524288;

	//set clock
	//set load
	int *timer_load = (int *)TIMER3_BASE;
	*timer_load = 5079;

	//set control bit
	int *timer_ctrl = (int *)(TIMER3_BASE + CRTL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;
}

void handle(pair *td_pq, td *td_ary, req request, int *task_id_counter) {

	switch(request.type) {
		case 0: // Create
			;

			struct taskDescriptor *newtd = &(td_ary[*task_id_counter]);

			// set td fields
			newtd->free = 0;
			newtd->id = *task_id_counter;
			newtd->state = Ready;
			newtd->priority = request.arg1;
			newtd->p_id = (request.task)->id;
			int stack_adr = STACK_BASE - (* task_id_counter) * STACK_SPACE;
			newtd->stack_ptr = stack_adr;
			newtd->SPSR = 0x50;
			newtd->rtn_value = 0;

			int usr_entry_point = (int) (request.arg2 + 0x00218000);
			
			newtd->stack_ptr -= 52;
			*((int *)newtd->stack_ptr) = usr_entry_point;
			*((int *)newtd->stack_ptr - 1) = stack_adr;
			newtd->stack_ptr -= 4;

			//insert into priority queue
			pq_insert(td_pq, newtd);
			
			(request.task)->rtn_value = *task_id_counter;
			
			(*task_id_counter)++;
			//bwprintf(COM2, "return value: %d\n\r", (request.task)->rtn_value);

			break;
				
		case 1: // MyTid
			(request.task)->rtn_value = (request.task)->id;
			break;

		case 2: // MyParentTid
			(request.task)->rtn_value = (request.task)->p_id;
			break;

		case 3: // Pass
			pq_movetoend(td_pq, request.task);
			break;

		case 4: //Exit
			pq_delete(td_pq, request.task);
			break;
		default:
			break;
	}
	return;
}

void *memcpy(void* dst, void* src, int len) {
	char *csrc = (char *)src;
    char *cdest = (char *)dst;
    int i;
    for (i = 0; i < len; i++)
       cdest[i] = csrc[i];

   return dst;
}

void handle_msg_passing(td *td_ary, req request, 
						msg_info* msg_queue, int *msg_queue_len, 
						recv_buf* recv_arr, recv_buf* reply_arr) {
	switch(request.type) {
		case 5: // Send
			;
			int send_tid = request.arg1;
			if (send_tid < 0 || send_tid >= 88) {
				(request.task)->rtn_value = -1;
				break;
			}
			else if (td_ary[send_tid].free == 1) {
				(request.task)->rtn_value = -2;
				break;
			}
			else if (td_ary[send_tid].state == Zombie) {
				(request.task)->rtn_value = -3;
				break;
			}
			void* send_buf = (void *)(request.arg2);
			int send_len = request.arg3;
			// Set the reply buffer of own task
			int own_id = (request.task)->id;
			reply_arr[own_id].msg = (void*)(request.arg4);
			reply_arr[own_id].msglen = request.arg5;

			if (td_ary[send_tid].state == Recv_Blk) {
				(request.task)->state = Reply_Blk; // Set current task to be reply blocked
				// Fill receive task's buffer
				*(recv_arr[send_tid].tid) = own_id;
				memcpy(recv_arr[send_tid].msg, send_buf, recv_arr[send_tid].msglen);
				// Make the receive task ready
				td_ary[send_tid].state = Ready;
				// Set the receive task return value
				td_ary[send_tid].rtn_value = send_len;

			}
			else {
				int own_id = (request.task)->id;
				// Set the current task to be send blocked
				(request.task)->state = Send_Blk;
				// Add the msg to the queue
				int msg_i = msg_queue_len[send_tid];
				msg_queue[send_tid*87 + msg_i].tid = own_id;
				msg_queue[send_tid*87 + msg_i].msg = send_buf;
				msg_queue[send_tid*87 + msg_i].msglen = send_len;
				// Increment the queue counter
				msg_queue_len[send_tid]++;
			}

			break;
		case 6: // Receive
			;
			int recv_tid = (request.task)->id;
			if (msg_queue_len[recv_tid] == 0) {
				// Set current task to be receive blocked
				(request.task)->state = Recv_Blk;
				// Fill the receive buffer
				int* tid_buf = (int*)(request.arg1);
				void* msg_buf = (void*)(request.arg2);
				int buf_len = request.arg3;
				int own_id = (request.task)->id;
				recv_arr[own_id].tid = tid_buf;
				recv_arr[own_id].msg = msg_buf;
				recv_arr[own_id].msglen = buf_len; 
			}
			else {
				int own_id = (request.task)->id;
				int send_tid = msg_queue[own_id*87 + 0].tid;
				int* tid_buf = (int*)(request.arg1);
				*tid_buf = send_tid;
				void* send_buf = msg_queue[own_id*87 + 0].msg;
				void* recv_buffer = (void*)(request.arg2);
				int recv_buf_len = request.arg3;
				memcpy(recv_buffer, send_buf, recv_buf_len);
				(request.task)->rtn_value = msg_queue[own_id*87 + 0].msglen;
				// Set the send task to be reply blocked
				td_ary[send_tid].state = Reply_Blk;
				// Remove the first one from the queue
				int i;
				for (i = 1; i < msg_queue_len[own_id]; i++) {
					msg_queue[own_id*87 + i - 1] = msg_queue[own_id*87 + i];
				}
				// Decrement the queue counter
				msg_queue_len[own_id]--;
			}
			break;
		case 7: // Reply
			;
			int reply_tid = request.arg1; 
			if (reply_tid < 0 || reply_tid >= 88) {
				(request.task)->rtn_value = -1;
				break;
			}
			else if (td_ary[reply_tid].free == 1) {
				(request.task)->rtn_value = -2;
				break;
			}
			else if (td_ary[reply_tid].state != Reply_Blk) {
				(request.task)->rtn_value = -3;
				break;
			}
			td_ary[reply_tid].state = Ready;
			td_ary[reply_tid].rtn_value = request.arg3;
			(request.task)->rtn_value = 0;
			void* reply_buffer = reply_arr[reply_tid].msg;
			void* reply_msg = (void*)(request.arg2);
			int reply_buf_len = reply_arr[reply_tid].msglen;
			memcpy(reply_buffer, reply_msg, reply_buf_len);
			break;
		default:
			break;
	}
}

struct blk_td {
	int tid;
	int event_type;
	td *task;

	struct blk_td* nxt;
	struct blk_td* prv;
};

struct blk_pair {
	struct blk_td *head;
	struct blk_td *tail;
};


void handle_block(struct blk_td *blk_ary, struct blk_pair *pair, req request) {
	switch(request.type) {
		case 8: // AwaitEvent
			;
			(request.task)->state = Event_Blk;

			struct blk_td *blk = &(blk_ary[(request.task)->id]);

			blk->tid = (request.task)->id;;
			blk->event_type = request.arg1;
			blk->task = request.task;

			//bwprintf(COM2, "in AwaitEvent handle: tid: %d, event: %d\n\r", blk->tid, blk->event_type);

			if(pair->head != 0 && pair->tail != 0) {
				//bwprintf(COM2, "handle_block 1\n\r");
				(pair->tail)->nxt = blk;
				blk->prv = (pair->tail);
				blk->nxt = 0;
				pair->tail = blk;
			} else {
				//bwprintf(COM2, "handle_block 2\n\r");
				pair->head = blk;
				pair->tail = blk;
				blk->nxt = 0;
				blk->prv = 0;
			}

			break;
		case 9: // hardware interrupt
			;
			//bwprintf(COM2, "Hardware Interrupt\n\r");
			int event;
			if(request.arg2 != 0) {
				event = timer3;

				int *VIC2xIntEnClear = (int *) (VIC2_BASE + VICxIntEnClear_OFFSET);
				*VIC2xIntEnClear = 524288;
			}

			struct blk_td *current = pair->head;
			for(;;) {
				
				if(current == 0) break;
				else {
					if(current->event_type == event) {
						//bwprintf(COM2, "in interrupt handle: id: %d, event1: %d, event2:%d\n\r", 
							//(current->task)->id, request.arg1, request.arg2);
						(current->task)->state = Ready;
						(current->task)->rtn_value = 0;

						if(current == pair->head && current == pair->tail) {
							pair->head = 0;
							pair->tail = 0;
						} else if(current == pair->head) {
							pair->head = current->nxt;
							(current->nxt)->prv = 0;
						} else if(current == pair->tail) {
							pair->tail = current->prv;
							(current->prv)->nxt = 0;
						} else {
							(current->prv)->nxt = current->nxt;
							(current->nxt)->prv = current->prv;
						}
						current->nxt = 0;
						current->prv = 0;
					}
				}
				current = current->nxt;
			}
			
			break;
		default:
			break;
	}
}

#endif

