CLASS zcl_aoc_check_cloud_test_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS test001_01.
    METHODS test001_02.
    METHODS test001_03.
    METHODS test001_04.
    METHODS test001_05.
    METHODS test001_06.
    METHODS test001_07.
    METHODS test001_08.
    METHODS test001_09.
    METHODS test001_10.
    METHODS test001_11.
    METHODS test001_12.
    METHODS test001_13.
    METHODS test001_14.
    METHODS test001_15.
    METHODS test001_16.
    METHODS test001_17.
    METHODS test001_18.
    METHODS test001_19.
    METHODS test001_20.
    METHODS test001_21.
    METHODS test001_22.
    METHODS test001_23.
    METHODS test001_24.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aoc_check_cloud_test_01 IMPLEMENTATION.
  METHOD test001_01.
* ===========

    IF 1 = 2.       "finding
      IF 3 = 4.
        WRITE: 'foo'.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "test1

  METHOD test001_02.
* ===========

    IF 1 = 2 AND 3 = 4.
      WRITE: 'foo'.
    ENDIF.

  ENDMETHOD.                    "test2

  METHOD test001_03.
* ===========

    IF 1 = 2.
      WRITE: 'bar'.
      IF 3 = 4.
        WRITE: 'foo'.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "test001_03

  METHOD test001_04.
* ===========

    IF 1 = 2.
      WRITE: 'foo'.
    ENDIF.
    IF 3 = 4.
      WRITE: 'bar'.
    ENDIF.

  ENDMETHOD.                    "test001_04

  METHOD test001_05.

    IF 1 = 2.
      IF 3 = 4.
        WRITE: 'foo'.
      ELSE.
        WRITE: 'bar'.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "test001_05

  METHOD test001_06.

    IF 1 = 2.
      IF 3 = 4.
        WRITE: 'foo'.
      ENDIF.
      IF 5 = 7.
        WRITE: 'bar'.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "test001_06

  METHOD test001_07.

    IF 1 = 2.
      WRITE: 'foo'.
      IF 1 = 2.        "finding
        IF 3 = 4.
          WRITE: 'foo'.
        ENDIF.
      ENDIF.
      WRITE: 'foo'.
    ENDIF.

  ENDMETHOD.                    "test001_07

  METHOD test001_08.

    IF 1 = 2.
      WRITE: 'foo'.
    ELSE.                    "finding aber warum???
      IF 3 = 4.
        WRITE: 'foo'.
      ELSE.
        WRITE: 'foo'.
      ENDIF.
    ENDIF.


  ENDMETHOD.

  METHOD test001_09.

    IF 1 = 2.
      WRITE: 'foo'.
    ELSEIF 3 = 4.
      WRITE: 'foo'.
    ELSE.
      WRITE: 'foo'.
    ENDIF.

  ENDMETHOD.

  METHOD test001_10.

    IF 1 = 2.
      WRITE: 'foo'.
    ELSE.
      IF 3 = 4.
        WRITE: 'foo'.
      ELSE.
        WRITE: 'foo'.
      ENDIF.
      WRITE: 'foo'.
    ENDIF.

  ENDMETHOD.

  METHOD test001_11.
    DATA lt_foo TYPE TABLE OF i.
    LOOP AT lt_foo ASSIGNING FIELD-SYMBOL(<ls_foo>).
      IF 1 = 2.
        CONTINUE.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD test001_12.

    IF 1 = 2.
      IF 3 = 4.
        WRITE: 'foo'.
      ENDIF.
    ELSEIF 5 = 6.
      IF 7 = 8.
        WRITE: 'foo'.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD test001_13.

    IF 1 = 'a'. "finding
      " comment
      IF 1 = 2.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD test001_14.

    IF 1 = 'a'.  "finding
*     comment
      IF 1 = 2.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD test001_15.

    IF 1 = 'a'. "finding
*     comment1
*     comment2
      IF 1 = 2.
      ENDIF.
    ENDIF.


  ENDMETHOD.

  METHOD test001_16.

    IF 1 = " comment   "finding
      'a'.
      IF 1 = 2.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD test001_17.

    IF sy-subrc <> 0.
      MESSAGE 'foobar' TYPE 'E'.
    ENDIF.
    IF 1 = 2.
      " blah
    ENDIF.

  ENDMETHOD.

  METHOD test001_18.
    DATA: foo TYPE string,
          bar TYPE string.
    IF 1 = 'a'.  "finding
      IF 1 = 2.
        WRITE foo.
        WRITE bar.
      ENDIF.
*     comment1
    ENDIF.

  ENDMETHOD.

  METHOD test001_19.
    DATA foo TYPE string.

    IF 1 = 2.
      WRITE foo.
    ELSE.           "finding aber warum???
      IF 1 = 2.
        WRITE foo.
      ELSEIF 1 = 2.
        WRITE foo.
      ENDIF.
*  comment
    ENDIF.

  ENDMETHOD.

  METHOD test001_20.
    DATA lv_string TYPE string.
    IF 1 = 2.
    ELSEIF lv_string IS INITIAL.
    ENDIF.

  ENDMETHOD.

  METHOD test001_21.
    DATA: ws_layo         TYPE string,
          ls_fcat         TYPE string,
          ls_fieldcatalog TYPE abap_bool.
    IF ws_layo IS INITIAL.
      IF ls_fcat IS NOT INITIAL.
        ls_fieldcatalog = abap_true.
      ENDIF.
    ELSE.
      ls_fieldcatalog = abap_true.
    ENDIF.


  ENDMETHOD.

  METHOD test001_22.
    DATA: iv_mode  TYPE string,
          blah     TYPE string,
          lt_dates TYPE TABLE OF string,
          lv_count TYPE i,
          foo      TYPE string.
    IF iv_mode = blah.
      lv_count = lines( lt_dates ). " sdf
      IF lv_count = 1. " dsf
        EXIT.
      ELSEIF lv_count > 1. " sdf
        WRITE foo.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD test001_23.
    DATA: iv_mode  TYPE string,
          blah     TYPE string,
          lt_dates TYPE TABLE OF string,
          lv_count TYPE i,
          foo      TYPE string.
    IF iv_mode = blah.
      IF lv_count = 1. " dsf
        EXIT.
      ELSEIF lv_count > 1. " sdf
        WRITE foo.
      ENDIF.
    ELSE.
      lv_count = lines( lt_dates ). " sdf
    ENDIF.

  ENDMETHOD.

  METHOD test001_24.

    DATA: iv_commit        TYPE string,
          lv_message       TYPE string,
          lv_dummy_message TYPE string ##NEEDED.

    IF iv_commit IS INITIAL.
      lv_message = 'foobar' ##NO_TEXT.
    ENDIF.

    IF 2 = 2.
      WRITE iv_commit.
      IF sy-subrc EQ 0.
        WRITE iv_commit.
      ELSE.
        WRITE iv_commit.
        IF sy-subrc NE 0.
          " blah blah
          WRITE iv_commit.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
