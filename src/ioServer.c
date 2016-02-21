#include "ioServer.h"
#include "syscall.h"
#include "ts7200.h"
//#include "bwio.h"

#define BUFFER_SIZE 512


void COM1GetServer() {
	RegisterAs("COM1GetServer");
	ioReq req;
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
		Receive(&recv_id, &req, sizeof(struct ioRequest));
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
	RegisterAs("COM1PutServer");
	ioReq req;
	int recv_id = 0;

	char ring_buf[BUFFER_SIZE];
	int read_index = 0;
	int write_index = 0;
	int item_count = 0;

	char notifierWaiting = 0;
	int notifierID = 0;

	for (;;) {
		Receive(&recv_id, &req, sizeof(struct ioRequest));
		switch (req.type) {
			case 0: // Notifier
				if (item_count > 0) {
					char data = ring_buf[read_index];
					read_index = (read_index + 1) % BUFFER_SIZE;
					item_count--;
					Reply(recv_id, &data, sizeof(char));
				}
				else {
					notifierWaiting = 1;
					notifierID = recv_id;
				}
				break;
			case 1: // Put
				if (notifierWaiting == 1) {
					char reply = req.ch;
					Reply(notifierID, &reply, sizeof(char));
					notifierWaiting = 0;
				}
				else {
					ring_buf[write_index] = req.ch;
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
				}
				char reply = 0;
				Reply(recv_id, &reply, sizeof(char));
				break;
		}
	}
}

void COM2GetServer() {
	Create(3, &COM2GetNotifier);
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
	Create(4, &COM2PutNotifier);
	int ret = RegisterAs("COM2PutServer");
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
					ring_buf[write_index] = req.ch;
					//bwprintf(COM2, "put, no noti wait\n\r");
					write_index = (write_index + 1) % BUFFER_SIZE;
					item_count++;
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

	for(;;) {	
		int ret = AwaitEvent(xmt1);

		ioReq req;
		req.type = 0;
		req.ch = 'a';

		char c;

		ret = Send(svrTid, &req, sizeof(struct ioRequest), &c, sizeof(char));

		int *data = (int *)(UART1_BASE + UART_DATA_OFFSET);

		*data = c;
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
