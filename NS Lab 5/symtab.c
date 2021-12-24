#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 40

#define INT_TYPE 1
#define REAL_TYPE 2
#define CHAR_TYPE 3

typedef struct list_t
{
	char st_name[MAX];	
    int st_type;
	int address;
	
	struct list_t *next;
}list_t;

list_t* head = NULL;
int address = 0;

void insert(char* name, int type);
list_t* search(char *name);
int id_check(char *st_name);
int get_type(char *st_name);
int type_check(int type1, int type2);

void insert(char* name, int type)
{
    if(search(name)==NULL)
    {
        list_t *temp = (list_t*)malloc(sizeof(list_t));

        strcpy(temp->st_name, name);
        temp->st_type = type;
        temp->address = address;
        address++;

        printf("inserting %s with type %d at address %d\n", temp->st_name, temp->st_type, temp->address);

        temp->next = head;
        head = temp; 
    }
    else
    {
        printf("same variable %s is declared more than one\n", name);
    }

}

list_t* search(char *name)
{
    list_t *current = head;

    while (current!=NULL)
    {
        if(strcmp(name, current->st_name)!=0)
            current = current->next;
        else
            break;
    }
    return current;
}

int id_check(char *st_name)
{
    list_t *id = search(st_name);

    if (id==NULL)
        return -1;
    
    return id->address;
}

int get_type(char *st_name)
{
    list_t* id = search(st_name);
    return id->st_type;
}

int type_check(int type1, int type2)
{
    if (type1==INT_TYPE && type2==INT_TYPE)
    {
        return (INT_TYPE);
    }
    else if (type1==INT_TYPE && type2==REAL_TYPE)
    {
        return (REAL_TYPE);
    }
    else if (type1==INT_TYPE && type2==CHAR_TYPE)
    {
        printf("Type INT and Type CHAR are incompatiable\n");
        return (-1);    
    }
    else if (type1==CHAR_TYPE && type2==REAL_TYPE)
    {
        printf("Type REAL and Type CHAR are incompatiable\n");
        return (-1);    
    }
    else
    {
        printf("Types are incompatiable\n");
        return (-1);    
    }

}
