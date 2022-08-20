FUNCTION
declspec
declarator
declspec
declarator
FUNCTION -> create_param_lvars
FUNCTION -> create_param_lvars
LOCAL VAR = x
compound_stmt
NEW NODE => NODE NAME = ND_BLOCK =>TOKEN NAME = int
declaration
declspec
declarator
LOCAL VAR = y
NEW NODE => NODE NAME = ND_BLOCK =>TOKEN NAME = ;
stmt
if
NEW NODE => NODE NAME = ND_IF =>TOKEN NAME = if
expr
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_VAR =>TOKEN NAME = x
add
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 1
NEW NODE => NODE NAME = ND_LE =>TOKEN NAME = <=
stmt
return
NEW NODE => NODE NAME = ND_RETURN =>TOKEN NAME = return
expr
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 1
stmt
return
NEW NODE => NODE NAME = ND_RETURN =>TOKEN NAME = return
expr
assign
equality
relational
add
mul
unary
primary
funcall
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_VAR =>TOKEN NAME = x
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 1
NEW NODE => NODE NAME = ND_SUB =>TOKEN NAME = -
NEW NODE => NODE NAME = ND_FUNCALL =>TOKEN NAME = fib
mul
unary
primary
funcall
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_VAR =>TOKEN NAME = x
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 2
NEW NODE => NODE NAME = ND_SUB =>TOKEN NAME = -
NEW NODE => NODE NAME = ND_FUNCALL =>TOKEN NAME = fib
NEW NODE => NODE NAME = ND_ADD =>TOKEN NAME = +
FUNCTION
declspec
declarator
FUNCTION -> create_param_lvars
compound_stmt
NEW NODE => NODE NAME = ND_BLOCK =>TOKEN NAME = int
declaration
declspec
declarator
LOCAL VAR = result
okk
NEW NODE => NODE NAME = ND_VAR =>TOKEN NAME = result
assign
equality
relational
add
mul
unary
primary
funcall
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 5
NEW NODE => NODE NAME = ND_FUNCALL =>TOKEN NAME = fib
NEW NODE => NODE NAME = ND_ASSIGN =>TOKEN NAME = ;
new_unary
NEW NODE => NODE NAME = ND_EXPR_STMT =>TOKEN NAME = ;
NEW NODE => NODE NAME = ND_BLOCK =>TOKEN NAME = ;
stmt
return
NEW NODE => NODE NAME = ND_RETURN =>TOKEN NAME = return
expr
assign
equality
relational
add
mul
unary
primary
NEW NODE => NODE NAME = ND_NUM =>TOKEN NAME = 0
FUNCTION = fib => VAR = y => offset = 8
FUNCTION = fib => VAR = x => offset = 16
n = 16
align = 16
(n + align - 1) = 31
align * align = 256
(n + align - 1) / align * align = 16
STACK SIZE = 16
FUNCTION = main => VAR = result => offset = 8
n = 8
align = 16
(n + align - 1) = 23
align * align = 256
(n + align - 1) / align * align = 16
STACK SIZE = 16
  .globl fib
fib:
  addi sp, sp, -16
  sd ra, 8(sp)
  sd fp, 0(sp)
  mv fp, sp
  addi sp, sp, -16
  sd a0, -16(fp)
ND_BLOCK
ND_BLOCK
ND_IF
ND_NUM
  li a0, 1
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
ND_VAR
gen_addr ND_VAR
  addi a0, fp, -16
LOAD
  ld a0, 0(a0)
POP
  ld a1, 0(sp)
  addi sp, sp, 8
ND_LE
  slt a0, a1, a0
  xori a0, a0, 1
  beqz a0, .L.else.1
ND_RETURN
ND_NUM
  li a0, 1
  j .L.return.fib
  j .L.end.1
.L.else.1:
.L.end.1:
ND_RETURN
ND_FUNCALL
ND_NUM
  li a0, 2
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
ND_VAR
gen_addr ND_VAR
  addi a0, fp, -16
LOAD
  ld a0, 0(a0)
POP
  ld a1, 0(sp)
  addi sp, sp, 8
ND_SUB
  sub a0, a0, a1
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
POP
  ld a0, 0(sp)
  addi sp, sp, 8
  call fib
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
ND_FUNCALL
ND_NUM
  li a0, 1
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
ND_VAR
gen_addr ND_VAR
  addi a0, fp, -16
LOAD
  ld a0, 0(a0)
POP
  ld a1, 0(sp)
  addi sp, sp, 8
ND_SUB
  sub a0, a0, a1
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
POP
  ld a0, 0(sp)
  addi sp, sp, 8
  call fib
POP
  ld a1, 0(sp)
  addi sp, sp, 8
ND_ADD
  add a0, a0, a1
  j .L.return.fib
.L.return.fib:
  mv sp, fp
  ld fp, 0(sp)
  ld ra, 8(sp)
  addi sp, sp, 16
  ret
  .globl main
main:
  addi sp, sp, -16
  sd ra, 8(sp)
  sd fp, 0(sp)
  mv fp, sp
  addi sp, sp, -16
ND_BLOCK
ND_BLOCK
ND_EXPR_STMT
ND_ASSIGN
gen_addr ND_VAR
  addi a0, fp, -8
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
ND_FUNCALL
ND_NUM
  li a0, 5
PUSH
  addi sp, sp, -8
  sd a0, 0(sp)
POP
  ld a0, 0(sp)
  addi sp, sp, 8
  call fib
STORE
POP
  ld a1, 0(sp)
  addi sp, sp, 8
  sd a0, 0(a1)
ND_RETURN
ND_NUM
  li a0, 0
  j .L.return.main
.L.return.main:
  mv sp, fp
  ld fp, 0(sp)
  ld ra, 8(sp)
  addi sp, sp, 16
  ret
