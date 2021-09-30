CLASS ltcl_tests DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_tests IMPLEMENTATION.

  METHOD test.
    DATA l_expected_findings TYPE if_ci_atc_unit_asserter=>ty_expected_findings.
    DATA(l_test_object) = VALUE if_ci_atc_check=>ty_object(
      type = 'CLAS'
      name = 'ZCL_AOC_CHECK_CLOUD_TEST_01' ).
    DO 24 TIMES.
      DATA(l_idx) = sy-index.
      IF l_idx < 10.
        DATA(l_method) = |TEST001_0{ l_idx }|.
      ELSE.
        l_method = |TEST001_{ l_idx }|.
      ENDIF.
      DATA(l_method_object) = cl_ci_atc_unit_driver=>get_method_object( VALUE #(
        class = l_test_object-name
        method = l_method ) ).
      CASE l_idx.
        WHEN 1.
          DATA(l_expected_finding) = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 4 column = 4 ) ).
        WHEN 7.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 5 column = 6 ) ).
        WHEN 13.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 14.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 15.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 16.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 18.
          l_expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = l_method_object
            location-position = VALUE #( line = 4 column = 4 ) ).
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      APPEND l_expected_finding TO l_expected_findings.
    ENDDO.
    cl_ci_atc_unit_driver=>create_asserter( )->check_and_assert(
      check = NEW zcl_aoc_check_cloud_01( )
      object = l_test_object
      expected_findings = VALUE #(
        ( LINES OF l_expected_findings ) )
      asserter_config = VALUE #( quickfixes = abap_false ) ).
  ENDMETHOD.

ENDCLASS.
