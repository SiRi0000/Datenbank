-- ***************************************************************
-- * File Name:                  ueb5_concept.sql                *
-- * File Creator:               Knolle                          *
-- * CreationDate:               21. Vovember 2022               *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2022/23
-- * Uebung 5 
--
-- ***************************************************************
-- * SQL*plus Job Control Section

set echo on
set linesize 80
set pagesize 50
spool ./ueb5_concept.log

-- Systemdatum Start (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--

-- ***************************************************************
-- * Clear Database Section

DROP TABLE TABMitglied CASCADE CONSTRAINTS;
DROP TABLE TABBibliotheksausweis CASCADE CONSTRAINTS;
DROP TABLE TABBestellung CASCADE CONSTRAINTS;
DROP TABLE TABMitglied_leih_für_Mitglied CASCADE CONSTRAINTS;
DROP TABLE TABNam_Titel CASCADE CONSTRAINTS;
DROP TABLE TABNam_Vorname CASCADE CONSTRAINTS;
DROP TABLE TABAdr_PLZ CASCADE CONSTRAINTS;
DROP TABLE TABBestellung_ent_Leihmaterial CASCADE CONSTRAINTS;
DROP TABLE TABphysisches_Leihmaterial CASCADE CONSTRAINTS;
DROP TABLE TABMitglied_leih_Leihmaterial CASCADE CONSTRAINTS;
DROP TABLE TABMitglied_download_Medien CASCADE CONSTRAINTS;
DROP TABLE TABDownload CASCADE CONSTRAINTS;
DROP TABLE TABdownloadbare_Medien CASCADE CONSTRAINTS;
DROP TABLE TABeBook CASCADE CONSTRAINTS;
DROP TABLE TABeMagazine CASCADE CONSTRAINTS;
DROP TABLE TABeAudio CASCADE CONSTRAINTS;
DROP TABLE TABeKategorie CASCADE CONSTRAINTS;
DROP TABLE TABMedien_hat_eKategorie CASCADE CONSTRAINTS;


-- ***************************************************************
-- * Table Section

CREATE TABLE TABMitglied
(PKMitglied Numeric(10), 
NN_Anrede char(6), 
NN_Nachname varchar(60), 
Email varchar(60),
NN_GeburtsDatum date,
NN_Adr_Straße varchar(80),
NN_Mitglied_Adr_Hausnummer varchar(5),
Adr_Zusatz varchar(60),
UK_PersoNr1 varchar(20)
);

CREATE TABLE TABBibliotheksausweis (
PK_BibAusweis Numeric(10),
UK_FKMitglied Numeric(10),
NN_Gueltigkeitsdatum date
);

CREATE TABLE TABBestellung(
PK_Bestellung Numeric(10),
FK_BibAusweis Numeric(10),
NN_Abholdatum date,
NN_Rückgabedatum date,
NN_Standort varchar(60)
);

CREATE TABLE TABMitglied_leih_für_Mitglied(
PK_FKMitglied Numeric(10),
PK_FKMitglied1 Numeric(10)
);

CREATE TABLE TABNam_Titel(
PK_FKMitglied Numeric(10),
PK_lftNr Numeric(10),
NN_NamTitel varchar(10)
);

CREATE TABLE TABNam_Vorname(
PK_FKMitglied Numeric(10),
PK_lftNr Numeric(10),
NN_NamVorname varchar(10)
);

CREATE TABLE TABAdr_PLZ(
PK_Adr_PLZ Numeric(5),
NN_AdrOrt Varchar(60)

);

CREATE TABLE TABBestellung_ent_Leihmaterial(
PK_FKLeihmaterial Numeric(10),
PK_FKBestellung Numeric(10)

);

CREATE TABLE TABphysisches_Leihmaterial(
PK_Leihmaterial Numeric(10),
NN_Standort Varchar(30),
NN_Leihdauer Numeric(2),
NN_Titel Varchar(60),
NN_Autor Varchar(60),
NN_Erscheinungsdatum Date,
NN_Verfügbarkeit Numeric(1)
);

CREATE TABLE TABMitglied_leih_Leihmaterial(
PK_FKLeihamterial Numeric(10),
FK_BibAusweis Numeric(10),
NN_Rueckgabefrist Date,
NN_Ausleihdatum Date
);

CREATE TABLE TABMitglied_download_Medien(
PK_FKDownload Numeric(10),
FK_BibAusweis Numeric(10),
FK_downMed_Mitgl Numeric(10)
);

CREATE TABLE TABDownload(
PK_Download_lfn Numeric(10),
NN_DownloadDatum Date
);

CREATE TABLE TABdownloadbare_Medien(
PK_downloadbareMedien Numeric(10),
UK_downloadbare_Medien_Titel_1 Varchar(80),
UK_downloadbare_Medien_Autor_1 Varchar(60),
NN_Erscheinungsdatum Date,
NN_Dateigroesse Numeric(5)
);

CREATE TABLE TABeBook(
PK_FKdownMed Numeric(10),
UK_eBook_IDeBook_1 Numeric(10),
NN_Verlag Varchar(60),
UK_ISBN_2 Varchar(60)
);

CREATE TABLE TABeMagazine(
PK_FKdownMed Numeric(10),
UK_eMagazine_IDeMagazine Numeric(10)
);

CREATE TABLE TABeAudio(
PK_FKdownMed Numeric(10),
UK_eAudio_IDeAudio Numeric(10),
NN_Audiolänge Numeric(5,2)
);

CREATE TABLE TABeKategorie(
PK_eKategorie Numeric(10),
NN_Bezeichnung Varchar(60)
);

CREATE TABLE TABMedien_hat_eKategorie(
PK_FKeKategorie Numeric(10),
PK_FKdownMed Numeric(10)
);



-- ***************************************************************
-- * NOT NULL Constraint Section
--_______________________________________________________
ALTER TABLE TABMitglied 
ADD CONSTRAINT NN_Anrede CHECK (NN_Anrede IS NOT NULL);

ALTER TABLE TABMitglied 
ADD CONSTRAINT NN_Nachname CHECK (NN_Nachname IS NOT NULL);

ALTER TABLE TABMitglied 
ADD CONSTRAINT NN_GeburtsDatum CHECK (NN_GeburtsDatum IS NOT NULL);

ALTER TABLE TABMitglied 
ADD CONSTRAINT NN_Adr_Straße CHECK (NN_Adr_Straße IS NOT NULL);

ALTER TABLE TABMitglied 
ADD CONSTRAINT NN_Mitglied_Adr_Hausnummer CHECK (NN_Mitglied_Adr_Hausnummer IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABBibliotheksausweis 
ADD CONSTRAINT NN_Gueltigkeitsdatum CHECK (NN_Gueltigkeitsdatum IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABBestellung 
ADD CONSTRAINT NN_Abholdatum CHECK (NN_Abholdatum IS NOT NULL);

ALTER TABLE TABBestellung 
ADD CONSTRAINT NN_Rückgabedatum CHECK (NN_Rückgabedatum IS NOT NULL);

ALTER TABLE TABBestellung 
ADD CONSTRAINT NN_Standort CHECK (NN_Standort IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABNam_Titel 
ADD CONSTRAINT NN_NamTitel CHECK (NN_NamTitel IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABNam_Vorname 
ADD CONSTRAINT NN_NamVorname CHECK (NN_NamVorname IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABAdr_PLZ 
ADD CONSTRAINT NN_AdrOrt CHECK (NN_AdrOrt IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Standort CHECK (NN_Standort IS NOT NULL);

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Leihdauer CHECK (NN_Leihdauer IS NOT NULL);

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Titel CHECK (NN_Titel IS NOT NULL);

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Autor CHECK (NN_Autor IS NOT NULL);

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Erscheinungsdatum CHECK (NN_Erscheinungsdatum IS NOT NULL);

ALTER TABLE TABphysisches_Leihmaterial 
ADD CONSTRAINT NN_Verfügbarkeit CHECK (NN_Verfügbarkeit IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABMitglied_leih_Leihmaterial 
ADD CONSTRAINT NN_Rueckgabefrist CHECK (NN_Rueckgabefrist IS NOT NULL);

ALTER TABLE TABMitglied_leih_Leihmaterial 
ADD CONSTRAINT NN_Ausleihdatum CHECK (NN_Ausleihdatum IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABDownload 
ADD CONSTRAINT NN_DownloadDatum CHECK (NN_DownloadDatum IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABdownloadbare_Medien 
ADD CONSTRAINT NNErscheinungsdatum CHECK (NN_Erscheinungsdatum IS NOT NULL);

ALTER TABLE TABdownloadbare_Medien 
ADD CONSTRAINT NN_Dateigroesse CHECK (NN_Dateigroesse IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABeBook 
ADD CONSTRAINT NN_Verlag CHECK (NN_Verlag IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABeAudio 
ADD CONSTRAINT NN_Audiolänge CHECK (NN_Audiolänge IS NOT NULL);

--_________________________________________________________

ALTER TABLE TABeKategorie 
ADD CONSTRAINT NN_Bezeichnung CHECK (NN_Bezeichnung IS NOT NULL);

--_________________________________________________________

-- ***************************************************************
-- * Primary Key Constraint Section

ALTER TABLE TABMitglied
      ADD CONSTRAINT PKMitglied PRIMARY KEY (PKMitglied);

ALTER TABLE TABBibliotheksausweis
      ADD CONSTRAINT PKBibAusweis PRIMARY KEY (PK_BibAusweis);
      
ALTER TABLE TABBestellung
      ADD CONSTRAINT PKBestellung PRIMARY KEY (PK_Bestellung);
      
ALTER TABLE TABMitglied_leih_für_Mitglied
      ADD CONSTRAINT PKMitglied_leih_für_Mitglied PRIMARY KEY (PK_FKMitglied, PK_FKMitglied1);

ALTER TABLE TABNam_Titel
      ADD CONSTRAINT PKNam_Titel PRIMARY KEY (PK_FKMitglied, PK_lftNr);

ALTER TABLE TABNam_Vorname
      ADD CONSTRAINT PKNam_Vorname PRIMARY KEY (PK_FKMitglied, PK_lftNr);

ALTER TABLE TABAdr_PLZ
      ADD CONSTRAINT PKAdr_PLZ PRIMARY KEY (PK_Adr_PLZ);

ALTER TABLE TABBestellung_ent_Leihmaterial
      ADD CONSTRAINT PKBestellung_ent_Leihmaterial PRIMARY KEY (PK_FKLeihmaterial, PK_FKBestellung);

ALTER TABLE TABphysisches_Leihmaterial
      ADD CONSTRAINT PKLeihmaterial PRIMARY KEY (PK_Leihmaterial);

ALTER TABLE TABMitglied_leih_Leihmaterial
      ADD CONSTRAINT PKMitglied_leih_Leihmaterial PRIMARY KEY (PK_FKLeihamterial);

ALTER TABLE TABMitglied_download_Medien
      ADD CONSTRAINT PKMitglied_download_Medien PRIMARY KEY (PK_FKDownload);

ALTER TABLE TABDownload
      ADD CONSTRAINT PKDownload PRIMARY KEY (PK_Download_lfn);

ALTER TABLE TABdownloadbare_Medien
      ADD CONSTRAINT PKdownloadbareMedien PRIMARY KEY (PK_downloadbareMedien);

ALTER TABLE TABeBook
      ADD CONSTRAINT PKeBook PRIMARY KEY (PK_FKdownMed);

ALTER TABLE TABeMagazine
      ADD CONSTRAINT PKeMagazine PRIMARY KEY (PK_FKdownMed);

ALTER TABLE TABeAudio
      ADD CONSTRAINT PKeAudio PRIMARY KEY (PK_FKdownMed);

ALTER TABLE TABeKategorie
      ADD CONSTRAINT PKeKategorie PRIMARY KEY (PK_eKategorie);

ALTER TABLE TABMedien_hat_eKategorie
      ADD CONSTRAINT PKMedien_hat_eKategorie PRIMARY KEY (PK_FKeKategorie, PK_FKdownMed);



-- ***************************************************************
-- * Unique Key Constraint Section

ALTER TABLE TABMitglied
      ADD CONSTRAINT UKMitglied UNIQUE  (UK_PersoNr1);


ALTER TABLE TABBibliotheksausweis
      ADD CONSTRAINT UKBibliotheksausweis UNIQUE  (UK_FKMitglied);

ALTER TABLE TABdownloadbare_Medien
      ADD CONSTRAINT UKdownloadbare_Medien UNIQUE  (UK_downloadbare_Medien_Titel_1,UK_downloadbare_Medien_Autor_1 );

ALTER TABLE TABeBook
      ADD CONSTRAINT UKeBook UNIQUE  (UK_eBook_IDeBook_1);
      
ALTER TABLE TABeBook
      ADD CONSTRAINT UKeBook2 UNIQUE  (UK_ISBN_2);

ALTER TABLE TABeMagazine
      ADD CONSTRAINT UKeMagazine UNIQUE  (UK_eMagazine_IDeMagazine);

ALTER TABLE TABeAudio
      ADD CONSTRAINT UKeAudio UNIQUE  (UK_eAudio_IDeAudio);



-- ***************************************************************
-- * Foreign Key Constraint Section

ALTER TABLE TABBibliotheksausweis
      ADD CONSTRAINT FKBibliotheksausweis 
      FOREIGN KEY (UK_FKMitglied)
      REFERENCES TABMitglied;

ALTER TABLE TABBestellung
      ADD CONSTRAINT FKBestellung 
      FOREIGN KEY (FK_BibAusweis)
      REFERENCES TABBibliotheksausweis;

ALTER TABLE TABMitglied_leih_für_Mitglied
      ADD CONSTRAINT FKMitglied_leih_für_Mitglied 
      FOREIGN KEY (PK_FKMitglied)
      REFERENCES TABMitglied;

ALTER TABLE TABMitglied_leih_für_Mitglied
      ADD CONSTRAINT FKMitglied_leih_für_Mitglied1 
      FOREIGN KEY (PK_FKMitglied1)
      REFERENCES TABMitglied;



CREATE TABLE TABNam_Titel(
PK_FKMitglied Numeric(10),
PK_lftNr Numeric(10),
NN_NamTitel varchar(10)
);

CREATE TABLE TABNam_Vorname(
PK_FKMitglied Numeric(10),
PK_lftNr Numeric(10),
NN_NamVorname varchar(10)
);

CREATE TABLE TABAdr_PLZ(
PK_Adr_PLZ Numeric(5),
NN_AdrOrt Varchar(60)

);

CREATE TABLE TABBestellung_ent_Leihmaterial(
PK_FKLeihmaterial Numeric(10),
PK_FKBestellung Numeric(10)

);

CREATE TABLE TABphysisches_Leihmaterial(
PK_Leihmaterial Numeric(10),
NN_Standort Varchar(30),
NN_Leihdauer Numeric(2),
NN_Titel Varchar(60),
NN_Autor Varchar(60),
NN_Erscheinungsdatum Date,
NN_Verfügbarkeit Numeric(1)
);

CREATE TABLE TABMitglied_leih_Leihmaterial(
PK_FKLeihamterial Numeric(10),
FK_BibAusweis Numeric(10),
NN_Rueckgabefrist Date,
NN_Ausleihdatum Date
);

CREATE TABLE TABMitglied_download_Medien(
PK_FKDownload Numeric(10),
FK_BibAusweis Numeric(10),
FK_downMed_Mitgl Numeric(10)
);

CREATE TABLE TABDownload(
PK_Download_lfn Numeric(10),
NN_DownloadDatum Date
);

CREATE TABLE TABdownloadbare_Medien(
PK_downloadbareMedien Numeric(10),
UK_downloadbare_Medien_Titel_1 Varchar(80),
UK_downloadbare_Medien_Autor_1 Varchar(60),
NN_Erscheinungsdatum Date,
NN_Dateigroesse Numeric(5)
);

CREATE TABLE TABeBook(
PK_FKdownMed Numeric(10),
UK_eBook_IDeBook_1 Numeric(10),
NN_Verlag Varchar(60),
UK_ISBN_2 Varchar(60)
);

CREATE TABLE TABeMagazine(
PK_FKdownMed Numeric(10),
UK_eMagazine_IDeMagazine Numeric(10)
);

CREATE TABLE TABeAudio(
PK_FKdownMed Numeric(10),
UK_eAudio_IDeAudio Numeric(10),
NN_Audiolänge Numeric(5,2)
);

CREATE TABLE TABeKategorie(
PK_eKategorie Numeric(10),
NN_Bezeichnung Varchar(60)
);

CREATE TABLE TABMedien_hat_eKategorie(
PK_FKeKategorie Numeric(10),
PK_FKdownMed Numeric(10)
);


-- ***************************************************************
-- * SQL*plus Job Control Section

spool ueb5_concept.log
set echo on
set linesize 80
set pagesize 50
spool off

-- Systemdatum Ende (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  

  spool off