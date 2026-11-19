
  CLASS zcl_main_018 DEFINITION
  public
  final
  create public .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_018 IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
DATA lt_accion TYPE i VALUE 1.

    DATA(lo_employee) = NEW zcl_creadora_018(
      iv_nombre             = 'Natalia'
      iv_apellido           = 'Ruiz'
      iv_telefono           = '666555777'
      iv_experiencia        = 4
      iv_certificaciones    = 2
    ).

    CASE lt_accion.

      WHEN 1.
        DATA(lv_mensaje_alta) = lo_employee->alta_empleado( ).
        out->write( lv_mensaje_alta ).

      WHEN 2.
        DATA(lv_mensaje_mod)    = lo_employee->modificacion(
          iv_nombre             = 'rrra'
          iv_apellido           = 'Ruiz'
          iv_telefono           = '666555777'
          iv_experiencia        = 4
          iv_certificaciones    = 2
          iv_id_empleado        = 10
        ).
        out->write( lv_mensaje_mod ).

      WHEN 3.
        DATA(lt_tabla_res) = lo_employee->traer_lt( iv_id_empleado = 0 ).
        out->write( lt_tabla_res ).

      WHEN 4.
        DATA(lt_tabla_n) = lo_employee->traer_n_filas( iv_n_filas = 2 ).
        out->write( lt_tabla_n ).

    ENDCASE.

  ENDMETHOD.
  ENDCLASS.

