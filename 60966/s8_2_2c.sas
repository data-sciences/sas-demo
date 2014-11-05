* S8_2_2c.sas
*
* loading an image using STYLE=;

* Using the JUST= attribute in the STYLE= option;

ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_2_2c.html';

title1;
proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
            nowd;
   column region country product,actual totalsales;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   define totalsales / computed format=dollar10.
                       'Total Sales';
   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
   endcomp;

   * Uses the JUST=LEFT attribute;
   compute before _page_ / 
                style={preimage="&path\magic.gif"
                       just=left
                       font_weight=bold
                       font_face=arial
                       font_size=6};
      line 'Magic Mystery, Inc.';
      line 'Sales Summary';
   endcomp;   
   break after region / summarize suppress;
   rbreak after       / summarize;
   run;
ods html close;
