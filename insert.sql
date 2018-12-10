INSERT INTO `crossfit`.`Trening` (`id`, `Datum`, `Opis`) VALUES (1, '2018-11-11', '100 sklekova');
INSERT INTO `crossfit`.`Trening` (`id`, `Datum`, `Opis`) VALUES (2, '2018-12-12', '100 trbusnjaka');
INSERT INTO `crossfit`.`Trening` (`id`, `Datum`, `Opis`) VALUES (3, '2018-12-15', '100 cucnjeva');
INSERT INTO `crossfit`.`Trening` (`id`, `Datum`, `Opis`) VALUES (4, '2018-12-20', '100 LUS-eva');

INSERT INTO `crossfit`.`Trener` (`id`, `Ime`, `Prezime`, `Plata`, `DatumRodjenja`) VALUES (1, 'Sreten', 'Bogicevic', 60000, '1973-06-28');
INSERT INTO `crossfit`.`Trener` (`id`, `Ime`, `Prezime`, `Plata`, `DatumRodjenja`) VALUES (2, 'Nikola', 'Tatalovic', 55000, '1990-02-06');
INSERT INTO `crossfit`.`Trener` (`id`, `Ime`, `Prezime`, `Plata`, `DatumRodjenja`) VALUES (3, 'Marina', 'Petkovic', 30000, '1992-11-05');

INSERT INTO `crossfit`.`Vodi` (`Trener_id`, `Trening_id`) VALUES (1, 1);
INSERT INTO `crossfit`.`Vodi` (`Trener_id`, `Trening_id`) VALUES (2, 2);
INSERT INTO `crossfit`.`Vodi` (`Trener_id`, `Trening_id`) VALUES (3, 3);
INSERT INTO `crossfit`.`Vodi` (`Trener_id`, `Trening_id`) VALUES (1, 4);

INSERT INTO `crossfit`.`Klijent` (`id`, `Ime`, `Prezime`, `BrojOdradjenihTreninga`) VALUES (1, 'Pera', 'Peric', 7);
INSERT INTO `crossfit`.`Klijent` (`id`, `Ime`, `Prezime`, `BrojOdradjenihTreninga`) VALUES (2, 'Ivan', 'Ivanovic', 3);
INSERT INTO `crossfit`.`Klijent` (`id`, `Ime`, `Prezime`, `BrojOdradjenihTreninga`) VALUES (3, 'Mika', 'Mikic', 14);

INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (1, 1);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (1, 2);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (2, 3);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (2, 2);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (3, 1);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (3, 3);
INSERT INTO `crossfit`.`Prijava` (`Trening_id`, `Klijent_id`) VALUES (4, 1);

INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (1, 'Nike', 'Lopte');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (2, 'Reebok', 'Vijace');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (3, 'Under Armor', 'Tegovi');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (4, 'Addidas', 'Razgibavanje');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (5, 'Addidas', 'Tegovi');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (6, 'Nike', 'Tegovi');
INSERT INTO `crossfit`.`Oprema` (`sifra`, `Proizvodjac`, `Naziv`) VALUES (7, 'Under Armor', 'Lopte');

INSERT INTO `crossfit`.`Tegovi` (`Oprema_sifra`, `Tezina`, `Kolicina`, `Opis`) VALUES (3, 17, 3, 'bucice');
INSERT INTO `crossfit`.`Tegovi` (`Oprema_sifra`, `Tezina`, `Kolicina`, `Opis`) VALUES (5, 25, 5, 'ploce');
INSERT INTO `crossfit`.`Tegovi` (`Oprema_sifra`, `Tezina`, `Kolicina`, `Opis`) VALUES (6, 12, 10, 'kugle');

INSERT INTO `crossfit`.`Medicinke` (`Oprema_sifra`, `Tezina`, `Kolicina`) VALUES (1, 9, 10);
INSERT INTO `crossfit`.`Medicinke` (`Oprema_sifra`, `Tezina`, `Kolicina`) VALUES (7, 6, 5);

INSERT INTO `crossfit`.`Strunjace` (`Oprema_sifra`, `Kolicina`) VALUES (4, 25);

INSERT INTO `crossfit`.`Upotreba` (`Vodi_Trener_id`, `Vodi_Trening_id`, `Oprema_sifra`) VALUES (1, 4, 5);
INSERT INTO `crossfit`.`Upotreba` (`Vodi_Trener_id`, `Vodi_Trening_id`, `Oprema_sifra`) VALUES (2, 2, 7);

INSERT INTO `crossfit`.`Obucavanje` (`Trener_id`, `Trener_id1`) VALUES (1, 2);
INSERT INTO `crossfit`.`Obucavanje` (`Trener_id`, `Trener_id1`) VALUES (1, 3);