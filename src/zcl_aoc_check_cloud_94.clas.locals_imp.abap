CLASS lcl_meta_data DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES if_ci_atc_check_meta_data.
ENDCLASS.

CLASS lcl_meta_data IMPLEMENTATION.

  METHOD if_ci_atc_check_meta_data~get_checked_object_types.
    types = VALUE #( ( 'CLAS' ) ( 'PROG' ) ( 'FUGR' ) ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_description.
    description = 'Wildcards in literals used for LIKE, CP, NP'(des).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_finding_code_infos.
    finding_code_infos = VALUE #( severity = if_ci_atc_check=>finding_severities-error
      ( code = zcl_aoc_check_cloud_94=>finding_codes-like text = 'SQL LIKE operator: * used instead of % as wildcard.'(lik) )
      ( code = zcl_aoc_check_cloud_94=>finding_codes-pattern_op text = 'ABAP CP or NP operator: % used instead of * as wildcard.'(pat) )
    ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_quickfix_code_infos.
    quickfix_code_infos = VALUE #(
      ( code = zcl_aoc_check_cloud_94=>quickfix_codes-like short_text = 'Replace invalid SQL wildcard * by %'(rli) )
      ( code = zcl_aoc_check_cloud_94=>quickfix_codes-pattern_op short_text = 'Raplace invalid ABAP wildcard % by *'(rpa) )
    ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~is_remote_enabled.
    is_remote_enabled = abap_true.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~uses_checksums.
    uses_checksums = abap_true.
  ENDMETHOD.

ENDCLASS.
