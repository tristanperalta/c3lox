c3lox: common.c3 debug.c3 value.c3 main.c3
	c3c compile common.c3 debug.c3 value.c3 main.c3

all: c3lox

clean:
	rm c3lox
