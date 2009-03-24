LEX=flex
.y.c:
	bison -d parser.y -o parser.c
.c.o:
	gcc -c -Wall $<
	
all: parser.o main.o symbol.o lexer.o init.o error.o emitter.o
	gcc -lfl -o parser parser.o main.o symbol.o lexer.o init.o error.o emitter.o

clean: 
	rm parser.o main.o symbol.o lexer.o init.o error.o emitter.o
