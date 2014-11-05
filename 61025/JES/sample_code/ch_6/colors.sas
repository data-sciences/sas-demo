

/*==========colors.sas=======================================
Display SAS ordinary-language color names


    %INCLUDE "&JES.sample_code/ch_6/colors.sas";
        %Show_Colors;

==================================================*/
%MACRO Show_Colors;
        GOPTIONS RESET=ALL BORDER;
        GOPTIONS GUNIT=PCT HTEXT=3 FTEXT='Arial';
        %Show_Color_List(  1,  24, 20);
        %Show_Color_List( 25,  48, 20);
        %Show_Color_List( 49,  72, 20);
        %Show_Color_List( 73,  96, 20);
        %Show_Color_List( 97, 120, 20);
        %Show_Color_List(121, 144, 20);
        /* GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.75 IN GSFNAME=Fig GSFMODE=REPLACE; */
        %Show_Grays(20);
%MEND Show_Colors;

%MACRO Show_Color_List(Cfrom, Cto, W);
        /* Use SYMBOL statements to assign gray-scale colors to the first &NumLine symbols */
        %let NumLine=%SYSEVALF(1+&Cto-&Cfrom); %put &NumLine;
        %DO s = 1 %TO &NumLine;
                %let c = %SYSEVALF(&Cfrom+&s-1);
                PROC SQL NOPRINT;
                        SELECT Color INTO :Color FROM JES.Colors WHERE Num=&c;
                QUIT;
                %put SYMBOL&s COLOR=&Color WIDTH=&W INTERPOL=JOIN;
                SYMBOL&s COLOR=&Color WIDTH=&W INTERPOL=JOIN;
        %END;
        /* Select rows between &Cfrom and &Cto  */
        Data Colors_; set JES.Colors;
                if Num >= &Cfrom;
                if Num <= &Cto;
                X=0; OUTPUT;
                X=1; OUTPUT;
                KEEP Num X Color Num_Color;
        RUN;

        AXIS1 LABEL=("") VALUE=NONE ORDER=0 TO 1;
        AXIS2 LABEL=("") ;
        TITLE1 H=5 "SAS Color Names &Cfrom - &Cto";
        PROC GPLOT DATA=Colors_;
                PLOT Num_Color* X = Num_Color / NOLEGEND VREVERSE HAXIS=AXIS1 VAXIS=AXIS2;
RUN; QUIT;
%MEND Show_Color_List; 

%MACRO Show_Grays(w);
        /* Create data set Gray containing gray-scale names  */
        DATA Grays;
                FORMAT hh $2. Gray $6.;
                DO i=1 TO 17;
                        n=16*(i-1);
                        IF n=256 THEN n=255;
                        hh = PUT(n, HEX2.);
                        Gray="GRAY"||TRIM(LEFT(hh));
                        x=0; OUTPUT;
                        x=1; OUTPUT;
                END;
        RUN;
        /* Use SYMBOL statements to assign gray-scale colors to the first 17 symbols */
        %DO i = 1 %TO 17;
                PROC SQL NOPRINT;
                        SELECT Gray INTO :Gray FROM Grays WHERE i=&i;
                QUIT;
                %put SYMBOL&i COLOR=&Gray WIDTH=&W INTERPOL=JOIN;
                SYMBOL&i COLOR="&Gray" WIDTH=&w INTERPOL=JOIN;
        %END;
        AXIS1 LABEL=("") VALUE=NONE ORDER=0 TO 1;
        AXIS2 LABEL=("") ;
        TITLE1 H=5 "SAS Gray-Scale Color Names";
        TITLE2 H=4 "17 of 256 Possible Grays";
        PROC GPLOT DATA=Grays;
                PLOT Gray* x = Gray / NAME="F6_20_" NOLEGEND VREVERSE HAXIS=AXIS1 VAXIS=AXIS2;
        RUN; QUIT;
%MEND Show_Grays; 

