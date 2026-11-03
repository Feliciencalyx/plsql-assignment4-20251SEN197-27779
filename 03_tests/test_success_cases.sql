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
SET SERVEROUTPUT ON;

DECLARE
    TYPE student_table IS TABLE OF VARCHAR2(100);

    v_students student_table;

BEGIN
    v_students := student_table(
        'Felicien Nshimyumukiza',
        'Nairot Igirimbabazi',
        'David Mugisha',
        'Grace Uwase',
        'Samuel Habimana'
    );

    DBMS_OUTPUT.PUT_LINE('NESTED TABLE STUDENT LIST');
    DBMS_OUTPUT.PUT_LINE('-------------------------');

    FOR i IN 1..v_students.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            i || '. ' || v_students(i)
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'Total students: ' || v_students.COUNT
    );
END;
/

SET SERVEROUTPUT ON;

DECLARE
    TYPE student_array IS VARRAY(5) OF VARCHAR2(100);

    v_students student_array;

BEGIN
    v_students := student_array(
        'Felicien Nshimyumukiza',
        'Nairot Igirimbabazi',
        'David Mugisha',
        'Grace Uwase',
        'Samuel Habimana'
    );

    DBMS_OUTPUT.PUT_LINE('VARRAY STUDENT LIST');
    DBMS_OUTPUT.PUT_LINE('-------------------');

    FOR i IN 1..v_students.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            i || '. ' || v_students(i)
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'Total students: ' || v_students.COUNT
    );

    DBMS_OUTPUT.PUT_LINE(
        'Maximum capacity: 5'
    );
END;
/

SET SERVEROUTPUT ON;

BEGIN
    UPDATE A4_STUDENT.STUDENTS
    SET status = 'ACTIVE'
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE(
        'Rows updated: ' || SQL%ROWCOUNT
    );

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student was found and updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No student was updated.');
    END IF;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No matching record exists.');
    END IF;
END;
/

SET SERVEROUTPUT ON;

BEGIN
    UPDATE A4_STUDENT.STUDENTS
    SET status = 'ACTIVE'
    WHERE student_id = 9999;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No student found with ID 9999.');
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Rows updated: ' || SQL%ROWCOUNT
    );
END;
/

SET SERVEROUTPUT ON;

DECLARE
    CURSOR student_cursor IS
        SELECT student_id, first_name, last_name, email
        FROM A4_STUDENT.STUDENTS
        ORDER BY student_id;

    v_id A4_STUDENT.STUDENTS.student_id%TYPE;
    v_first_name A4_STUDENT.STUDENTS.first_name%TYPE;
    v_last_name A4_STUDENT.STUDENTS.last_name%TYPE;
    v_email A4_STUDENT.STUDENTS.email%TYPE;

BEGIN
    OPEN student_cursor;

    DBMS_OUTPUT.PUT_LINE('STUDENT REGISTRATION LIST');
    DBMS_OUTPUT.PUT_LINE('-------------------------');

    LOOP
        FETCH student_cursor
        INTO v_id, v_first_name, v_last_name, v_email;

        EXIT WHEN student_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            v_id || '. ' || v_first_name || ' ' ||
            v_last_name || ' - ' || v_email
        );
    END LOOP;

    CLOSE student_cursor;
END;
/
