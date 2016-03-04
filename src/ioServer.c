#include "ioServer.h"
#include "syscall.h"
#include "ts7200.h"
//#include "bwio.h"

#define BUFFER_SIZE 512

#define COM1GetNotifier_Priority 3
#define COM1PutNotifier_Priority 7
#define COM2GetNotifier_Priority 27
#define COM2PutNotifier_Priority 25
#define Courier1_Priority 11
#define Courier2_Priority 27



void COM1GetServer() {
	Create(COM1GetNotifier_Priority, &COM1GetNotifier);
	RegisterAs("COM1GetServer");
	volatile int recv_id = 0;
	
	volatile char ring_buf[BUFFER_SIZE];
	volatile int read_index = 0;
	volatile int write_index = 0;
	volatile int item_count = 0;

	volatile int queue_buf[88];
	volatile int r_in = 0;
	volatile int w_in = 0;
	volatile int queue_count = 0;

	for (;;) {
		volatile ioReq req;
		Receive(&recv_id, &req, sizeof(struct ioRequest));
		//Prvolatile intf(COM2, "recv_id: %d, req_type: %d\n\r", recv_id, req.type);
		switch (req.type) {
			case 0: // Notifier
				;
				volatile char data = req.ch;
				if (queue_count > 0) {
					volatile char reply = data;
					volatile int re_id = queue_buf[r_in];
					r_in = (r_in + 1) % 88;
					queue_count--;
					Reply(re_id, &reply, sizeof(char));
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					volatile char reply = 0;
					ring_buf[write_index] = data;
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
					Reply(recv_id, &reply, sizeof(char));
				}

				break;
			case 1: // Get 
				if (item_count > 0) {
					volatile char reply = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					queue_buf[w_in] = recv_id;
					w_in = (w_in + 1) % 88;
					queue_count++;
				}
				break;
		}
	}
}

void COM1PutServer() {
	Create(COM1PutNotifier_Priority, &COM1PutNotifier);
	RegisterAs("COM1PutServer");
	Create(Courier1_Priority, &Courier1);
	volatile int recv_id = 0;
	
	volatile char ring_buf[BUFFER_SIZE];
	volatile int read_index = 0;
	volatile int write_index = 0;
	volatile int item_count = 0;

	volatile char notifierWaiting = 0;
	volatile int notifierID = 0;

	for (;;) {
		volatile ioReq req;
		//volatile char msg[sizeof(struct ioRequest)];

		//bwprvolatile intf(COM2, "server before received\n\r");
		Receive(&recv_id, &req, sizeof(struct ioRequest));

		//myMemCpy(&req, msg, sizeof(struct ioRequest));
		//bwprvolatile intf(COM2, "server received req %d from id %d\n\r", req.type, recv_id);
		switch (req.type) {
			case 0: // Notifier
				if (item_count > 0) {
					volatile char data = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					//bwprvolatile intf(COM2, "noti, server reply\n\r");
					Reply(recv_id, &data, sizeof(char));
				}
				else {
					//bwprvolatile intf(COM2, "noti, no put\n\r");
					notifierWaiting = 1;
					notifierID = recv_id;
				}
				break;
			case 1: // Put
				if (notifierWaiting == 1) {
					volatile char reply = req.ch;
					//bwprvolatile intf(COM2, "put server reply to noti\n\r");
					Reply(notifierID, &reply, sizeof(char));
					notifierWaiting = 0;
				}
				else {
					if(item_count < BUFFER_SIZE - 1) {
						ring_buf[write_index] = req.ch;
						//bwprvolatile intf(COM2, "put, no noti wait\n\r");
						write_index = (write_index + 1) % BUFFER_SIZE;
						item_count++;
					}
				}
				volatile char reply = 0;
				Reply(recv_id, &reply, sizeof(char));
				break;
			default:
				//unknown request
				break;
		}
	}
}

void COM2GetServer() {
	Create(COM2GetNotifier_Priority, &COM2GetNotifier);
	RegisterAs("COM2GetServer");
	volatile int recv_id = 0;
	
	volatile char ring_buf[BUFFER_SIZE];
	volatile int read_index = 0;
	volatile int write_index = 0;
	volatile int item_count = 0;

	volatile int queue_buf[88];
	volatile int r_in = 0;
	volatile int w_in = 0;
	volatile int queue_count = 0;

	for (;;) {
		volatile ioReq req;
		Receive(&recv_id, &req, sizeof(struct ioRequest));
		//Prvolatile intf(COM2, "recv_id: %d, req_type: %d\n\r", recv_id, req.type);
		switch (req.type) {
			case 0: // Notifier
				;
				volatile char data = req.ch;
				if (queue_count > 0) {
					volatile char reply = data;
					volatile int re_id = queue_buf[r_in];
					r_in = (r_in + 1) % 88;
					queue_count--;
					Reply(re_id, &reply, sizeof(char));
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					volatile char reply = 0;
					ring_buf[write_index] = data;
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
					Reply(recv_id, &reply, sizeof(char));
				}

				break;
			case 1: // Get 
				if (item_count > 0) {
					volatile char reply = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					queue_buf[w_in] = recv_id;
					w_in = (w_in + 1) % 88;
					queue_count++;
				}
				break;
		}
	}
}

