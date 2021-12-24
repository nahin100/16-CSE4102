
main:
	bison -d parser.y  
	flex lexer.l  
	gcc -o a.out parser.tab.c lex.yy.c  
	rm lex.yy.c parser.tab.c
	a.out <full_example2.c > output2.txt 
	
main2:
	gcc main.c
	./a.out
