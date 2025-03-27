files = common.c3 debug.c3 value.c3 vm.c3 main.c3
c3lox: $(files)
	c3c compile $(files)

all: c3lox

clean:
	rm c3lox
