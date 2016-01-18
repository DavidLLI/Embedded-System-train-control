#include "bwio.h"
#include "data.h"

int main(int argc, char *argv[]) {

	// declare kernel data structures
	pair td_pq[32];


	//initialize(td_pq); // tds is an array of TDs
	for(;;) {
		td *active = schedule(td_pq);

		// ???????
		if(active < 0) {
			bwputstr(COM2, "No more task to be scheduled. Kernel is exiting.");
			break;
		}

		//kerxit(active, req); // req is a pointer to a Request
		//handle(td_pq, req);
	}
	return 0;
}

