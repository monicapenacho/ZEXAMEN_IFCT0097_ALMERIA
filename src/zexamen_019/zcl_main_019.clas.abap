CLASS zcl_main_019 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_main_019 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " Variable que decide qué acción se ejecuta (1 alta, 2 modificación, 3 traer registros, 4 traer N filas)
    DATA lt_accion TYPE i VALUE 2.

    " Instancia de la clase creadora con los datos del enunciado
    DATA(lo_employee) = NEW zcl_creadora_019(
      iv_nombre          = 'Natalia'
      iv_apellido        = 'Ruiz'
      iv_telefono        = '666555777'
      iv_experiencia     = 4
      iv_certificaciones = 2 ).

    CASE lt_accion.

      WHEN 1.  " 1 - Alta de empleado
        out->write( lo_employee->alta_empleado( ) ).

      WHEN 2.   " 2 - Modificación del empleado con id 10
        out->write( lo_employee->modificacion(
                      iv_nombre          = 'Natalia2'
                      iv_apellido        = 'Ruiz'
                      iv_telefono        = '666555777'
                      iv_experiencia     = 4
                      iv_certificaciones = 2
                      iv_id_empleado     = 00000001 ) ).
      WHEN 3." 3 - Traer todos los registros (id 0)
        out->write( lo_employee->traer_lt( iv_id_empleado = 0 ) ).

      WHEN 4." 4 - Traer como máximo 2 filas
        out->write( lo_employee->traer_n_filas( iv_n_filas = 2 ) ).

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
