 /**********************************************************************
 *   PRODUCT:   SAS
 *   VERSION:   9.1
 *   CREATOR:   External File Interface
 *   DATE:      11APR09
 *   DESC:      Generated SAS Datastep Code
 *   TEMPLATE SOURCE:  (None Specified.)
 ***********************************************************************/
    data _null_;
    set  SASHELP.CLASS                                end=EFIEOD;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    %let _EFIREC_ = 0;     /* clear export record count macro variable */
    file 'C:\InnovativeTechniques\data\class.csv' delimiter=',' DSD DROPOVER lrecl=32767;
       format Name $8. ;
       format Sex $1. ;
       format Age best12. ;
       format Height best12. ;
       format Weight best12. ;
    if _n_ = 1 then        /* write column names */
     do;
       put
       'Name'
       ','
       'Sex'
       ','
       'Age'
       ','
       'Height'
       ','
       'Weight'
       ;
     end;
     do;
       EFIOUT + 1;
       put Name $ @;
       put Sex $ @;
       put Age @;
       put Height @;
       put Weight ;
       ;
     end;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    if EFIEOD then call symputx('_EFIREC_',EFIOUT);
    run;
