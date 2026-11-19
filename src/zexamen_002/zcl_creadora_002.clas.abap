CLASS zcl_creadora_002 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_002 WITH EMPTY KEY.

    METHODS constructor
      IMPORTING iv_nombre          TYPE zde_nombre_002
                iv_apellido        TYPE zde_nombre_002
                iv_telefono        TYPE zde_tele_002
                iv_experiencia     TYPE i
                iv_certificaciones TYPE i.

    METHODS modificacion
      IMPORTING iv_nombre          TYPE zde_nombre_002
                iv_apellido        TYPE zde_nombre_002
                iv_telefono        TYPE zde_tele_002
                iv_experiencia     TYPE i
                iv_id_empleado     TYPE i
                iv_certificaciones TYPE i
      RETURNING VALUE(rv_mensaje)  TYPE string.

    METHODS alta_empleado
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS calcular_sueldo.

    METHODS ex_id_empleado.

    METHODS traer_n_filas
      IMPORTING iv_n_filas      TYPE i
      RETURNING VALUE(rv_tabla) TYPE tty_emp.

    METHODS traer_lt
      IMPORTING iv_id_empleado  TYPE i
      RETURNING VALUE(rv_tabla) TYPE tty_emp.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA lt_registro TYPE tty_emp.
    DATA ls_prueba       TYPE ztab_eje_obj_002.
    DATA experiencia     TYPE i.
    DATA id_empleado TYPE i.
    DATA certificaciones TYPE i.
    DATA iv_nombre TYPE string.

ENDCLASS.



CLASS zcl_creadora_002 IMPLEMENTATION.

  METHOD constructor.
    ls_prueba-nombre = iv_nombre.
    ls_prueba-apellido = iv_apellido.
    ls_prueba-telefono = iv_telefono.
    experiencia = iv_experiencia.
    certificaciones = iv_certificaciones.
    ls_prueba-currency_code = 'EUR'.

  ENDMETHOD.

  METHOD modificacion.
    ls_prueba-nombre = iv_nombre.
    ls_prueba-apellido = iv_apellido.
    ls_prueba-telefono = iv_telefono.

    experiencia = iv_experiencia.
    certificaciones = iv_certificaciones.
    ls_prueba-currency_code = 'EUR'.
    id_empleado = iv_id_empleado.

    SELECT SINGLE @abap_true FROM ztab_eje_obj_002 WHERE id_empleado = @me->id_empleado INTO @DATA(lv_existe).

    IF sy-subrc = 0.
      rv_mensaje = alta_empleado( ).
    ELSE.
      rv_mensaje = `El ID no existe en la base de datos, no se ha podido hacer la modificación `.
    ENDIF.


  ENDMETHOD.

  METHOD alta_empleado.

    calcular_sueldo( ).

    IF id_empleado IS NOT INITIAL.
      ls_prueba-id_empleado = id_empleado.
    ELSE.
      ex_id_empleado( ).
    ENDIF.


    MODIFY ztab_eje_obj_002 FROM @ls_prueba.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = `Subida correcta`.
    ELSE.
      rv_mensaje = `Error en la Subida `.
    ENDIF.


  ENDMETHOD.

  METHOD calcular_sueldo.
    DATA(sueldo) = ( certificaciones * 50 + experiencia * 100 ) + 1000.
    ls_prueba-sueldo = sueldo.

  ENDMETHOD.

  METHOD ex_id_empleado.
    SELECT MAX( id_empleado )
    FROM ztab_eje_obj_002
    INTO @DATA(lv_max).


    IF sy-subrc = 0.
      ls_prueba-id_empleado = lv_max + 1.
    ELSE.
      ls_prueba-id_empleado = 1.
    ENDIF.

  ENDMETHOD.

  METHOD traer_lt.
    id_empleado = iv_id_empleado.

    IF id_empleado = 0.
      SELECT *
      FROM ztab_eje_obj_002
      ORDER BY id_empleado
      INTO TABLE @lt_registro.
    ELSE.
      SELECT *
      FROM ztab_eje_obj_002
      WHERE id_empleado = @id_empleado
      INTO TABLE @lt_registro.
    ENDIF.

    rv_tabla = lt_registro.
  ENDMETHOD.

  METHOD traer_n_filas.
    SELECT *
    FROM ztab_eje_obj_002
    ORDER BY id_empleado
    INTO TABLE @lt_registro
    UP TO @iv_n_filas ROWS.

     rv_tabla = lt_registro.

  ENDMETHOD.

ENDCLASS.
