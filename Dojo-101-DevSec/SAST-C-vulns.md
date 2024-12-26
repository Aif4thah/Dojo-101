# C

## Signed overflow

```C
int offset, len ; // signed integers
...
/* first check that both offset and len are positives */
if (offset < 0 || len <= 0)
    return -EINVAL;
/* if offset + len exceeds the MAXSIZE threshold, or in case of overflow,
return an error code */
if ((offset + len > MAXSIZE) || (offset + len < 0)
    return -EFBIG // offset + len does overflow
/* assume from now on that len + offset did not overflow ... */
```

Le test (offset < 0 || len <=0) peut ne pas être réalisé du fait d’optimisations,
alors que les variables sont signées, ce qui introduit une vulnérabilité de type Integer
Overflow (CWE-190), Il est recommandé de compiler le noyau linux avec l’option « -fnostrict-overflow »

## Buffer overflow

```C
void main ()
{
    char t;
    char t1[8] ;
    char t2[16] ;
    int i;
    t = 0;
    for (i=0;i<15;i++) t2[i]=2;
    t2[15]=’\0’ ;
    strcpy(t1, t2) ; // copy t2 into t1
    printf("La valeur de t : %d \n", t);
}

```
strcpy(t1, t2) copie t2[16] danst1[8], provoquant un Buffer Overflow (CWE-121).


## Dynamic allocation

```C
typedef struct {void (*f)(void);} st;
void nothing (){ printf("Nothing\n"); }
int main(int argc , char * argv [])
{ 
    st *p1;
    char *p2;
    p1=(st*) malloc(sizeof(st));
    p1 ->f=&nothing;
    free(p1);
    p2=malloc(strlen(argv [1]));
    strcpy(p2 ,argv [1]);
    p1 ->f();
    return 0;
    }

```

assigner la valeur NULL permet de se prémunir de lecture/écriture/exécution
arbitraire dans la mémoire. Cette solution n’est pas complète, car « p1 ->f() » est ensuite
appelé ( Use After Free). Il faudrait vérifier la valeur NULL/ l’adresse de p1 au préalable.
(CWE-465)

## Arithmetic overflow - Signed Integers

```C
unsigned int i, nrep; // user inputs
...
nrep = packet_get_int() ;
response = malloc(nrep*sizeof(char*));
if (response != NULL)
    for (i=0; i<nrep; i++)
        response[i] = packet_get_string(NULL)
```

CVE-2002-0639, la taille (nresp*4bytes) est attendue. Mais si la
valeur 1 073 741 824 est reçue on a response = malloc(0), un dépassement de tampon se
produit. 





## BoF signed char

```C
void safewrite (int tab[], int size, signed char ind, int val) {
if (ind<size)
    tab[ind]=val;
else
    printf("Out of bounds\n");
}

/* FAIL */
int main() {
    const unsigned int size=120 ;
    int tab[size];
    safewrite(tab, size, 127, 0);
    safewrite(tab, size, 128, 1); 
    return 0;
}
```

un « Signed char » doit être compris entre -128 et 127. 