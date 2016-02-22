#include "kernelFunction.h"
#include "syscall.h"
#include "ts7200.h"
#include "contextSwitch.h"
#include "helper.h"
#include "bwio.h"


void handle(pair *td_pq, td *td_ary, req request, int *task_id_counter) {
	//bwprintf(COM2, "handle\n\r");
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


void handle_block(struct blk_td *blk_ary, struct blk_pair *pair, req request, int *asserted) {
	(request.task)->swi_hwi = 0;

	int *UART1ctrl = (int *) (UART1_BASE + UART_CTLR_OFFSET);
	int *UART2ctrl = (int *) (UART2_BASE + UART_CTLR_OFFSET);

	switch(request.type) {
		case 8: // AwaitEvent
			;
			(request.task)->state = Event_Blk;

			struct blk_td *blk = &(blk_ary[(request.task)->id]);

			blk->tid = (request.task)->id;;
			blk->event_type = request.arg1;
			blk->task = request.task;

			switch(blk->event_type) {
				case xmt1:
					if(*asserted == 2) {
						*asserted = 0;
					} else {
						*UART1ctrl |= TIEN_MASK;
					}
					break;
				case xmt2:
					*UART2ctrl |= TIEN_MASK;
					break;
				default:
					break;
			}

			if(pair->head != 0 && pair->tail != 0) {
				(pair->tail)->nxt = blk;
				blk->prv = (pair->tail);
				blk->nxt = 0;
				pair->tail = blk;
			} else {
				pair->head = blk;
				pair->tail = blk;
				blk->nxt = 0;
				blk->prv = 0;
			}

			break;
		case 9: // hardware interrupt
			;
			(request.task)->swi_hwi = 1;
			//bwprintf(COM2, "Hardware Interrupt\n\r");
			int event = -1;
			int *UART1_INTR_OFFSET = (int *) (UART1_BASE + UART_INTR_OFFSET);
			int *UART2_INTR_OFFSET = (int *) (UART2_BASE + UART_INTR_OFFSET);

			if(request.arg2 & (1 << 19)) {
				event = timer3;

				volatile int *timer_clr = (int *) (TIMER3_BASE + CLR_OFFSET);
				*timer_clr = 1;
				//int *VIC2xIntEnClear = (int *) (VIC2_BASE + VICxIntEnClear_OFFSET);
				//*VIC2xIntEnClear = 524288;
			} else if (*UART1_INTR_OFFSET & RIS_MASK) {
				event = rcv1;
				//*UART1_INTR_OFFSET = 1;
			} else if (*UART1_INTR_OFFSET & TIS_MASK) {
				event = xmt1;
				//bwprintf(COM2, "transmit com1 interrupt\n\r");
				/*if (*asserted == 1) {
					event = xmt1;
					*asserted = 0;
				}
				else {
					*asserted = 1;
				}
				int nops_i = 0;
				for (nops_i = 0; nops_i < 30; nops_i++) {
					asm volatile ("nop");
				}*/
				*UART1ctrl &= ~(TIEN_MASK);
				*asserted = 2;

			} else if (*UART2_INTR_OFFSET & RIS_MASK) {
				event = rcv2;
				//*UART2_INTR_OFFSET = 1;
				//int *UART2ctrl = (int *) (UART2_BASE + UART_CTLR_OFFSET);
				//*UART2ctrl &= ~(RIEN_MASK);
			} else if (*UART2_INTR_OFFSET & TIS_MASK) {
				event = xmt2;

				*UART2ctrl &= ~(TIEN_MASK);
				//*UART2_INTR_OFFSET = 1;
			}

			int *flag = (int *) (UART1_BASE + UART_FLAG_OFFSET);
			int *mdmSts = (int *) (UART1_BASE + UART_MDMSTS_OFFSET);
			if((*mdmSts & DCTS_MASK) && (*flag & CTS_MASK) && (*asserted == 0)) {
				*UART1ctrl |= TIEN_MASK;
				*asserted = 2;
			}
			
			/*if(*UART1_INTR_OFFSET & MIS_MASK) {
				//bwprintf(COM2, "modem status interrupt\n\r");
				if (*asserted == 1) {
					event = xmt1;
					*asserted = 0;
				}
				else {
					*asserted = 1;
				}
				// Clear the modem status interrupt
				*UART1_INTR_OFFSET = 1;
			}*/

			//bwprintf(COM2, "event: %d\n\r", event);
			struct blk_td *current = pair->head;
			for(;;) {
				if(current == 0) break;
				else {
					if(current->event_type == event) {
						//bwprintf(COM2, "event: %d\n\r", event);
						(current->task)->state = Ready;
						if(event == rcv2) {
							int *data = (int *)(UART2_BASE + UART_DATA_OFFSET);
							char c = *data;
							(current->task)->rtn_value = c;
							//int *UART2ctrl = (int *) (UART2_BASE + UART_CTLR_OFFSET);
							//*UART2ctrl |= RIEN_MASK;
						} else if(event == rcv1) {
							int *data = (int *)(UART1_BASE + UART_DATA_OFFSET);
							char c = *data;
							(current->task)->rtn_value = c;
						} else {
							(current->task)->rtn_value = 0;
						}
						

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

