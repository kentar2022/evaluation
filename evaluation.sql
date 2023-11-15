
-- Creation de la base de données --
CREATE DATABASE CinemaReservationDB;

USE CinemaReservationDB;


-- Creation des tables --
CREATE TABLE Cinema (
    ID_Cinema INT PRIMARY KEY AUTO_INCREMENT,
    Nom VARCHAR(255) NOT NULL,
    Emplacement VARCHAR(255) NOT NULL
);

CREATE TABLE CinemaHall (
    ID_Hall INT PRIMARY KEY AUTO_INCREMENT,
    CinemaID INT NOT NULL,
    Capacite INT NOT NULL,
    FOREIGN KEY (CinemaID) REFERENCES Cinema(ID_Cinema)
);

CREATE TABLE Movie (
    ID_Film INT PRIMARY KEY AUTO_INCREMENT,
    Titre VARCHAR(255) NOT NULL,
    Description TEXT,
    Duree INT,
    DateSortie DATE
);

CREATE TABLE Showtime (
    ID_Showtime INT PRIMARY KEY AUTO_INCREMENT,
    FilmID INT NOT NULL,
    HallID INT NOT NULL,
    DateHeure DATETIME NOT NULL,
    Prix DECIMAL(8, 2) NOT NULL,
    PlacesDisponibles INT NOT NULL,
    FOREIGN KEY (FilmID) REFERENCES Movie(ID_Film),
    FOREIGN KEY (HallID) REFERENCES CinemaHall(ID_Hall)
);

CREATE TABLE User (
    ID_User INT PRIMARY KEY AUTO_INCREMENT,
    NomUtilisateur VARCHAR(50) NOT NULL,
    MotDePasse VARCHAR(50) NOT NULL,
    TypeUtilisateur VARCHAR(20) NOT NULL
);

CREATE TABLE Reservation (
    ID_Reservation INT PRIMARY KEY AUTO_INCREMENT,
    ShowtimeID INT NOT NULL,
    UserID INT NOT NULL,
    PrixTotal DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (ShowtimeID) REFERENCES Showtime(ID_Showtime),
    FOREIGN KEY (UserID) REFERENCES User(ID_User)
);

CREATE TABLE Seat (
    ID_Seat INT PRIMARY KEY AUTO_INCREMENT,
    HallID INT NOT NULL,
    Disponibilite BOOLEAN NOT NULL,
    FOREIGN KEY (HallID) REFERENCES CinemaHall(ID_Hall)
);

CREATE TABLE Rate (
    ID_Rate INT PRIMARY KEY AUTO_INCREMENT,
    TypeTarif VARCHAR(20) NOT NULL,
    Prix DECIMAL(8, 2) NOT NULL
);

CREATE TABLE Payment (
    ID_Payment INT PRIMARY KEY AUTO_INCREMENT,
    ReservationID INT NOT NULL,
    Montant DECIMAL(8, 2) NOT NULL,
    TypePaiement VARCHAR(20) NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ID_Reservation)
);




--Remplissage des tables avec de fausses données--
INSERT INTO Cinema (Nom, Emplacement) VALUES
    ('Cinema A', 'Emplacement A'),
    ('Cinema B', 'Emplacement B'),
    ('Cinema C', 'Emplacement C');

INSERT INTO CinemaHall (CinemaID, Capacite) VALUES
    (1, 100),
    (1, 150),
    (2, 120),
    (2, 180),
    (3, 80),
    (3, 110);

INSERT INTO Movie (Titre, Description, Duree, DateSortie) VALUES
    ('Film 1', 'Description du Film 1', 120, '2023-01-10'),
    ('Film 2', 'Description du Film 2', 110, '2023-02-15'),
    ('Film 3', 'Description du Film 3', 135, '2023-03-20');


INSERT INTO Showtime (FilmID, HallID, DateHeure, Prix, PlacesDisponibles) VALUES
    (1, 1, '2023-01-10 18:00:00', 10.50, 80),
    (1, 2, '2023-01-10 20:30:00', 10.50, 120),
    (2, 3, '2023-02-15 19:15:00', 9.75, 90),
    (2, 4, '2023-02-15 21:45:00', 9.75, 150),
    (3, 5, '2023-03-20 17:30:00', 11.00, 60),
    (3, 6, '2023-03-20 20:00:00', 11.00, 100);


INSERT INTO User (NomUtilisateur, MotDePasse, TypeUtilisateur) VALUES
    ('Utilisateur1', 'MotDePasse1', 'Client'),
    ('Utilisateur2', 'MotDePasse2', 'Client'),
    ('Admin1', 'MotDePasseAdmin1', 'Administrateur'),
    ('Admin2', 'MotDePasseAdmin2', 'Administrateur');

INSERT INTO Reservation (ShowtimeID, UserID, PrixTotal) VALUES
    (1, 1, 10.50),
    (3, 2, 9.75),
    (5, 1, 11.00),
    (2, 3, 10.50);

INSERT INTO Seat (HallID, Disponibilite) VALUES
    (1, 1),
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (4, 1),
    (5, 1),
    (6, 1);

INSERT INTO Rate (TypeTarif, Prix) VALUES
    ('Plein tarif', 9.20),
    ('Étudiant', 7.60),
    ('Moins de 14 ans', 5.90);

INSERT INTO Payment (ReservationID, Montant, TypePaiement) VALUES
    (1, 10.50, 'Carte de crédit'),
    (3, 9.75, 'PayPal'),
    (5, 11.00, 'Carte de crédit'),
    (2, 10.50, 'Espèces');
