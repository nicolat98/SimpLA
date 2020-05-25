#include <stdio.h>
#include <stdlib.h>

typedef enum 
{
    PROGRAM,
    VAR_DECL_LIST,
    VAR_DECL,
    ID_LIST,
    TYPE,
    FUNC_DECL_LIST,
    FUNC_DECL,
    OPT_PARAM_LIST,
    PARAM_LIST,
    PARAM_DECL,
    N_BODY,
    STAT_LIST,
    STAT,
    ASSIGN_STAT,
    IF_STAT,
    OPT_ELSE_STAT,
    WHILE_STAT,
    FOR_STAT,
    RETURN_STAT,
    OPT_EXPR,
    READ_STAT,
    WRITE_STAT,
    WRITE_OP,
    EXPR_LIST,
    EXPR,
    LOGIC_OP,
    BOOL_TERM,
    REL_OP,
    REL_TERM,
    LOW_PREC_OP,
    LOW_TERM,
    HIGH_PREC_OP,
    FACTOR,
    UNARY_OP,
    CONST,
    FUNC_CALL,
    OPT_EXPR_LIST,
    COND_EXPR,
    CAST,
    DECL,
    ASSIGN,
    ERROR
} Nonterminal;

typedef enum
{
    VOID,
    REAL,
    INTEGER,
    STRING,
    BOOLEAN,
    INTCONST,
    BOOLCONST,
    STRCONST,
    REALCONST,
    RETURN,
    ID,
    FUNC,
    T_BODY,
    END,
    TO,
    DO,
    IF,
    THEN,
    ELSE,
    READ,
    WRITE,
    WRITELN,
    AND,
    OR,
    NOT,
    FOR,
    WHILE,
    BREAK,
    LT,
    LE,
    EQ,
    NE,
    GT,
    GE,
    PLUS,
    MINUS,
    MUL,
    DIV,
    NONTERMINAL
} Typenode;

typedef union
{
    int ival;
    char *sval;
    enum {FALSE, TRUE} bval;
    float fval;
} Value;

typedef struct snode
{
    Typenode type;
    Value value;
    struct snode *child, *brother;
} Node;

typedef Node *Pnode;

char *newstring(char*);

int yylex();

Pnode nontermnode(Nonterminal), 
      idnode(), 
      keynode(Typenode), 
      intconstnode(),
      strconstnode(),
      boolconstnode(),
      newnode(Typenode);
      
void treeprint(Pnode, int),
     yyerror();



