/* 9.2 applicable only: 14.31, 14.32, 14.33, 14.34, 14.35,
                        18.4, 18.5, 18.6, 18.20,
                        20.10, 20.11, 20.12, 20.16, 20.17 */

/* Need to substitute -your- image file name in our
   examples in order to successfully use
   these template examples: 14.29, 14.30, 17.21, 17.22, 17.25, 
                            17.26, 17.27, 17.28, 17.29, 17.30, 
                            18.18, 18.19

Also remember that for HTML the image location for
style element is the location of the image when the 
HTML page is LOADED into the browser.

For RTF and PDF files, the image location for the
style element is the location of the image when the
RTF or PDF file is CREATED by SAS.
  
*/
ods listing close;
option nodate nonumber center;

ods path work.temp(update)
         sasuser.templat(update)
         sashelp.tmplmst(read);

/* Figure 2.6 */
PROC TEMPLATE;
  DEFINE STYLE SILLY;
  PARENT=STYLES.DEFAULT;
  REPLACE fonts /
         'TitleFont2' = ("Comic Sans MS, sans-serif",4,bold italic)
         'TitleFont' = ("Comic Sans MS, sans-serif",5,bold italic)
         'StrongFont' = ("Comic Sans MS, sans-serif",4,bold)
         'EmphasisFont' = ("Comic Sans MS, sans-serif",3,italic)
         'FixedEmphasisFont' = ("Comic Sans MS, monospace",2,italic)
         'FixedStrongFont' = ("Comic Sans MS, monospace",2,bold)
         'FixedHeadingFont' = ("Comic Sans MS, monospace",2)
         'BatchFixedFont' = ("Comic Sans MS, monospace",
         2)
         'FixedFont' = ("Comic Sans MS",2)
         'headingEmphasisFont' = ("Comic Sans MS, sans-serif",4,bold
         italic)
         'headingFont' = ("Comic Sans MS, sans-serif",4,bold)
         'docFont' = ("Comic Sans MS, sans-serif",3);
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='fig2_6.html' style=silly;
proc print data=sashelp.class;
  title 'Figure 2.6';
run;
ods _all_ close;


/* Figure 4.52 */
proc template;
  define style styles.usefc;
  parent=styles.rtf;
    replace systemfooter/
       protectspecialchars=off;
  end;
run;
ods rtf file='fig4_52.rtf' style=usefc;
proc print data=sashelp.class;
  title 'Figure 4_52';
  footnote '\uld Underlined Footnote \uld0';
run;
ods _all_ close;
title; footnote;


/* Figure 13.9 */
PROC TEMPLATE;
  DEFINE STYLE DefaultNewTitle;
  PARENT=styles.default;
  REPLACE FONTS /
    'TitleFont2' = ("<sans-serif>, Helvetica, sans-serif",4,bold italic)
    'TitleFont' = ("Times New Roman, Times, sans-serif",5,bold italic)
    'StrongFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold)
    'EmphasisFont' = ("<sans-serif>, Helvetica, sans-serif",3,italic)
    'FixedEmphasisFont' = ("<monospace>, Courier, monospace",2,italic)
    'FixedStrongFont' = ("<monospace>, Courier, monospace",2,bold)
    'FixedHeadingFont' = ("<monospace>, Courier, monospace",2)
    'BatchFixedFont' = ("SAS Monospace, <monospace>, Courier, monospace",2)
    'FixedFont' = ("<monospace>, Courier",2)
    'headingEmphasisFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold italic)
    'headingFont' = ("<sans-serif>, Helvetica, sans-serif",4,bold)
    'docFont' = ("<sans-serif>, Helvetica, sans-serif",3);
  end;
run;

ods html path='c:\temp' (url=none)
         file='fig13_9.html' style=DefaultNewTitle;
proc print data=sashelp.class;
  title 'Figure 13.9 Should be Italic Title';
run;
ods _all_ close;


/* Figure 14.10 */

PROC TEMPLATE;
  DEFINE STYLE STYLES.REDLINE;
    PARENT=STYLES.DEFAULT;
    REPLACE html
  "Common HTML text used in the default style" /
  'expandAll' =
   "<span onclick=""if(msie4==1)expandAll()"">"
  'posthtml flyover line' = "</span><hr size=""3"">"
  'prehtml flyover line' = "<span><hr size=""3"">"
  'prehtml flyover bullet' = %nrstr("<span><b>&#183;</b>")
  'posthtml flyover' = "</span>"
  'prehtml flyover' = "<span>"
  'break' = "<br>"
  'Line' = "<hr size=""3"">"
  'PageBreakLine' =
    '<p style="page-break-after: always;"><br></p><hr size="5" color="red">'
  'fake bullet' = %nrstr("<b>&#183;</b>");

  END;
RUN;
ods html path='c:\temp' (url=none)
         file='fig14_10.html' style=RedLine;
proc print data=sashelp.class(obs=2);
  title 'Figure 14.10 Should see Red HR';
run;

proc print data=sashelp.class(obs=2);
  title 'Figure 14.10 Should see Red HR';
run;
ods _all_ close;




/* Figure 14.12 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.CHGABS;
  PARENT=STYLES.DEFAULT;
  REPLACE HeadersandFooters /
     font = ("Courier New, SAS Monospace",4,Bold)
     background=yellow
     foreground=purple;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='fig14_12.html' style=CHGABS;
proc print data=sashelp.class(obs=2);
  title 'Figure 14.12 Yellow and Purple';
run;
ods _all_ close;


/* Figure 14.13 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.DIFFHDRS;
    PARENT=STYLES.DEFAULT;
    REPLACE Header  /
      font = ("Arial, Helvetica, sans-serif",5,Bold)
      background=black
      foreground=white
      just=center;
    STYLE RowHeader from Header /
      font = ("Courier New, SAS Monospace",4,Bold)
      background=white
      foreground=black
      just=right;
  END;
RUN;


ods html path='c:\temp' (url=none)
         file='fig14_13.html' style=DIFFHDRS;

proc tabulate data=sashelp.class;
  title 'Figure 14.13 Different Header and RowHeader';
  class sex age;
  var height;
  table age all, sex*(height*mean);
run;
ods _all_ close;



/* Not used in a figure, same page as code for 14.13 */
proc template;
  define style styles.samehdrs;
    parent=styles.default;
    replace Header from _self_ /
      font = ("Arial, Helvetica, sans-serif",5,Bold)
      background=black
      foreground=white
      just=center;

  replace RowHeader from _self_ /
      font = ("Arial, Helvetica, sans-serif",5,Bold)
      background=black
      foreground=white
      just=center;
  end;
