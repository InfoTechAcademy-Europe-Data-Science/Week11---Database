
2- 'class4' database olusturun (M). Database silin (M). Ayni database yine olusturun (K)

CREATE DATABASE class4
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
	
5- ER modeldeki tablolardan 3 tanesini K olusturun.

CREATE TABLE language (
language_id INTEGER PRIMARY KEY NOT NULL,
name varchar(15) NOT NULL,
last_update TIMESTAMP NOT NULL
);

CREATE TABLE film_actor(
	actor_id SERIAL PRIMARY KEY NOT NULL,
	film_id INTEGER NOT NULL,
	last_update TIMESTAMP NOT NULL	
);

CREATE TABLE inventory (
inventory_id SERIAL PRIMARY KEY NOT NULL,
	store_id INTEGER
	);

6- ER modeldeki tablolardan 3 tanesini C olusturun.

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()
command="""CREATE TABLE RENTAL(
    rental_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    last_update TIMESTAMP
);"""
cur.execute(command)
cur.close()
conn.commit()
conn.close()

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
command="""CREATE TABLE payment (
    rental_id SERIAL PRIMARY KEY NOT NULL,
    rental_date TIMESTAMP NOT NULL,
    staff_id INTEGER NOT NULL);"""
    
cur.execute(command)

cur.close()
conn.commit()
conn.close()

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()
command="""CREATE TABLE payment (
    rental_id SERIAL PRIMARY KEY NOT NULL,
    rental_date TIMESTAMP NOT NULL,
    staff_id INTEGER NOT NULL);"""
    
cur.execute(command)

cur.close()
conn.commit()
conn.close()

8- Olusturdugunuz 3 tabloya K ile 5 veri girişi yapin.

INSERT INTO film (film_id,title) VALUES (27,'A Man')
INSERT INTO film_actor (actor_id,film_id,last_update) values(42,25,'17.12.1997 07:37:16.00 PST')
INSERT INTO film_category (film_id,category_id,last_update) values(20,40,'17.12.1997 07:37:16.00 PST')

9- Olusturdugunuz 3 tabloya C ile 5 veri girişi yapin.

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()

for i in range(5):
    command="""INSERT INTO inventory (inventory_id,store_id) VALUES ({},{})
    """.format(i+1,i+1)
    cur.execute(command)
cur.close()
conn.commit()
conn.close()


import psycopg2
from datetime import date, datetime

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()

name_list=['Murat','Ahmet','Suat','Vedat','Emin']
datetime_obj=datetime.now()
t=datetime_obj.strftime('%H:%M:%S')
print(t)


for i in range(5):
   cur.execute('INSERT INTO language VALUES (%s,%s,%s)', (i,name_list[i],datetime_obj))

    
for i in range(5):
    cur.execute('INSERT INTO staff VALUES (%s,%s)',(i,name_list[i]))
   

for i in range(5):
    cur.execute('INSERT INTO rental VALUES (%s,%s,%s)',(i,20+i,datetime_obj))
    
cur.close()
conn.commit()
conn.close()

11- 3 tablodaki birer veriyi K ile degistirin.

UPDATE language SET name='Adem' WHERE language_id=0;
UPDATE inventory SET store_id=50 WHERE inventory_id=1;

12- 3 tablodaki birer veriyi C ile degistirin.

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()
cur.execute('UPDATE film_actor SET film_id=500 WHERE actor_id=43')
cur.execute('UPDATE film SET title=\'The Heft\' WHERE film_id=25')
cur.execute("UPDATE category SET name= 'Heft' WHERE category_id=3")

cur.close()
conn.commit()
conn.close()

14- 3 tablonun son satirini K ile silin.
DELETE FROM film_category WHERE film_id=24 OR film_id=25;
DELETE FROM inventory WHERE inventory_id=4 OR inventory_id=5;
DELETE FROM language WHERE language_id=4;

15- 3 tablonun son satirini C ile silinmiş.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
cur.execute('DELETE FROM payment WHERE rental_id=5')
cur.execute('DELETE FROM rental WHERE rental_id=4 ')
cur.execute('DELETE FROM staff WHERE staff_id=4')

cur.close()
conn.commit()
conn.close()

17- 1 tabloyu K ile silin.
DROP TABLE film;

18- 1 tabloyu C ile silinmiş.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
cur.execute('DROP TABLE film_actor')

cur.close()
conn.commit()
conn.close()

19- Kalan tablolardan 1 tanesinin 2 veya 3 sutununu K ile baska bir tablo olarak olusturun.

CREATE TABLE customer (
	customer_id INTEGER PRIMARY KEY NOT NULL,
	first_name VARCHAR(20) NOT NULL);
INSERT INTO customer
SELECT language_id, name FROM language;

