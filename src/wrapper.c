#include "wrapper.h"
#include "bwio.h"
#include "helper.h"
#include "ts7200.h"
#include "syscall.h"


int RegisterAs(char *name) {
	struct ns_request r;
	r.type = 0;
	r.tid = MyTid();

	myMemCpy(r.name, name, 32);

	//bwprintf(COM2, "reg %s %d\n\r", name, sizeof(name)/sizeof(char));

	char msg[sizeof(struct ns_request)];

	myMemCpy(msg, &r, sizeof(struct ns_request));

	char reply[32];

	//bwprintf(COM2, "reg before send\n\r");
	int ret = Send(1, msg, sizeof(struct ns_request), reply, 32);
	if(ret != 32) bwprintf(COM2, "RegisterAs(), Send error.\n\r");
	//bwprintf(COM2, "reg after send\n\r");

	return myAtoi(reply);

}


int WhoIs(char *name) {
	struct ns_request r;
	r.type = 1;

	myMemCpy(r.name, name, 32);

	char msg[sizeof(struct ns_request)];

	myMemCpy(msg, &r, sizeof(struct ns_request));

	char reply[32];

	//bwprintf(COM2, "who before send\n\r");
	int ret = Send(1, msg, sizeof(struct ns_request), reply, 32);
	if(ret != 32) bwprintf(COM2, "WhoIs(), Send error.\n\r");
	//bwprintf(COM2, "who after send\n\r");

	return myAtoi(reply);
}


int Getc(int channel) {
	int serverID = 0;
	switch (channel) {
		case COM1:
			serverID = WhoIs("COM1GetServer");
			break;
		case COM2:
			serverID = WhoIs("COM2GetServer");
			break;
	}
	char req_type = 1;
	char ret = 0;
	Send(serverID, &req_type, sizeof(char), &ret, sizeof(char));
	return ret;
}

int Putc(int channel, char ch) {
	int serverID = 0;
	switch (channel) {
		case COM1:
			serverID = WhoIs("COM1PutServer");
			break;
		case COM2:
			serverID = WhoIs("COM2PutServer");
			break;
	}
	ioReq req;
	char reply = 0;
	req.type = 1;
	req.ch = ch;
	
	Send(serverID, &req, sizeof(struct ioRequest), &reply, sizeof(char));
	return 0;
}

int Time (void) {
	int clockServerTid = WhoIs("ClockServer");
	int current_time = 0;
	clockMsg msg;
	msg.type = 0;
	Send(clockServerTid, &msg, sizeof(struct clockMessage), &current_time, sizeof(int));
	return current_time;
}

int Delay(int ticks) {
	int clockServerTid = WhoIs("ClockServer");
	//bwprintf(COM2, "Clock server tid in delay: %d\n\r", clockServerTid);
	char c;
	clockMsg msg;
	msg.type = 1;
	msg.ticks = ticks;
	Send(clockServerTid, &msg, sizeof(struct clockMessage), &c, sizeof(char));
	return 0;
}

int DelayUntil(int ticks) {
	int clockServerTid = WhoIs("ClockServer");
	char c;
	clockMsg msg;
	msg.type = 2;
	msg.ticks = ticks;
	Send(clockServerTid, &msg, sizeof(struct clockMessage), &c, sizeof(char));
	return 0;
}

