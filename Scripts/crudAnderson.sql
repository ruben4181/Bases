
/*********************************************
***************** FACTURA ********************
**********************************************/

CREATE OR REPLACE FUNCTION VALIDAR_TARIFA(id_tarifa IN TARIFA.ID_TARIFA%TYPE) RETURN BOOLEAN
IS
    f_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO f_temporal
    FROM tarifa
    WHERE id_tarifa = nit;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;

/*******************CREAR***********************/
CREATE OR REPLACE PROCEDURE REGISTRAR_TARIFA(  INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer,
                                   idcliempre integer,
                                   idtipoclie integer)
IS
BEGIN
  IF VALIDAR_CLIENTE(nit)=FALSE THEN
  BEGIN
      INSERT INTO cliente (nit_clie,nom_clie,direccion_clie,tel_clie,email_clie,cod_ciudad,id_cliente_empresa,id_tipo_clie)
      VALUES (nit,nombre,direccion,telefono,email,codiciudad,idcliempre,idtipoclie);
      DBMS_OUTPUT.PUT_LINE('Insertado cliente: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' cliente: '|| nit || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando cliente ');
END REGISTRAR_CLIENTE;


