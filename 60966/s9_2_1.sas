* S9_2_1.sas
*
* Using PDF properties options;

ods listing close;
ods pdf file="&path\results\ch9_2_1.pdf"
        title='Example 9.2.1'
        author='Art Carpenter'
        subject='PDF Property Items'
        keywords='PDF s9_2_1.sas properties';

   title1 'Sales Summary';
   proc report data=sashelp.prdsale(where=(prodtype='OFFICE')) 
               nowd;
   column region country product,actual;
   define region  / group;
   define country / group;
   define product / across;
   define actual  / analysis sum 
                    format=dollar8. 
                    'Sales';
   break after region / summarize suppress;
   rbreak after / summarize;
   run;
ods pdf close;