void COM2PutServer() {
	Create(COM2PutNotifier_Priority, &COM2PutNotifier);
	RegisterAs("COM2PutServer");
	Create(Courier2_Priority, &Courier2);
	//bwprvolatile intf(COM2, "server register ret %d\n\r", ret);
	volatile int recv_id = 0;
	
	volatile char ring_buf[BUFFER_SIZE];
	volatile int read_index = 0;
	volatile int write_index = 0;
	volatile int item_count = 0;

	volatile char notifierWaiting = 0;
	volatile int notifierID = 0;

	for (;;) {
		volatile ioReq req;
		//volatile char msg[sizeof(struct ioRequest)];

		//bwprvolatile intf(COM2, "server before received\n\r");
		Receive(&recv_id, &req, sizeof(struct ioRequest));

		//myMemCpy(&req, msg, sizeof(struct ioRequest));
		//bwprvolatile intf(COM2, "server received req %d from id %d\n\r", req.type, recv_id);
		switch (req.type) {
			case 0: // Notifier
				if (item_count > 0) {
					volatile char data = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					//bwprvolatile intf(COM2, "noti, server reply\n\r");
					Reply(recv_id, &data, sizeof(char));
				}
				else {
					//bwprvolatile intf(COM2, "noti, no put\n\r");
					notifierWaiting = 1;
					notifierID = recv_id;
				}
				break;
			case 1: // Put
				if (notifierWaiting == 1) {
					volatile char reply = req.ch;
					//bwprvolatile intf(COM2, "put server reply to noti\n\r");
					Reply(notifierID, &reply, sizeof(char));
					notifierWaiting = 0;
				}
				else {
					if (item_count < BUFFER_SIZE - 1) {
						ring_buf[write_index] = req.ch;
						//bwprvolatile intf(COM2, "put, no noti wait\n\r");
						write_index = (write_index + 1) % BUFFER_SIZE;
						item_count++;
					}
				}
				volatile char reply = 0;
				Reply(recv_id, &reply, sizeof(char));
				break;
			default:
				//unknown request
				break;
		}
	}
}



void COM1GetNotifier() {
	volatile int svrTid =  MyParentTid();

	for (;;) {
		volatile int ret = AwaitEvent(rcv1);

		volatile ioReq req;
		req.type = 0;
		req.ch = ret;
		volatile char c;

		Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));
	}
}

void COM1PutNotifier() {
	volatile int svrTid = MyParentTid();

	//Putc(COM2, 'e');
	for(;;) {	
		volatile int ret = AwaitEvent(xmt1);
		//Prvolatile intf(COM2, "Return from event\n\r");

		volatile ioReq req;
		req.type = 0;
		req.ch = 'a';

		volatile char c;

		ret = Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));

		volatile int *data = (volatile int *) (UART1_BASE + UART_DATA_OFFSET);
		*data = c;
		/*
		volatile int *flag = (volatile int *) (UART1_BASE + UART_FLAG_OFFSET);
		volatile int *mdmSts = (volatile int *) (UART1_BASE + UART_MDMSTS_OFFSET);

		for(;;) {
			if(first && (*flag & CTS_MASK)) {
				volatile int *data = (volatile int *) (UART1_BASE + UART_DATA_OFFSET);
				*data = c;
				first = 0;

				//Prvolatile intf(COM2, "%x", c);

				//Putc(COM2, 's');
				break;					
			}
			else if((*mdmSts & DCTS_MASK) && (*flag & CTS_MASK)) {
				volatile int *data = (volatile int *) (UART1_BASE + UART_DATA_OFFSET);
				*data = c;
				//Putc(COM2, 't');
				break;			
			}	
			Delay(1);		
		}
		*/

	}
}

void COM2GetNotifier() {
	volatile int svrTid = MyParentTid();

	for (;;) {

		volatile char ret = AwaitEvent(rcv2);
		//Prvolatile intf(COM2, "await return\n\r");

		volatile ioReq req;
		req.type = 0;
		req.ch = ret;
		volatile char c;

		Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));
		//Prvolatile intf(COM2, "send return\n\r");
	}
}

void COM2PutNotifier() {
	volatile int svrTid = MyParentTid();
	//bwprvolatile intf(COM2, "put noti\n\r");

	for(;;) {
		volatile int ret = AwaitEvent(xmt2);

		volatile ioReq req;
		req.type = 0;
		req.ch = 'a';

		volatile char c;

		
		ret = Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));

		volatile int *data = (volatile int *)(UART2_BASE + UART_DATA_OFFSET);

		*data = c;
	}
}

void Courier1() {
	RegisterAs("Courier1");
	volatile int recv_id = 0;
	volatile char buffer[100];
	volatile int i = 0;
	volatile int size = 0;
	for (i = 0; i < 100; i++) {
		buffer[i] = 0;
	}
	for(;;) {

		size = Receive(&recv_id, buffer, 100);
		volatile char c = 0;
		Reply(recv_id, &c, sizeof(char));
		volatile int i = 0;
		for (i = 0; i < size; i++) {
			Putc(COM1, buffer[i]);
			buffer[i] = 0;
		}
	}
}

void Courier2() {
	RegisterAs("Courier2");
	volatile int recv_id = 0;
	volatile char buffer[100];
	volatile int i = 0;
	volatile int size = 0;
	for (i = 0; i < 100; i++) {
		buffer[i] = 0;
	}
	for(;;) {

		size = Receive(&recv_id, buffer, 100);
		volatile char c = 0;
		Reply(recv_id, &c, sizeof(char));
		volatile int i = 0;
		for (i = 0; i < size; i++) {
			Putc(COM2, buffer[i]);
			buffer[i] = 0;
		}
	}
}
