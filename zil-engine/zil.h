#ifndef __ZIL__
#define __ZIL__

typedef enum {
  N_EXPR,      // <...>
  N_LIST,      // (...)
  N_STRING,    // "..."
  N_IDENT,     // identifier
  N_NUMBER,    // 123
  N_SYMBOL,     // ,FOO or other symbols
  N_COMMENT,
} zil_Type;

typedef struct zil_Node {
  zil_Type type;
  char *val;
  struct zil_Node *children;
  struct zil_Node *next;
  struct zil_Node **tail;
} zil_Node;

zil_Node *zil_mk(zil_Type t, char *v);
void zil_del(zil_Node *p);
void zil_add(zil_Node *p, zil_Node *c);
void zil_run(zil_Node *node);

#endif
