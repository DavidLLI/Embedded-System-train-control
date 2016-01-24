#include <bwio.h>
#include <data.h>

void enter_software_interrupt() {
	//bwprintf(COM2, "Enter swi\n\r");
	asm volatile(
		"swi #0"
	);

}

void first() {
	bwprintf(COM2, "user mode\n\r");
	enter_software_interrupt();
	bwprintf(COM2, "user mode back\n\r");
	enter_software_interrupt();
}

void initialize(td* tds) {
	// Task descriptor initialization
	tds->id = 1;
	tds->state = Ready;

	tds->stack_ptr = 0x800000;

	int usr_entry_point = &first + 0x00218000;

	asm volatile (
		"stmfd %0!, {%0, %1}"
		:"=r"(tds->stack_ptr)
		:"r"(usr_entry_point)
	);
	//int *stack_ptr = (int *)tds->stack_ptr;
	//*(stack_ptr) = (&first + 0x00218000);
	//*(stack_ptr - 1) = 0x7fa000;
	//tds->stack_ptr = 0x7f9ffc;

	tds->SPSR = 0xd0;
	tds->rtn_value = 0;

	// Set up swi table
	int *handler_addr = 0x28;
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

void activate(td* tds) {
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

	// Put return value into r0
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

int main() {
	bwsetfifo(COM2, OFF);
	td tds;
	initialize(&tds);

	int i = 0;
	for (i = 0; i < 3 ; i++) {
		activate(&tds);
	}
	return 0;
}
