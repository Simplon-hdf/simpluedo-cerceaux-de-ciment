-- CREATE USER admin_simpluedo WITH CREATEDB;

-- Connexion à une autre base de données pour permettre la suppression
\c postgres

-- Supprime la base de données si elle existe
DROP DATABASE IF EXISTS simpluedo;

-- Crée une nouvelle base de données
CREATE DATABASE simpluedo;

-- Se reconnecte à la nouvelle base de données
\c simpluedo

-- Après s'être connecté à la base de données
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin_simpluedo;

CREATE TABLE personnage(
   id_perso INTEGER PRIMARY KEY,
   nom_perso VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE salle(
   id_salle INTEGER PRIMARY KEY,
   nom_salle VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE objet(
   id_objet INTEGER PRIMARY KEY,
   nom_objet VARCHAR(20) ,
   id_salle INTEGER NOT NULL REFERENCES salle(id_salle)
);

CREATE TABLE role(
   id_role INTEGER PRIMARY KEY,
   nom_role VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE utilisateur(
   uuid_utilisateur UUID PRIMARY KEY DEFAULT gen_random_uuid(),
   pseudo_utilisateur VARCHAR(20) NOT NULL,
   id_role INTEGER NOT NULL REFERENCES role(id_role),
   id_perso INTEGER UNIQUE REFERENCES personnage(id_perso)
);

CREATE TABLE visiter(
   id_perso INTEGER REFERENCES personnage(id_perso),
   id_salle INTEGER REFERENCES salle(id_salle),
   heure_arrive TIME,
   heure_sortie TIME,
   PRIMARY KEY(id_perso, id_salle)
);