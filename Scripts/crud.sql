/*********************************************
***************** CLIENTE ********************
**********************************************/

CREATE OR REPLACE FUNCTION VALIDAR_CLIENTE(nit IN cliente.nit_clie%TYPE) RETURN BOOLEAN
IS
    v_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO v_temporal
    FROM cliente
    WHERE nit_clie = nit;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;

---- CREATE

CREATE OR REPLACE PROCEDURE REGISTRAR_CLIENTE(nit   INTEGER,
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


---- READ

CREATE OR REPLACE PROCEDURE LEER_CLIENTE(nit   INTEGER)
IS
BEGIN
  IF VALIDAR_CLIENTE(nit)=TRUE THEN
  BEGIN
      SELECT nit_clie,nom_clie,direccion_clie,tel_clie,email_clie,cod_ciudad,id_cliente_empresa,id_tipo_clie FROM cliente
      WHERE nit_clie = nit;
      DBMS_OUTPUT.PUT_LINE('Lectura cliente: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' cliente: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error leyendo cliente ');
END LEER_CLIENTE;

----- UPDATE

CREATE OR REPLACE PROCEDURE ACTUALIZAR_CLIENTE(nit   INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer,
                                   idcliempre integer,
                                   idtipoclie integer)
IS
BEGIN
  IF VALIDAR_CLIENTE(nit)=TRUE THEN
  BEGIN
      UPDATE cliente SET (nit_clie = nit ,nom_clie = nombre ,direccion_clie = direccion ,tel_clie = telefono, email_clie =email , cod_ciudad = codiciudad , id_cliente_empresa=idcliempre ,id_tipo_clie = idtipoclie)
      WHERE nit_clie = nit;
      DBMS_OUTPUT.PUT_LINE('Actualizado cliente: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' cliente: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error actualizando cliente ');
END ACTUALIZAR_CLIENTE;


----- DELETE

CREATE OR REPLACE PROCEDURE BORRAR_CLIENTE(nit   INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer,
                                   idcliempre integer,
                                   idtipoclie integer)
IS
BEGIN
  IF VALIDAR_CLIENTE(nit)=TRUE THEN
  BEGIN
      DELETE FROM cliente WHERE nit_clie = nit;
      DBMS_OUTPUT.PUT_LINE('Cliente: Borrado: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' cliente: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando el cliente ');
END BORRAR_CLIENTE;





/*********************************************
***************** PROVEEDOR ******************
**********************************************/



CREATE OR REPLACE FUNCTION VALIDAR_PROVEEDOR(nit IN proveedores.nit_prove%TYPE) RETURN BOOLEAN
IS
    v_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO v_temporal
    FROM proveedores
    WHERE nit_prove = nit;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;


---- CREATE


CREATE OR REPLACE PROCEDURE REGISTRAR_PROVEEDOR(nit      INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer)
IS
BEGIN
  IF VALIDAR_PROVEEDOR(nit)=FALSE THEN
  BEGIN
      INSERT INTO proveedores(nit_prove,nom_prove,direccion_prove,email_prove,tel_prove,cod_ciudad)
      VALUES (nit,nombre,direccion,email,telefono,codiciudad);
      DBMS_OUTPUT.PUT_LINE('Insertado proveedor: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' proveedor: '|| nit || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando proveedor '||SQLERRM);
END REGISTRAR_PROVEEDOR;


----- READ
CREATE OR REPLACE PROCEDURE LEER_PROVEEDOR(nit   INTEGER)
IS
BEGIN
  IF VALIDAR_PROVEEDOR(nit)=TRUE THEN
  BEGIN
      SELECT nit_prove,nom_prove,direccion_prove,email_prove,tel_prove,cod_ciudad FROM proveedores
      WHERE nit_prove = nit;
      DBMS_OUTPUT.PUT_LINE('Lectura proveedor: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' proveedor: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error leyendo proveedor '||SQLERRM);
END LEER_PROVEEDOR;


----- UPDATE
CREATE OR REPLACE PROCEDURE ACTUALIZAR_PROVEEDOR(nit      INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer)
IS
BEGIN
  IF VALIDAR_PROVEEDOR(nit)=TRUE THEN
  BEGIN
      UPDATE proveedores SET (nit_prove = nit ,nom_prove = nombre , direccion_prove = direccion , email_prove = email , tel_prove = telefono , cod_ciudad codiciudad)
      WHERE nit_prove = nit;
      DBMS_OUTPUT.PUT_LINE('Actualizado proveedor: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' proveedor: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error actualizando proveedor '||SQLERRM);
END ACTUALIZAR_PROVEEDOR;



------ DELETE
CREATE OR REPLACE PROCEDURE BORRAR_PROVEEDOR(nit      INTEGER,
                                   nombre   char,
                                   direccion varchar2,
                                   telefono varchar2,
                                   email varchar2,
                                   codiciudad integer)
IS
BEGIN
  IF VALIDAR_PROVEEDOR(nit) = TRUE THEN
  BEGIN
      DELETE FROM proveedores WHERE nit_prove = nit;
      DBMS_OUTPUT.PUT_LINE('Proveedor Borrado: '|| nit || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' proveedor: '|| nit || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando proveedor '||SQLERRM);
END BORRAR_PROVEEDOR;



/*********************************************
***************** PRODUCTO *******************
**********************************************/


CREATE OR REPLACE FUNCTION VALIDAR_PRODUCTO(codigo IN producto.cod_produ%TYPE) RETURN BOOLEAN
IS
    v_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO v_temporal
    FROM producto
    WHERE cod_produ = codigo;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;


---- CREATE

CREATE OR REPLACE PROCEDURE REGISTRAR_PRODUCTO(cod      INTEGER,
                                   nombre   char,
                                   precio numeric,
                                   iva smallint,
                                   peso numeric,
                                   cantidad integer,
                                   nit integer,
                                   codCate integer,
                                   codEmpa integer)
IS
BEGIN
  IF VALIDAR_PRODUCTO(cod)=FALSE THEN
  BEGIN
      INSERT INTO producto(cod_produ,nom_produ,precio_produ,iva_produ,peso_produ,cantDispo,nit_prove,cod_catego,cod_empaque)
      VALUES (cod,nombre,precio,iva,peso,cantidad,nit,codCate,codEmpa);
      DBMS_OUTPUT.PUT_LINE('Insertado Producto: '|| cod || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Producto: '|| cod || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando producto '||SQLERRM);
END REGISTRAR_PRODUCTO;


---- READ

CREATE OR REPLACE PROCEDURE LEER_PRODUCTO(cod   INTEGER)
IS
BEGIN
  IF VALIDAR_PRODUCTO(cod)=FALSE THEN
  BEGIN
      SELECT cod_produ,nom_produ,precio_produ,iva_produ,peso_produ,cantDispo,nit_prove,cod_catego,cod_empaque FROM producto
      WHERE cod_produ = cod;
      DBMS_OUTPUT.PUT_LINE('Lectura Producto: '|| cod || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Producto: '|| cod || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error leyendo producto '||SQLERRM);
END LEER_PRODUCTO;

---- UPDATE

CREATE OR REPLACE PROCEDURE ACTUALIZAR_PRODUCTO(cod      INTEGER,
                                   nombre   char,
                                   precio numeric,
                                   iva smallint,
                                   peso numeric,
                                   cantidad integer,
                                   nit integer,
                                   codCate integer,
                                   codEmpa integer)
IS
BEGIN
  IF VALIDAR_PRODUCTO(cod)=TRUE THEN
  BEGIN
      UPDATE producto SET (cod_produ = cod , nom_produ = nombre , precio_produ = precio , iva_produ = iva , peso_produ = peso , cantDispo = cantidad , nit_prove = nit , cod_catego = codCate , cod_empaque = codEmpa)
      WHERE cod_produ = cod;
      DBMS_OUTPUT.PUT_LINE('Actualizado Producto: '|| cod || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Producto: '|| cod || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error actualizando producto '||SQLERRM);
END ACTUALIZAR_PRODUCTO;

---- DELETE

CREATE OR REPLACE PROCEDURE BORRAR_PRODUCTO(cod      INTEGER,
                                   nombre   char,
                                   precio numeric,
                                   iva smallint,
                                   peso numeric,
                                   cantidad integer,
                                   nit integer,
                                   codCate integer,
                                   codEmpa integer)
IS
BEGIN
  IF VALIDAR_PRODUCTO(cod)=TRUE THEN
  BEGIN
      DELETE FROM producto WHERE cod_produ = cod;
      DBMS_OUTPUT.PUT_LINE('Producto Borrado: '|| cod || ' ' || nombre );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Producto: '|| cod || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando producto '||SQLERRM);
END BORRAR_PRODUCTO;



/*********************************************
***************** CATÀLOGO *******************
**********************************************/




CREATE OR REPLACE FUNCTION VALIDAR_CATALOGO_FECHA(fechaini IN catalogo.fecha_ini%TYPE) RETURN BOOLEAN
IS
    v_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO v_temporal
    FROM catalogo
    WHERE fechaini > fecha_fin
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;


CREATE OR REPLACE FUNCTION VALIDAR_CATALOGO(cod IN catalogo.cod_catalo%TYPE) RETURN BOOLEAN
IS
    v_temporal VARCHAR(1);
BEGIN
    SELECT 'x'
    INTO v_temporal
    FROM catalogo
    WHERE cod_catalo = cod
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;

----- CREATE


CREATE OR REPLACE PROCEDURE REGISTRAR_CATALOGO(cod      INTEGER,
                                   fechaIni date,
                                   fechaFin date)
IS
BEGIN
  IF ((VALIDAR_CATALOGO_FECHA(fechaIni)=TRUE ).AND (VALIDAR_CATALOGO(cod)  = FALSE)) THEN
  BEGIN
      INSERT INTO catalogo(cod_catalo,fecha_ini,fecha_fin)
      VALUES (cod,fechaIni,fechaFin);
      DBMS_OUTPUT.PUT_LINE('Insertado Catalogo: '|| cod );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Catalogo: '|| cod || ' ya existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando catalogo '||SQLERRM);
END REGISTRAR_CATALOGO;



----- READ


CREATE OR REPLACE PROCEDURE LEER_CATALOGO(cod      INTEGER)
IS
BEGIN
  IF VALIDAR_CATALOGO(cod)  = TRUE THEN
  BEGIN
      SELECT cod_catalo,fecha_ini,fecha_fin FROM catalogo
      WHERE cod_catalo = cod ;
      DBMS_OUTPUT.PUT_LINE('Lectura Catalogo: '|| cod );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Catalogo: '|| cod || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error leyendo catalogo '||SQLERRM);
END LEER_CATALOGO;

---- UPDATE


CREATE OR REPLACE PROCEDURE ACTUALIZAR_CATALOGO(cod      INTEGER,
                                   fechaIni date,
                                   fechaFin date)
IS
BEGIN
  IF VALIDAR_CATALOGO(cod)= TRUE THEN
  BEGIN
      UPDATE catalogo. SET ( cod_catalo = cod , fecha_ini = fechaini , fecha_fin = fechaFin)
      WHERE cod_catalo = cod;
      DBMS_OUTPUT.PUT_LINE('Actualizado Catalogo: '|| cod );
    END;
  ELSE
    DBMS_OUTPUT.PUT_LINE(' Catalogo: '|| cod || ' no existe en la base de datos');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Se presento un error actualizando catalogo '||SQLERRM);
END ACTUALIZAR_CATALOGO;


