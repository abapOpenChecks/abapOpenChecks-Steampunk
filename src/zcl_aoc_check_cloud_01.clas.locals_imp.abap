CLASS meta_data DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES if_ci_atc_check_meta_data.
ENDCLASS.

CLASS meta_data IMPLEMENTATION.

  METHOD if_ci_atc_check_meta_data~get_checked_object_types.
    types = VALUE #( ( 'CLAS' ) ( 'PROG' ) ( 'FUGR' ) ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_description.
    description = '001 - IF in IF'(des).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_finding_code_infos.
    finding_code_infos = VALUE #( severity = if_ci_atc_check=>finding_severities-error
      ( code = zcl_aoc_check_cloud_01=>finding_codes-if_in_if text = 'IF in IF, can easily be reduced.'(m01) )
    ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~is_remote_enabled.
    is_remote_enabled = abap_true.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~uses_checksums.
    uses_checksums = abap_true.
  ENDMETHOD.
  method if_ci_atc_check_meta_data~get_quickfix_code_infos.
  endmethod.
ENDCLASS.
