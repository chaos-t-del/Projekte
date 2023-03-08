#include <stdio.h>
#include <math.h>

int ermittlungTicketanzahl(void)
{
	int anzahl;
	printf("Wieviel Tickets wollen Sie? ");
	scanf_s("%i", &anzahl);
	getchar();
	return anzahl;
}
double berechneForderung(int Anzahl)
{
	double Forderung;
	Forderung = Anzahl * 1.8;
	return Forderung;
}
double bezahlen(double Forderung)
{	
	double e;	//Eingabe der Bezahlung
	double Wechselgeld;
	do
	{
		printf("Noch zu zahlender Betrag: %.2lf Euro.\n", Forderung);
		scanf_s("%lf", &e);	//Geldeingabe
		getchar();
		Forderung = Forderung - e;			//neue (Rest-)Forderung berechnen
		
	} while (Forderung > 0);
	Wechselgeld = Forderung * (-1);
	return Wechselgeld;
}
void ticketausgabe(int Anzahl)
{
	while (Anzahl > 0)
	{
		printf("***************************\n");
		printf("****** T I C K E T ********\n");
		printf("***************************\n");
		printf("\n");
		Anzahl = Anzahl - 1;
	}
}

void wechselgeldausgabe_cent(int Wechselgeld)
{
	while (Wechselgeld >= 50)
	{
		printf("50 Cent\t");
		Wechselgeld = Wechselgeld - 50;
	}
	printf("\n");
	while (Wechselgeld >= 20)
	{
		printf("20 Cent\t");
		Wechselgeld = Wechselgeld - 20;
	}
	printf("\n");
	while (Wechselgeld >= 10)
	{
		printf("10 Cent\t");
		Wechselgeld = Wechselgeld - 10;
	}
	printf("\n");
	while (Wechselgeld >= 5)
	{
		printf("5 Cent\t");
		Wechselgeld = Wechselgeld - 5;
	}
	printf("\n");
	while (Wechselgeld >= 2)
	{
		printf("2 Cent\t");
		Wechselgeld = Wechselgeld - 2;
	}
	printf("\n");
	while (Wechselgeld > 0)
	{
		printf("1 Cent\t");
		Wechselgeld = Wechselgeld - 1;
	}
	printf("\n");
}
void wechselgeldausgabe_euro(double Wechselgeld_euro)
{
	int Wechselgeld_cent;
	if (Wechselgeld_euro < 0) { Wechselgeld_euro = Wechselgeld_euro * (-1); }
	Wechselgeld_cent = (int)round(Wechselgeld_euro * 100);
	wechselgeldausgabe_cent(Wechselgeld_cent);

}


void main(void)
{
	//1. benötigte Variablen festlegen
	double f;	//Forderung
	double wg;	//Wechselgeld	
	int a;		//Anzahl der Tickets
	do {
		a = ermittlungTicketanzahl();		//2. Auswahl der Anzahl der Tickets
		f = berechneForderung(a);			//3. Berechnung der Forderung
		wg = bezahlen(f);					//4. Forderung stellen UND //5. Bezahlvorgang
		ticketausgabe(a);					//6. Ticketausgabe		
		wechselgeldausgabe_euro(wg);		//7. Wechselgeldermittlung/ -ausgabe
		
		printf("neustart (j/n):");
	} while (getchar() == 'j');


	getchar();
}
