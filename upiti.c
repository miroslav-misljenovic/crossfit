#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdarg.h>
#include <errno.h>

#define QUERY_SIZE 256

#define BUFFER_SIZE 80

/* Funkcija error_fatal() ispisuje poruku o gresci i potom prekida program. */
static void error_fatal(char *format, ...);


// gcc -g -Wall `mysql_config --cflags --libs`


int main(int argc, char **argv)
{

  MYSQL *konekcija;	/* Promenljiva za konekciju. */
  MYSQL_RES *rezultat;	/* Promenljiva za rezultat. */
  MYSQL_ROW red;	/* Promenljiva za jedan red rezultata. */
  MYSQL_FIELD *polje;	/* Promenljiva za nazive kolona. */
  int i;		/* Brojac u petljama. */
  int broj;		/* Pomocna promenljiva za broj kolona. */
  
  int idPrijava, treningPrijava;
  int trenerVodi, treningVodi;

  char query[QUERY_SIZE];	/* Promenljiva za formuaciju upita. */
  char buffer[BUFFER_SIZE];	/* Velicina poruke koja se ucitava sa ulaza. */
  
  konekcija = mysql_init(NULL);
  
    
  system("clear");
  
  printf("Prvi upit:\n");
  printf("Unesite podatke u tabelu `Prijava`\
  \nkako bi se aktivirao okidac koji menja sadrzaj tabele `Klijent`\
  \ntako sto odgovarajucem klijentu povecava broj odradjenih treninga.\n\n");
  
    
/* -----------------------------------------------------
-- Ispis tabele Prijava
-- -----------------------------------------------------
*/
  
  if (mysql_real_connect(konekcija, "localhost", "root", "", "crossfit", 0, NULL,
       0) == NULL)
      error_fatal("Greska u konekciji. %s\n", mysql_error (konekcija));  
  
  sprintf(query, "select * from Prijava");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\n", polje[0].name, polje[1].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("\t%s\t", red[i]);
      printf ("\n");
    }  

  printf("\n\n");
    
  mysql_free_result (rezultat);
  

/* -----------------------------------------------------
-- Ispis tabele Klijent
-- -----------------------------------------------------
*/
  
  sprintf(query, "select * from Klijent");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name, polje[3].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Unos podataka o treningu i klijentu
-- -----------------------------------------------------
*/  
  
  printf("Unesite ID treninga:\n");
  scanf("%d", &treningPrijava);
  
  printf("Unesite ID klijenta za kog zelite da prijavite trening:\n");
  scanf("%d", &idPrijava);
  
/* -----------------------------------------------------
-- Naredba INSERT
-- -----------------------------------------------------
*/


  sprintf(query, "INSERT INTO `Prijava` VALUES (\"%d\", \"%d\");", treningPrijava, idPrijava);

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));
  
  printf("\nStanje baze nakon naredbe: INSERT INTO `Prijava` VALUES (\"%d\", \"%d\")\n\n", treningPrijava, idPrijava);

/* ------------------------------------------------------------------------
-- Ispis tabele Klijent kako bi se videla promena broja odradjenih treninga
-- ------------------------------------------------------------------------
*/
  
  sprintf(query, "select * from Klijent");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error(konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name, polje[3].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Kraj prvog upita
-- -----------------------------------------------------
*/  
  

  printf("Da li zelite sledeci upit? (y/n):\n");
  scanf("%s", buffer);
  
  if (!strcmp(buffer, (const char*) "n")) return 0;
  
  
/* -----------------------------------------------------
-- Drugi upit
-- -----------------------------------------------------
*/
    
  system("clear");
  
  printf("Drugi upit:\n");
  printf("Unesite podatke u tabelu `Vodi`\
  \nkako bi se aktivirao okidac koji menja sadrzaj tabele `Trener`.\
  \nTreneru se povecava plata za svakog prijavljenog klijenta (po 150 dinara).\n\n");

/* -----------------------------------------------------
-- Ispis tabele Trener
-- -----------------------------------------------------
*/  
  
  sprintf(query, "select * from Trener");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\t\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name, polje[3].name, polje[4].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Ispis tabele Prijava
-- -----------------------------------------------------
*/    
  
  sprintf(query, "select * from Prijava");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\n", polje[0].name, polje[1].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("\t%s\t", red[i]);
      printf ("\n");
    }  

  printf("\n\n");
    
  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Ispis tabele Vodi
