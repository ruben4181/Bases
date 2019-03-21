CREATE SEQUENCE ID_TABLA MINVALUE 1 START WITH 1 MAXVAL 1000000;
/*********************************************
***************** FACTURA ********************
**********************************************/

CREATE OR REPLACE FUNCTION VALIDAR_TARIFA(
                                          valor_minuto  tarifas.valor_minuto%type,
                                          valor_mensaje  tarifas.valor_mensaje%type ,
                                          valor_mb  tarifas.valor_mb%type,
                                          valor_minuto_extra  tarifas.valor_minuto_extra%type,
                                          valor_mensaje_extra  tarifas.valor_mensaje_extra%type,
                                          valor_mb_extra  tarifas.valor_mb_extra%type) RETURN BOOLEAN
IS
    f_temporal VARCHAR(5);
BEGIN
    SELECT 'x'
    INTO f_temporal
    FROM tarifas
    WHERE tarifas.valor_minuto = valor_minuto 
          and tarifas.valor_mensaje = valor_mensaje
          and tarifas.valor_mb = valor_mb
          and tarifas.valor_minuto_extra = valor_minuto_extra
          and tarifas.valor_mensaje_extra = valor_mensaje_extra
          and tarifas.valor_mb_extra = valor_mb_extra;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
commit;
/*******************CREAR***********************/
create or replace PROCEDURE REGISTRAR_TARIFA(
                                   valor_minuto  tarifas.valor_minuto%type,
                                   valor_mensaje  tarifas.valor_mensaje%type ,
                                   valor_mb  tarifas.valor_mb%type,
                                   valor_minuto_extra  tarifas.valor_minuto_extra%type,
                                   valor_mensaje_extra  tarifas.valor_mensaje_extra%type,
                                   valor_mb_extra  tarifas.valor_mb_extra%type)
IS
BEGIN
  IF VALIDAR_TARIFA(valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra)=FALSE THEN
  BEGIN
      INSERT INTO tarifas (id_tarifa,valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra)
      VALUES (ID_TARIFA.nextval,valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra);
      DBMS_OUTPUT.PUT_LINE('Tarifa Insertada : ');
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' La Tarifa  ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la tarifa '||sqlerrm);
END;
commit;

/****************Eliminar*******************************/

CREATE OR REPLACE PROCEDURE DELETE_TARIFA(id_tarifa tarifas.id_tarifa%type,
                                   valor_minuto  tarifas.valor_minuto%type,
                                   valor_mensaje  tarifas.valor_mensaje%type ,
                                   valor_mb  tarifas.valor_mb%type,
                                   valor_minuto_extra  tarifas.valor_minuto_extra%type,
                                   valor_mensaje_extra  tarifas.valor_mensaje_extra%type,
                                   valor_mb_extra  tarifas.valor_mb_extra%type)
IS
BEGIN
  IF VALIDAR_TARIFA(valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra)=TRUE THEN
  BEGIN
      DELETE FROM cliente WHERE nit_clie = nit;
      DBMS_OUTPUT.PUT_LINE('TARIFA: Borrada: '|| id_tarifa);
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Tarifa: '|| id_tarifa || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando la tarifa ');
END;

