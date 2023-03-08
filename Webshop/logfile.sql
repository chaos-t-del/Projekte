MariaDB [(none)]> 
MariaDB [(none)]> 
MariaDB [(none)]> -- erstellen Datenbank 
MariaDB [(none)]> create database webshop;
Query OK, 1 row affected (0.001 sec)

MariaDB [(none)]> -- verwenden Datenbank 
MariaDB [(none)]> use webshop; 
Database changed
MariaDB [webshop]> -- tabelle erstellen 
MariaDB [webshop]> create table produkt(
    -> pid int auto_increment,
    -> titel varchar(20),
    -> beschreibung varchar(50),
    -> preis decimal(6,2),
    -> bild varchar(25),
    -> primary key (pid));
Query OK, 0 rows affected (0.224 sec)

MariaDB [webshop]> describe produkt;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| pid          | int(11)      | NO   | PRI | NULL    | auto_increment |
| titel        | varchar(20)  | YES  |     | NULL    |                |
| beschreibung | varchar(50)  | YES  |     | NULL    |                |
| preis        | decimal(6,2) | YES  |     | NULL    |                |
| bild         | varchar(25)  | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
5 rows in set (0.041 sec)

MariaDB [webshop]> create table bestellung (
    -> bid int auto_increment,
    -> kunde varchar(30),
    -> pid int,
    -> anzahl int,
    -> primary key (bid));
Query OK, 0 rows affected (0.251 sec)

MariaDB [webshop]> -- beziehung erstellen -- ein produkt in vielen bestellungen (1:n) 
MariaDB [webshop]> -- pid in Tabelle bestellung ist fremdschlssel 
MariaDB [webshop]> alter table bestellung add foreign key (bid) references produkt (pid) on delete set null on update cascade;
ERROR 1005 (HY000): Can't create table `webshop`.`bestellung` (errno: 150 "Foreign key constraint is incorrectly formed")
MariaDB [webshop]> describe bestellung;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| bid    | int(11)     | NO   | PRI | NULL    | auto_increment |
| kunde  | varchar(30) | YES  |     | NULL    |                |
| pid    | int(11)     | YES  |     | NULL    |                |
| anzahl | int(11)     | YES  |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+
4 rows in set (0.009 sec)

