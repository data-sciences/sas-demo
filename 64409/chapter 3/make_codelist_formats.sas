*---------------------------------------------------------------*;
* make_codelist_formats.sas creates a permanent SAS format library
* stored to the libref LIBRARY from the codelist metadata file 
* CODELISTS.xlsx.  The permanent format library that is created
* contains formats that are named like this: 
*   CODELISTNAME_SOURCEDATASET_SOURCEVARIABLE
* where CODELISTNAME is the name of the SDTM codelist, 
* SOURCEDATASET is the name of the source SAS dataset and
* SOURCEVARIABLE is the name of the source SAS variable.
*---------------------------------------------------------------*;
proc import 
    datafile="C:\path\SDTM_METADATA.xlsx"
    out=formatdata 
    dbms=excelcs 
    replace; 
    sheet="CODELISTS";
run;


** make a proc format control dataset out of the SDTM metadata;
data source.formatdata;
    set formatdata(drop=type);

	where sourcedataset ne "" and sourcevalue ne "";

	keep fmtname start end label type;
	length fmtname $ 32 start end $ 16 label $ 200 type $ 1;

	fmtname = compress(codelistname || "_" || sourcedataset 
                  || "_" || sourcevariable);
	start = left(sourcevalue);
	end = left(sourcevalue);
	label = left(codedvalue);
	if upcase(sourcetype) = "NUMBER" then
	    type = "N";
	else if upcase(sourcetype) = "CHARACTER" then
	    type = "C";
run;

** create a SAS format library to be used in SDTM conversions;
proc format
    library=library
    cntlin=source.formatdata
    fmtlib;
run;

