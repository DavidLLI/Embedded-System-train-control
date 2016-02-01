#ifndef __NAMESERVER_H__
#define __NAMESERVER_H__

#include "syscall.h"
#include "bwio.h"

/*
struct ns_request {
	int type;		// 0 -- RegisterAs, 1 -- WhoIs
	int tid;
	char name[32]; 	// max length of name is 32
};
*/

struct server {
	char name[32];
	int tid;
	struct server *prv;
	struct server *nxt;
};

void nameServer() {
	struct server svr_ary[20];
	struct server *head = 0;
	struct server *tail = 0;
	int svr_counter = 0;

	for(;;) {
		char msg[sizeof(struct ns_request)];
		char reply[32];
		struct ns_request req;
		int sender;

		//bwprintf(COM2, "ns before Receive\n\r");
		int ret = Receive(&sender, msg, sizeof(struct ns_request));
		//bwprintf(COM2, "ns after Receive\n\r");

		if(ret != sizeof(struct ns_request)) bwprintf(COM2, "nameServer(), reveive error.\n\r");
		myMemCpy(&req, msg, sizeof(struct ns_request));

		//bwprintf(COM2, "type:%d, name:%s\n\r, size: %d", req.type, req.name, sizeof(struct ns_request));

		switch(req.type) {
			case 0:			//registerAs
				;
				if(svr_counter <= 20) {
					struct server *svr = &(svr_ary[svr_counter]);
					svr_counter++;
					myMemCpy(svr->name, req.name, 32);

					svr->tid = req.tid;
					if(head == 0) {
						head = svr;
						tail = svr;
						svr->prv = 0;
						svr->nxt = 0;
					} else {
						tail->nxt = svr;
						svr->prv = tail;
						svr->nxt = 0;
						tail = svr;
					}
					myItoa(0, reply);			
				} else {
					myItoa(-1, reply);
				}

				//bwprintf(COM2, "ns before reply to %d\n\r", sender);
				Reply(sender, reply, sizeof(reply)/sizeof(char));
				//bwprintf(COM2, "ns after Receive\n\r");
				//bwprintf(COM2, "%s registered\n\r", tail->name);
				break;
			case 1:			// whoIs
				;
				//bwprintf(COM2, "ns accept who req\n\r");
				struct server *current = head;
				myItoa(-1, reply);
				while(current != 0) {
					if(myStrcmp(current->name, req.name) == 0) {
						myItoa(current->tid, reply);
						//bwprintf(COM2, "ns found whois %s\n\r", reply);
						break;
					}
					current = current->nxt;
				}

				//bwprintf(COM2, "ns before reply to %d\n\r", sender);
				Reply(sender, reply, sizeof(reply)/sizeof(char));
				//bwprintf(COM2, "ns after reply\n\r");
				break;
			default:
				bwprintf(COM2, "Invalid request type\n\r");
		}
	}

}

#endif

