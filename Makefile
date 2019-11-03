CC=g++
CFLAGS=-std=c++11

default: build

build: color.o notes.o main.cpp
	$(CC) $(CFLAGS) -o notes++ main.cpp notes.o color.o

color.o: color.cpp
	$(CC) $(CFLAGS) -w -c color.cpp

notes.o: notes.cpp
	$(CC) $(CFLAGS) -c notes.cpp

clean:
	rm -f *.o
	rm -f notes++

fresh:
	make clean
	make

run:
	./notes++

test:
	./notes++ -db ./nppdb_test.db

memtest: fresh
	valgrind ./notes++ -db ./nppdb_test.db

install:
	cp ./notes++ /usr/local/bin/
	ln -s -f /usr/local/bin/notes++ /usr/local/bin/npp

uninstall:
	rm /usr/local/bin/notes++
	rm /usr/local/bin/npp

gentest:
	touch nppdb_test.db
	echo "NPP-DB-HEAD" > nppdb_test.db
	echo "V:2" >> nppdb_test.db
	echo "C:6" >> nppdb_test.db
	echo "BEGIN" >> nppdb_test.db
	echo "N:0:hello world" >> nppdb_test.db
	echo "I:1:goodbye world" >> nppdb_test.db
	echo "N:0:watwatwat" >> nppdb_test.db
	echo "I:0:whodat" >> nppdb_test.db
	echo "I:2:archived task" >> nppdb_test.db
	echo "N:1:completed task" >> nppdb_test.db
	echo "EOF" >> nppdb_test.db
	echo "Completed generating test database..."
