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
	int c1;
	int c2;
};


void server() {
	char name[] = "RPS";
	RegisterAs(name);

	struct match m_ary[20];
	int signup_counter = 0;

	for(;;) {
		char rcv[MSG_LEN];
		int sender;

		int ret = Receive(&sender, rcv, MSG_LEN);
		if(ret != MSG_LEN) bwprintf(COM2, "player(), Send error.\n\r");

		struct match* m;
		int id;
		char reply[MSG_LEN];

		int rcv_int = myAtoi(rcv);
		switch(rcv_int) {
		case -2:
			;
			m = &(m_ary[signup_counter/2]);
			if(signup_counter % 2) {
				m->tid2 = sender;
				m->c2 = -1;
			} else {
				m->tid1 = sender;
				m->c1 = -1;
			}
			bwprintf(COM2, "Server: signup request, tid: %d, pid: %d\n\r", sender, signup_counter);
			myItoa(signup_counter, reply);
			signup_counter++;
			Reply(sender, reply, MSG_LEN);

			break;
		case -1:
			;
			id = rcv_int / 10;
			m = &(m_ary[id/2]);

			myItoa(1, reply);
			//Reply(sender, reply, MSG_LEN);

			if(signup_counter % 2) {
				m->tid2 = -1;
				m->c2 = -1;
			} else {
				m->tid1 = -1;
				m->c1 = -1;
			}

			break;
		default:
			;
			int choice = rcv_int % 10;
			id = rcv_int / 10;

			bwprintf(COM2, "Server: play request, tid: %d, pid: %d, choice: %d\n\r",sender, id, choice);

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

					bwprintf(COM2, "Server: play result, player tid %d and player tid %d tie\n\r", m->tid1, m->tid2);

					Reply(m->tid1, reply, MSG_LEN);
					Reply(m->tid2, reply, MSG_LEN);
					
				} else if(m->c1 - m->c2 == -1 || (m->c1 == 3 && m->c2 == 0)) {
					//c1 win, c2 lose
					bwprintf(COM2, "Server: play result, player tid %d win and player tid %d lose\n\r", m->tid1, m->tid2);

					myItoa(1, reply);
					Reply(m->tid1, reply, MSG_LEN);
					myItoa(2, reply);
					Reply(m->tid2, reply, MSG_LEN);
				} else {
					//c1 lose, c2 win
					bwprintf(COM2, "Server: play result, player tid %d lose and player tid %d win\n\r", m->tid1, m->tid2);

					myItoa(2, reply);
					Reply(m->tid1, reply, MSG_LEN);
					myItoa(1, reply);
					Reply(m->tid2, reply, MSG_LEN);
				}

				m->c1 = -1;
				m->c2 = -1;

				//bwgetc(COM2);
			}
		}
	}
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

	int i;
	for(i = 0; i < 5; i++) {
		int choice = (*timer_value) % 3;
		int msg_int = pid * 10 + choice;
		char msg[MSG_LEN];
		myItoa(msg_int, msg);

		char reply2[MSG_LEN];

		//bwprintf(COM2, "			player before play\n\r");
		ret = Send(server_tid, msg, MSG_LEN, reply2, MSG_LEN);
		//bwprintf(COM2, "			player after play\n\r");
		if(ret != MSG_LEN) bwprintf(COM2, "player(), Send error.\n\r");

		if(myAtoi(reply2) == 0) {
			bwprintf(COM2, "Player id: %d, choice: %d, result: tie\n\r", pid, choice);
		} else if(myAtoi(reply2) == 1) {
			bwprintf(COM2, "Player id: %d, choice: %d, result: win\n\r", pid, choice);
		} else if(myAtoi(reply2) == 2) {
			bwprintf(COM2, "Player id: %d, choice: %d, result: lose\n\r", pid, choice);
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
	bwprintf(COM2, "Created name server: %d\n\r", ret);

	ret = Create(2, &server);
	bwprintf(COM2, "server Created: %d\n\r", ret);

	ret = Create(3, &player);
	bwprintf(COM2, "player 0 Created: %d\n\r", ret);

	ret = Create(3, &player);
	bwprintf(COM2, "player 1 Created: %d\n\r", ret);

	Exit();
}


/*
void send_task() {
	char send[] = "a";
	char reply[MSG_LEN];
	int actual_reply_size = 0;

	//timer init
	int *timer_load = (int *)TIMER2_BASE;
	*timer_load = *timer_load | 50000;

	int *timer_ctrl = (int *)(TIMER2_BASE + CRTL_OFFSET);
	*timer_ctrl = *timer_ctrl | ENABLE_MASK | MODE_MASK | CLKSEL_MASK;
	
	int *timer_value = (int *)(TIMER2_BASE + VAL_OFFSET);

	int time1 = *timer_value;

	actual_reply_size = Send(2, send, MSG_LEN, reply, MSG_LEN);

	int time2 = *timer_value;

	bwprintf(COM2, "first(), time: %d\n\r", time2 - time1);

	Exit();
}

void receive_and_reply_task() {
	char receive[MSG_LEN];
	int receive_size = MSG_LEN;
	int tid;
	receive_size = Receive(&tid, receive, MSG_LEN);
	char reply[] = "a";
	Reply(tid, reply, MSG_LEN);

	Exit();
}

void first() {

	bwputstr(COM2, "first enter\n\r");
	int ret;
	ret = Create(2, &send_task);
	bwprintf(COM2, "Created send, tid: %d\n\r", ret);

	ret = Create(1, &receive_and_reply_task);
	bwprintf(COM2, "Created receive, tid %d\n\r", ret);

	Exit();

*/
#endif
