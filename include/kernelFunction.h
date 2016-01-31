#ifndef __KERNELFUNCTION_H__
#define __KERNELFUNCTION_H__

#include "taskDescriptor.h"
#include "syscall.h"


typedef struct request {
	int type;
	td *task;
	int arg1;
	int arg2;
} req;


void activate(td* tds, req *request) {
	// Install spsr of the active task
	int active_spsr = tds->SPSR;
	asm volatile (
		"msr spsr, %0"
		:"=r"(active_spsr)
	);
	// save kernel registers
	asm volatile (
		"stmfd	sp!, {fp}"
	);
	// Change to system mode
	asm volatile (
		"msr CPSR_c, #0xdf"
	);
	
	// Put sp, spsr, rtn_value
	unsigned int temp_stack_ptr = (unsigned int) tds->stack_ptr;
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
	
	// Put return value into r0
	int rtn_value = tds->rtn_value;
	asm volatile (
		"mov r0, %0"
		:"=r"(rtn_value)
	);

	asm volatile (
		"movs pc, lr"
	);

	// SWI Handler
	asm volatile ( "__SWI_HANDLER:" );
	// Pop kernel register from the stack (Automatic)
	asm volatile (
		"ldmfd sp, {fp}"
	);
	
	// Get argument
	int arg1 = 0;
	int arg2 = 0;
	asm volatile (
		"mov %0, r1"
		:"=r"(arg1)
	);
	asm volatile (
		"mov %0, r2"
		:"=r"(arg2)
	);
	asm volatile (
		"ldr %0, [lr, #-4]"
		:"=r"(request->type)
	);

	request->type = request->type & 0x00ffffff;

	if (request->type == 0) {
		request->arg1 = arg1;
		request->arg2 = arg2;
	}
	
	// Acquire lr
	asm volatile(
		"mov ip, lr"
	);
	int lk_reg = 0;
	asm volatile (
		"mov %0, lr"
		:"=r"(lk_reg)
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
		"stmfd	sp!, {ip, lr}"
	);
	// Acquire stack pointer
	int stack_ptr_value = 0;
	asm volatile (
		"mov %0, sp"
		:"=r"(stack_ptr_value)
	);
	// Return to supervisor mode
	asm volatile (
		"msr cpsr, #0xd3"
	);

	// Acquire SPSR
	int spsr_value = 0;
	asm volatile (
		"mrs %0, spsr"
		:"=r"(spsr_value)
	);
	
	// Fill in request and argument
	// put sp and spsr into td
	tds->stack_ptr = stack_ptr_value;
	tds->SPSR = spsr_value;
}


void handle(pair *td_pq, td *td_ary, req request, int *task_id_counter) {
	if(request.type == 0) {
		struct taskDescriptor *newtd = &(td_ary[*task_id_counter]);

		// set td fields
		newtd->free = 0;
		newtd->id = *task_id_counter;
		newtd->state = Ready;
		newtd->priority = request.arg1;
		newtd->p_id = (request.task)->id;
		int stack_adr = 0x7fff00 - (* task_id_counter) * 0x1000;
		newtd->stack_ptr = stack_adr;
		newtd->SPSR = 0xd0;
		newtd->rtn_value = 0;

		int usr_entry_point = (int) (request.arg2 + 0x00218000);
		
		*((int *)newtd->stack_ptr) = usr_entry_point;
		*((int *)newtd->stack_ptr - 1) = stack_adr;
		newtd->stack_ptr -= 4;

		//insert into priority queue
		pq_insert(td_pq, newtd);
		
		(request.task)->rtn_value = *task_id_counter;
		
		(*task_id_counter)++;

		return;		
	}


	switch(request.type) {
				
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

#endif

