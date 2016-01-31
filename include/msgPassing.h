#ifndef __MSGPASSING_H__
#define __MSGPASSING_H__

typedef struct message_information{
	int tid;
	void* msg;
	int msglen;
}msg_info;

typedef struct receive_buffer{
	int* tid;
	void* msg;
	int msglen;
}recv_buf;

#endif
