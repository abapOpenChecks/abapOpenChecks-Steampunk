CLASS zcl_aoc_check_cloud_01 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS:
      BEGIN OF finding_codes,
        if_in_if TYPE if_ci_atc_check=>ty_finding_code VALUE 'IF_IN_IF',
      END OF finding_codes.
    INTERFACES if_ci_atc_check .

ENDCLASS.

CLASS zcl_aoc_check_cloud_01 IMPLEMENTATION.
  METHOD if_ci_atc_check~get_meta_data.
    meta_data = NEW lcl_meta_data( ).
  ENDMETHOD.

  METHOD if_ci_atc_check~run.
    DATA(code_provider) = data_provider->get_code_provider( ).
    DATA(procedures) = code_provider->get_procedures( code_provider->object_to_comp_unit( object ) ).
    LOOP AT procedures->* ASSIGNING FIELD-SYMBOL(<procedure>).
      LOOP AT <procedure>-statements ASSIGNING FIELD-SYMBOL(<statement>)
          WHERE keyword = 'IF' OR keyword = 'ELSE'.
        DATA(l_tabix) = sy-tabix.
        DATA(l_is_finding) = abap_true.
        IF <procedure>-statements[ l_tabix + 1 ]-keyword = 'IF'.
*         check if an else-follows
          DATA(l_open_ifs) = 1.
          LOOP AT <procedure>-statements FROM l_tabix + 2 ASSIGNING FIELD-SYMBOL(<l_next>).
            DATA(l_idx) = sy-tabix.
            CASE <l_next>-keyword.
              WHEN 'IF'.
                l_open_ifs += 1.
              WHEN 'ELSE' OR 'ELSEIF'.
                IF l_open_ifs <> 2.
*                 no finding
                  l_is_finding = abap_false.
                  EXIT.
                ENDIF.
              WHEN 'ENDIF'.
                l_open_ifs -= 1.
                IF l_open_ifs = 0.
                  IF lines( <procedure>-statements ) > l_idx AND <procedure>-statements[ l_idx + 1 ]-keyword <> 'ENDIF'.
                    l_is_finding = abap_false.
                  ENDIF.
                  EXIT.
                ENDIF.
              WHEN OTHERS.
                IF l_open_ifs = 0.
                  l_is_finding = abap_false.
                  EXIT.
                ENDIF.
            ENDCASE.
          ENDLOOP.
          IF l_is_finding = abap_true.
            INSERT VALUE #(
                code = finding_codes-if_in_if
                location = code_provider->get_statement_location( <statement> )
                checksum = code_provider->get_statement_checksum( <statement> )
                 ) INTO TABLE findings.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

  METHOD if_ci_atc_check~set_assistant_factory.

  ENDMETHOD.

  METHOD if_ci_atc_check~verify_prerequisites.

  ENDMETHOD.

ENDCLASS.
