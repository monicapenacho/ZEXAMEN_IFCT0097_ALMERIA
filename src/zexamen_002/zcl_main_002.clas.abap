CLASS zcl_main_002 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_002 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_accion TYPE i VALUE 4.
    DATA(lo_employee) = NEW zcl_creadora_002( iv_nombre          = 'Natalia'
                                          iv_apellido        = 'Ruiz'
                                          iv_telefono        = '666555777'
                                          iv_experiencia     = 4
                                          iv_certificaciones = 2 ).

    CASE lt_accion.
      WHEN 1.
        out->write( `Caso 1` ).
        DATA(alta) = lo_employee->alta_empleado( ).
        out->write( alta ).

      WHEN 2.
        out->write( `Caso 2` ).
        DATA(modificacion) = lo_employee->modificacion(
                               iv_nombre          = 'rrra'
                               iv_apellido        = 'Ruiz'
                               iv_telefono        = '666555777'
                               iv_experiencia     = 4
                               iv_id_empleado     = 10
                               iv_certificaciones = 2 ).
        out->write( modificacion ).

      WHEN 3.
        out->write( `Caso 3` ).
        DATA(registros) = lo_employee->traer_lt( iv_id_empleado = 0 ).
        out->write( registros ).

      WHEN 4.
        out->write( `Caso 4` ).
        DATA(filas) = lo_employee->traer_n_filas( iv_n_filas = 2 ).
        out->write( filas ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
