# C basics

> [!WARNING]
> Ces informations visent à présenter des vulnérabilités et ne respectent PAS les bonnes pratiques

## compilation sans protection

```sh
gcc -fno-stack-protector -z execstack source.c
```

## package pour les librairies 32bits

```sh
sudo apt-get install gcc-multilib
```

## pointeurs

```c
#include <stdio.h>
#include <stdlib.h>

int main()
{
    char tab1[] = "bonjour" ;
    int tab2[] = {10, 20, 30, 40} ;
    char* p1 = &tab1 ;
    int* p2 = &tab2 ;

    printf("tab1=\t%p \n", tab1) ; //adresse
    printf("tab2=\t%p \n", tab2) ;  //adresse

    printf("&tab1=\t%p \n", &tab1) ;   //adresse 
    printf("&tab2=\t%p \n", &tab2) ;    //adresse 

    printf("tab1[3]=\t%c \n", tab1[3]) ; // valeur
    printf("tab2[3]=\t%d \n", tab2[3]) ; //valeur

    printf("&tab1[3]=\t%p \n", &tab1[3]) ; // adresse
    printf("&tab2[3]=\t%p \n", &tab2[3]) ; //adresse

    //printf("*tab1[3]=\t%p \n", *tab1[3]) ; //ne compile pas car on voudrai un & pour l'adresse
    //printf("*tab2[3]=\t%p \n", *tab2[3]) ; //ne compile pas car on voudrai un & pour l'adresse  

    printf("p1=\t%p\n", p1) ; //adresse
    printf("p2=\t%p\n", p2) ; //adresse

    printf("*p1=\t%c\n", *p1) ; //valeur 
    printf("*p2=\t%d\n", *p2) ; //valeur 

    printf("*p1+1=\t%c\n", *p1+1) ; //valeur+1
    printf("*p2+1=\t%d\n", *p2+1) ; //valeur+1

    printf("*(p1+1)=\t%c\n", *(p1+1)) ; //adresses suivante
    printf("*(p2+1)=\t%d\n", *(p2+1)) ; //adresses suivante
    
    printf("&p1=\t%p\n", &p1) ; //adresse du pointeur
    printf("&p2=\t%p\n", &p2) ; //addresse du pointeur

    return EXIT_SUCCESS ;
}

/*
tab1=   0x7ffffcf45580
tab2=   0x7ffffcf45570
&tab1=  0x7ffffcf45580
&tab2=  0x7ffffcf45570
tab1[3]=        j
tab2[3]=        40
&tab1[3]=       0x7ffffcf45583
&tab2[3]=       0x7ffffcf4557c
p1=     0x7ffffcf45580
p2=     0x7ffffcf45570
*p1=    b
*p2=    10
*p1+1=  c
*p2+1=  11
*(p1+1)=        o
*(p2+1)=        20
&p1=    0x7ffffcf45560
&p2=    0x7ffffcf45568
*/
```

## passer root

```c
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
  
 int main(void) 
{
setreuid(geteuid(), geteuid());
system("/bin/sh");
return 0;
}
```

## Vulnérabilités

### Signed overflow

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

### Buffer overflow

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

strcpy(t1, t2) copie t2[16] dans t1[8], provoquant un Buffer Overflow (CWE-121).

### Dynamic allocation

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

### Arithmetic overflow - Signed Integers

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

### BoF signed char

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
