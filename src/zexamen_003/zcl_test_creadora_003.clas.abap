CLASS zcl_test_creadora_003 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_creadora_003 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_empleado) = NEW zcl_creadora_003(
      iv_nombre          = 'ANA'
      iv_apellido        = 'GARCIA'
      iv_telefono        = '600123456'
      iv_experiencia     = 5
      iv_certificaciones = 2
    ).

    out->write( 'M1 - CONSTRUCTOR: OK' ).

    DATA(lv_mensaje) = lo_empleado->alta_empleado( ).

    out->write( 'M3 - ALTA EMPLEADO:' ).
    out->write( lv_mensaje ).

    DATA lv_id_empleado TYPE zde_id_003.

    SELECT MAX( id_empleado )
      FROM ztab_eje_obj_003
      INTO @lv_id_empleado.

    out->write( 'M5 - GENERACION DE ID:' ).
    out->write( lv_id_empleado ).

    DATA(lt_empleados) = lo_empleado->traer_n_filas(
      iv_n_filas = 5
    ).

    out->write( 'M6 - TRAER N FILAS:' ).
    out->write( lt_empleados ).

    DATA(lt_por_id) = lo_empleado->traer_lt(
  iv_id_empleado = CONV i( lv_id_empleado )
).

    out->write( 'M7 - TRAER POR ID:' ).
    out->write( lt_por_id ).

    DATA(lv_modificacion) = lo_empleado->modificacion(
      iv_nombre          = 'ANA MARIA'
      iv_apellido        = 'GARCIA'
      iv_telefono        = '611222333'
      iv_experiencia     = 6
      iv_id_empleado     = CONV i( lv_id_empleado )
      iv_certificaciones = 3
    ).

    out->write( 'M2 - MODIFICACION:' ).
    out->write( lv_modificacion ).

    out->write( 'M4 - CALCULAR SUELDO: INCLUIDO EN EL ALTA Y MODIFICACION' ).

  ENDMETHOD.

ENDCLASS.