20- Kalan tablolardan 1 tanesinin 2 veya 3 sutununu C ile baska bir tablo olarak olusturun.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
command="""
CREATE TABLE address(
    address_id INTEGER PRIMARY KEY NOT NULL,
    postal_code INTEGER NOT NULL);
    INSERT INTO address
    SELECT film_id,category_id FROM film_category;"""
cur.execute(command)

cur.close()
conn.commit()
conn.close()

22- Tablolardan 1 tanesini K ile truncate edin.

TRUNCATE TABLE language;

23- Tablolardan 1 tanesini C ile truncate edin.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
command="""TRUNCATE TABLE payment;"""
cur.execute(command)

cur.close()
conn.commit()
conn.close()

25- 2 tabloyu K ile silin.

DROP TABLE address;
DROP TABLE customer;

26- 2 tabloyu C silin.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
command="""DROP TABLE film_category;
           DROP TABLE rental;"""
cur.execute(command)

cur.close()
conn.commit()
conn.close()

30- Import ettiğiniz bu tabloyu C ile silin.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=murat3216")
cur=conn.cursor()
command="""DROP TABLE staff;"""
cur.execute(command)

cur.close()
conn.commit()
conn.close()

32- DB nizde 15 adet tablo olmasi lazim. Her tabloyu teker teker goruntuleyin ve kolon isimlerine bakarak, 5 tablodaki hangi kolonun PK ve FK olduğunu yazin.

adress PK address_id FK city_id
city PK city_id FK country_id
customer PK customer_id FK address_id 
film PK film_id FK language_id
film_actor PK actor_id film_id FK actor_id FK film_id

33- Action filmlerinin ortalama suresi ne kadar?

SELECT AVG(length) FROM film WHERE film_id IN ( SELECT film_id FROM film_category WHERE category_id=1);
111.6093750000000000

34- En cok staff olan store hangisidir?

SELECT COUNT(*),manager_staff_id FROM store GROUP BY manager_staff_id ORDER BY COUNT(*) DESC LIMIT 1
1

35- 'Gene Willis' adli actorun oynadığı filmlerin reytingi nedir?

SELECT rating FROM film
WHERE film_id IN (SELECT film_id FROM film_actor WHERE actor_id=(
SELECT actor_id FROM actor WHERE first_name || ' ' ||last_name = 'GENE WİLLİS'))
"R"
"PG-13"
"R"
"R"
"G"
"NC-17"
"PG"
"NC-17"
"NC-17"
"PG-13"
"G"
"R"
"R"
"PG-13"
"PG"
"PG-13"
"G"
"PG"
"NC-17"
"PG"
"R"
"G"
"PG"

36- Aktif customer sayisi nedir?
SELECT COUNT(*) FROM customer 
WHERE active =1;
584

37-'C' harfiyle baslayan filmler hangileridir?

SELECT * FROM film
WHERE title like 'C%';
"Chamber Italian"
"Casualties Encino"
"Cabin Flash"
"Caddyshack Jedi"
"Calendar Gunfight"
"California Birds"
"Camelot Vacation"
"Campus Remember"
"Candidate Perdition"
"Candles Grapes"
"Canyon Stock"

38- 4$ den az odeme yapan musterilerin e-posta adresleri nedir?
SELECT email from customer
WHERE customer_id IN (SELECT customer_id FROM payment WHERE amount <4);

"marion.ocampo@sakilacustomer.org"
"tracy.herrmann@sakilacustomer.org"
"seth.hannon@sakilacustomer.org"
"kent.arsenault@sakilacustomer.org"
"terrance.roush@sakilacustomer.org"
"rene.mcalister@sakilacustomer.org"
"eduardo.hiatt@sakilacustomer.org"
"terrence.gunderson@sakilacustomer.org"
"enrique.forsythe@sakilacustomer.org"
"freddie.duggan@sakilacustomer.org"
"wade.delvalle@sakilacustomer.org"
"austin.cintron@sakilacustomer.org"

39- Moskova'da ikamet eden staff ve customer tablosu? (sadece isim/soyisim sütün olsun).

SELECT first_name, last_name FROM customer 
WHERE address_id =(SELECT address_id FROM address WHERE city_id =(SELECT city_id FROM city WHERE city= 'Moscow'));
"Catherine"	"Campbell"
SELECT first_name, last_name FROM staff 
WHERE address_id =(SELECT address_id FROM address WHERE city_id =(SELECT city_id FROM city WHERE city= 'Moscow'));
NULL

40- En az kiralanan 5 film?

SELECT COUNT(*),film_id, title FROM film
GROUP BY film_id
ORDER BY COUNT(*) ASC LIMIT 5;

"Effect Gladiator"
"Balloon Homeward"
"Voyage Legally"
"Stallion Sundance"
"Pajama Jawbreaker"

41- 2006 yilinda yayinlanan İngilizce filmler hangileridir?

SELECT * FROM film WHERE release_year=2006 and
language_id=(SELECT language_id FROM language WHERE name='English');


