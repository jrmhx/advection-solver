.SUFFIXES:
.PRECIOUS: %.o

HDRS=serAdvect.h parAdvect.h
OBJS=serAdvect.o parAdvect.o
PROG=testAdvect
CCFLAGS=-O3 # -Xptxas -v

all: $(PROG) 

%: %.o $(OBJS)
	nvcc -o $* $*.o $(OBJS) -lm
%.o: %.cu $(HDRS)
	nvcc $(CCFLAGS) -c $*.cu
clean:
	rm -f *.o $(PROG)
