/* C basics

## compilation sans protection:

gcc -fno-stack-protector -z execstack source.c

## pbm de librairie 32bits:

sudo apt-get install gcc-multilib

*/

// memento pointeur:

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
