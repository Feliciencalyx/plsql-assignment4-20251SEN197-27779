SET SERVEROUTPUT ON;

DECLARE
    TYPE student_array IS TABLE OF VARCHAR2(100)
    INDEX BY PLS_INTEGER;

    v_students student_array;
    v_counter PLS_INTEGER := 0;

BEGIN
    FOR student IN (
        SELECT first_name, last_name
        FROM A4_STUDENT.STUDENTS
        ORDER BY student_id
    )
    LOOP
        v_counter := v_counter + 1;

        v_students(v_counter) :=
            student.first_name || ' ' || student.last_name;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('STUDENT LIST');
    DBMS_OUTPUT.PUT_LINE('--------------------');

    FOR i IN 1..v_counter
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            i || '. ' || v_students(i)
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'Total students: ' || v_counter
    );
END;
/