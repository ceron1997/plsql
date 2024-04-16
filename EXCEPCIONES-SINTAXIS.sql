SET SERVEROUTPUT ON
DECLARE
    empl   employees%rowtype;--p
BEGIN
    SELECT
        *
    INTO
        empl
    FROM
        employees
    WHERE
        employee_id > 1;--=1000
    dbms_output.put_line(empl.first_name);
--tipos oracle y usuario
EXCEPTION
    WHEN ex6 THEN
        NULL;
    WHEN ex2 THEN
        NULL;
    WHEN OTHERS THEN
        NULL;        
END;