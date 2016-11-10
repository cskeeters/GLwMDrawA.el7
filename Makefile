main: foo.o main.o
	g++ foo.o main.o

clean:
	rm -f *.o a.out

%.o: %.c++
	g++ -c $<