-- -----------------------------------------------------
*/  
  sprintf(query, "select * from Vodi");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\n", polje[0].name, polje[1].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("\t%s\t", red[i]);
      printf ("\n");
    }  

  printf("\n\n");
    
  mysql_free_result (rezultat);
  
  
/* -----------------------------------------------------
-- Unos podataka o treneru i treningu
-- -----------------------------------------------------
*/  
  
  printf("Unesite ID trenera:\n");
  scanf("%d", &trenerVodi);
  
  printf("Unesite ID treninga:\n");
  scanf("%d", &treningVodi);
  
/* -----------------------------------------------------
-- Naredba INSERT
-- -----------------------------------------------------
*/    
  sprintf(query, "INSERT INTO `Vodi` VALUES (\"%d\", \"%d\");", trenerVodi, treningVodi);

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error (konekcija));
  
  printf("\nStanje baze nakon naredbe: INSERT INTO `Vodi` VALUES (\"%d\", \"%d\")\n\n", trenerVodi, treningVodi);
  
/* -----------------------------------------------------
-- Ispis tabele Trener kako bi se videla promena plate
-- -----------------------------------------------------
*/  
  sprintf(query, "select * from Trener");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error(konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name, polje[3].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Kraj drugog upita
-- -----------------------------------------------------
*/    
  
  
  printf("Da li zelite sledeci upit? (y/n):\n");
  scanf("%s", buffer);
  
  if (!strcmp(buffer, (const char*) "n")) return 0;
  
  
/* -----------------------------------------------------
-- Treci upit
-- -----------------------------------------------------
*/

  system("clear");
  
  printf("Treci upit:\n");
  printf("Izracunati ukupnu tezinu svih tegova zeljenog proizvodjaca!\n");

/* -----------------------------------------------------
-- Ispis tabele Oprema
-- -----------------------------------------------------
*/    

  sprintf(query, "select * from Oprema");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error(konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	if (i == 1)
	  printf ("%s\t\t", red[i]);
	else
	  printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);
  
/* -----------------------------------------------------
-- Ispis tabele Tegovi
-- -----------------------------------------------------
*/  
  sprintf(query, "select * from Tegovi");

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error(konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s\t%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name, polje[3].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	if (i == 0 || i == 2)
	  printf ("%s\t\t", red[i]);
	else
	  printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);

/* -----------------------------------------------------
-- Unos imena proizvodjaca tegova i ispis rezultata
-- -----------------------------------------------------
*/
  
  printf("Ime proizvodjaca:\n");
  scanf("%s", buffer);
  
  sprintf(query, "SELECT Tegovi.Tezina*Tegovi.Kolicina \"Ukupna tezina\"\
   FROM Oprema join Tegovi on Oprema.sifra = Tegovi.Oprema_sifra\
   WHERE `Proizvodjac`=\"%s\";", buffer);

  if (mysql_query(konekcija, query) != 0)
    error_fatal("Greska u upitu %s\n", mysql_error(konekcija));

  rezultat = mysql_use_result(konekcija);

  polje = mysql_fetch_field(rezultat);

  printf("%s: ", polje[0].name);
  
  broj = mysql_num_fields(rezultat);

  while ((red = mysql_fetch_row (rezultat)) != 0){
      for (i = 0; i < broj; i++)
	printf ("%s\t", red[i]);
      printf ("\n");
    }  

  mysql_free_result (rezultat);  
  
/* -----------------------------------------------------
-- Kraj treceg upita
-- -----------------------------------------------------
*/     
  
  
  /* Zatvara se konekcija. */
  mysql_close(konekcija);

  /* Zavrsava se program */
  exit(EXIT_SUCCESS);
}

static void
error_fatal(char *format, ...)
{
  va_list arguments;		/* Lista argumenata funkcije. */

  /* Stampa se string predstavljen argumentima funkcije. */
  va_start(arguments, format);
  vfprintf(stderr, format, arguments);
  va_end(arguments);

  /* Prekida se program. */
  exit(EXIT_FAILURE);
}
