CLASS zcl_aoc_check_cloud_test_94 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
PROTECTED SECTION.
PRIVATE SECTION.
  METHODS selects.
  METHODS patterns
    importing str type string.
  methods potential_false_positives.
ENDCLASS.



CLASS zcl_aoc_check_cloud_test_94 IMPLEMENTATION.

method selects.
  select * from i_country where Country like 'E*' into table @data(countries).
  select * from i_country where Country like 'E%' into table @countries.
  select * from i_country where Country like 'E' into table @countries.
  select * from i_country where Country like 'E*T' into table @countries.
  select * from i_country where Country like 'E%T' into table @countries.
  select * from i_country where Country like 'ET' into table @countries.
endmethod.

method patterns.
  if str cp 'PAT'.
  endif.
  if str cp 'PA*'.
  endif.
  if str cp 'PA%'.
  endif.
  data(bool) = xsdbool( str np 'PAT' ).
  bool = xsdbool( str np 'PA*AP' ).
  bool = xsdbool( str np 'PA%AP' ).
endmethod.

METHOD potential_false_positives.
  data(cp) = ''.
  concatenate cp 'NOT%A%PATTERN' into data(dummy).
  "if str cp 'PAT%'
ENDMETHOD.

ENDCLASS.
