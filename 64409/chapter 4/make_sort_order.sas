*----------------------------------------------------------------*;
* make_sort_order.sas creates a global macro variable called  
* **SORTSTRING where ** is the name of the dataset that contains  
* the metadata specified sort order for a given dataset.
*
* MACRO PARAMETERS:
* dataset = the dataset or domain name
*----------------------------------------------------------------*;
%macro make_sort_order(dataset=);

    ** create **SORTSTRING macro variable;
    %global &dataset.SORTSTRING;
    data _null_;
      set "C:\sas\toolkit_global_library\standards\XYZ_program_cdisc-sdtm-3.1.2-1.3\metadata\reference_tables.sas7bdat";

        where upcase(table) = "&dataset";
    
        call symputx(compress("&dataset" || "SORTSTRING"), left(keys));
    run;
     
%mend make_sort_order;