run;

ods html path='c:\temp' (url=none)
         file='fig14_13_same.html' style=SAMEHDRS;

proc tabulate data=sashelp.class;
  title 'Figure 14.13 Same Header and RowHeader';
  class sex age;
  var height;
  table age all, sex*(height*mean);
run;
ods _all_ close;


/* Figure 14.14 */
PROC TEMPLATE;
 DEFINE STYLE STYLES.ALERT;
   PARENT=STYLES.DEFAULT;
   REPLACE StartupFunction /
      tagattr='alert("To Get Paid For Overtime, Fill Out Your TimeSheets!!")';
 END;
RUN;

ods html path='c:\temp' (url=none)
         file='fig14_14.html' style=ALERT;
proc print data=sashelp.class;
  title 'Figure 14.14 Must Enable Popups to See Alert';
run;
ods _all_ close;



/* Figure 14.15 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.PUTDATE;
    PARENT=STYLES.DEFAULT;
    STYLE Body from Document / 
      posthtml=
     '<SCRIPT LANGUAGE=JAVASCRIPT TYPE="text/javascript" SRC="c:\temp\GETDATE.JS"></script>';
  END;
RUN;

**************************************************************
** You must have a valid Javascript program installed in the
** SRC= location in order to test this template.
**************************************************************;

/* Figure 14.16 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.BOTTOMTOC;
    PARENT=STYLES.DEFAULT;
    STYLE frame from Document / 
          contentposition=bottom  
          contentsize=25%;
    STYLE contents from Document / background=white;
    STYLE contenttitle from IndexTitle / 
          font = ("Arial, Helvetica",16 pt,Bold)
          foreground=black  background=white
          pretext = 'Select Your Report From the List Below';
    STYLE contentfolder from IndexItem / background=white;
    STYLE ContentProcname from IndexProcName / 
          background=white  bullet=none;
    STYLE contentitem from IndexItem / 
          bullet=none  background=white;
  END;
RUN;

ods html path='c:\temp' (url=none)
         contents='fig14_16_toc.html'
         frame='fig14_16_frm.html'
         file='fig14_16.html' style=BOTTOMTOC;


proc freq data=sashelp.class;
  title 'Figure 14.16 Use FRAME=, CONTENTS=, Bottom TOC Position';
  tables age;
run;

proc means data=sashelp.class;
  var height weight;
  title 'Average Height and Weight';
run;

proc print data=sashelp.class;
  title 'List of Students';
run;

ods _all_ close;

/* Figure 14.17, 14.18, 14.19 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.CHGBODY;
    PARENT=STYLES.DEFAULT;
    style Body from body /  
          rightmargin = 10
          leftmargin = 0;
  END;
RUN;

options center;     
ods html path='c:\temp' (url=none)
         file='fig14_17_default.html' style=default;
proc print data=sashelp.class(obs=2)
     style(table)={outputwidth=100%};
  var name name name name name name age age age age age height weight;
  title 'Figure 14.17 default margins on left and right';
run;
ods _all_ close;

ods html path='c:\temp' (url=none)
         file='fig14_17_chgbody.html'  style=chgbody;

proc print data=sashelp.class(obs=2)
     style(table)={outputwidth=100%};
  var name name name name name name age age age age age height weight;
  title 'Figure 14.17 Change body margin left=0 right=10';
run;

ods _all_ close;


/* Figure 14.20, 14.21 */
proc template;
  define style styles.chgtable;
    parent=styles.default;
    replace Output / background = white
                     rules = ALL
                     frame = BOX
                     cellpadding = 7
                     cellspacing = 5
                     bordercolor = black
                     borderwidth = 5;
  end;
run;

ods html path='c:\temp' (url=none)
         file='fig14_20.html'  style=chgtable;

proc print data=sashelp.class(obs=2)
     style(table)={outputwidth=100%};
  var name name name name name name age age age age age height weight;
  title 'Figure 14.20 cellpadding=7 cellspacing=5 bordercolor=black';
run;

ods _all_ close;

/* Figure 14.22 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.CHGTABLE2;
    PARENT=STYLES.DEFAULT;
    REPLACE Output / background = white
                     rules = ALL
                     frame = BOX
                     cellpadding = 7
                     cellspacing = 0
                     bordercolor = black
                     borderwidth = 5;
  END;
RUN;


ods html path='c:\temp' (url=none)
         file='fig14_22.html'  style=chgtable2;

proc print data=sashelp.class(obs=2)
     style(table)={outputwidth=100%};
  var name name name name name name age age age age age height weight;
  title 'Figure 14.22 cellpadding=7 cellspacing=0 bordercolor=black';
run;

ods _all_ close;


/* Figure 14.23_1-8 */

/*
Possible values for 
RULES: ROWS COLS NONE ALL GROUPS
FRAME: VOID BOX HSIDES VSIDES 

Depending on inheritance, you may find that 
REPLACE TABLE works better in SAS 9.1.3 while
STYLE or CLASS syntax works better in SAS 9.2;

PROC TEMPLATE;
  DEFINE STYLE STYLES.RULESFRAME;
    PARENT=STYLES.DEFAULT;

    REPLACE TABLE from OUTPUT /
            cellspacing=0;
            rules = ?????
            frame = ?????;
  END;
RUN;


The book only shows 8 combinations, but there are more combinations
*/

/* Macro to generate templates and reports similar to 
   Output 14.23 and Output 14.24 */
