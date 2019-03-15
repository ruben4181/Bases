
/*********************************************
***************** FACTURA ********************
**********************************************/

CREATE OR REPLACE FUNCTION VALIDAR_TARIFA(
                                          valor_minuto  tarifa.valor_minuto%type,
                                          valor_mensaje  tarifa.valor_mensaje%type ,
                                          valor_mb  tarifa.valor_mb%type,
                                          valor_minuto_extra  tarifa.valor_minuto_extra%type,
                                          valor_mensaje_extra  tarifa.valor_mensaje_extra%type,
                                          valor_mb_extra  tarifa.valor_mb_extra%type) RETURN BOOLEAN
IS
    f_temporal VARCHAR(5);
BEGIN
    SELECT 'x'
    INTO f_temporal
    FROM tarifa
    WHERE tarifa.valor_minuto = valor_minuto 
          and tarifa.valor_mensaje = valor_mensaje
          and tarifa.valor_mb = valor_mb
          and tarifa.valor_minuto_extra = valor_minuto_extra
          and tarifa.valor_mensaje_extra = valor_mensaje_extra
          and tarifa.valor_mb_extra = valor_mb_extra;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/*******************CREAR***********************/
CREATE OR REPLACE PROCEDURE REGISTRAR_TARIFA( id_tarifa tarifa.id_tarifa%type,
                                   valor_minuto  tarifa.valor_minuto%type,
                                   valor_mensaje  tarifa.valor_mensaje%type ,
                                   valor_mb  tarifa.valor_mb%type,
                                   valor_minuto_extra  tarifa.valor_minuto_extra%type,
                                   valor_mensaje_extra  tarifa.valor_mensaje_extra%type,
                                   valor_mb_extra  tarifa.valor_mb_extra%type)
IS
BEGIN
  IF VALIDAR_TARIFA(valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra)=FALSE THEN
  BEGIN
      INSERT INTO tarifa (id_tarifa,valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra)
      VALUES (id_tarifa,valor_minuto,valor_mensaje,valor_mb,valor_minuto_extra,valor_mensaje_extra,valor_mb_extra);
      DBMS_OUTPUT.PUT_LINE('Tarifa Insertada : '|| id_tarifa);
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' La Tarifa : '|| id_tarifa || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la tarifa '||sqlerrm);
END VALIDAR_TARIFA;

/****************Eliminar*******************************/