MariaDB [webshop]> alter table bestellung add foreign key (pid) references produkt (pid) on delete set null on update cascade;
Query OK, 0 rows affected (1.369 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [webshop]> describe produkt;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| pid          | int(11)      | NO   | PRI | NULL    | auto_increment |
| titel        | varchar(20)  | YES  |     | NULL    |                |
| beschreibung | varchar(50)  | YES  |     | NULL    |                |
| preis        | decimal(6,2) | YES  |     | NULL    |                |
| bild         | varchar(25)  | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
5 rows in set (0.008 sec)

MariaDB [webshop]> insert into produkt (titel, beschreibung, preis, bild) values ("Toaster", "Toastet alles was geht", 39.99, "toaster.jpg");
Query OK, 1 row affected (0.175 sec)

MariaDB [webshop]> insert into produkt (titel, beschreibung, preis, bild) values ("Herd", "kochen wie frher", 569.99, "herd.jpg");
Query OK, 1 row affected, 1 warning (0.049 sec)

MariaDB [webshop]> select * from produkt;
+-----+---------+------------------------+--------+-------------+
| pid | titel   | beschreibung           | preis  | bild        |
+-----+---------+------------------------+--------+-------------+
|   1 | Toaster | Toastet alles was geht |  39.99 | toaster.jpg |
|   2 | Herd    | kochen wie fr?her      | 569.99 | herd.jpg    |
+-----+---------+------------------------+--------+-------------+
2 rows in set (0.010 sec)

MariaDB [webshop]> update produkt set beschreibung = "kochen wie frueher" where pid = 2;
Query OK, 1 row affected (0.054 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [webshop]> select * from produkt;
+-----+---------+------------------------+--------+-------------+
| pid | titel   | beschreibung           | preis  | bild        |
+-----+---------+------------------------+--------+-------------+
|   1 | Toaster | Toastet alles was geht |  39.99 | toaster.jpg |
|   2 | Herd    | kochen wie frueher     | 569.99 | herd.jpg    |
+-----+---------+------------------------+--------+-------------+
2 rows in set (0.000 sec)

MariaDB [webshop]> -- eintragen Bestellung 
MariaDB [webshop]> insert into bestellung (kunde, pid, anzahl) values ("Meier", 1, 1);
Query OK, 1 row affected (0.082 sec)

MariaDB [webshop]> -- wir wollen eine šbersicht welcher Kunde hat was bestellt 
MariaDB [webshop]> select * from produkt;
+-----+---------+------------------------+--------+-------------+
| pid | titel   | beschreibung           | preis  | bild        |
+-----+---------+------------------------+--------+-------------+
|   1 | Toaster | Toastet alles was geht |  39.99 | toaster.jpg |
|   2 | Herd    | kochen wie frueher     | 569.99 | herd.jpg    |
+-----+---------+------------------------+--------+-------------+
2 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellung; 
+-----+-------+------+--------+
| bid | kunde | pid  | anzahl |
+-----+-------+------+--------+
|   1 | Meier |    1 |      1 |
+-----+-------+------+--------+
1 row in set (0.000 sec)

MariaDB [webshop]> select bid, kunde, titel from bestellung inner join produkt using (pid); 
+-----+-------+---------+
| bid | kunde | titel   |
+-----+-------+---------+
|   1 | Meier | Toaster |
+-----+-------+---------+
1 row in set (0.016 sec)

MariaDB [webshop]> -- wir brauchen einen user selli@localhost, der nur Zugang zu dieser DAtenbank ha t
MariaDB [webshop]> create user selli@localhost identified by "0000";
Query OK, 0 rows affected (0.043 sec)

MariaDB [webshop]> -- alle rechte an der Datenbank 
MariaDB [webshop]> grant all privileges on webshop.* to selli@localhost;
Query OK, 0 rows affected (0.052 sec)

MariaDB [webshop]> exit;
MariaDB [(none)]> 
MariaDB [(none)]> use webshop;
Database changed
MariaDB [webshop]> select * from produkt;
+-----+----------------+----------------------------+--------+--------------------+
| pid | titel          | beschreibung               | preis  | bild               |
+-----+----------------+----------------------------+--------+--------------------+
|   1 | Toaster        | Toastet alles was geht     |  39.99 | toaster.jpg        |
|   2 | Herd           | kochen wie frueher         | 569.99 | herd.jpg           |
|   3 | kaffeemaschine | von der bohne in die Tasse |  79.99 | kaffeemaschine.jpg |
|   4 | kuehlschrank   | fuer frostige Lebensmittel | 329.79 | kuehlschrank.jpg   |
|   5 | Staubsauger    | Den Flusen ein Ende setzen |  79.89 | staubstauger.jpg   |
|   6 | Waschmaschine  | Kleidung besenrein         | 299.99 | waschmaschine.jpg  |
|   7 | Wasserkocher   | Kocht auch Gluehwein       |  29.99 | wasserkocher.jpg   |
+-----+----------------+----------------------------+--------+--------------------+
7 rows in set (0.169 sec)

MariaDB [webshop]> select * from bestellung;
+-----+-------+------+--------+
| bid | kunde | pid  | anzahl |
+-----+-------+------+--------+
|   1 | Meier |    1 |      1 |
+-----+-------+------+--------+
1 row in set (0.028 sec)

MariaDB [webshop]> -- tabelle bestellung: spalte l”schen anzahl und pid
MariaDB [webshop]> alter table bestellung drop anzahl;
Query OK, 0 rows affected (0.125 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [webshop]> alter table bestellung drop pid;
ERROR 1553 (HY000): Cannot drop index 'pid': needed in a foreign key constraint
MariaDB [webshop]> 
MariaDB [webshop]> -- bevor wir l”schen k”nnen pid, mssen wir beziehung l”schen 
MariaDB [webshop]> use information_schema;
Database changed
MariaDB [information_schema]> describe key_column_usage,
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 1
MariaDB [information_schema]> describe key_column_usage;
+-------------------------------+--------------+------+-----+---------+-------+
| Field                         | Type         | Null | Key | Default | Extra |
+-------------------------------+--------------+------+-----+---------+-------+
| CONSTRAINT_CATALOG            | varchar(512) | NO   |     |         |       |
| CONSTRAINT_SCHEMA             | varchar(64)  | NO   |     |         |       |
| CONSTRAINT_NAME               | varchar(64)  | NO   |     |         |       |
| TABLE_CATALOG                 | varchar(512) | NO   |     |         |       |
| TABLE_SCHEMA                  | varchar(64)  | NO   |     |         |       |
| TABLE_NAME                    | varchar(64)  | NO   |     |         |       |
| COLUMN_NAME                   | varchar(64)  | NO   |     |         |       |
| ORDINAL_POSITION              | bigint(10)   | NO   |     | 0       |       |
| POSITION_IN_UNIQUE_CONSTRAINT | bigint(10)   | YES  |     | NULL    |       |
| REFERENCED_TABLE_SCHEMA       | varchar(64)  | YES  |     | NULL    |       |
| REFERENCED_TABLE_NAME         | varchar(64)  | YES  |     | NULL    |       |
| REFERENCED_COLUMN_NAME        | varchar(64)  | YES  |     | NULL    |       |
+-------------------------------+--------------+------+-----+---------+-------+
12 rows in set (0.075 sec)

MariaDB [information_schema]> select * from key_column_usage where table_schema="webshop" \G
*************************** 1. row ***************************
           CONSTRAINT_CATALOG: def
            CONSTRAINT_SCHEMA: webshop
              CONSTRAINT_NAME: PRIMARY
                TABLE_CATALOG: def
                 TABLE_SCHEMA: webshop
                   TABLE_NAME: bestellung
                  COLUMN_NAME: bid
             ORDINAL_POSITION: 1
POSITION_IN_UNIQUE_CONSTRAINT: NULL
      REFERENCED_TABLE_SCHEMA: NULL
        REFERENCED_TABLE_NAME: NULL
       REFERENCED_COLUMN_NAME: NULL
*************************** 2. row ***************************
           CONSTRAINT_CATALOG: def
            CONSTRAINT_SCHEMA: webshop
              CONSTRAINT_NAME: bestellung_ibfk_1
                TABLE_CATALOG: def
                 TABLE_SCHEMA: webshop
                   TABLE_NAME: bestellung
                  COLUMN_NAME: pid
             ORDINAL_POSITION: 1
POSITION_IN_UNIQUE_CONSTRAINT: 1
      REFERENCED_TABLE_SCHEMA: webshop
        REFERENCED_TABLE_NAME: produkt
       REFERENCED_COLUMN_NAME: pid
*************************** 3. row ***************************
           CONSTRAINT_CATALOG: def
            CONSTRAINT_SCHEMA: webshop
              CONSTRAINT_NAME: PRIMARY
                TABLE_CATALOG: def
                 TABLE_SCHEMA: webshop
                   TABLE_NAME: produkt
                  COLUMN_NAME: pid
             ORDINAL_POSITION: 1
POSITION_IN_UNIQUE_CONSTRAINT: NULL
      REFERENCED_TABLE_SCHEMA: NULL
        REFERENCED_TABLE_NAME: NULL
       REFERENCED_COLUMN_NAME: NULL
3 rows in set (0.013 sec)

MariaDB [information_schema]> alter table bestellung drop foreign key bestellung_ibfk_1;
ERROR 1044 (42000): Access denied for user 'root'@'localhost' to database 'information_schema'
MariaDB [information_schema]> alter table webshop.bestellung drop foreign key bestellung_ibfk_1;
Query OK, 0 rows affected (0.084 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [information_schema]> use webshop;
Database changed
MariaDB [webshop]> alter table bestellung drop pid;
Query OK, 0 rows affected (0.290 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [webshop]> select * from produkt;
+-----+----------------+----------------------------+--------+--------------------+
| pid | titel          | beschreibung               | preis  | bild               |
+-----+----------------+----------------------------+--------+--------------------+
|   1 | Toaster        | Toastet alles was geht     |  39.99 | toaster.jpg        |
|   2 | Herd           | kochen wie frueher         | 569.99 | herd.jpg           |
|   3 | kaffeemaschine | von der bohne in die Tasse |  79.99 | kaffeemaschine.jpg |
|   4 | kuehlschrank   | fuer frostige Lebensmittel | 329.79 | kuehlschrank.jpg   |
|   5 | Staubsauger    | Den Flusen ein Ende setzen |  79.89 | staubstauger.jpg   |
|   6 | Waschmaschine  | Kleidung besenrein         | 299.99 | waschmaschine.jpg  |
|   7 | Wasserkocher   | Kocht auch Gluehwein       |  29.99 | wasserkocher.jpg   |
+-----+----------------+----------------------------+--------+--------------------+
7 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellung;
+-----+-------+
| bid | kunde |
+-----+-------+
|   1 | Meier |
+-----+-------+
1 row in set (0.000 sec)

MariaDB [webshop]> - wir fgen hinzu zu bestellung das datum 
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '- wir f?gen hinzu zu bestellung das datum' at line 1
MariaDB [webshop]> 
MariaDB [webshop]> -- wir fgen hinzu zu bestellung das datum 
MariaDB [webshop]> alter table bestellung add datum datetime;
Query OK, 0 rows affected (0.115 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [webshop]> -- die bestellung mit der bid = 1 wurde jetzt gemacht 
MariaDB [webshop]> select * from bestellung;
+-----+-------+-------+
| bid | kunde | datum |
+-----+-------+-------+
|   1 | Meier | NULL  |
+-----+-------+-------+
1 row in set (0.000 sec)

MariaDB [webshop]> update bestellung set datum = now() where bid = 1;
Query OK, 1 row affected (0.088 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [webshop]> select * from bestellung;
+-----+-------+---------------------+
| bid | kunde | datum               |
+-----+-------+---------------------+
|   1 | Meier | 2022-10-28 08:08:05 |
+-----+-------+---------------------+
1 row in set (0.000 sec)

MariaDB [webshop]> -- eine bestellung - viele Produkte, ein produkt  - viele bestellungen 
MariaDB [webshop]> create table bestellposition (
    -> pid int,
    -> bid int,
    -> anzahl int,
    -> foreign key (pid) references produkt (pid) on delete set null on update cascade,
    -> foreign key (bid) references bestellung (bid) on delete set null on update cascade);
Query OK, 0 rows affected (0.263 sec)

MariaDB [webshop]> select * from produkt,
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 1
MariaDB [webshop]> select * from produkt;
+-----+----------------+----------------------------+--------+--------------------+
| pid | titel          | beschreibung               | preis  | bild               |
+-----+----------------+----------------------------+--------+--------------------+
|   1 | Toaster        | Toastet alles was geht     |  39.99 | toaster.jpg        |
|   2 | Herd           | kochen wie frueher         | 569.99 | herd.jpg           |
|   3 | kaffeemaschine | von der bohne in die Tasse |  79.99 | kaffeemaschine.jpg |
|   4 | kuehlschrank   | fuer frostige Lebensmittel | 329.79 | kuehlschrank.jpg   |
|   5 | Staubsauger    | Den Flusen ein Ende setzen |  79.89 | staubstauger.jpg   |
|   6 | Waschmaschine  | Kleidung besenrein         | 299.99 | waschmaschine.jpg  |
|   7 | Wasserkocher   | Kocht auch Gluehwein       |  29.99 | wasserkocher.jpg   |
+-----+----------------+----------------------------+--------+--------------------+
7 rows in set (0.000 sec)

MariaDB [webshop]> insert into bestellposition (pid, bid, anzahl) values (1, 1, 2), (2, 1, 3);
Query OK, 2 rows affected (0.105 sec)
Records: 2  Duplicates: 0  Warnings: 0

MariaDB [webshop]> select * from bestellung;
+-----+-------+---------------------+
| bid | kunde | datum               |
+-----+-------+---------------------+
|   1 | Meier | 2022-10-28 08:08:05 |
+-----+-------+---------------------+
1 row in set (0.001 sec)

MariaDB [webshop]> select * from bestellposition; 
+------+------+--------+
| pid  | bid  | anzahl |
+------+------+--------+
|    1 |    1 |      2 |
|    2 |    1 |      3 |
+------+------+--------+
2 rows in set (0.000 sec)

MariaDB [webshop]> 
MariaDB [webshop]> -- wir haben eine neue Bestellung , besteht aus pid = 2 / anzahl = 5 und pid=3/anzahl = 4
MariaDB [webshop]> -- wir brauchen eine Bestellnummer fr die neue Bestellung 
MariaDB [webshop]> -- und dann k”nnen wir die bestellpositionen eintragen 
MariaDB [webshop]> 
MariaDB [webshop]> -- 1. neue bestellung 
MariaDB [webshop]> insert into bestellung (kunde, datum) values ("schmidt", now() );
Query OK, 1 row affected (0.049 sec)

MariaDB [webshop]> -- 2. wie ist die neue Nummer 
MariaDB [webshop]> select * from bestellung;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   1 | Meier   | 2022-10-28 08:08:05 |
|   2 | schmidt | 2022-10-28 09:39:55 |
+-----+---------+---------------------+
2 rows in set (0.000 sec)

MariaDB [webshop]> -- 3. bestellpositionen eintragen 
MariaDB [webshop]> insert into bestellposition (pid, bid, anzahl) values ( 2, 2, 5),  (3,2,4);
Query OK, 2 rows affected (0.051 sec)
Records: 2  Duplicates: 0  Warnings: 0

MariaDB [webshop]> select * from bestellung order by datum desc;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   2 | schmidt | 2022-10-28 09:39:55 |
|   1 | Meier   | 2022-10-28 08:08:05 |
+-----+---------+---------------------+
2 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellung order by datum desc limit 1;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   2 | schmidt | 2022-10-28 09:39:55 |
+-----+---------+---------------------+
1 row in set (0.000 sec)

MariaDB [webshop]> select bid from bestellung order by datum desc limit 1;
+-----+
| bid |
+-----+
|   2 |
+-----+
1 row in set (0.000 sec)

MariaDB [webshop]> select * from bestellung;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   1 | Meier   | 2022-10-28 08:08:05 |
|   2 | schmidt | 2022-10-28 09:39:55 |
|   3 | Ich     | 2022-10-28 10:13:07 |
+-----+---------+---------------------+
3 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellposition;
+------+------+--------+
| pid  | bid  | anzahl |
+------+------+--------+
|    1 |    1 |      2 |
|    2 |    1 |      3 |
|    2 |    2 |      5 |
|    3 |    2 |      4 |
|    3 |    3 |      3 |
|    1 |    3 |      7 |
|    5 |    3 |      5 |
+------+------+--------+
7 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellung;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   1 | Meier   | 2022-10-28 08:08:05 |
|   2 | schmidt | 2022-10-28 09:39:55 |
|   3 | Ich     | 2022-10-28 10:13:07 |
|   4 |         | 2022-10-28 10:30:14 |
|   5 |         | 2022-10-28 10:30:57 |
+-----+---------+---------------------+
5 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellung;
+-----+---------+---------------------+
| bid | kunde   | datum               |
+-----+---------+---------------------+
|   1 | Meier   | 2022-10-28 08:08:05 |
|   2 | schmidt | 2022-10-28 09:39:55 |
|   3 | Ich     | 2022-10-28 10:13:07 |
|   4 |         | 2022-10-28 10:30:14 |
|   5 |         | 2022-10-28 10:30:57 |
|   6 |         | 2022-10-28 10:45:58 |
+-----+---------+---------------------+
6 rows in set (0.000 sec)

MariaDB [webshop]> select * from bestellposition;
+------+------+--------+
| pid  | bid  | anzahl |
+------+------+--------+
|    1 |    1 |      2 |
|    2 |    1 |      3 |
|    2 |    2 |      5 |
|    3 |    2 |      4 |
|    3 |    3 |      3 |
|    1 |    3 |      7 |
|    5 |    3 |      5 |
|    5 |    4 |      4 |
+------+------+--------+
8 rows in set (0.000 sec)

MariaDB [webshop]> select titel, anzahl, preis, anzahl * preis as gesamt from bestellposition inner join produkt (pid);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '(pid)' at line 1
MariaDB [webshop]> select titel, anzahl, preis, anzahl * preis as gesamt from bestellposition inner join produkt using(pid);
+----------------+--------+--------+---------+
| titel          | anzahl | preis  | gesamt  |
+----------------+--------+--------+---------+
| Toaster        |      2 |  39.99 |   79.98 |
| Herd           |      3 | 569.99 | 1709.97 |
| Herd           |      5 | 569.99 | 2849.95 |
| kaffeemaschine |      4 |  79.99 |  319.96 |
| kaffeemaschine |      3 |  79.99 |  239.97 |
| Toaster        |      7 |  39.99 |  279.93 |
| Staubsauger    |      5 |  79.89 |  399.45 |
| Staubsauger    |      4 |  79.89 |  319.56 |
| kuehlschrank   |      2 | 329.79 |  659.58 |
+----------------+--------+--------+---------+
9 rows in set (0.000 sec)

MariaDB [webshop]> select titel, anzahl, preis, anzahl * preis as gesamt from bestellposition inner join produkt using(pid) where bid = 2;
+----------------+--------+--------+---------+
| titel          | anzahl | preis  | gesamt  |
+----------------+--------+--------+---------+
| Herd           |      5 | 569.99 | 2849.95 |
| kaffeemaschine |      4 |  79.99 |  319.96 |
+----------------+--------+--------+---------+
2 rows in set (0.000 sec)

MariaDB [webshop]> create user login@localhost identified by "1234";
Query OK, 0 rows affected (0.050 sec)

MariaDB [webshop]> grant select on webshop.* to login@localhost;
Query OK, 0 rows affected (0.021 sec)