%macro chgrf(rulelist=, framelist=, templatename=testtemplate);
  %let rulenumber=1;

  %let rule=%scan(&rulelist,&rulenumber);
  %do %until (&rule=);
    %let framenumber=1;
    %let frame=%scan(&framelist,&framenumber);
    %do %until (&frame=);
      proc template;
        define style styles.&templatename;
          parent=styles.default;

          style Table from Output  / cellspacing = 0
                                     rules = &RULE
                                     frame = &FRAME
                                     bordercolor=black;

        end;
      run;

      ods html path='c:\temp' (url=none)
               body="r_&rule._f_&frame..html"
               style=styles.&templatename;
      ods noproctitle;
      proc freq data=sashelp.shoes;
        title "RULE=&RULE and FRAME=&FRAME";
        tables region / nocum;
      run;
      ods _all_ close;

      %let framenumber=%eval(&framenumber+1);
      %let frame=%scan(&framelist,&framenumber);
    %end;
    %let rulenumber=%eval(&rulenumber+1);
    %let rule=%scan(&rulelist,&rulenumber);
  %end;
%mend chgrf;

/* List the RULE= values you want to test separated by a space     */
/* List the FRAME= values you want to test separated by a space    */
/* This macro call creates many different reports using the combinations */
/* of the values in RULELIST and FRAMELIST                         */

%chgrf(RULELIST=NONE ALL GROUPS ROWS COLS, 
       FRAMELIST=VOID ABOVE BOX HSIDES VSIDES);
run;




/* Figure 14.25 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.DECORATIVE;
    PARENT=STYLES.DEFAULT;
    STYLE Table from Output / rules=all frame=box
      cellspacing=5 borderwidth=5 bordercolor=black
      bordertopstyle=dotted  borderbottomstyle=dotted
      borderrightstyle=dotted  borderleftstyle=dotted;
    STYLE Header from HeadersAndFooters / background=gray foreground=white
                   font_face='Courier New'
      bordertopstyle=dashed borderbottomstyle=dashed
      borderrightstyle=dashed borderleftstyle=dashed;
    STYLE Data from Cell / background=white foreground=black
      bordertopstyle=dotted borderbottomstyle=dotted
      borderrightstyle=dotted borderleftstyle=dotted;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig14_25.html' style=decorative;

  proc print data=sashelp.class;
    title 'Figure 14.25 Different Border Styles';
  run;
ods _all_ close;

/* Figure 14.26, 14.27, 14.28 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.MANYPARTS;
    PARENT=STYLES.DEFAULT;
    STYLE Table from Output / rules=all
                  frame=box
                  cellspacing=0
                  borderwidth=2
                  cellpadding=1
                  bordercolor=yellow;
    STYLE Header from HeadersAndFooters / background=gray
                   foreground=white
                   font_face='Courier New';
    STYLE RowHeader from Header / background=black
                      foreground=white;
    STYLE Data from Cell / background=white
                 foreground=black;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig14_26.html' style=manyparts;

  proc print data=sashelp.class;
    title 'Figure 14.26 Different Colors Many Parts of the Table';
  run;
ods _all_ close;


/* Figure 14.29 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.ADDIMAGE;
    PARENT=STYLES.DEFAULT;
    STYLE Body from Document / preimage= 'LH.gif';
    STYLE Table from Output / postimage='draft.gif';
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig14_29.html' style=addimage;

  proc print data=sashelp.class;
    title 'Figure 14.29 Will see red X instead of image';
    title2 'But when valid image location used, will see image';
  run;
ods _all_ close;


/* Figure 14.30 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.WATERMARK;
  PARENT=STYLES.DEFAULT;
  STYLE Body from Document /
      backgroundimage = 'LH.gif'
      watermark=on;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig14_30.html' style=watermark;

  proc print data=sashelp.class;
    title 'Figure 14.30 No Watermark Until Valid Image Used';
  run;
ods _all_ close;

/* Figure 14.31, 14.32 */
/* The template for 14.31 and 14.32 which shows
   formatting for 10 titles and 10 footnotes within
   a style template will only work in SAS 9.2. In
   earlier versions of SAS, all the titles used the
   same style elements.
*/

ods html path='c:\temp' (url=none)
         file='Fig14_31.html' style=default;

  proc print data=sashelp.class(obs=2);
    /* 'Figure 14.31 Size Titles Differently in 9.1.3'*/
    Title  h=24pt 'Fig. 14.31Title 1';
    Title2  h=22pt 'Title 2';
    Title3  h=20pt 'Title 3';
    Title4  h=18pt 'Title 4';
    Title5  h=16pt 'Title 5';
    Title6  h=14pt 'Title 6';
    Title7  h=12pt 'Title 7';
    Title8  h=10pt 'Title 8';
    Title9  h=8pt 'Title 9';
    Title10  h=6pt 'Title 10';
    Footnote  h=24pt 'Footnote 1';
    Footnote2  h=22pt 'Footnote 2';
    Footnote3  h=20pt 'Footnote 3';
    Footnote4  h=18pt 'Footnote 4';
    Footnote5  h=16pt 'Footnote 5';
    Footnote6  h=14pt 'Footnote 6';
    Footnote7  h=12pt 'Footnote 7';
    Footnote8  h=10pt 'Footnote 8';
    Footnote9  h=8pt 'Footnote 9';
    Footnote10  h=6pt 'Footnote 10';
  run;
ods _all_ close;
title; footnote;


/* Figure 15.1, 15.2 */
PROC TEMPLATE;
   DEFINE STYLE DefaultSmaller;
     PARENT=Styles.Default;
     REPLACE fonts /
         'TitleFont2'=("Arial, Helvetica, Helv",3,Bold Italic)
         'TitleFont'=("Arial, Helvetica, Helv",4,Bold Italic)
         'StrongFont'=("Arial, Helvetica, Helv",3,Bold)
         'EmphasisFont'=("Arial, Helvetica, Helv",2,Italic)
         'FixedEmphasisFont'=("Courier",1,Italic)
         'FixedStrongFont'=("Courier",1,Bold)
         'FixedHeadingFont'=("Courier",1)
         'BatchFixedFont'=("SAS Monospace, Courier",1)
         'FixedFont'=("Courier",1)
         'headingEmphasisFont'=("Arial,Helvetica,Helv",3,Bold Italic)
         'headingFont'=("Arial, Helvetica, Helv",3,Bold)
         'docFont'=("Arial, Helvetica, Helv",2);
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig15_1.html' style=DefaultSmaller;

  proc print data=sashelp.class;
    title 'Figure 15.1 Smaller fonts for Default style';
  run;
