
* initialize the toolkit framework;
%cst_setStandardProperties(
  _cstStandard=CST-FRAMEWORK,
  _cstSubType=initialize);

* define _ctsGroot macro variable;
%cstutil_setcstgroot;

%cst_createTablesForDataStandard(
   _cstStandard=XYZ std CDISC-SDTM,
   _cstStandardVersion=3.1.2,
   _cstOutputLibrary=work
   );
