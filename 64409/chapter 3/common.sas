**** %common defines common librefs and SAS options.;
%macro common;
	libname source "C:\path\source_data";
	libname library "C:\path\source_data";
	libname target "C:\path\sdtm_data";
	options ls=256 nocenter;
%mend common;