ods _all_ close;



/* Figure 15.4, 15.5 */

PROC TEMPLATE;
   DEFINE STYLE PrinterSmaller;
      PARENT=Styles.Printer;
   REPLACE fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
   END;
RUN;
  
options orientation=portrait nodate nonumber;
ods pdf file='Fig15_4.pdf' style=PrinterSmaller;

  proc print data=sashelp.class;
    title 'Figure 15.4 Smaller fonts for Printer style';
  run;
ods _all_ close;


/* Figure 15.7, 15.8 */
PROC TEMPLATE;
   DEFINE STYLE RTFSmaller;
     PARENT=Styles.RTF;
     REPLACE fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
   END;
RUN;
 
options orientation=portrait nodate nonumber;
ods rtf file='Fig15_7.rtf' style=RTFSmaller;

  proc print data=sashelp.class;
    title 'Figure 15.7 Smaller fonts for RTF style';
  run;
ods _all_ close;




/* Figure 15.9 */
PROC TEMPLATE;
  DEFINE STYLE DefaultNewFonts;
    PARENT=Styles.Default;
    REPLACE fonts /
    'TitleFont2' = ("Algerian",4,Bold Italic)
    'TitleFont' = ("Brittanic Bold",7,Bold Italic)
    'StrongFont' = ("Comic Sans MS",4,Bold)
    'EmphasisFont' = ("Desdemona",3,Italic)
    'FixedEmphasisFont' = ("Lucida Typewriter",2,Italic)
    'FixedStrongFont' = ("Letter Gothic MT",2,Bold)
    'FixedHeadingFont' = ("QuickType Mono",2)
    'BatchFixedFont' = ("SAS Monospace",2)
    'FixedFont' = ("Courier New",2)
    'headingEmphasisFont' = ("Eras Demi ITC",4,Bold Italic)
    'headingFont' = ("Franklin Gothic Medium",4,Bold)
    'docFont' = ("Goudy Old Style",3);
  END;
RUN;

** Note, you must have these fonts available on your system;
** And, in a simple PROC PRINT, not all the fonts will be used.;

ods html path='c:\temp' (url=none)
         file='Fig15_9.html' style=DefaultNewFonts;

  proc print data=sashelp.class;
    title 'Figure 15.9 Different Fonts for HTML';
  run;
ods _all_ close;


