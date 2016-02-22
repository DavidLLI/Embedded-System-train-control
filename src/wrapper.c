#include "wrapper.h"
//#include "bwio.h"
#include "helper.h"
#include "ts7200.h"
#include "syscall.h"


int RegisterAs(char *name) {
	struct ns_request r;
	r.type = 0;
	r.tid = MyTid();

	myMemCpy(r.name, name, 32);

	//bwprintf(COM2, "reg %s %d\n\r", name, sizeof(name)/sizeof(char));

	int reply;

	//bwprintf(COM2, "reg before send\n\r");
	int ret = Send(1, &r, sizeof(struct ns_request), &reply, sizeof(int));
	//if(ret != sizeof(int)) bwprintf(COM2, "RegisterAs(), Send error.\n\r");
	//bwprintf(COM2, "reg after send\n\r");

	return reply;

}


int WhoIs(char *name) {
	struct ns_request r;
	int reply;

	r.type = 1;
	myMemCpy(r.name, name, 32);

	//bwprintf(COM2, "who before send\n\r");
	int ret = Send(1, &r, sizeof(struct ns_request), &reply, sizeof(int));
	//if(ret != sizeof(int)) bwprintf(COM2, "WhoIs(), Send error.\n\r");
	//bwprintf(COM2, "who after send\n\r");

	return reply;
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
	ioReq req;
	req.type = 1;
	char ret = 0;
	Send(serverID, &req, sizeof(struct ioRequest), &ret, sizeof(char));
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

int Insert(char* channel, char c, int* counter) {
	channel[*counter] = c;
	(*counter) ++;
}

char myc2x( char ch ) {
	if ( (ch <= 9) ) return '0' + ch;
	return 'a' + ch - 10;
}

int putx( char* channel, char c, int *counter ) {
	char chh, chl;

	chh = myc2x( c / 16 );
	chl = myc2x( c % 16 );
	Insert( channel, chh, counter );
	return Insert( channel, chl, counter );
}

int putr( char* channel, unsigned int reg, int* counter ) {
	int byte;
	char *ch = (char *) &reg;

	for( byte = 3; byte >= 0; byte-- ) putx( channel, ch[byte], counter );
	return Insert( channel, ' ', counter );
}

int putstr( char* channel, char *str, int* counter ) {
	while( *str ) {
		if( Insert( channel, *str, counter ) < 0 ) return -1;
		str++;
	}
	return 0;
}

void putw( char* channel, int n, char fc, char *bf, int* counter ) {
	char ch;
	char *p = bf;

	while( *p++ && n > 0 ) n--;
	while( n-- > 0 ) Insert( channel, fc, counter );
	while( ( ch = *bf++ ) ) Insert( channel, ch, counter );
}


int a2d( char ch ) {
	if( ch >= '0' && ch <= '9' ) return ch - '0';
	if( ch >= 'a' && ch <= 'f' ) return ch - 'a' + 10;
	if( ch >= 'A' && ch <= 'F' ) return ch - 'A' + 10;
	return -1;
}

char a2i( char ch, char **src, int base, int *nump ) {
	int num, digit;
	char *p;

	p = *src; num = 0;
	while( ( digit = a2d( ch ) ) >= 0 ) {
		if ( digit > base ) break;
		num = num*base + digit;
		ch = *p++;
	}
	*src = p; *nump = num;
	return ch;
}

void ui2a( unsigned int num, unsigned int base, char *bf ) {
	int n = 0;
	int dgt;
	unsigned int d = 1;
	
	while( (num / d) >= base ) d *= base;
	while( d != 0 ) {
		dgt = num / d;
		num %= d;
		d /= base;
		if( n || dgt > 0 || d == 0 ) {
			*bf++ = dgt + ( dgt < 10 ? '0' : 'a' - 10 );
			++n;
		}
	}
	*bf = 0;
}

void i2a( int num, char *bf ) {
	if( num < 0 ) {
		num = -num;
		*bf++ = '-';
	}
	ui2a( num, 10, bf );
}

void format ( char* channel, char *fmt, va_list va, int *counter) {
	char bf[12];
	char ch, lz;
	int w;

	
	while ( ( ch = *(fmt++) ) ) {
		if ( ch != '%' )
			Insert( channel, ch, counter );
		else {
			lz = 0; w = 0;
			ch = *(fmt++);
			switch ( ch ) {
			case '0':
				lz = 1; ch = *(fmt++);
				break;
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				ch = a2i( ch, &fmt, 10, &w );
				break;
			}
			switch( ch ) {
			case 0: return;
			case 'c':
				Insert( channel, va_arg( va, char ), counter );
				break;
			case 's':
				putw( channel, w, 0, va_arg( va, char* ), counter );
				break;
			case 'u':
				ui2a( va_arg( va, unsigned int ), 10, bf );
				putw( channel, w, lz, bf, counter );
				break;
			case 'd':
				i2a( va_arg( va, int ), bf );
				putw( channel, w, lz, bf, counter );
				break;
			case 'x':
				ui2a( va_arg( va, unsigned int ), 16, bf );
				putw( channel, w, lz, bf, counter );
				break;
			case '%':
				Insert( channel, ch, counter );
				break;
			}
		}
	}
}

void Printf( int channel, char *fmt, ... ) {
		int courier_id = 0;
		if (channel == COM1) {
			courier_id = WhoIs("Courier1");
		}
		else {
			courier_id = WhoIs("Courier2");
		}

		int counter = 0;
		char buffer[100];
        va_list va;

        va_start(va,fmt);
        format( buffer, fmt, va, &counter );
        va_end(va);

        char c = 0;
        Send(courier_id, buffer, counter * sizeof(char), c, sizeof(char));
}

int setfifo( int channel, int state ) {
	int *line, buf;
	switch( channel ) {
	case COM1:
		line = (int *)( UART1_BASE + UART_LCRH_OFFSET );
	        break;
	case COM2:
	        line = (int *)( UART2_BASE + UART_LCRH_OFFSET );
	        break;
	default:
	        return -1;
	        break;
	}
	buf = *line;
	buf = state ? buf | FEN_MASK : buf & ~FEN_MASK;
	*line = buf;
	return 0;
}

int setspeed( int channel, int speed ) {
	int *high, *low;
	switch( channel ) {
	case COM1:
		high = (int *)( UART1_BASE + UART_LCRM_OFFSET );
		low = (int *)( UART1_BASE + UART_LCRL_OFFSET );
	        break;
	case COM2:
		high = (int *)( UART2_BASE + UART_LCRM_OFFSET );
		low = (int *)( UART2_BASE + UART_LCRL_OFFSET );
	        break;
	default:
	        return -1;
	        break;
	}
	switch( speed ) {
	case 115200:
		*high = 0x0;
		*low = 0x3;
		return 0;
	case 2400:
		*high = 0x0;
		*low = 191;
		return 0;
	default:
		return -1;
	}
}


