CREATE TABLE alumnes (
    id_alumne INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(50) NOT NULL,
    data_naixement DATE NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefon VARCHAR(50) NOT NULL,
    cicle_formatiu VARCHAR(50) NOT NULL,
    curs INT NOT NULL
);

CREATE TABLE empreses (
    id_empresa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    adreça VARCHAR(50) NOT NULL,
    telefon VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE tutors (
    id_tutor INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefon VARCHAR(50) NOT NULL
);


CREATE TABLE pràctiques (
    id_practica INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_alumne INT NOT NULL,
    id_empresa INT NOT NULL,
    tipus_practica VARCHAR(50) NOT NULL,
    data_inici DATE NOT NULL,
    data_fi DATE NOT NULL,
    hores INT NOT NULL,
    té_exempció BOOLEAN NOT NULL,
    tipus_exempció VARCHAR(50) NOT NULL);


CREATE TRIGGER comprovar_data_inici BEFORE INSERT ON practiques FOR EACH ROW BEGIN IF NEW.data_inici < CURDATE() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es poden inserir pràctiques amb data d''inici anteriors a la data actual'; END IF; END;

CREATE TRIGGER comprovar_data_fi BEFORE UPDATE ON practiques FOR EACH ROW BEGIN IF NEW.data_fi < NEW.data_inici THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es poden actualitzar pràctiques amb data de finalització anteriors a la data d''inici'; END IF; END;

CREATE TRIGGER comprovar_referencies BEFORE DELETE ON practiques FOR EACH ROW BEGIN DECLARE num_alumne INT; DECLARE num_empresa INT; SELECT COUNT(*) INTO num_alumne FROM practiques WHERE id_alumne = OLD.id_alumne; SELECT COUNT(*) INTO num_empresa FROM practiques WHERE id_empresa = OLD.id_empresa; IF num_alumne = 1 OR num_empresa = 1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es poden eliminar pràctiques que siguin l''única referència a alumnes o empreses'; END IF; END;