/* Figure 15.12, 15.13*/
PROC TEMPLATE;
   DEFINE STYLE RTFNoItalics;
      PARENT=Styles.RTF;
   REPLACE fonts /
      'TitleFont2' = ("Times",12pt,Bold)
      'TitleFont' = ("Times",13pt,Bold)
      'StrongFont' = ("Times",10pt,Bold)
      'EmphasisFont' = ("Times",10pt)
      'FixedEmphasisFont' = ("Courier New, Courier",9pt)
      'FixedStrongFont' = ("Courier New, Courier",9pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",9pt,Bold)
      'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",6.7pt)
      'FixedFont' = ("Courier New, Courier",9pt)
      'headingEmphasisFont' = ("Times",11pt,Bold)
      'headingFont' = ("Times",11pt,Bold)
      'docFont' = ("Times",10pt);
   END;
RUN;
 
options orientation=portrait nodate nonumber;
ods rtf file='Fig15_12.rtf' style=RTFNoItalics;

  proc print data=sashelp.class;
    title 'Figure 15.12 No Italics for RTF style';
  run;
ods _all_ close;

/* Figure 15.15 */
PROC TEMPLATE;
   DEFINE STYLE DefaultNewFonts2;
     PARENT=Styles.Default;
     REPLACE fonts /
        'TitleFont2' = ("Arial, Helvetica, Helv",4,Bold Italic)
        'TitleFont' = ("Arial, Helvetica, Helv",5,Bold Italic)
        'StrongFont' = ("Arial, Helvetica, Helv",4,Bold)
        'EmphasisFont' = ("Arial, Helvetica, Helv",3,Italic)
        'FixedEmphasisFont' = ("Courier",2,Italic)
        'FixedStrongFont' = ("Courier",2,Bold)
        'FixedHeadingFont' = ("Courier",2)
        'BatchFixedFont' = ("SAS Monospace, Courier",2)
        'FixedFont' = ("Courier",2)
        'headingEmphasisFont' = ("Arial,Helvetica,Helv",4,Bold Italic)
        'headingFont' = ("Arial, Helvetica, Helv",4,Bold)
        'docFont' = ("Arial, Helvetica, Helv",3)
        'FootnoteFont'= ("Arial, Helvetica, Helv", 1, Italic);
     REPLACE SystemFooter from TitlesAndFooters /
       font = Fonts('FootnoteFont');
  end;
run;

ods html path='c:\temp' (url=none)
         file='Fig15_15.html' style=DefaultNewFonts2;

  proc print data=sashelp.class(obs=2);
    title 'Figure 15.15 Different Fonts for HTML';
    footnote 'Really Small Footnote';
  run;
ods _all_ close;
title; footnote;


PROC TEMPLATE;
  DEFINE STYLE RTFFixed;
    PARENT=Styles.RTF;
  REPLACE fonts /
    'TitleFont2' = ("Courier New, Courier",12pt,Bold Italic)
    'TitleFont' = ("Courier New, Courier",13pt,Bold Italic)
    'StrongFont' = ("Times",10pt,Bold)
    'EmphasisFont' = ("Times",10pt,Italic)
    'FixedEmphasisFont' = ("Courier New, Courier",9pt,Italic)
    'FixedStrongFont' = ("Courier New, Courier",9pt,Bold)
    'FixedHeadingFont' = ("Courier New, Courier",9pt,Bold)
    'BatchFixedFont' = ("SAS Monospace,Courier New,Courier",12pt, Bold)
    'FixedFont' = ("Courier New, Courier",9pt)
    'headingEmphasisFont' = ("Times",11pt,Bold Italic)
    'headingFont' = ("Courier New, Courier",11pt,Bold)
    'docFont' = ("SAS Monospace, Courier New, Courier",10pt);
  END;
RUN;
 
options orientation=portrait nodate nonumber;
ods rtf file='Fig15_rtffixed.rtf' style=RTFFixed;

  proc print data=sashelp.class;
    title 'Figure 15 RTF Fixed Pitch or "Monospace For Most Fonts';
  run;
ods _all_ close;


/* Figure 16.4 */
PROC TEMPLATE;
  DEFINE STYLE WiderBorder;
    PARENT=Styles.Default;
    REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 10;
  END;
RUN;
  
ods html path='c:\temp' (url=none)
         file='Fig16_4.html' style=WiderBorder;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.4 Wide Border';
  run;
ods _all_ close;

/* Figure 16.5 */
PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = NONE
         frame = BOX
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig16_5.html' style=DefaultNoBorderRule;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.5 FRAME=BOX and Borderwidth=1';
    title2 'CELLSPACING=1 and RULES=NONE';
  run;
ods _all_ close;


/* Figure 16.6 */
PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule2;
      PARENT=Styles.Default;
      REPLACE Output from Container /
         background = colors('tablebg')
         rules = NONE
         frame = VOID
         cellpadding = 7
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig16_6.html' style=DefaultNoBorderRule2;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.6 FRAME=VOID and Borderwidth=1';
    title2 'CELLSPACING=1 and RULES=NONE';
    title3 'Now only see table background, no frame';
  run;
ods _all_ close;


/* Figure 16.7 */
PROC TEMPLATE;
   DEFINE STYLE DefaultNoBorderRule3;
      PARENT=Styles.Default;
      REPLACE Table from Output /
         background = colors('tablebg')
         rules = NONE
         frame = VOID
         cellpadding = 7
         cellspacing = 0
         bordercolor = colors('tableborder')
         borderwidth = 1;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig16_7.html' style=DefaultNoBorderRule3;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.7 FRAME=VOID and Borderwidth=1';
    title2 'CELLSPACING=0 and RULES=NONE';
    title3 'Now interior lines go away with cellspacing 0';
  run;
ods _all_ close;


/* Figure 16.10 */
PROC TEMPLATE;
  DEFINE STYLE PrinterNoBorder;
    PARENT=Styles.Printer;
    REPLACE Table from Output /
         rules = NONE
         frame = VOID
         cellpadding = 4pt
         cellspacing = 0
         borderwidth = 1;
   END;
RUN;


ods pdf file='Fig16_10.pdf' style=PrinterNoBorder;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.10 FRAME=VOID and Borderwidth=1';
    title2 'CELLSPACING=0 and RULES=NONE';
    title3 'Now interior lines go away with cellspacing 0';
  run;
ods _all_ close;



/* Figure 16.12 */
PROC TEMPLATE;
  DEFINE STYLE DefaultSqueeze;
    PARENT=Styles.Default;
    REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 3
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig16_12.html' style=DefaultSqueeze;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.12 Cellpadding=3';

  run;
ods _all_ close;


/* Figure 16.13 */
PROC TEMPLATE;
  DEFINE STYLE DefaultStretch;
    PARENT=Styles.Default;
    REPLACE Output from Container /
         background = colors('tablebg')
         rules = GROUPS
         frame = BOX
         cellpadding = 10
         cellspacing = 1
         bordercolor = colors('tableborder')
         borderwidth = 1;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig16_13.html' style=DefaultStretch;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.13 Cellpadding=10';

  run;
ods _all_ close;

/* Figure 16.15 */
PROC TEMPLATE;
  DEFINE STYLE NoBullet;
    PARENT=STYLES.DEFAULT;
    REPLACE ContentProcName from IndexProcName /
       BULLET=NONE;
  END;
RUN;


ods html path='c:\temp' (url=none)
         contents='fig16_15_toc.html'
         frame='fig16_15_frm.html'
         file='Fig16_15.html' style=NoBullet;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.15 No Bullet Contents';
  run;

  proc freq data=sashelp.class;
    title 'PROC FREQ';
    tables age;
  run;
ods _all_ close;



/* Figure 16.17 */
PROC TEMPLATE;
  DEFINE STYLE FixedWidth;
    PARENT=STYLES.DEFAULT;
    REPLACE Table from Output / outputwidth=400;
    REPLACE Frame from Document /
         contentposition = L
         bodyscrollbar = auto
         bodysize = *
         contentscrollbar = auto
         contentsize = 200
         framespacing = 1
         frameborderwidth = 4
         frameborder = on;
  END;
RUN;

ods html path='c:\temp' (url=none)
         contents='fig16_17_toc.html'
         frame='fig16_17_frm.html'
         file='Fig16_17.html' style=FixedWidth;

  proc print data=sashelp.class(obs=2);
    title 'Figure 16.17 Fixed Width Content and table';
    title2 'Contentscrollbar = auto';
  run;

  proc freq data=sashelp.class;
    title 'PROC FREQ';
    tables age;
  run;
ods _all_ close;

/* Figure 16.19 */
PROC TEMPLATE;
   DEFINE STYLE RtfMargins;
      PARENT = Styles.RTF;
      STYLE BODY FROM BODY /
         BOTTOMMARGIN = .5in
         TOPMARGIN = .5in
         RIGHTMARGIN = .5in
         LEFTMARGIN = .5in;
   END;
RUN;

options orientation=portrait nodate nonumber;
ods rtf file='Fig16_19.rtf' style=RtfMargins;

  proc print data=sashelp.class;
    title 'Figure 16.19 Check Word Layout for Margins at .5';
  run;
ods _all_ close;


/* Figure 16.20 */
PROC TEMPLATE;
   DEFINE STYLE RtfMargins2;
      PARENT = Styles.RTF;
      STYLE BODY FROM BODY /
         BOTTOMMARGIN = _undef_
         TOPMARGIN = _undef_
         RIGHTMARGIN = _undef_
         LEFTMARGIN = _undef_;
   END;
RUN;

options orientation=portrait nodate nonumber
        topmargin=3in bottommargin=1in ;
ods rtf file='Fig16_20.rtf' style=RtfMargins2;

  proc print data=sashelp.class;
    title 'Figure 16.20 margin comes from Option: 3in Top Margin';
  run;
ods _all_ close;
options topmargin=.25in bottommargin=.25in rightmargin=.25in
        leftmargin=.25in;

/* Figure 16.21, 16.22, 16.23 16.24 */

PROC TEMPLATE;
  DEFINE STYLE STYLES.LOOKLIST;
  PARENT=STYLES.PRINTER;
    REPLACE fonts  /
     'BatchFixedFont' = ("Courier",8pt)
     'TitleFont2' = ("Courier",8pt)
     'TitleFont' = ("Courier",8pt)
     'StrongFont' = ("Courier",8pt)
     'EmphasisFont' = ("Courier",8pt)
     'FixedEmphasisFont' = ("Courier",8pt)
     'FixedStrongFont' = ("Courier",8pt)
     'FixedHeadingFont' = ("Courier",8pt)
     'FixedFont' = ("Courier",8pt)
     'headingEmphasisFont' = ("Courier",8pt)
     'headingFont' = ("Courier",8pt)
     'docFont' = ("Courier",8pt);
    STYLE table from output /
      cellpadding = 2pt
      cellspacing = 0pt
      background=white
      rules=groups
      frame=void;
    REPLACE color_list  /
     'link' = black
     'bgH' = white
     'fg' = black
     'bg' = white;
  END;
RUN;

ods pdf file='fig16_21.pdf' style=looklist;

  proc print data=sashelp.class;
    title 'Figure 16.21 Output Resembles LISTING';
  run;

ods pdf close;


/* Figure 17.4 */
PROC TEMPLATE;
  DEFINE STYLE ReverseColors;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cxE0E0E0
      'bgA' = cx002288;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_4.html' style=ReverseColors;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.4 Reverse Colors';
  run;
ods _all_ close;

/* Figure 17.5 */
PROC TEMPLATE;
  DEFINE STYLE RevColorTitle;
  PARENT=Styles.Default;
  REPLACE TitlesAndFooters from Container /
      font = Fonts('TitleFont2')
      background = colors('systitlefg')
      foreground = colors('systitlebg');
   END;

RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_5.html' style=RevColorTitle;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.5 Reverse Colors Title';
  run;
ods _all_ close;

/* Figure 17.6 */
PROC TEMPLATE;
  DEFINE STYLE GreenTitle;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx00FF00
      'bgA' = cxE0E0E0;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_6.html' style=GreenTitle;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.6 Green Title';
  run;
ods _all_ close;

/* Figure 17.7 */
PROC TEMPLATE;
  DEFINE STYLE GreenNameTitle;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = green
      'bgA' = cxE0E0E0;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_7.html' style=GreenNameTitle;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.7 Use Named Color Green for Title';
  run;
ods _all_ close;



/* Figure 17.10 */
PROC TEMPLATE;
  DEFINE STYLE WhiteBack;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx002288
      'bgA' = cxFFFFFF;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_10.html' style=WhiteBack;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.10 White Background';
  run;
ods _all_ close;

/* Figure 17.11 */
PROC TEMPLATE;
  DEFINE STYLE AllWhiteBack;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cxFFFFFF
      'bgA3' = cxFFFFFF
      'fgA2' = cx0033AA
      'bgA2' = cxFFFFFF
      'fgA1' = cx000000
      'bgA1' = cxFFFFFF
      'fgA' = cx002288
      'bgA' = cxFFFFFF;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_11.html' style=AllWhiteBack;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.11 All White Background';
  run;
ods _all_ close;


/* Figure 17.13 */
PROC TEMPLATE;
  DEFINE STYLE DefaultLogoColors;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxFFFF33
      'fgA2' = cx336600
      'bgA2' = cxFFCC00
      'fgA1' = cx003300
      'bgA1' = cxFFFF66
      'fgA' = cx002288
      'bgA' = cxE0E0E0;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_13.html' style=DefaultLogoColors;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.13 Other Yellowy Colors';
  run;
ods _all_ close;


/* Figure 17.14 */
PROC TEMPLATE;
  DEFINE STYLE DefaultLogoColors2;
  PARENT=Styles.Default;
  REPLACE color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxFFFF33
      'fgA2' = cx336600
      'bgA2' = cxFFCC00
      'fgA1' = cx003300
      'bgA1' = cxFFFF66
      'fgA' = cx336600
      'bgA' = cxFFFF66;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_14.html' style=DefaultLogoColors2;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.14 All (incl Background) Yellow Colors';
  run;
ods _all_ close;


/* Figure 17.16 */
PROC TEMPLATE;
  DEFINE STYLE DefaultPurpleFN;
  PARENT=Styles.Default;
  REPLACE color_list
      "Colors used in the default style" /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0033AA
      'bgA2' = cxB0B0B0
      'fgA1' = cx000000
      'bgA1' = cxF0F0F0
      'fgA' = cx002288
      'bgA' = cxE0E0E0
      'fgNew'= cx660066;
   REPLACE colors
      "Abstract colors used in the default style" /
      'headerfgemph' = color_list('fgA2')
      'headerbgemph' = color_list('bgA2')
      'headerfgstrong' = color_list('fgA2')
      'headerbgstrong' = color_list('bgA2')
      'headerfg' = color_list('fgA2')
      'headerbg' = color_list('bgA2')
      'datafgemph' = color_list('fgA1')
      'databgemph' = color_list('bgA3')
      'datafgstrong' = color_list('fgA1')
      'databgstrong' = color_list('bgA3')
      'datafg' = color_list('fgA1')
      'databg' = color_list('bgA3')
      'batchfg' = color_list('fgA1')
      'batchbg' = color_list('bgA3')
      'tableborder' = color_list('fgA1')
      'tablebg' = color_list('bgA1')
      'notefg' = color_list('fgA')
      'notebg' = color_list('bgA')
      'bylinefg' = color_list('fgA2')
      'bylinebg' = color_list('bgA2')
      'captionfg' = color_list('fgA1')
      'captionbg' = color_list('bgA')
      'proctitlefg' = color_list('fgA')
      'proctitlebg' = color_list('bgA')
      'titlefg' = color_list('fgA')
      'titlebg' = color_list('bgA')
      'systitlefg' = color_list('fgA')
      'systitlebg' = color_list('bgA')
      'Conentryfg' = color_list('fgA2')
      'Confolderfg' = color_list('fgA')
      'Contitlefg' = color_list('fgA')
      'link2' = color_list('fgB2')
      'link1' = color_list('fgB1')
      'contentfg' = color_list('fgA2')
      'contentbg' = color_list('bgA2')
      'docfg' = color_list('fgA')
      'docbg' = color_list('bgA')
      'footnotefg' = color_list('fgNew');
   REPLACE SystemFooter from TitlesAndFooters /
      font = Fonts('TitleFont')
      foreground = colors('footnotefg');
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_16.html' style=DefaultPurpleFN;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.16 Purple Footnote';
    footnote 'Should be Purple from style element';
  run;
ods _all_ close;
title; footnote;

/* Alternate DEFAULTPURPLEFN */
PROC TEMPLATE;
  DEFINE STYLE AltPurpleFN;
  PARENT=Styles.Default;
  REPLACE SystemFooter from TitlesAndFooters /
      font = Fonts('TitleFont')
      foreground = cx660066;
   END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_16_alt.html' style=AltPurpleFN;

  proc print data=sashelp.class(obs=2);
    title 'Figure 17.16 Alternate Purple Footnote';
    footnote 'Should be Purple from Alternate Method';
  run;
ods _all_ close;
title; footnote;

/* Figure 17.20 */
** In the book, figure 17.20 is produced by inheriting from ;
** styles.highcontrast -- which is a 9.2 only style template.;
** with a black and white style.;
** For SAS 9.1.3, you might want to inherit from a black and white;
** style like the Journal style or the RTF style;
** Also, the <MTserif> font is a 9.2 only font, which is;
** installed by SAS and named in the SAS registry.;
      
PROC TEMPLATE;
  DEFINE STYLE HCSerif;
  PARENT=Styles.RTF;
  REPLACE fonts /
     'TitleFont2' = ("Times Roman",4,bold italic)
     'TitleFont' = ("Times Roman",5,bold italic)
     'StrongFont' = ("Times Roman",4,bold)
     'EmphasisFont' = ("Times Roman",3,italic)
     'FixedEmphasisFont' = ("Courier",2,italic)
     'FixedStrongFont' = ("Courier",2,bold)
     'FixedHeadingFont' = ("Courier",2)
     'BatchFixedFont' = ("SAS Monospace, Courier",2)
     'FixedFont' = ("Courier",2)
     'headingEmphasisFont' = ("Times Roman",4,bold italic)
     'headingFont' = ("Times Roman",4,bold)
     'docFont' = ("Times Roman",3);
  REPLACE TABLE from output /
      rules=all
      frame=box
      cellpadding=7px
      cellspacing=1
      background=_undef_
      borderwidth=1;
  REPLACE Header /
      background=white
      foreground=black;
  REPLACE RowHeader /
      background=white
      foreground=black;
  END;
RUN;

ods html path='c:\temp' (url=none)
         file='Fig17_20.html' style=HCSerif;

  proc print data=sashelp.class(obs=2);
    title 'Fig 17.20 High Contrast Black Foreground on White Background';
    footnote 'Should be all Serif Fonts';
  run;
ods _all_ close;
title; footnote;



** About 17.21 through 17.30;
** Need to have valid image to see images actually used.;
** Otherwise, will see red X in browser when image not found.;
** HTML Location should be location of image when;
** the HTML page is LOADED into the browser.;
** RTF and PDF image location should be location of image;
** when the RTF or PDF file is CREATED by SAS.;

/* Figure 17.21 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogo;
  PARENT=Styles.Default;
  REPLACE Body from Document /
       preimage="corporatelogo.gif";
  END;
RUN;



/* Figure 17.22 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogoJournal;
  PARENT=Styles.Journal;
  REPLACE Body /
      preimage="corporatelogo.gif";
  REPLACE SystemTitle /
      foreground = cx990000;
  END;
RUN;



/* Figure 17.23 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogo2;
  PARENT=Styles.Default;
  REPLACE Body /
     prehtml='<table width=100%><tr><td nowrap align=left>
        <img border="0" src="corporatelogo.gif">
        <font face="Arial" size=3><b>SprayTech Corp.</b></font>
        </tr></td></table>';
  END;
RUN;



/* Figure 17.24 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogoBG;
  PARENT=Styles.Default;
  REPLACE Body from Document /
      backgroundimage="corporatelogobg.gif";
  END;
RUN;


/* Figure 17.25 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogoBG2;
  PARENT=Styles.Default;
  REPLACE Body from Document /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <font face="Arial" size=5><b>SprayTech Corp.</b></font>
         </tr></td></table>'
      backgroundimage='corporatelogobg.gif';
  REPLACE Container /
      font = Fonts('DocFont')
      foreground = colors('docfg');
  REPLACE TitlesAndFooters from Container /
      font = Fonts('TitleFont2')
      foreground = colors('systitlefg');
  END;
RUN;

/* Figure 17.26 */
PROC TEMPLATE;
  DEFINE STYLE CorpLogoMin;
    PARENT=Styles.Minimal;
    REPLACE Body from Document /
      prehtml='<table width=100%><tr><td nowrap align=left>
         <font face="Arial" size=5><b>SprayTech Corp.</b></font>
         </tr></td></table>'
      backgroundimage='corporatelogobg.gif';
  END;
RUN;


/* Figure 17.27 */
PROC TEMPLATE;
  DEFINE STYLE RTFImage;
     PARENT=Styles.RTF;
     REPLACE Body /
        preimage="corporatelogo.jpg";
  END;
RUN;

/* Figure 17.28  */
PROC TEMPLATE;
  DEFINE STYLE RTFImageLeft;
     PARENT=Styles.RTF;
     REPLACE Body  /
        preimage="corporatelogo.jpg"
        just=left;
  END;
RUN;

/* Figure 17.29  */
PROC TEMPLATE;
  DEFINE STYLE RTFImageRepeat;
     PARENT=Styles.RTF;
     REPLACE SystemTitle /
        preimage="corporatelogo.jpg"
        just=left;
  END;
RUN;

/* Figure 17.30  */
proc template;
   define style PrinterLogo;
   parent=styles.printer;
   REPLACE body /
      preimage='corporatelogo.jpg';
   end;
run;


/* Figure 18.16 */

** data for 18.16;
data projected_billing;
  infile datalines;
  input Division $ BillableAmt_Base Grow_At_05 Grow_At_10 Grow_At_25 Grow_At_50;
return;
datalines;
Analysis             44372.55    46591.18    48809.80    55465.69    66558.82
Applications         50869.29    53412.75    55956.22    63586.61    76303.93
Documentation        46970.17    49318.68    51667.19    58712.71    70455.26
QA                   50069.78    52573.27    55076.76    62587.22    75104.67
Reporting            43575.22    45753.98    47932.74    54469.03    65362.83
Systems              53446.35    56118.67    58790.98    66807.94    80169.52
;
run;

**style template;
PROC TEMPLATE;
  DEFINE STYLE STYLES.PROJBILL_COLORS;
    PARENT=STYLES.SASWEB;
    STYLE Hilite from Data /
             background=yellow
             font_weight=bold
             foreground=black;
    STYLE Hooray from Data/
             background=cyan
             font_weight=bold
             foreground=black;
  END;
RUN;
             
** table template;
PROC TEMPLATE;
  DEFINE TABLE PROJBILL_TABLE;
    COLUMN DIVISION BILLAMT;
    DYNAMIC TREATCOL;
    HEADER REPHDR;
    DEFINE REPHDR;
      TEXT '/Projected Billing Report';
    END;
    DEFINE DIVISION;
      STYLE=Header;
    END;
    DEFINE BillAmt;
      DEFINE HEADER BillHdr;
        TEXT _LABEL_;
        STYLE=Header;
      END;
      GENERIC=ON;
      FORMAT=dollar14.2;
      HEADER=BillHdr;
      STYLE=treatcol;
    END;
  END;
RUN;

** use style and table template together with the;
** dynamic column "treatcol" which tells the table template;
** what style element to use for the column.;
ODS LISTING CLOSE;
ODS RTF FILE='c:\temp\Special_Style.rtf' STYLE=PROJBILL_COLORS;
ODS PDF FILE='c:\temp\Special_Style.pdf' STYLE=PROJBILL_COLORS;
ODS HTML FILE='c:\temp\Special_Style.html' STYLE=PROJBILL_COLORS;
title 'Using Custom Table and Style Template';
data _null_;
  set work.projected_billing;
  file print ods=(template='projbill_table'
	   columns=(Division
	            BillAmt=BillableAmt_Base(generic=on
                        dynamic=(treatcol='Hilite'))
		    BillAmt=Grow_At_05(generic=on
                        dynamic=(treatcol='Data'))
		    BillAmt=Grow_At_25(generic=on
                        dynamic=(treatcol='Hooray'))));
  put _ods_;
  label Grow_At_05 = 'Growth at 5%'
        Grow_At_10 = 'Growth at 10%'
        Grow_At_25 = 'Growth at 25%'
        Grow_At_50 = 'Growth at 50%'
        BillableAmt_Base = 'Baseline (Actual)';
run;
ODS _ALL_  CLOSE;


/* Figure 18.17 */
PROC TEMPLATE;
  DEFINE STYLE STYLES.SMALLER;
    PARENT = STYLES.PRINTER;
    REPLACE fonts /
      'TitleFont2' = ("Times",10pt,Bold Italic)
      'TitleFont' = ("Times",11pt,Bold Italic)
      'StrongFont' = ("Times",8pt,Bold)
      'EmphasisFont' = ("Times",8pt,Italic)
      'FixedEmphasisFont' = ("Courier New, Courier",7pt,Italic)
      'FixedStrongFont' = ("Courier New, Courier",7pt,Bold)
      'FixedHeadingFont' = ("Courier New, Courier",7pt,Bold)
      'BatchFixedFont' = ("SAS Monospace, Courier New, Courier",5pt)
      'FixedFont' = ("Courier New, Courier",7pt)
      'headingEmphasisFont' = ("Times",9pt,Bold Italic)
      'headingFont' = ("Times",9pt,Bold)
      'docFont' = ("Times",8pt);
    REPLACE Table from Output /
      rules = ALL
      cellpadding = 2pt
      cellspacing = 0;
  END;
RUN;

** Again for 18.18 and 18.19;
** will have to use a valid image file in order to see the;
** results with an image in the PDF file.;
** Remember that images are converted to PDF internal format;
** and that the location for preimage should be the location;
** of the image file when the PDF file is CREATED by SAS.;

/* Figure 18.18 */
proc template;
   define style PrinterLogo;
   parent=styles.printer;
   style body from body /
      preimage='c:\books\ods\logo.jpg';
   end;
run;

/* Figure 18.19 */
proc template;
   define style PrinterLogo2;
   parent=styles.printer;
   style SystemTitle from SystemTitle/
      just=r
      preimage='c:\books\ods\logo.jpg';
   end;
run;

/* Figure 18.20 */
/*  For SAS 9.1.3, you will have to use RTF control strings to
    put a line above a footnote or inside a table as described in these
    papers and Tech Support notes: 
    http://support.sas.com/rnd/base/ods/templateFAQ/Template_rtf.html#escapechar
    http://support.sas.com/resources/papers/proceedings09/027-2009.pdf
    http://www.lexjansen.com/phuse/2005/ts/ts06.pdf

    The code for 18.20 relies on
    the SAS footnotes to each use a different style element. This
    code cannot be converted to SAS 9.1.3 because all the titles
    use the SystemTitle style element and all the footers use
    the same SystemFooter style element.
*/


