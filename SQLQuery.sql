CREATE DATABASE Warsztat;
use Warsztat;

CREATE TABLE Klient (
  ID_Klienta int PRIMARY KEY identity(1,1),
  Nazwa nvarchar(50),
  Adres nvarchar(50),
  Telefon varchar(9),
  Email nvarchar(50),
);

CREATE TABLE Samochod (
  ID_Samochodu int PRIMARY KEY identity(1,1),
  Marka nvarchar(50),
  Model nvarchar(50),
  Rok int,
  Rodzaj_paliwa nvarchar(50),
  Pojemnos int,
  Moc int,
);

CREATE TABLE Pracownik (
  ID_Pracownika int PRIMARY KEY identity(1,1),
  Nazwisko nvarchar(50),
  Imie nvarchar(50),
  Pesel varchar(11),
  Stawka decimal(12,2),
);

CREATE TABLE Czesci (
  ID int PRIMARY KEY identity(1,1),
  ID_naprawy int,
  Nazwa_czesci nvarchar(50),
  Cena_czesci decimal(12,2),
  ilosc_sztuk int,
);

CREATE TABLE Naprawa (
  ID_Naprawy int PRIMARY KEY identity(1,1),
  Data_przyjecia datetime,
  ID_klienta int,
  ID_samochodu int,
  Opis_usterki nvarchar(500),
  ID_pracownika int,
  Czas_pracy int,
  Opis_naprawy nvarchar(500),
  Data_wydania datetime,
  Numer_faktury nvarchar(10),
  Cena_netto decimal(12,2),
  Cena_brutto decimal(12,2),
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
select * from Klient;

insert into Samochod values ('Mercedes', 'E220', 1999, 'DIESEL', 2200, 125);
insert into Samochod values ('BMW', '530D', 2000, 'BENZYNA', 3000, 230);
insert into Samochod values ('Seat', 'Toledo', 2002, 'DIESEL', 1900, 110);
select * from Samochod;

insert into Naprawa values ('20191220 10:02:02 AM', 1, 1, 'Olej w uk³adzie ch³odzenia', 3, 1, 'Wymiana ch³odniczki oleju i termostat', '20191230 08:02:02 PM', 'FV 3333/12', 0, 0);
insert into Naprawa values ('20191230 11:45:02 AM', 2, 3, 'Œciaga samochód w lewo', 3, 2, 'Ustawienie zbierznoœci pojazdu', '20191231 06:22:02 PM', 'FV 3334/12', null, null);
select * from Naprawa;

select nazwa from Klient k inner join Naprawa n on k.ID_Klienta=n.ID_klienta where n.ID_samochodu=1;

insert into Czesci values (1, 'Ch³odniczka oleju', 400, 1);
insert into Czesci values (1, 'Termostat', 280, 1);
select * from Czesci;

select SUM(Cena_czesci) as Cena from Czesci where ID_naprawy=1;
select Czas_pracy*50 as Cena from Naprawa where ID_naprawy=1;