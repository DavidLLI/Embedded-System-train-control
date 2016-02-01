#ifndef __USERFUNCTION_H__
#define __USERFUNCTION_H__

#include "bwio.h"
#include "syscall.h"
#include "nameServer.h"
#include "ts7200.h"

#define MSG_LEN 4


void user() {
	bwprintf(COM2, "1--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Pass();

	bwprintf(COM2, "2--MyTid: %d, MyParentTid: %d\n\r", MyTid(), MyParentTid());
	Exit();
}

struct match {
	int tid1;
	int tid2;
	int pid1;
	int pid2;
	int c1;
	int c2;
};


void server() {
	char name[] = "RPS";
	RegisterAs(name);

	struct match m_ary[20];
	int signup_counter = 0;

	int dum = 0;

	for(;;) {
		char rcv[MSG_LEN];
		int sender;



		//bwprintf(COM2, "-------------------------------------------------------\n\r");
		//bwprintf(COM2, "~Game Start~\n\r");
		int ret = Receive(&sender, rcv, MSG_LEN);
		if(ret != MSG_LEN) bwprintf(COM2, "player(), Send error.\n\r");

		dum++;
		struct match* m;
		int id;
		char reply[MSG_LEN];

		if(dum == 50) {
			bwprintf(COM2, "\n\r---------------------------------------------\n\r");
			bwprintf(COM2, "Warning: There is no EASTER EGG in this game!\n\r");
			bwprintf(COM2, "---------------------------------------------\n\r\n\r");
		}

		if(dum == 60) {
			bwprintf(COM2, "\n\r---------------------------------------------\n\r");
			bwprintf(COM2, "I told you there is no EASTER EGG!\n\r");
			bwprintf(COM2, "---------------------------------------------\n\r\n\r");
		}		

		int rcv_int = myAtoi(rcv);
		switch(rcv_int) {
		case -2:
			;
			m = &(m_ary[signup_counter/2]);
			if(signup_counter % 2) {
				m->tid2 = sender;
				m->pid2 = signup_counter;
				m->c2 = -1;
			} else {
				m->tid1 = sender;
				m->pid1 = signup_counter;
				m->c1 = -1;
			}
			//bwprintf(COM2, "Server: signup request, tid: %d, pid: %d\n\r", sender, signup_counter);
			myItoa(signup_counter, reply);
			signup_counter++;
			Reply(sender, reply, MSG_LEN);

			break;
		case -1:
			;
			id = rcv_int / 10;
			m = &(m_ary[id/2]);

			myItoa(1, reply);
			Reply(sender, reply, MSG_LEN);

			if(signup_counter % 2) {
				m->tid2 = -1;
				m->c2 = -1;
			} else {
				m->tid1 = -1;
				m->c1 = -1;
			}

			signup_counter--;

			break;
		default:
			;
			int choice = rcv_int % 10;
			id = rcv_int / 10;

			char c;
			switch(choice) {
				case 0: 
					bwprintf(COM2, "---Player %d uses ROCK throw! (Geodude, is that you?)\n\r", id, c);
					break;
				case 1:
					bwprintf(COM2, "---Player %d shows CS 452 final exam PAPER! (Prof. Cowan, is that you?)\n\r", id, c);
					break;
				case 2:	
					bwprintf(COM2, "---Player %d uses SCISSORS to cut your eternet line! (NOOOOOOOOOOO!)\n\r", id, c);
					break;
			}

			m = &(m_ary[id/2]);
			if(id%2) {
				m->c2 = choice;
			} else {
				m->c1 = choice;
			}

			//bwprintf(COM2, "m->c1: %d, m->c2: %d\n\r", m->c1, m->c2);

			if(m->c1 >= 0 && m->c2 >= 0) {
				if(m->c1 == m->c2) {
					myItoa(0, reply);

					bwprintf(COM2, "*Result: TIE\n\r", m->pid1);
					switch(m->c1) {
						case 0:
							bwprintf(COM2, "It's not very effective...\n\r\n\r");
							break;
						case 1:
							bwprintf(COM2, "Both of you finish that final exam right now.\n\r\n\r" );
							break;
						case 2:
							bwprintf(COM2, "Fine, we can only use WIFI now...\n\r\n\r", m->pid2);
							break;
					}					

					Reply(m->tid1, reply, MSG_LEN);
					Reply(m->tid2, reply, MSG_LEN);
					
				} else if(m->c1 - m->c2 == 1 || (m->c1 == 0 && m->c2 == 2)) {
					//c1 win, c2 lose
					bwprintf(COM2, "*Result: Player %d win!\n\r", m->pid1);
					switch(m->c1) {
						case 0:
							bwprintf(COM2, "Thank god...\n\r\n\r");
							break;
						case 1:
							bwprintf(COM2, "Of course Geodude can't pass CS 452 final...\n\r\n\r" );
							break;
						case 2:
							bwprintf(COM2, "Player %d, are your sure u wanna cut that final exam as well?\n\r\n\r", m->pid2);
							break;
					}
					
					myItoa(1, reply);
					Reply(m->tid1, reply, MSG_LEN);
					myItoa(2, reply);
					Reply(m->tid2, reply, MSG_LEN);
				} else {
					//c1 lose, c2 win
					bwprintf(COM2, "*Result: Player %d win!\n\r", m->pid2);
					switch(m->c2) {
						case 0:
							bwprintf(COM2, "Charlie, you really need to stop.\n\r\n\r");
							break;
						case 1:
							bwprintf(COM2, "Of course Geodude can't pass CS 452 final...\n\r\n\r" );
							break;
						case 2:
							bwprintf(COM2, "Player %d, are your sure u wanna cut that final exam as well?\n\r\n\r", m->pid1);
							break;
					}

					myItoa(2, reply);
					Reply(m->tid1, reply, MSG_LEN);
					myItoa(1, reply);
					Reply(m->tid2, reply, MSG_LEN);
				}

				m->c1 = -1;
				m->c2 = -1;
			}
		}

		if(signup_counter == 0) break;
	}

	Exit();
}

void player() {
	int *timer_value = (int *)(TIMER2_BASE + VAL_OFFSET);

	char name[] = "RPS";
	int server_tid = WhoIs(name);
	//bwprintf(COM2, "Server id: %d\n\r", server_tid);
	int pid = -1;

	char reply1[MSG_LEN];

	int ret = Send(server_tid, "-2", MSG_LEN, reply1, MSG_LEN);
	

	if(ret != MSG_LEN) bwprintf(COM2, "player(), Send error.\n\r");
	if(myAtoi(reply1) < 0) bwprintf(COM2, "player %d, Signup failed.\n\r", MyTid());
	else pid = myAtoi(reply1);

	for(;;) {
		int choice = (*timer_value) % 3;
		int msg_int = pid * 10 + choice;
		char msg[MSG_LEN];
		myItoa(msg_int, msg);

		char reply2[MSG_LEN];

		//bwprintf(COM2, "			player before play\n\r");
		ret = Send(server_tid, msg, MSG_LEN, reply2, MSG_LEN);
		//bwprintf(COM2, "			player after play\n\r");
		if(ret != MSG_LEN) bwprintf(COM2, "player(), Send error.\n\r");

		char c;
		switch(choice) {
			case 0: 
				c = 'R';
				break;
			case 1:	
				c = 'P';
				break;
			case 2:	
				c = 'S';
				break;
		}

		/*
		if(myAtoi(reply2) == 0) {
			bwprintf(COM2, "Player id: %d, choice: %c, result: tie\n\r", pid, c);
		} else if(myAtoi(reply2) == 1) {
			bwprintf(COM2, "Player id: %d, choice: %c, result: win\n\r", pid, c);
		} else if(myAtoi(reply2) == 2) {
			bwprintf(COM2, "Player id: %d, choice: %c, result: lose\n\r", pid, c);
		}
		*/

		bwprintf(COM2, "					Player %d, it's your turn. Press ENTER to accept the challenge or type q to quit.\n\r", pid);

		char cmd = bwgetc(COM2);

		if(cmd == 'q') {
			ret = Send(server_tid, "-1", MSG_LEN, reply2, MSG_LEN);
			break;
		}
	}

	Exit();
}



void first() {

	//timer init
	int *timer_load = (int *)TIMER2_BASE;
	*timer_load = *timer_load | 50000;

	int *timer_ctrl = (int *)(TIMER2_BASE + CRTL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;


	int ret;
	ret = Create(1, &nameServer);
	//bwprintf(COM2, "Created name server: %d\n\r", ret);

	ret = Create(2, &server);
	//bwprintf(COM2, "RPS server Created: %d\n\r", ret);

	ret = Create(3, &player);
	//bwprintf(COM2, "player 0 Created: %d\n\r", ret);

	ret = Create(3, &player);
	//bwprintf(COM2, "player 1 Created: %d\n\r", ret);

	Exit();
}

#endif

