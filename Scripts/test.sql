SELECT * FROM RANGO_SALARIOS;
SELECT * FROM CLIENTES;
SELECT * FROM NUMEROS;
SELECT * FROM EMPRESAS;

BEGIN
    INSERT_CLIENTE(1061543081, 'Ruben Dario', 'Vargas Yandy', 'Cl 42 Cr 112 Farallones de Bochalema Apto 302', 
                TO_DATE('1998-01-16','YYYY-MM-DD'), 'M', 'Estudiante', 1);
END;

BEGIN
    UPDATE_CLIENTE(1061543081, 'Ruben Dario', 'Vargas Yandy', 'Cl 42 Cr 112 Farallones de Bochalema Apto 302', 
                TO_DATE('1998-01-16','YYYY-MM-DD'), 'M', 'Estudiante', 1);
END;

BEGIN 
    DELETE_CLIENTE(1061543081);
END;

BEGIN
    INSERT_NUMERO(3117348662, 1061543081);
END;

BEGIN
    RECARGAR_NUMERO(3116021602, 2000);
END;