* S8_4_7c.sas
*
* Traffic lighting on the summary row;

proc format;
   value cfore
      low    - 21000 = 'white'
      21000< - 25000 = 'black'
      75000  - high  = 'white';
   value cback
      low    - 21000 = 'red'
      21000< - 25000 = 'yellow'
      75000  - high  = 'green';
   value fchair
      low    - 23500 = 'white';
   value bchair
      low    - 23500 = 'red';
   value fdesk
      low    - 25000 = 'white';
   value bdesk
      low    - 25000 = 'red';
   value ftable
      low    - 21000 = 'white';
   value btable
      low    - 21000 = 'red';
   value ftotal
      low    - 72000 = 'white';
   value btotal
      low    - 72000 = 'red';
   value fregn
      low    - 73000 = 'white';
   value bregn
      low    - 73000 = 'red';
   value fprod
      low    - 145000 = 'white'
      other           = 'black';
   value bprod
      low    - 145000 = 'red'
      other           = 'white';
   run;


ods listing close;
ods html style=default
         path="&path\results"
         body='ch8_4_7c.html';

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
 
   break after region / summarize suppress;
   rbreak after       / summarize;

   compute actual;
      if _break_ = ' ' then do;
         call define('_C3_','style','style={background=bchair. 
                                            foreground=fchair.}');
         call define('_C4_','style','style={background=bdesk. 
                                            foreground=fdesk.}');
         call define('_C5_','style','style={background=btable. 
                                            foreground=ftable.}');
      end;
      else if _break_='REGION' then do;
         call define(_row_,'style','style={background=bregn. 
                                           foreground=fregn.}');
      end;
      else if _break_='_RBREAK_' then do;
         call define(_row_,'style','style={background=bprod. 
                                           foreground=fprod.}');
      end;
   endcomp;

   compute totalsales;
      totalsales = sum(_c3_, _c4_, _c5_);
      if _break_ = ' ' then do;
         call define(_COL_,'style', 'style={background=btotal. 
                                            foreground=ftotal.}');
      end;
      else if _break_='REGION' then do;
         call define(_col_,'style','style={background=cback.
                                           foreground=cfore.}');
      end;
   endcomp;
   run;
ods html close;

