https://ghidra-sre.org/

EXEMPLE:


JE et JZ ne sont que des noms différents pour exactement la même chose: un saut conditionnel lorsque ZF (le drapeau "zéro") est égal à 1.

(De même, JNE et JNZ ne sont que des noms différents pour un saut conditionnel lorsque ZF est égal à 0.)



=======================

        0804861c 85 c0           TEST       EAX,EAX
        0804861e 75 12           JNZ        LAB_08048632
        08048620 89 5c 24 04     MOV        dword ptr [ESP + local_1098],EBX
        08048624 c7 04 24        MOV        dword ptr [ESP]=>local_109c,s_Good_work,_the_p   = "Good work, the password is : 
                 e8 87 04 08
        0804862b e8 dc fd        CALL       <EXTERNAL>::printf                               int printf(char * __format, ...)
                 ff ff
        08048630 eb 0c           JMP        LAB_0804863e


======================

Avec Ghidra on raplace le JNZ par JZ afin d'afficher le mdp (clic-droit -> patch instruction)
Puis rééxporter (file -> export) le binaire au format ELF

=====================

@m-VirtualBox:~/Documents$ ./c2 aaaa
Good work, the password is : 

<redacted>
