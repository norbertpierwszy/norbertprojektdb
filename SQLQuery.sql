CREATE DATABASE Warsztat;
use Warsztat;

CREATE TABLE Klient (
  ID_Klienta int PRIMARY KEY identity(1,1),
  Nazwa nvarchar(50) not null,
  Adres nvarchar(50) not null,
  Telefon varchar(9) not null,
  Email nvarchar(50) null,
);

CREATE TABLE Samochod (
  ID_Samochodu int PRIMARY KEY identity(1,1),
  Marka nvarchar(50) not null,
  Model nvarchar(50) not null,
  Rok int null,
  Rodzaj_paliwa nvarchar(50) null,
  Pojemnos int null,
  Moc int null,
);

CREATE TABLE Pracownik (
  ID_Pracownika int PRIMARY KEY identity(1,1),
  Nazwisko nvarchar(50) not null,
  Imie nvarchar(50) not null,
  Pesel varchar(11) not null,
  Stawka decimal(12,2) null,
);

CREATE TABLE Czesci (
  ID int PRIMARY KEY identity(1,1),
  ID_naprawy int not null,
  Nazwa_czesci nvarchar(50) not null,
  Cena_czesci decimal(12,2) not null,
  ilosc_sztuk int not null,
);

CREATE TABLE Naprawa (
  ID_Naprawy int PRIMARY KEY identity(1,1),
  Data_przyjecia datetime not null,
  ID_klienta int not null,
  ID_samochodu int not null,
  Opis_usterki nvarchar(500) not null,
  ID_pracownika int null,
  Czas_pracy int null,
  Opis_naprawy nvarchar(500) null,
  Data_wydania datetime null,
  Numer_faktury nvarchar(10) null,
  Cena_netto decimal(12,2) null,
  Cena_brutto decimal(12,2) null,
);
 
ALTER TABLE Naprawa
ADD FOREIGN KEY (ID_klienta) REFERENCES Klient(ID_Klienta);

ALTER TABLE Naprawa
ADD FOREIGN KEY (ID_samochodu) REFERENCES Samochod(ID_Samochodu);

ALTER TABLE Czesci
ADD FOREIGN KEY (ID_naprawy) REFERENCES Naprawa(ID_Naprawy);

ALTER TABLE Naprawa
ADD FOREIGN KEY (ID_pracownika) REFERENCES Pracownik(ID_Pracownika);

INSERT INTO Pracownik VALUES ('Æwiok', 'Tomasz', '94020212345', 15.70);
INSERT INTO Pracownik VALUES ('Cygan', 'Artur', '97050111111', 15.70);
INSERT INTO Pracownik VALUES ('Kowalski', 'Piotr', '55101011111', 19.50);
INSERT INTO Pracownik VALUES ('Nowak', 'Kamil', '99090911111', 14.80);
INSERT INTO Pracownik VALUES ('Zaj¹c', 'Kacper', '02122411111', 10.00);
select * from Pracownik;

insert into Klient values ('lewandowski7', 'Krakowska 13 29-300 Poznan', '123445664', 'lewy@bayern.com');
insert into Klient values ('messidwa', 'Rozbita 8 12-300 Szczecin', '123432567', 'golgol@cos.com');
insert into Klient values ('ronaldo', 'Juve 20 11-323 Warszawa', '123567867', null);
insert into Klient values ('piszczek', 'Szklana 18 11-120 Krakow', '123122567', null);
insert into Klient values ('piatek111', 'Korfantego 13/6 21-222 Zakopane', '127732567', 'eloelol@cee.com');
select * from Klient;

insert into Samochod values ('Mercedes', 'E220', 1999, 'DIESEL', 2200, 125);
insert into Samochod values ('BMW', '530D', 2000, 'BENZYNA', 3000, 230);
insert into Samochod values ('Seat', 'Toledo', 2002, 'DIESEL', 1900, 110);
insert into Samochod values ('VW', 'Golf', null, null, null, null);
insert into Samochod values ('VW', 'Passat', null, null, null, null);
insert into Samochod values ('BMW', '120D', null, null, null, null);
insert into Samochod values ('BMW', '525i', null, null, null, null);
insert into Samochod values ('Mercedes', 'C200', null, null, null, null);
insert into Samochod values ('Audi', 'A3', null, null, null, null);
insert into Samochod values ('Audi', 'A4', null, null, null, null);
insert into Samochod values ('Audi', 'A6', null, null, null, null);
insert into Samochod values ('Mercedes', 'Sprinter', null, null, null, null);
insert into Samochod values ('Ford', 'Transit', null, null, null, null);
select * from Samochod;

insert into Naprawa values ('20191220 10:02:02 AM', 1, 1, 'Olej w uk³adzie chlodzenia', 3, 1, 'Wymiana chlodniczki oleju i termostatu', '20191230 08:02:02 PM', 'FV 3333/12', 0, 0);
insert into Naprawa values ('20191230 11:45:02 AM', 2, 3, 'Sciaga samochód w lewo', 3, 2, 'Ustawienie zbierznosci pojazdu', '20191231 06:22:02 PM', 'FV 3334/12', null, null);
insert into Naprawa values ('20200102 08:08:02 AM', 5, 11, 'Nie odpala', 4, 1, 'Czyszczenie ukladu paliwowego', null, null, null, null);
insert into Naprawa values ('20200112 09:08:02 PM', 3, 8, 'Spalona zarowka', null, null, null, null, null, null, null);
select * from Naprawa;

select nazwisko, pesel from Pracownik order by Nazwisko;

select nazwisko, imie from Pracownik where stawka>18  order by Nazwisko;

select nazwisko, marka, model from (Pracownik p inner join Naprawa n on p.ID_Pracownika=n.ID_pracownika) inner join Samochod s on n.ID_samochodu=s.ID_Samochodu;

select nazwa from Klient k inner join Naprawa n on k.ID_Klienta=n.ID_klienta where n.ID_samochodu=1;

insert into Czesci values (1, 'Ch³odniczka oleju', 400, 1);
insert into Czesci values (1, 'Termostat', 280, 1);
insert into Czesci values (4, 'Zarowka', 15, 2);
select * from Czesci;

select SUM(Cena_czesci) as Cena from Czesci where ID_naprawy=1;

select Marka, COUNT(Model) as Liczba_pojazdow from Samochod group by Marka;

create procedure [DodajKlienta] @n nvarchar(50), @a nvarchar(50), @t nvarchar(9)
as
	insert into Klient values (@n, @a, @t, null);
	
exec DodajKlienta 'smolarekebi', 'Wejcherowo 3', '123123123'; 
select * from Klient;

create procedure [UsunKlienta] @i int
as
	delete from Klient where ID_Klienta = @i;

exec UsunKlienta 4;
select * from Klient;