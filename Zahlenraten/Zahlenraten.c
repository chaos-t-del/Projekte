#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void main(void)

{
	int zahl;
	int counter = 3;
	int versuch = 0;
	int random;
	int check;

	srand(time(0));

	random = rand() % 9 + 1;

	printf("Bitte erraten Sie eine Zufallszahl zwischen 1 und 9.\n");
	printf("Sie haben %d Versuche.\n\n", counter);

	do {
		++versuch;

		printf("Ihr %d Versuch: ", versuch);

		do {
			check = scanf_s("%d", &zahl);
			if (check !=1) {
				printf("Eingabefehler!!! Versuchen sie es noch ein Mal.\n");
				printf("Ihr %d Versuch: ", versuch);
			}
		} while (getchar() !=  '\n');

		if (zahl == random) {
			printf("-----------------GAME OVER-------------------\n");
			printf("Sie haben Gewonnen. %d ist die gesuchte Zahl.\n", zahl);
			printf("-----------------GAME OVER-------------------\n");
			break;
			
		}
		else if (zahl < random)
			printf("Die gesuchte Zahl ist Groesser!\n\n");
		
		else
			printf("Die gesuchte Zahl ist Kleiner!\n\n");

		if (versuch >= counter) {
			printf("-------------GAME OVER---------------\n");
			printf("Verloren! Sie haben zu Viele Versuche gebraucht\n");
			printf("-------------GAME OVER---------------\n");
			break;
		}

	} while (zahl != random || versuch != counter);

	getchar();
}
