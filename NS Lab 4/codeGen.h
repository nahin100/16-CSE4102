
enum code_ops {START, HALT, LD_INT_VALUE, ST, LD_VAR, ADD, LD_INT, STS};
char *op_name[] = {"start", "halt", "ld_int_value", "store", "ld_var", "add", "ld_int", "store_from_stack"};

struct instruction
{
    enum code_ops op;
    int arg;
};

struct instruction code[999];

int code_offset = 0;
void gen_code(enum code_ops op, int arg)
{
    code[code_offset].op = op;
    code[code_offset].arg = arg;
    code_offset++; 
}

void print_code()
{
    int i = 0;

    for(i=0; i<code_offset; i++)
    {
        printf("%3d: %-15s %4d\n", i, op_name[code[i].op], code[i].arg);
    }
}