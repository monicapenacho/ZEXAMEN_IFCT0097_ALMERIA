CLASS zcl_0018_nextflights DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES TT_FLIGHTS TYPE STANDARD TABLE OF ZCERT_FLIGHT
                   WITH NON-UNIQUE KEY carrier_id connection_id.

    METHODS GET_NEXT_FLIGHTS
      RETURNING VALUE(r_flights) TYPE tt_flights.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_0018_nextflights IMPLEMENTATION.

  METHOD GET_NEXT_FLIGHTS.

    DATA lv_today TYPE d.
    lv_today = cl_abap_context_info=>get_system_date( ).

    SELECT FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             MIN( flight_date ) AS flight_date
      WHERE  flight_date > @lv_today
      GROUP BY carrier_id,
               connection_id
      ORDER BY flight_date ASCENDING
      INTO CORRESPONDING FIELDS OF TABLE @r_flights.

  ENDMETHOD.


ENDCLASS.
