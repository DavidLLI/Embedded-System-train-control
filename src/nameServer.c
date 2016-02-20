#include "nameServer.h"
#include "syscall.h"
//#include "bwio.h"
#include "helper.h"

struct server {
	char name[32];
	int tid;
	struct server *prv;
	struct server *nxt;
};

void nameServer(void) {
	struct server svr_ary[20];
	struct server *head = 0;
	struct server *tail = 0;
	int svr_counter = 0;

	for(;;) {
		
		int reply = -1;
		struct ns_request req;
		int sender;

		//bwprintf(COM2, "ns before Receive\n\r");
		int ret = Receive(&sender, &req, sizeof(struct ns_request));
		//bwprintf(COM2, "ns after Receive\n\r");

		//if(ret != sizeof(struct ns_request)) bwprintf(COM2, "nameServer(), reveive error.\n\r");
		

		//bwprintf(COM2, "type:%d, name:%s\n\r, size: %d", req.type, req.name, sizeof(struct ns_request));

		switch(req.type) {
			case 0:			//RegisterAs
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
					reply = 0;			
				}

				//bwprintf(COM2, "ns before reply to %d\n\r", sender);
				Reply(sender, &reply, sizeof(int));
				//bwprintf(COM2, "ns after Receive\n\r");
				//bwprintf(COM2, "%s registered\n\r", tail->name);
				break;
			case 1:			// WhoIs
				;
				//bwprintf(COM2, "ns accept who req\n\r");
				struct server *current = head;
				while(current != 0) {
					if(myStrcmp(current->name, req.name) == 0) {
						reply = current->tid;
						//bwprintf(COM2, "ns found whois %s\n\r", reply);
						break;
					}
					current = current->nxt;
				}

				//bwprintf(COM2, "ns before reply to %d\n\r", sender);
				Reply(sender, &reply, sizeof(int));
				//bwprintf(COM2, "ns after reply\n\r");
				break;
			default:
				//Invalid request type
				//bwprintf(COM2, "Invalid request type\n\r");
				break;
		}
	}
}
