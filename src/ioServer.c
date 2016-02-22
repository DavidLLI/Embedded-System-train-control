#include "ioServer.h"
#include "syscall.h"
#include "ts7200.h"
//#include "bwio.h"

#define BUFFER_SIZE 512

#define COM1GetNotifier_Priority 4
#define COM1PutNotifier_Priority 7
#define COM2GetNotifier_Priority 3
#define COM2PutNotifier_Priority 25
#define Courier1_Priority 11
#define Courier2_Priority 27



void COM1GetServer() {
	Create(COM1GetNotifier_Priority, &COM1GetNotifier);
	RegisterAs("COM1GetServer");
	int recv_id = 0;
	
	char ring_buf[BUFFER_SIZE];
	int read_index = 0;
	int write_index = 0;
	int item_count = 0;

	int queue_buf[88];
	int r_in = 0;
	int w_in = 0;
	int queue_count = 0;

	for (;;) {
		ioReq req;
		Receive(&recv_id, &req, sizeof(struct ioRequest));
		//Printf(COM2, "recv_id: %d, req_type: %d\n\r", recv_id, req.type);
		switch (req.type) {
			case 0: // Notifier
				;
				char data = req.ch;
				if (queue_count > 0) {
					char reply = data;
					int re_id = queue_buf[r_in];
					r_in = (r_in + 1) % 88;
					queue_count--;
					Reply(re_id, &reply, sizeof(char));
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					char reply = 0;
					ring_buf[write_index] = data;
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
					Reply(recv_id, &reply, sizeof(char));
				}

				break;
			case 1: // Get 
				if (item_count > 0) {
					char reply = ring_buf[read_index];
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
	int recv_id = 0;
	
	char ring_buf[BUFFER_SIZE];
	int read_index = 0;
	int write_index = 0;
	int item_count = 0;

	char notifierWaiting = 0;
	int notifierID = 0;

	int *flags = (int *) (UART2_BASE + UART_FLAG_OFFSET);

	for (;;) {
		volatile ioReq req;
		//char msg[sizeof(struct ioRequest)];

		//bwprintf(COM2, "server before received\n\r");
		Receive(&recv_id, &req, sizeof(struct ioRequest));

		//myMemCpy(&req, msg, sizeof(struct ioRequest));
		//bwprintf(COM2, "server received req %d from id %d\n\r", req.type, recv_id);
		switch (req.type) {
			case 0: // Notifier
				if (item_count > 0) {
					char data = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					//bwprintf(COM2, "noti, server reply\n\r");
					Reply(recv_id, &data, sizeof(char));
				}
				else {
					//bwprintf(COM2, "noti, no put\n\r");
					notifierWaiting = 1;
					notifierID = recv_id;
				}
				break;
			case 1: // Put
				if (notifierWaiting == 1) {
					char reply = req.ch;
					//bwprintf(COM2, "put server reply to noti\n\r");
					Reply(notifierID, &reply, sizeof(char));
					notifierWaiting = 0;
				}
				else {
					if(item_count < BUFFER_SIZE - 1) {
						ring_buf[write_index] = req.ch;
						//bwprintf(COM2, "put, no noti wait\n\r");
						write_index = (write_index + 1) % BUFFER_SIZE;
						item_count++;
					}
				}
				char reply = 0;
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
	int recv_id = 0;
	
	char ring_buf[BUFFER_SIZE];
	int read_index = 0;
	int write_index = 0;
	int item_count = 0;

	int queue_buf[88];
	int r_in = 0;
	int w_in = 0;
	int queue_count = 0;

	for (;;) {
		ioReq req;
		Receive(&recv_id, &req, sizeof(struct ioRequest));
		//Printf(COM2, "recv_id: %d, req_type: %d\n\r", recv_id, req.type);
		switch (req.type) {
			case 0: // Notifier
				;
				char data = req.ch;
				if (queue_count > 0) {
					char reply = data;
					int re_id = queue_buf[r_in];
					r_in = (r_in + 1) % 88;
					queue_count--;
					Reply(re_id, &reply, sizeof(char));
					Reply(recv_id, &reply, sizeof(char));
				}
				else {
					char reply = 0;
					ring_buf[write_index] = data;
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
					Reply(recv_id, &reply, sizeof(char));
				}

				break;
			case 1: // Get 
				if (item_count > 0) {
					char reply = ring_buf[read_index];
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
	int ret = RegisterAs("COM2PutServer");
	Create(Courier2_Priority, &Courier2);
	//bwprintf(COM2, "server register ret %d\n\r", ret);
	int recv_id = 0;
	
	char ring_buf[BUFFER_SIZE];
	int read_index = 0;
	int write_index = 0;
	int item_count = 0;

	char notifierWaiting = 0;
	int notifierID = 0;

	int *flags = (int *) (UART2_BASE + UART_FLAG_OFFSET);

	for (;;) {
		volatile ioReq req;
		//char msg[sizeof(struct ioRequest)];

		//bwprintf(COM2, "server before received\n\r");
		Receive(&recv_id, &req, sizeof(struct ioRequest));

		//myMemCpy(&req, msg, sizeof(struct ioRequest));
		//bwprintf(COM2, "server received req %d from id %d\n\r", req.type, recv_id);
		switch (req.type) {
			case 0: // Notifier
				if (item_count > 0) {
					char data = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					//bwprintf(COM2, "noti, server reply\n\r");
					Reply(recv_id, &data, sizeof(char));
				}
				else {
					//bwprintf(COM2, "noti, no put\n\r");
					notifierWaiting = 1;
					notifierID = recv_id;
				}
				break;
			case 1: // Put
				if (notifierWaiting == 1) {
					char reply = req.ch;
					//bwprintf(COM2, "put server reply to noti\n\r");
					Reply(notifierID, &reply, sizeof(char));
					notifierWaiting = 0;
				}
				else {
					if (item_count < BUFFER_SIZE - 1) {
						ring_buf[write_index] = req.ch;
						//bwprintf(COM2, "put, no noti wait\n\r");
						write_index = (write_index + 1) % BUFFER_SIZE;
						item_count++;
					}
				}
				char reply = 0;
				Reply(recv_id, &reply, sizeof(char));
				break;
			default:
				//unknown request
				break;
		}
	}
}



void COM1GetNotifier() {
	int svrTid =  MyParentTid();

	for (;;) {
		int ret = AwaitEvent(rcv1);

		ioReq req;
		req.type = 0;
		req.ch = ret;
		char c;

		Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));
	}
}

void COM1PutNotifier() {
	int svrTid = MyParentTid();
	int first = 1;

	//Putc(COM2, 'e');
	for(;;) {	
		int ret = AwaitEvent(xmt1);
		//Printf(COM2, "Return from event\n\r");

		ioReq req;
		req.type = 0;
		req.ch = 'a';

		char c;

		ret = Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));

		int *data = (int *) (UART1_BASE + UART_DATA_OFFSET);
		*data = c;
		/*
		int *flag = (int *) (UART1_BASE + UART_FLAG_OFFSET);
		int *mdmSts = (int *) (UART1_BASE + UART_MDMSTS_OFFSET);

		for(;;) {
			if(first && (*flag & CTS_MASK)) {
				int *data = (int *) (UART1_BASE + UART_DATA_OFFSET);
				*data = c;
				first = 0;

				//Printf(COM2, "%x", c);

				//Putc(COM2, 's');
				break;					
			}
			else if((*mdmSts & DCTS_MASK) && (*flag & CTS_MASK)) {
				int *data = (int *) (UART1_BASE + UART_DATA_OFFSET);
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
	int svrTid = MyParentTid();

	for (;;) {

		char ret = AwaitEvent(rcv2);
		//Printf(COM2, "await return\n\r");

		ioReq req;
		req.type = 0;
		req.ch = ret;
		char c;

		Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));
		//Printf(COM2, "send return\n\r");
	}
}

void COM2PutNotifier() {
	int svrTid = MyParentTid();
	//bwprintf(COM2, "put noti\n\r");

	for(;;) {
		int ret = AwaitEvent(xmt2);

		ioReq req;
		req.type = 0;
		req.ch = 'a';

		char c;

		
		ret = Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));

		int *data = (int *)(UART2_BASE + UART_DATA_OFFSET);

		*data = c;
	}
}

void Courier1() {
	RegisterAs("Courier1");
	int recv_id = 0;
	char buffer[100];
	int i = 0;
	int size = 0;
	for (i = 0; i < 100; i++) {
		buffer[i] = 0;
	}
	for(;;) {

		size = Receive(&recv_id, buffer, 100);
		char c = 0;
		Reply(recv_id, c, sizeof(char));
		int i = 0;
		for (i = 0; i < size; i++) {
			Putc(COM1, buffer[i]);
			buffer[i] = 0;
		}
	}
}

void Courier2() {
	RegisterAs("Courier2");
	int recv_id = 0;
	char buffer[100];
	int i = 0;
	int size = 0;
	for (i = 0; i < 100; i++) {
		buffer[i] = 0;
	}
	for(;;) {

		size = Receive(&recv_id, buffer, 100);
		char c = 0;
		Reply(recv_id, c, sizeof(char));
		int i = 0;
		for (i = 0; i < size; i++) {
			Putc(COM2, buffer[i]);
			buffer[i] = 0;
		}
	}
}
