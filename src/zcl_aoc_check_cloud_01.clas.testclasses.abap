CLASS tests DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS tests IMPLEMENTATION.

  METHOD test.
    DATA expected_findings TYPE if_ci_atc_unit_asserter=>ty_expected_findings.
    DATA(test_object) = VALUE if_ci_atc_check=>ty_object(
      type = 'CLAS'
      name = 'ZCL_AOC_CHECK_CLOUD_TEST_01'
    ).
    DO 24 TIMES.
      DATA(l_idx) = sy-index.
      IF l_idx < 10.
        DATA(l_method) = |TEST001_0{ l_idx }|.
      ELSE.
        l_method = |TEST001_{ l_idx }|.
      ENDIF.
      DATA(method_object) = cl_ci_atc_unit_driver=>get_method_object( VALUE #( class = test_object-name method = l_method ) ).
      CASE l_idx.
        WHEN 1.
          DATA(expected_finding) = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 4 column = 4 ) ).
        WHEN 7.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 5 column = 6 ) ).
        WHEN 13.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 14.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 15.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 16.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 3 column = 4 ) ).
        WHEN 18.
          expected_finding = VALUE if_ci_atc_unit_asserter=>ty_expected_finding(
            code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if location-object = method_object
            location-position = VALUE #( line = 4 column = 4 ) ).
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      APPEND expected_finding TO expected_findings.
    ENDDO.
    cl_ci_atc_unit_driver=>create_asserter( )->check_and_assert(
      check = NEW zcl_aoc_check_cloud_01( )
      object = test_object
      expected_findings = VALUE #(
        ( LINES OF expected_findings )
      )
      asserter_config = VALUE #( quickfixes = abap_false )
    ).
  ENDMETHOD.

ENDCLASS.
