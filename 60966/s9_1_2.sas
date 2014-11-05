* S9_1_2.sas
*
* Using RTF Control words.;

ods listing close; 

* Create a style that turns off the protection for
* special characters (like the backslash);
proc template;
      define style styles.test;
         parent=styles.rtf;
         style systemtitle from systemtitle /
               protectspecialchars=off;
      end;
   run;

ods rtf style=styles.test
        file="&path\results\ch9_1_2.rtf"
        bodytitle;

title1 '\b \highlight3 Product Summary';
footnote1;

proc report data=sashelp.prdsale
            nowd;
   column prodtype region product,actual;
   define prodtype / group page;
   define region   / group 'Region';
   define product  / across;
   define actual   / analysis sum
                     format=dollar8.
                     'Sales';
   rbreak after / summarize;
   run;
ods rtf close;
