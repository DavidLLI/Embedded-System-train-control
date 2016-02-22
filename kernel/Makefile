XCC     = gcc
AS	= as
LD      = ld
CFLAGS  = -c -fPIC -Wall -I. -I../include -mcpu=arm920t -msoft-float
# -g: include hooks for gdb
# -c: only compile
# -mcpu=arm920t: generate code for the 920t architecture
# -fpic: emit position-independent code
# -Wall: report all warnings

ASFLAGS	= -mcpu=arm920t -mapcs-32
# -mapcs: always generate a complete stack frame

LDFLAGS = -init main -Map kernel.map -N  -T orex.ld -L/u/wbcowan/gnuarm-4.0.2/lib/gcc/arm-elf/4.0.2 -L../lib

OBJ = ClockServer.o helper.o kernelFunction.o nameServer.o taskDescriptor.o userFunction.o contextSwitch.o command.o syscall.o wrapper.o ioServer.o train.o bwio.o



all: $(OBJ) kernel.s kernel.elf 


taskDescriptor.o: ../src/taskDescriptor.c
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

ClockServer.o: ../src/ClockServer.c
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

helper.o: ../src/helper.c
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

kernelFunction.o: ../src/kernelFunction.c
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

nameServer.o: ../src/nameServer.c
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

userFunction.o: ../src/userFunction.c 
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

contextSwitch.o: ../src/contextSwitch.c 
	$(XCC) -c -o $@ $< $(CFLAGS)

syscall.o: ../src/syscall.c 
	$(XCC) -c -o $@ $< $(CFLAGS)

wrapper.o: ../src/wrapper.c 
	$(XCC) -O2 -c -o $@ $< $(CFLAGS)

ioServer.o: ../src/ioServer.c 
	$(XCC) -c -o $@ $< $(CFLAGS)

train.o: ../src/train.c 
	$(XCC) -c -o $@ $< $(CFLAGS)
	
command.o: ../src/command.c 
	$(XCC) -c -o $@ $< $(CFLAGS)	

bwio.o: ../src/bwio.c 
	$(XCC) -c -o $@ $< $(CFLAGS)


kernel.s: kernel.c 
	$(XCC) -S $(CFLAGS) kernel.c ../src/taskDescriptor.c ../src/contextSwitch.c



kernel.o: kernel.s taskDescriptor.s contextSwitch.s
	$(AS) $(ASFLAGS) -o kernel.o kernel.s

kernel.elf: kernel.o
	$(LD) $(LDFLAGS) -o $@ kernel.o $(OBJ) -lgcc	

clean:
	-rm -f kernel.elf *.s *.o kernel.map
