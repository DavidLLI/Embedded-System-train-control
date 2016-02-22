#include "contextSwitch.h"
#include "userFunction.h"
#include "ts7200.h"
#include "bwio.h"


void activate(td* tds, req *request) {
	//bwprintf(COM2, "Activate\n\r");
	// Install spsr of the active task
	volatile int temp = 0;
	volatile int hwi = 0;
	volatile int active_spsr = tds->SPSR;
	asm volatile (
		"msr spsr, %0"
		:"=r"(active_spsr)
	);
	// save kernel registers
	asm volatile (
		"stmfd	sp!, {r0-r12, lr}\n\r"
		"stmfd	sp!, {fp}\n\r"
	);

	volatile int *VIC2xIntEnable = (int *) (VIC2_BASE + VICxIntEnable_OFFSET);
	*VIC2xIntEnable = 524288;

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
	asm volatile ("__HWI_HANDLER:");

	asm volatile (
		"msr CPSR_c, #0xdf\n\t"
		"stmfd sp!, {r1-r12, lr}\n\t"
		"msr CPSR, #0xd2\n\t"
		"mov ip, lr\n\t"
		"msr CPSR, #0xd3\n\t"
		"sub lr, ip, #4\n\t"
		"mov r9, #0\n\t"
		"b __END_OF_BRANCH__"
	);

	// SWI Handler
	asm volatile ( "__SWI_HANDLER:" );

	asm volatile (
		"msr CPSR_c, #0xdf\n\t"
		"stmfd sp!, {r1-r12, lr}\n\t"
		"msr cpsr, #0xd3\n\t"
		"mov r9, #1\n\t"
		"__END_OF_BRANCH__:"
	);



	// Pop kernel register from the stack (Automatic)
	asm volatile (
		"ldmfd sp!, {fp}"
	);
	
	asm volatile (
		"mov %0, r0"
		:"=r"(temp)
	);
	tds->rtn_value = temp;

	// Fill in request and argument

	
	


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

	asm volatile (
		"mov %0, r9"
		:"=r"(hwi)
	);

	

	

	// Acquire lr
	asm volatile(
		"mov ip, lr"
	);
	// Change to system state
	asm volatile (
		"msr CPSR_c, #0xdf"
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

	*VIC2xIntEnable = 0;

	volatile int *VIC1xIRQStatus = (int *) (VIC1_BASE + VICxIRQStatus_OFFSET);
	volatile int *VIC2xIRQStatus = (int *) (VIC2_BASE + VICxIRQStatus_OFFSET);
	volatile int status1 = *VIC1xIRQStatus;
	volatile int status2 = *VIC2xIRQStatus;

	if(hwi == 0) {
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

	asm volatile (
		"ldmfd sp!, {r0-r12, lr}"
	);
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
	volatile int hwi_handler_addr = 0;

	asm volatile (
		"ldr ip, =__SWI_HANDLER"
	);
	asm volatile (
		"mov %0, ip"
		:"=r"(swi_handler_addr)
	);

	*handler_addr = swi_handler_addr + 0x00218000;
	asm volatile (
		"ldr ip, =__HWI_HANDLER"
	);
	asm volatile (
		"mov %0, ip"
		:"=r"(hwi_handler_addr)
	);
	*irq_handler = hwi_handler_addr + 0x00218000;

	//enable IRQ
	int *VIC2xIntEnable = (int *) (VIC2_BASE + VICxIntEnable_OFFSET);
	*VIC2xIntEnable = 524288;
	//*VIC2xIntEnable |= (1 << 20);

	//enable IRQ in ICU
	int *VIC1xIntEnable = (int *) (VIC1_BASE + VICxIntEnable_OFFSET);
	//*VIC1xIntEnable = (3 << 25);
	*VIC1xIntEnable = (15 << 23);

	//set clock
	//set load
	int *timer_load = (int *)TIMER3_BASE;
	*timer_load = 5079;

	//set control bit
	int *timer_ctrl = (int *)(TIMER3_BASE + CRTL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;

	// enable UART interrupt
	int *UART2ctrl = (int *) (UART2_BASE + UART_CTLR_OFFSET);
	*UART2ctrl |= RIEN_MASK;
	//*UART2ctrl |= TIEN_MASK;

	int *UART1ctrl = (int *) (UART1_BASE + UART_CTLR_OFFSET);
	*UART1ctrl |= RIEN_MASK;
	//*UART1ctrl |= TIEN_MASK;
	//*UART1ctrl |= MSIEN_MASK;
	//*UART1ctrl |= 0x1;
}

