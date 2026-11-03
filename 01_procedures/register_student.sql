
CREATE OR REPLACE PROCEDURE A4_STUDENT.REGISTER_STUDENT (
    p_first_name IN VARCHAR2,
    p_last_name  IN VARCHAR2,
    p_email      IN VARCHAR2,
    p_dob        IN DATE
)
IS
BEGIN
    INSERT INTO A4_STUDENT.STUDENTS (
        first_name,
        last_name,
        email,
        date_of_birth
    )
    VALUES (
        p_first_name,
        p_last_name,
        p_email,
        p_dob
    );

    DBMS_OUTPUT.PUT_LINE(
        'Student registered successfully!'
    );

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'A student with this email already exists.'
        );

    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Registration failed: ' || SQLERRM
        );
END REGISTER_STUDENT;
/
