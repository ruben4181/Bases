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
      DELETE FROM tarifas WHERE tarifas.id_tarifa = id_tarifa;
      DBMS_OUTPUT.PUT_LINE('TARIFA: Borrada: '|| id_tarifa);
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Tarifa: '|| id_tarifa || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando la tarifa ');
END;
commit;

/*********************************************CATALOGO******************************/
/************************************************************************************/
/*************************************************************************************/

/*******************CREAR***********************/
create or replace PROCEDURE REGISTRAR_(
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

/*****************catalogo ************/
/************************//*********/
create or replace PROCEDURE insert_catalogo(
                          nombre_catalogo CATALOGO.nombre_catalogo%TYPE)

AS
BEGIN
  INSERT INTO catalogos(id_catalogo, nombre_catalogo)
  VALUES(ID_CATALOGO.nextval, nombre_catalogo);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ocurrio un error al insertar en la tabla catalogo');
END;
commit;
/****************Update********************/
create or replace PROCEDURE update_catalogo(id_catalogo CATALOGOS.ID_CATALOGO%TYPE,
                        nombre_catalogo CATALOGOS.NOMBRE_CATALOGO%TYPE) 
                       AS
BEGIN
    IF exists_catalogo(id_catalogo)=TRUE THEN
            UPDATE CATALOGOS SET CATALOGOS.NOMBRE_CATALOGO=nombre_catalogo;
        
    ELSE
            DBMS_OUTPUT.PUT_LINE('El catalogo no existe');
    END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error ocurred while updating CATALOGOS table');
END;
/******************VALIDAR**************************/
create or replace FUNCTION
exists_catalogo(id_catalogo catalogos.id_catalogo%TYPE) RETURN BOOLEAN AS
  tmp VARCHAR(1);
BEGIN
  SELECT 'y' INTO tmp FROM catalogos WHERE catalogos.id_catalogo=id_catalogo;
  RETURN TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END;
/***********************delete**********************/
create or replace PROCEDURE delete_catalogo(id_catalogo_val CATALOGOS.ID_CATALOGO%TYPE) AS
BEGIN
    IF exists_catalogo(id_catalogo_val) THEN
        DELETE FROM CATALOGOS WHERE CATALOGOS.ID_CATALOGO = id_catalogo_val;
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('El catalogo no existe en la base de datos');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error ocurred while deleting from Catalogos table');
END;
commit;
/*******************************************************/
/******************PLANES**********************************/
/*******************************************************/
create or replace PROCEDURE insert_plan(
                          precio_val PLANES.PRECIO%TYPE,
                          minutos_plan_val PLANES.MINUTOS_PLAN%TYPE,
                          descripcion_val PLANES.DESCRIPCION%TYPE,
                          gigas_plan_val PLANES.GIGAS_PLAN%TYPE,
                          tipos_plan_id_tipo_plan_val PLANES.TIPOS_PLAN_ID_TIPO_PLAN%TYPE,
                          nombre_plan_val PLANES.NOMBRE_PLAN%TYPE,
                          sms_plan_val PLANES.SMS_PLAN%TYPE)

AS
BEGIN
  INSERT INTO planes(id_plan,precio,minutos_plan,descripcion,gigas_plan,tipos_plan_id_tipo_plan,nombre_plan,sms_plan)
  VALUES(ID_PLAN.nextval, precio_val,minutos_plan_val,descripcion_val,gigas_plan_val, tipos_plan_id_tipo_plan_val, nombre_plan_val,sms_plan_val);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ocurrio un error al insertar en la tabla PLANES');
END;
commit;

/**********Inserta catalogo a plan*******************************/








create or replace FUNCTION exists_contrato_activo(numero_val contratos.numero%TYPE) RETURN BOOLEAN AS
  tmp VARCHAR(1);
BEGIN  
  SELECT 'y' INTO tmp FROM contratos WHERE numero_val = contratos.numero and contratos.estado_contrato=1 and  ROWNUM = '1';
  RETURN TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Ya se encuentra este contrato activo y no lo podemos agregar');
    RETURN FALSE;
END;