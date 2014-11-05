



%MACRO Get_Colors;

  data WORK.COLORS                                  ;

    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */

    infile "&JES.input_data/colors.csv" delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
        informat Num_Color $23. ;
        informat Color $17. ;
        informat Hex $6. ;
        informat Num best32. ;
        informat Color_Hex $33. ;
        informat Group best32. ;
        informat VAR7 $4. ;
        format Num_Color $23. ;
        format Color $17. ;
        format Hex $6. ;
        format Num best12. ;
        format Color_Hex $33. ;
        format Group best12. ;
        format VAR7 $4. ;
     input
                 Num_Color $
                 Color $
                 Hex $
                 Num
                 Color_Hex $
                 Group
                 VAR7 $
     ;
     if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
     run;
 data colors; set colors; N=mod(num,24); if N=0 then N=24; run;
DATA C1; SET Colors; IF Group=1; C1=Color; LABEL C1="   1-24"; KEEP N C1; RUN;
DATA C2; SET Colors; IF Group=2; C2=Color; LABEL C2="  25-48"; KEEP N C2; RUN;
DATA C3; SET Colors; IF Group=3; C3=Color; LABEL C3="  49-72"; KEEP N C3; RUN;
DATA C4; SET Colors; IF Group=4; C4=Color; LABEL C4="  73-96"; KEEP N C4; RUN;
DATA C5; SET Colors; IF Group=5; C5=Color; LABEL C5=" 97-120"; KEEP N C5; RUN;
DATA C6; SET Colors; IF Group=6; C6=Color; LABEL C6="121-144"; KEEP N C6; RUN;
DATA JES.Color_Tab; MERGE C1 C2 C3 C4 C5 C6; BY N; RUN;
DATA JES.Colors; SET Colors; run;
PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Colors Color_Tab;
RUN; QUIT;

 %MEND Get_Colors;
%get_colors;
