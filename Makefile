all:
	bison -d calculator.y
	flex calculator.l
	gcc calculator.tab.c lex.yy.c -lm -o calc

clean:
	rm lex.yy.c calculator.tab.c calculator.tab.h calc calculator.output