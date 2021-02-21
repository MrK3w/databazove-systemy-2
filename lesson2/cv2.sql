-- Proceduralna nadstavba SQL - PL/SQL

-- Blok prikazov
BEGIN

END;

-- V ramci bloku prikazov moze byt:
-- 1, SQL jazyk
-- 2, Vypisy na obrazovku
-- 3, Premenne
-- 4, Vynimky
-- 5, Transakcie

-- 1, Vlozte jedneho studenta do tabulky student v ramci bloku prikazov
BEGIN
  insert into PIE0056."Student" (login, fname, lname, tallness) values ('abd123', 'Petr', 'Novak', 178);
END;

-- 2, Uloha 1 + info, ze student bol uspesne vlozeny
BEGIN
  insert into PIE0056."Student" (login, fname, lname, tallness) values ('abc125', 'Petr', 'Novak', 178);
  DBMS_OUTPUT.PUT_LINE('Student bol uspesne vlozeny');
END;

-- 3, Uloha 2 + vynimku v pripade chyby
BEGIN
  insert into  PIE0056."Student" (login, fname, lname, tallness) values ('abc125', 'Petr', 'Novak', 178);
  DBMS_OUTPUT.PUT_LINE('Student bol uspesne vlozeny');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Nastala chyba pri vkladani studenta');
END;

-- 4, Uloha 3 + premenne
-- vysku ziskate selektom zo studenta s login abc123
DECLARE
  p_login char(6);
BEGIN
  p_login := 'abc126';
  insert into  PIE0056."Student" (login, fname, lname, tallness) values (p_login, 'Petr', 'Novak', 178);
  DBMS_OUTPUT.PUT_LINE('Student s login ' || p_login || ' bol uspesne vlozeny');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Nastala chyba pri vkladani studenta');
END;

-- Student s loginom abc126 a meno Petr Novak bol uspesne vlozeny.
-- spajanie retazcov ||

-- 5, Uloha 3 + premenne (druhy sposob)
SET SERVEROUTPUT ON; 
DECLARE
  p_login  PIE0056."Student".login%type;
BEGIN
  p_login := 'abc126';
  insert into  PIE0056."Student" (login, fname, lname, tallness) values (p_login, 'Petr', 'Novak', 178);
  DBMS_OUTPUT.PUT_LINE('Student s login ' || p_login || ' bol uspesne vlozeny');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Nastala chyba pri vkladani studenta');
END;

-- 5, Uloha 3 + premenne (treti sposob)
DECLARE
  p_student  PIE0056."Student"%rowtype;
BEGIN
  p_student.login := 'abc126';
  insert into  PIE0056."Student" (login, fname, lname, tallness) values ('abc3', 'Petr', 'Novak', 178);
  insert into  PIE0056."Student" (login, fname, lname, tallness) values ('abc1', 'Petr', 'Novak', 178);
  insert into  PIE0056."Student" (login, fname, lname, tallness) values ('abc13', 'Petr', 'Novak', 178);
  DBMS_OUTPUT.PUT_LINE('Student s login ' || p_student.login || ' bol uspesne vlozeny');
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Nastala chyba pri vkladani studenta');
    ROLLBACK;
END;

-- COMMIT - potvrdzuje vsetky zmeny do databaze
-- ROLLBACK - vracia databazu do povodneho stavu

-- nastavenie hodnoty premennej pomocou selectu
-- select musi vraciat vzdy len jeden zaznam !!!
select count(*) into p_premenna from  PIE0056."Student";
select fname into p_fname, lname into p_lname from student where login='abc123';
select * into p_student from  PIE0056."Student" where login='abc123';
