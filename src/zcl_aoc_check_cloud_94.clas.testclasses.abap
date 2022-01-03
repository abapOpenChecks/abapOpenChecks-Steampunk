CLASS ltcl_tests DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_tests IMPLEMENTATION.

  METHOD test.
    DATA(test_object) = VALUE if_ci_atc_check=>ty_object(
      type = 'CLAS'
      name = 'ZCL_AOC_CHECK_CLOUD_TEST_94'
    ).

    DATA(select_method_object) = cl_ci_atc_unit_driver=>get_method_object( VALUE #( class = test_object-name method = 'SELECTS' ) ).
    IF select_method_object IS INITIAL.
      cl_abap_unit_assert=>skip( |Test class method { test_object-name }->SELECTS does not exist.| ).
    ENDIF.
    DATA(expected_like_findings) = VALUE if_ci_atc_unit_asserter=>ty_expected_findings(
      code = zcl_aoc_check_cloud_94=>finding_codes-like location-object = select_method_object
      ( location-position = VALUE #( line = 2 column = 45 )
        quickfixes = VALUE #( location-object = select_method_object quickfix_code = zcl_aoc_check_cloud_94=>quickfix_codes-like
          ( location-position = VALUE #( line = 2 column = 4 ) code = VALUE #( ( `select * from i_country where Country like 'E%' into table @data(countries).` ) ) )
      ) )
      ( location-position = VALUE #( line = 5 column = 45 )
        quickfixes = VALUE #( location-object = select_method_object quickfix_code = zcl_aoc_check_cloud_94=>quickfix_codes-like
          ( location-position = VALUE #( line = 5 column = 4 ) code = VALUE #( ( `select * from i_country where Country like 'E%T' into table @countries.` ) ) )
      ) )
    ).

    DATA(pattern_method_object) = cl_ci_atc_unit_driver=>get_method_object( VALUE #( class = test_object-name method = 'PATTERNS' ) ).
    DATA(expected_op_findings) = VALUE if_ci_atc_unit_asserter=>ty_expected_findings(
      code = zcl_aoc_check_cloud_94=>finding_codes-pattern_op location-object = pattern_method_object
      ( location-position = VALUE #( line = 6 column = 12 )
        quickfixes = VALUE #( location-object = pattern_method_object quickfix_code = zcl_aoc_check_cloud_94=>quickfix_codes-pattern_op
          ( location-position = VALUE #( line = 6 column = 4 ) code = VALUE #( ( `if str cp 'PA*'.` ) ) )
      ) )
      ( location-position = VALUE #( line = 10 column = 25 )
        quickfixes = VALUE #( location-object = pattern_method_object quickfix_code = zcl_aoc_check_cloud_94=>quickfix_codes-pattern_op
          ( location-position = VALUE #( line = 10 column = 4 ) code = VALUE #( ( `bool = xsdbool( str np 'PA*AP' ).` ) ) )
      ) )
    ).

    cl_ci_atc_unit_driver=>create_asserter( )->check_and_assert(
      check = NEW zcl_aoc_check_cloud_94( )
      object = test_object
      expected_findings = VALUE #(
        ( LINES OF expected_like_findings )
        ( LINES OF expected_op_findings )
      )
      asserter_config = VALUE #( quickfixes = abap_true )
    ).
  ENDMETHOD.

ENDCLASS.
