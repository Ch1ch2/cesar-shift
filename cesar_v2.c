/**
 * cesar.c
 * ---------------
 *  Implementation de l'agorithme du chiffrement par decalage
 *
 * @Author Guillaume Legrain
 * @version 2013-10-15
 *
 */

// NOTE: librarie pour avoir la fonction printf
// printf permet l'affichage dans la console
// cette librarie n'existe pas sur STM32machintruk
// 
// on remplacera le printf par une ecriture en memoire
#include <stdio.h> 
 

// On definit la cle de cryptage comme un constante
// CLE = 8
#define CLE 8


/**
 * Procedure qui va crypter une chaine de caractere
 * -------
 * @param clearText Le type char* est une reference 
 * (i.e. un pointeur) vers le debut du tableau de caracteres
 * @param key La cle du decallage
 * 
 * @return void Cette procedure ne retourne rien, 
 * elle modifie directement les valeurs de clearText.
 *
 * */
 void crypt(char *clearText, int key) {
   int i = 0;
   while(clearText[i] != 0x0 ) {    // 0x00 est le caractere null pour
                                    //signaler la fin du string.
      if ( (clearText[i] - 32 + key ) < 0 ) {
         // On restreint les decallages sur les caractere ASCII imprimables
         clearText[i] = (clearText[i] - 32 + key + 94) % 94 + 32; 
      } else {
         clearText[i] = (clearText[i] - 32 + key) % 94 + 32;
      }
    i++;
 }
}

/**
 * Procedure pour decrypter le message
 * ----------
 *  @param codedText
 *  @param key
 */
 void decrypt(char *codedText, int key) {
   crypt(codedText, - key);
}

/*
 * Debut du programme 
 * */
 int main(void) {

   // On declare le tableau de caracteres
   // char inputStr[] = "Hello bob ! ,!@#$%^&*";
   char inputStr[] = "0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [  ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z";

   //On affiche le message original
   printf("Message original: \"%s\"\n", inputStr);

   // Appel a la procedure crypt definie plus haut
   crypt( inputStr , CLE);

   // inputStr est maintenant crypte
   // On l'affiche dans la console
   printf("Message crypte: \"%s\" \n", inputStr);

   // Appel a procedure de decryptage
   decrypt( inputStr, CLE );

   // inputStr est maintenant crypte
   // On l'affiche dans la console
   printf("Message decrypte: \"%s\" \n", inputStr);

   // Pas important: la fonction main retourne 0 
   // pour dire que c'est la fin
   return 0;
}

