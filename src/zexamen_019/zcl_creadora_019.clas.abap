CLASS zcl_creadora_019 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_019 WITH EMPTY KEY.
    METHODS: constructor
      IMPORTING iv_nombre          TYPE zde_nombre_019
                iv_apellido        TYPE zde_nombre_019
                iv_telefono        TYPE zde_tele_019
                iv_experiencia     TYPE i
                iv_certificaciones TYPE i,

      modificacion
        IMPORTING iv_nombre          TYPE zde_nombre_019
                  iv_apellido        TYPE zde_nombre_019
                  iv_telefono        TYPE zde_tele_019
                  iv_experiencia     TYPE i
                  iv_id_empleado     TYPE i
                  iv_certificaciones TYPE i
        RETURNING VALUE(rv_mensaje)  TYPE string,

      alta_empleado
        RETURNING VALUE(rv_mensaje) TYPE string,

      calcular_sueldo,

      ex_id_empleado,

      traer_n_filas
        IMPORTING iv_n_filas      TYPE i
        RETURNING VALUE(rv_tabla) TYPE tty_emp,

      traer_lt
        IMPORTING iv_id_empleado  TYPE i
        RETURNING VALUE(rv_tabla) TYPE tty_emp.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lt_registro     TYPE tty_emp,
          ls_prueba       TYPE ztab_eje_obj_019,
          experiencia     TYPE i,
          id_empleado     TYPE i,
          certificaciones TYPE i,
          iv_nombre       TYPE string.
ENDCLASS.

CLASS zcl_creadora_019 IMPLEMENTATION.

  METHOD constructor.
    " --- CONSTRUCTOR: guarda nombre, apellido, teléfono, experiencia y certificaciones; moneda = 'EUR' ---
    me->ls_prueba-nombre        = iv_nombre.
    me->ls_prueba-apellido      = iv_apellido.
    me->ls_prueba-telefono      = iv_telefono.
    me->experiencia             = iv_experiencia.
    me->certificaciones         = iv_certificaciones.
    me->ls_prueba-currency_code = 'EUR'.
  ENDMETHOD.

  METHOD modificacion.
    " --- MODIFICACION: si el id existe en la tabla, sobrescribe el registro; si no, devuelve error ---
    me->ls_prueba-nombre        = iv_nombre.
    me->ls_prueba-apellido      = iv_apellido.
    me->ls_prueba-telefono      = iv_telefono.
    me->experiencia             = iv_experiencia.
    me->certificaciones         = iv_certificaciones.
    me->id_empleado             = iv_id_empleado.
*    me->ls_prueba-id_empleado   = iv_id_empleado.
    me->ls_prueba-currency_code = 'EUR'.


    SELECT SINGLE @abap_true
      FROM ztab_eje_obj_019
      WHERE id_empleado = @me->id_empleado
      INTO @DATA(lv_existe).

    IF sy-subrc = 0.
      rv_mensaje = me->alta_empleado( ).
    ELSE.
      rv_mensaje = `El ID no existe en la base de datos, no se ha podido hacer la modificación `.
    ENDIF.
  ENDMETHOD.

  METHOD alta_empleado.
    " --- ALTA_EMPLEADO: calcula sueldo, asigna id (recibido o autogenerado) y guarda con MODIFY + COMMIT ---
    me->calcular_sueldo( ).

    IF me->id_empleado IS NOT INITIAL.
      me->ls_prueba-id_empleado = me->id_empleado.
    ELSE.
      me->ex_id_empleado( ).
    ENDIF.

    MODIFY ztab_eje_obj_019 FROM @me->ls_prueba.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = `Subida correcta`.
    ELSE.
      rv_mensaje = `Error en la Subida `.
    ENDIF.
  ENDMETHOD.

  METHOD calcular_sueldo.
    " --- CALCULAR_SUELDO: sueldo = (certificaciones * 50 + experiencia * 100) + 1000 ---
    me->ls_prueba-sueldo =
  ( me->certificaciones * 50 +
    me->experiencia * 100 ) + 1000.
  ENDMETHOD.

  METHOD ex_id_empleado.
    SELECT MAX( id_empleado )
       FROM ztab_eje_obj_019
       INTO @DATA(lv_max).

    IF sy-subrc = 0.
      me->ls_prueba-id_empleado = lv_max + 1.
    ELSE.
      me->ls_prueba-id_empleado = 1.
    ENDIF.
  ENDMETHOD.

  METHOD traer_n_filas.
    " --- TRAER_N_FILAS: devuelve como máximo iv_n_filas registros ordenados por id_empleado ---
    SELECT * FROM ztab_eje_obj_019
      ORDER BY id_empleado
      INTO TABLE @me->lt_registro
      UP TO @iv_n_filas ROWS.

    rv_tabla = me->lt_registro.
  ENDMETHOD.

  METHOD traer_lt.
    " --- TRAER_LT: id = 0 devuelve todos los registros; si no, solo el que coincide con el id ---
    me->id_empleado = iv_id_empleado.

    IF me->id_empleado = 0.
      SELECT * FROM ztab_eje_obj_019
        ORDER BY id_empleado
        INTO TABLE @me->lt_registro.
    ELSE.
      SELECT * FROM ztab_eje_obj_019
        WHERE id_empleado = @me->id_empleado
        ORDER BY id_empleado
        INTO TABLE @me->lt_registro.
    ENDIF.

    rv_tabla = me->lt_registro.

  ENDMETHOD.

ENDCLASS.
