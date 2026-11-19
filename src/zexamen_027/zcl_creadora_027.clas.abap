CLASS zcl_creadora_027 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_027 WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        iv_Nombre          TYPE zde_nombre_027
        iv_Apellido        TYPE zde_nombre_027
        iv_telefono        TYPE zde_tele_027
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

    METHODS modificacion
      IMPORTING
        iv_Nombre          TYPE zde_nombre_027
        iv_Apellido        TYPE zde_nombre_027
        iv_telefono        TYPE zde_tele_027
        iv_experiencia     TYPE i
        iv_id_empleado     TYPE i
        iv_certificaciones TYPE i
      RETURNING
        VALUE(rv_mensaje)  TYPE string.

    METHODS alta_empleado
      RETURNING
        VALUE(rv_mensaje) TYPE string.

    METHODS clacular_sueldo.
    METHODS ex_id_empleado.
    METHODS traer_n_filas
      IMPORTING
        iv_n_filas      TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.
    METHODS traer_lt
      IMPORTING
        iv_id_empleado  TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA lt_registro     TYPE tty_emp.
    DATA ls_prueba       TYPE ztab_eje_obj_027.
    DATA experiencia     TYPE i.
    DATA id_empleado     TYPE i.
    DATA certificaciones TYPE i.
    DATA iv_nombre       TYPE string.

ENDCLASS.



CLASS ZCL_CREADORA_027 IMPLEMENTATION.


  METHOD constructor.
    me->ls_prueba-nombre   = iv_nombre.
    me->ls_prueba-apellido = iv_apellido.
    me->ls_prueba-telefono = iv_telefono.
    me->experiencia     = iv_experiencia.
    me->certificaciones = iv_certificaciones.
    me->ls_prueba-currency_code = 'EUR'.
  ENDMETHOD.


  METHOD modificacion.
    me->ls_prueba-nombre = iv_Nombre.
    me->ls_prueba-apellido = iv_Apellido.
    me->ls_prueba-telefono = iv_telefono.
    me->experiencia = iv_experiencia.
    me->certificaciones = iv_certificaciones.
    me->ls_prueba-currency_code = 'EUR'.
    me->id_empleado = iv_id_empleado.

    SELECT SINGLE @abap_true FROM ztab_eje_obj_027 WHERE id_empleado = @me->id_empleado INTO @DATA(lv_exists).

    IF sy-subrc = 0.
      rv_mensaje = me->alta_empleado( ).
    ELSE.
      rv_mensaje = `El ID no existe en la base de datos, no se ha podido hacer la modificación `.
    ENDIF.
  ENDMETHOD.


  METHOD alta_empleado.
    clacular_sueldo( ).

    IF me->id_empleado IS NOT INITIAL.
      me->ls_prueba-id_empleado = me->id_empleado.
    ELSE.
      ex_id_empleado( ).
    ENDIF.

    MODIFY ztab_eje_obj_027 FROM @me->ls_prueba.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = `Subida correcta`.
    ELSE.
      rv_mensaje = `Error en la Subida `.
    ENDIF.
  ENDMETHOD.


  METHOD clacular_sueldo.
    me->ls_prueba-sueldo = ( me->certificaciones * 50 + me->experiencia * 100 ) + 1000.
  ENDMETHOD.


  METHOD ex_id_empleado.

    SELECT FROM ztab_eje_obj_027
        FIELDS MAX( id_empleado )
        INTO @DATA(max_id_empleado).

    IF sy-subrc = 0.
      me->ls_prueba-id_empleado = max_id_empleado + 1.
    ELSE.
      me->ls_prueba-id_empleado = '0001'.
    ENDIF.

  ENDMETHOD.


  METHOD traer_n_filas.
    SELECT FROM ztab_eje_obj_027
    FIELDS *
    ORDER BY id_empleado
    INTO TABLE @me->lt_registro
    UP TO @iv_n_filas ROWS.

    rv_tabla = me->lt_registro.
  ENDMETHOD.


  METHOD traer_lt.
    me->id_empleado = iv_id_empleado.

    IF me->id_empleado = 0.
      SELECT FROM ztab_eje_obj_027
        FIELDS * ORDER BY id_empleado
        INTO TABLE @me->lt_registro .
    ELSE.
      SELECT FROM ztab_eje_obj_027
        FIELDS *
        WHERE id_empleado = @me->id_empleado
        INTO TABLE @me->lt_registro.
    ENDIF.

    rv_tabla = me->lt_registro.
  ENDMETHOD.
ENDCLASS.
