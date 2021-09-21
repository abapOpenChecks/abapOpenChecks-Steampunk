CLASS zcl_aoc_check_cloud_94 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES if_ci_atc_check.

  CONSTANTS:
    BEGIN OF finding_codes,
      like TYPE if_ci_atc_check=>ty_finding_code VALUE 'LIKE',
      pattern_op TYPE if_ci_atc_check=>ty_finding_code VALUE 'PATTERN_OP',
    END OF finding_codes.
  CONSTANTS:
    BEGIN OF quickfix_codes,
      like TYPE cl_ci_atc_quickfixes=>ty_quickfix_code VALUE 'LIKE',
      pattern_op TYPE cl_ci_atc_quickfixes=>ty_quickfix_code VALUE 'PATTERN_OP',
    END OF quickfix_codes.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA assistant_factory TYPE REF TO cl_ci_atc_assistant_factory.
  METHODS analyze_pattern
    IMPORTING
      finding_code TYPE if_ci_atc_check=>ty_finding_code
      code_provider TYPE REF TO if_ci_atc_source_code_provider
      procedure TYPE if_ci_atc_source_code_provider=>ty_procedure
      statement TYPE if_ci_atc_source_code_provider=>ty_statement
      token_idx TYPE syst-tabix
      statement_idx TYPE syst-tabix
    RETURNING
      VALUE(findings) TYPE if_ci_atc_check=>ty_findings.
ENDCLASS.



CLASS zcl_aoc_check_cloud_94 IMPLEMENTATION.

  METHOD if_ci_atc_check~get_meta_data.
    meta_data = NEW meta_data( ).
  ENDMETHOD.

  METHOD if_ci_atc_check~run.
    DATA(code_provider) = data_provider->get_code_provider( ).
    DATA(procedures) = code_provider->get_procedures( code_provider->object_to_comp_unit( object ) ).
    LOOP AT procedures->* ASSIGNING FIELD-SYMBOL(<procedure>).
      LOOP AT <procedure>-statements ASSIGNING FIELD-SYMBOL(<statement>).
        DATA(statement_idx) = sy-tabix.
        LOOP AT <statement>-tokens ASSIGNING FIELD-SYMBOL(<token>)
            WHERE references IS INITIAL.
          DATA(token_idx) = sy-tabix.
          CASE <token>-lexeme.
            WHEN 'LIKE'.
              INSERT LINES OF analyze_pattern(
                finding_code = finding_codes-like
                code_provider = code_provider
                procedure = <procedure>
                statement_idx = statement_idx
                statement = <statement>
                token_idx = token_idx
              ) INTO TABLE findings.

            WHEN 'NP' OR 'CP'.
              INSERT LINES OF analyze_pattern(
                finding_code = finding_codes-pattern_op
                code_provider = code_provider
                procedure = <procedure>
                statement_idx = statement_idx
                statement = <statement>
                token_idx = token_idx
              ) INTO TABLE findings.

          ENDCASE.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD analyze_pattern.
    DATA(wrong_wildcard) = COND #( WHEN finding_code = finding_codes-like THEN '*' ELSE '%' ).
    DATA(correct_wildcard) = COND #( WHEN finding_code = finding_codes-like THEN '%' ELSE '*' ).
    ASSIGN statement-tokens[ token_idx + 1 ] TO FIELD-SYMBOL(<next_token>).
    IF <next_token>-lexeme CA wrong_wildcard AND <next_token>-lexeme NA correct_wildcard.
      DATA(quickfixes) = assistant_factory->create_quickfixes( ).
      quickfixes->create_quickfix( COND #(
        WHEN finding_code = finding_codes-like THEN quickfix_codes-like ELSE quickfix_codes-pattern_op
      ) )->replace(
        context = assistant_factory->create_quickfix_context( VALUE #(
          procedure_id = procedure-id
          statements = VALUE #( from = statement_idx to = statement_idx )
          tokens = VALUE #( from = token_idx + 1 to = token_idx + 1 )
        ) )
        code = VALUE #( ( replace( val = <next_token>-lexeme sub = wrong_wildcard with = correct_wildcard ) ) )
      ).
      DATA(finding_location) = code_provider->get_statement_location( statement ).
      finding_location-position = <next_token>-position.
      INSERT VALUE #(
        code = finding_code
        location = finding_location
        checksum = code_provider->get_statement_checksum( statement )
        details = assistant_factory->create_finding_details( )->attach_quickfixes(
          quickfixes
        )
      ) INTO TABLE findings.
    ENDIF.
  ENDMETHOD.

  METHOD if_ci_atc_check~set_assistant_factory.
    assistant_factory = factory.
  ENDMETHOD.

  METHOD if_ci_atc_check~verify_prerequisites ##NEEDED.

  ENDMETHOD.

ENDCLASS.
