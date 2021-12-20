#use command "make SHELL=cmd"

input = input.txt
output = output.txt

main: cal.l
	flex cal.l
	gcc lex.yy.c
	a <$(input)> $(output)
	#./a.out <input.txt> output.txt

main2: cal.l cal.y
	#yacc -d cal.y
	bison -d cal.y 
	#lex cal.l
	flex cal.l 
	gcc cal.tab.c lex.yy.c
	a <$(input)> $(output)

main3: lexer.l parser.y
	bison -d parser.y 
	flex lexer.l 
	gcc parser.tab.c lex.yy.c
	a <$(input)> $(output)
	


