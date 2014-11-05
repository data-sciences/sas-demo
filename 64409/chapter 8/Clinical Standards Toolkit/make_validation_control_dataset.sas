libname master "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\validation\control";
libname control "C:\Documents and Settings\XPMUser\Desktop\CDISC_book\CST_validate_sdtm\metadata\control";

data control.validation_control;
  set master.validation_master;

  where standardversion in ("***","3.1.2") and checksource in ("OpenCDISC","WebSDM");
run;
