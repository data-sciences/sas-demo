

/*--------------------------------------------------------------------------*/
 /*      Painless Windows: A Handbook for SAS(R) Users, Third Edition       */
 /*          by Jodie Gilmore                                               */
 /*       Copyright(c) 2004  by SAS Institute Inc., Cary, NC, USA           */
 /*                   SAS Publications order # 58783                        */
 /*                        ISBN 1-59047-399-X                               */
 /*-------------------------------------------------------------------------*/
 /*                                                                         */
 /* This material is provided "as is" by SAS Institute Inc.  There          */
 /* are no warranties, expressed or implied, as to merchantability or       */
 /* fitness for a particular purpose regarding the materials or code        */
 /* contained herein. The Institute is not responsible for errors           */
 /* in this material as it now exists or will exist, nor does the           */
 /* Institute provide technical support for it.                             */
 /*                                                                         */
 /*-------------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be            */
 /* addressed to the author:                                                */
 /*                                                                         */
 /* SAS Institute Inc.                                                      */
 /* Books by Users                                                          */
 /* Attn: Jodie Gilmore                                                     */
 /* SAS Campus Drive                                                        */
 /* Cary, NC   27513                                                        */
 /*                                                                         */
 /*                                                                         */
 /* If you prefer, you can send email to:  sasbbu@sas.com                   */
 /* Use this for subject field:                                             */
 /*     Comments for Jodie Gilmore                                          */
 /*                                                                         */
 /*-------------------------------------------------------------------------*/
 /* Date Last Updated:                                                      */
 /*-------------------------------------------------------------------------*/

-----------------------------------------------------------------------------
Chapter 8 Using the SAS Output Delivery System
-----------------------------------------------------------------------------

Creating an HTML Table of Contents (page 203)

ods listing close;
ods html path = "C:\"(url=none)
         frame = "frame.htm"
         body = "body.htm"
         contents = "toc.htm";

data test;
   x=1;
   y=2;
run;

proc print contents="Data for Test";
run;

data test2;
   w=5;
   z=7;
run;

proc print contents="Data for Test2";
run;

ods html close;
ods listing;


Creating PDF Output (page 205)

ods listing close; /* optional */
ods html close; /* optional */
ods pdf;

data test;
   x=1;
   y=2;
run;

proc print;
run;

data test2;
   w=5;
   z=7;
run;

proc print;
run;

ods pdf close; /* necessary to see the output */
ods listing;


Sending Output to More Than One File with the Same Destination Type (page 210)

ods pdf (id=plain) file="c:\PlainOutput.pdf";
ods pdf (id=fancy) style=FancyPrinter 
         file="c:\FancyOutput.pdf";

data fruit;
   length name $15 color $15;
   input name $ color $;
   datalines;
Orange orange
Apple  red
Banana yellow
Pear   green
;
run;

data veggies;
   length name $15 color $15;
   input name $ color $;
   datalines;
Cauliflower white
Broccoli    green
Beet        red
Carrot      orange
Eggplant    purple
;
run;

proc print data=fruit;
run;
proc print data=veggies;
run;

ods pdf (id=plain) close;
ods pdf (id=fancy) close;


Controlling Which Output Objects Are Included in Your Output (page 213)

ods trace on/label;
   
data test;
   do i = 1 to 150;
      group = (i > 50);
      x = normal(123);
      y1 = uniform(123);
      y2 = uniform(567);
      output;
   end;
run;

proc means;
   by group;
   title 'Means Step';
run;


Example?Selecting an Output Object (page 215)

ods html body='c:\body2.htm';

data test;
   do i = 1 to 150;
      group = (i > 50);
      x = normal(123);
      y1 = uniform(123);
      y2 = uniform(567);
      output;
   end;
run;

   /* Select a single output object. Note the use of */
   /* quotation marks in the label path. */
ods select "The MEANS Procedure"."group=1"."Summary 
statistics";

proc means;
   by group;
   title 'Means Step';
run;

ods html close;
ods listing;


Creating Your Own Style Definition (page 222)

options nodate;
ods listing close;

ods html path = "C:\"(url=none)
         frame = "NewFrame.htm"
         body = "NewBody.htm"
         contents = "NewToc.htm";

footnote "~ Report prepared by Farmer Bob ~";

proc print data=fruit contents="Fruit Data";
   title "Fruit Data from My Farm";
run;

proc print data=veggies contents="Veggie Data";
   title "Veggie Data from My Farm";
run;

ods html close;
ods listing;

proc template;
   /* Give the new style definition a name (MyWebStyle). */
   /* It is stored in the default location, which is the */
   /* SASUSER.TEMPLAT template store, accessed through the */
   /* Templates window. This is a permanent file, not a */
   /* temporary file, and persists from one SAS session to */
   /* the next. */
define style MyWebStyle;
   /* Specify the parent style definition as a starting 
      point. */
parent = styles.default;

   /* Replace the old color list with a new color list. */
replace color_list /
      'fgB2' = cx0066AA
      'fgB1' = cx004488
      'fgA4' = cxAAFFAA
      'bgA4' = cx880000
      'bgA3' = cxD3D3D3
      'fgA2' = cx0000FF
      'bgA2' = cxFFFF99 /* a darker yellow */
      'fgA1' = cx000000
      'bgA1' = cxCCFFFF /* a light blue */
      'fgA' = cx000000 /* black */
      'bgA' = cxFFFFCC; /* a light buff yellow */
 
         /* Replace the foreground and background colors for 
       the title and footnote areas. */
replace titlesandfooters /
      foreground = colors("systitlefg")
      background = colors("systitlebg");

         /* Modify the font used for footnotes. */
style SystemFooter from SystemFooter /                                
   font = Fonts('TitleFont') font_size=1 
   font_weight = demi_light;

         /* Modify the font used for column headers. */
style header from header /
      font_style = italic;

         /* Replace the commonly used text phrases. */
replace text /
      "prefix1" = "PROC "
      "suffix1" = "--"
         /* title for table of contents */
      "Content Title" = "Content Map"
      "Pages Title" = "Pages"
      "Note Banner" = "Note"
      "Warn Banner" = "Warning:"
      "Error Banner" = "Error:"
      "Fatal Banner" = "Fatal:";
 
         /* Replace the commonly used HTML snippets. */
replace html from html /
    /* Cause the table of contents title to be 
       centered. */
   'expandAll' = "<center><SPAN onClick=""if(msie4==1)expandAll()"">"
         /* End the centering. */
   'posthtml flyover line' = "</center></SPAN><HR size=""3"">" 
   'prehtml flyover line' = "<SPAN><HR size=""3"">"            
   'posthtml flyover' = "</SPAN>"                             
   'prehtml flyover' = "<SPAN>"                               
   'break' = "<br>"                                           
   'Line' = "<HR size=""3"">"                                 
   'PageBreakLine' = %nrstr("<p style=""page-break-after: always;"">&#160</p><HR size=""3"">");

         /* Modify how tables are presented. */
style table from table /
      rules = rows /* rules only between rows */
      cellspacing = 3 /* increase cell spacing */
      bordercolorlight = colors("databg")
      bordercolordark = colors("link1")
      borderwidth = 3;

         /* Increase the size of the table of contents 
       area. */
style frame from frame /
          contentsize = 30%;

         /* Modify some of the colors used in the table 
       of contents. */
style contents from contents /
      visitedlinkcolor = colors("systitlefg")
      foreground = colors('systitlefg');

         /* Modify the font used in the table of contents 
       heading. */
style ContentTitle from ContentTitle /
     font = fonts('headingEmphasisFont');

         /* Modify the behavior of the leaf nodes in the table 
       of contents. Notably, remove the ugly "middle dot" 
       type bullets. */
replace IndexItem from IndexItem /
   leftmargin = 6pt                                                     
   listentryanchor = on                                                 
   background = colors('contentbg')                                     
   foreground = colors('conentryfg');   

         /* Modify more table of contents features, such as 
       adding more space between output items and using a 
       more attractive bullet. */
style ContentItem from ContentItem /
   posthtml = '<br>'
   bullet = "disc";
end;
run;
 
ods listing close;
options nodate;

         /* Add the STYLE= option to the ODS statement so the new
       style definition is used. */
ods html path = "C:\"(url=none)
         frame = "NewFrame.htm"
         body = "NewBody.htm"
         contents = "NewToc.htm"
         style=MyWebStyle;

footnote "~ Report prepared by Farmer Bob ~";

proc print data=fruit contents="Fruit Data";
   title "Fruit Data from My Farm";
run;

proc print data=veggies contents="Veggie Data";
   title "Veggie Data from My Farm";
run;

ods html close;
ods listing;

Creating a Cascading Style Sheet (CSS) (page 228)

ods listing close;
ods html file="c:\Test.html" 
    style=MyWebStyle stylesheet="c:\MyWebStyle.css";
data one;
x=1;
run;
proc print;
run;
ods html close;
ods listing;

Example Using PROC DOCUMENT (page 229)

ods html path = "C:\"(url=none)
         frame = "DocFrame.htm"
         body = "DocBody.htm"
         contents = "DocToc.htm";

options nodate;

proc sort data=sasuser.members out=sasuser.MembersSorted;
   by city_state_zip name;
run;

title "Proc TABULATE Step";
proc tabulate data=sasuser.MembersSorted;
   by city_state_zip;
   class city_state_zip status;
   table city_state_zip,status;
run;

title "Proc FREQ Step";
proc freq data=sasuser.MembersSorted;
   by city_state_zip;
   table status;
run;
 
ods html close;
ods listing;

More Detailed example (page 231)

ods document name=sasuser.mydoc(write);

options nodate;

proc sort data=sasuser.members out=sasuser.MembersSorted;
   by city_state_zip name;
run;

title "Proc TABULATE Step";
proc tabulate data=sasuser.MembersSorted;
   by city_state_zip;
   class city_state_zip status;
   table city_state_zip,status;
run;

title "Proc FREQ Step";
proc freq data=sasuser.MembersSorted;
   by city_state_zip;
   table status;
run;

ods document close;

program lists the output objects associated with our example:
ods listing;
title "Names of Output Objects in SASUSER.MYDOC";
proc document name=sasuser.mydoc;
   list/levels=all;
run;
   /* Like other interactive procedures, PROC DOCUMENT */ 
   /* requires a QUIT statement. */
quit; 
ods listing close;

   /* Specify a new document name in which to store the reorganized output. */
proc document name=sasuser.mydoc2;
      /* Create a subdirectory for each of the BY-group values. */
      /* Also create a label for each subdirectory. */
   make Camas;
   setlabel Camas 'City=Camas, WA 98607';
   make Vancouver1;
   setlabel Vancouver1 'City=Vancouver, WA 98663';
   make Vancouver2;
   setlabel Vancouver2 'City=Vancouver, WA 98683';
   make Washougal;
   setlabel Washougal 'City=Washougal, WA 98671';

      /* Make the active directory the Camas directory. */
   dir ^^\Camas;
      /* Copy specific output objects from the original 
         document to the new document. The '^' character 
         represents the current directory. */
   copy \sasuser.mydoc\Freq#1\ByGroup1#1\Table1#1\OneWayFreqs#1 
         to ^;
   copy \sasuser.mydoc\Tabulate#1\ByGroup1#1\Report#1\Table#1 to ^;
      /* Make the active directory the Vancouver1 directory. */
   dir ^^\Vancouver1;
      /* Copy specific output objects from the original 
         document to the new document. The '^' character 
         represents the current directory. */
   copy \sasuser.mydoc\Freq#1\ByGroup2#1\Table1#1\OneWayFreqs#1 
         to ^;
   copy \sasuser.mydoc\Tabulate#1\ByGroup2#1\Report#1\Table#1 to ^;
      /* Make the active directory the Vancouver2 directory. */
   dir ^^\Vancouver2;
      /* Copy specific output objects from the original 
         document to the new document. The '^' character 
         represents the current directory. */
   copy \sasuser.mydoc\Freq#1\ByGroup3#1\Table1#1\OneWayFreqs#1 
         to ^;
   copy \sasuser.mydoc\Tabulate#1\ByGroup3#1\Report#1\Table#1 to ^;
      /* Make the active directory the Washougal directory. */
   dir ^^\Washougal;
      /* Copy specific output objects from the original 
         document to the new document. The '^' character 
 
         represents the current directory. */
   copy \sasuser.mydoc\Freq#1\ByGroup4#1\Table1#1\OneWayFreqs#1 
         to ^;
   copy \sasuser.mydoc\Tabulate#1\ByGroup4#1\Report#1\Table#1 to ^;
   run;
quit;


ods listing close;
ods html path = "C:\"(url=none)
         frame = "NewDocFrame.htm"
         body = "NewDocBody.htm"
         contents = "NewDocToc.htm"
         style = MyWebStyle;

options nodate;

proc document name=sasuser.mydoc2;
   replay;
   run;
quit;

ods html close;
ods listing;

ods listing close;
ods pdf file="c:\NewOutput.pdf"
    style = MyWebStyle;

options nodate;

proc document name=sasuser.mydoc2;
   replay;
   run;
quit;

ods pdf close; 
ods listing;



------------------------------------------------------------------------------------------------ 
Chapter 14  Sharing Data Between SAS and Windows Applications
------------------------------------------------------------------------------------------------ 
 
Example 1: Starting Word from Your SAS Session (page 347)

   /* Sets the NOXSYNC and NOXWAIT system options, starts Word, */
   /* and pauses the SAS System for 15 seconds */
options noxsync noxwait; 
x 'c:\winword\winword.exe';     
data _null_; 
   x=sleep(15);          
run;


Example 2: Reading Data from Microsoft Word (page 347)

   /* Define the file shortcuts for the two bookmarks. */   
   /* The NOTAB option is necessary so the */ 
   /* SAS System does not expect tabs */ 
   /* between columns. */ 
filename number dde 'winword|august.doc!number'
         notab; 
filename client dde 'winword|august.doc!client'
         notab;
   /* Associate the library reference INVOICE with */ 
   /* the folder C:\SAS\INVOICES. */ 
libname invoice 'c:\sas\invoices';

   /* Create the table INVOICE.AUGUST, */ 
   /* read the information at the two */ 
   /* bookmarks, and store the data in columns. */ 
data invoice.august;     
      /* Set the column length to an */         
      /* arbitrary number. */ 
    length invnum $45 invclnt $45; 
      /* Get ready to read the first bookmark. */ 
        infile number;  
      /* Read the invoice number as a */ 
      /* character column. */   
        input invnum $;         
      /* Get ready to read the second bookmark. */ 
      /* Because the data include spaces, use some */ 
      /* other arbitrary character as the */ 
      /* delimiter. */ 
        infile client dlm='@';  
      /* Read the client as a character column. */
        input invclnt $; 
run;

   /* Print the output. */ 
proc print; 
run;


Example 3: Opening and Closing a Word Document  (page 348)

filename mycmds dde 'winword|system'; 
data _null_; 
   file mycmds; 
   put '[FileOpen.Name="c:\invoices\august.doc"]'; 
run;
data _null_; 
   file mycmds; 
      /* Close the active Word document. */ 
   put '[FileClose]'; 
   put '[FileExit]'; /* Close Word. */ 
run;


Example 4: Inserting a File into a Word Document (page 349)

filename mycmds dde 'winword|system' notab lrecl=850;
data _null_;
   file mycmds;
   put '[EditBookmark.Name="MyMark1", .Goto]';
   put '[StartOfLine]';
   put '[InsertFile.Name="C:\MyHTML1.htm", 
         .ConfirmConversions=0]';
run;


Example 5: Combining the SAS Macro Language and DDE (page 349)

%macro InsertFile(filename,markname);
   put "[EditBookmark.Name=""&markname"", .Goto]";
   put "[StartOfLine]";
   put "[InsertFile.Name=""&filename"",   
       .ConfirmConversions=0]";
%mend;
filename mycmds dde 'winword|system' notab lrecl=850;

data _null_;
   file mycmds;
   %InsertFile(C:\testing1.htm,MyMark1);
   %InsertFile(C:\testing2.htm,MyMark2);
run;


Example 6: Inserting an Object into a Word Document, via a Word Macro (page 350)

Sub InsertTestingObjectAtBookmark()
    Selection.GoTo What:=wdGoToBookmark, Name:="MyMark2"
    Selection.Find.ClearFormatting
    With Selection.Find
        .Text = ""
        .Replacement.Text = ""

        .Forward = True
        .Wrap = wdFindContinue
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.HomeKey Unit:=wdLine

    Selection.InlineShapes.AddOLEObject ClassType:="NetscapeMarkup", FileName _
        :="C:\testing.htm", LinkToFile:=False, DisplayAsIcon:=False
End Sub
Now, you can simply call the macro from SAS:
filename mycmds dde 'winword|system' notab;
data _null_;
   file mycmds;
   put '[InsertTestingObjectAtBookmark()]';
run;


Example 7: Using DDE to Send HTML-Formatted PROC TABULATE Output to an Excel File (page 351)

   /* Turn off the XWAIT and XSYNC system options, so Excel 
      will run independently of SAS. */
options nodate noxwait noxsync;

   /* Turn off listing output and turn on HTML output. */
ods listing close;
ods html file="c:\Table1.html" style=minimal;

   /* Use the SASHELP.CLASS data set (installed with SAS) to 
      create a new data set. */
data mydata;
   set sashelp.class;
   obsno=_n_;
run;

   /* Increase the linesize to accommodate the data and Excel 
      commands. */
options linesize=150;


title "Sending PROC TABULATE Output to Excel";
proc tabulate data=mydata format=12.;
   class sex age;
   table (age all='All Ages')
          *(n='Number of students'*f=9.
          pctn='Percent of total'),
   sex='Gender' all='All Students'/ rts=50;
run;

   /* Close the HTML destination. */
ods html close;

   /* Start Excel. Your pathname may differ. */
x '"c:\program files\microsoft office\office\excel.exe"';

   /* Cause the SAS System to wait 5 seconds, for Excel to 
      finish starting up. */
data _null_;
   x=sleep(5);
run;
quit;

   /* Define the CMDS fileref for sending commands to Excel. */
filename cmds dde 'excel|system';

data _null_;
   file cmds;
      /* Pull the TABULATE HTML output into Excel. */
   put '[open("c:\table1.html")]';
      /* Save the Excel file. */
   put '[save.as("c:\NewTable.xls")]';
      /* Wait for a half-second for the save to be completed. */
   x=sleep(.5);
      /* Close the file and close Excel. */
   put '[close("false")]';
   put '[quit()]';
run;
quit;



-----------------------------------------------------------------------------------------------------------
Chapter 15  Using SAS/Connect Software to Connect Your PC to Other Systems
-----------------------------------------------------------------------------------------------------------   

Example 1: Using Compute Services (page 387)

filename tcpvms "C:\Program Files\SAS\
   SAS 9.1\connect\saslink\tcpvms.scr";

   /* Tell the OpenVMS SAS session to use */ 
   /* the HOST sort utility. /* 
options sortpgm=host;            
   
   /* Define a library reference on OpenVMS. */          
libname panthers 'species::[florida.cats]'; 
proc sort data=panthers.kittens          
     out=females (where=(gender='f'));   
     by age idnum;      
run;

proc print data=females;         
     title='Female Florida Panther Kittens';
     by age;     
run;


Example 2: Using Data Transfer Services (page 389)

%let to390=tiger@company.com;

C:\PROGRAM FILES\SAS\SAS 9.1\CONNECT\SASLINK\TCPTSO.SCR 

   /* Define a library reference on z/OS. */     
libname pollute 'vehicle.test.results';
proc download data=pollute.large out=large; 
   where year between 1975 and 1977 
      and weight > 6000 
      and hydcarb >= 750;        
run;

proc upload data=hydcarb 
            out=pollute.hydcarb; 
        run;


Example 3: Using Remote Library Services (page 390)


%let tounix=1.20.327.45;

C:\PROGRAM FILES\SAS\SAS 9.1\CONNECT\SASLINK\TCPUNIX.SCR

libname co       
     '/home/user/smith/vehicles/light/tests'
     server=tounix;
data co.high_co;        
   set co.year81;        
   where carbmono > 1.2;         
run;

proc plot data=co.high_co nolegend;     
   title1 '1981 Vehicles Weighing Less than 
      6,000 Pounds';     
   title2 'with High Carbon Monoxide Emissions'; 
   title3 '(Measured in Percentage)';    
   plot vin*carbmono='*';        
run;


Example 4: Combining Compute, Data Transfer, and Remote Library Services 
           along with Parallel Processing (page 392)

%let to390=tiger@company.com tsospawn;

options comamid=tcp remote=to390;
signon user=sasexpert password=_prompt_; 

libname os390 remote 'joeuser.data' server=to390; 
libname win 'c:\wildcat\info';

proc sort data=os390.vital;      
   by id;        
run;

proc sort data=win.region;       
   by id;        
run;

   /* Issue a waitfor statement so the merge doesn't start 
      until the remotely submitted sort is complete. */
waitfor _all_ to390;

   /* Create the merged table. */ 
data catinfo;    
   merge os390.vital win.region;         
   by id; 
run;

libname cat 'joeuser.data';
        proc upload data=catinfo         
             out=cat.catinfo;    
        run;

proc tabulate data=cat.catinfo   
             format=comma8.;     
   title 'Tabulation of Wild Cat Information 
         Organized by Species and Region';
   class species region;         
   var weight age;       
   table species*region,         
   age*mean*f=8.2 weight*mean*f=8.2 age*n; 
run;


Example 5: Using SAS/CONNECT Software in Batch Mode (page 394)


   /* Define a nickname for the remote session ID. */ 
%let tounix=1.45.735.26;
   /* Set the communications access method. */ 
options comamid=tcp;
.   /* Assign the RLINK file shortcut to the     
       appropriate script file. */ 
filename rlink '!SASROOT\connect\saslink\tcpunix.scr';
   /* Define a library reference on the local PC, where 
      the downloaded table is stored. */ 
libname windata 'c:\temp\july';
signon; /* Initiate the connection. */

   /* Begin the remote submitted block of code. */ 
rsubmit;
   /* Define a library reference for a UNIX data library. */ 
libname unixdata 'janeuser/tempdata/july';
   /* Create a temporary table that contains the high and 
      low temperatures for July. */ 
data hilo;       
       merge unixdata.hi (drop=date place
                 rename=(time=hitime)) 
             unixdata.lo        
                 (rename=(time=lotime)); 
run;

   /* Download the merged table. */ 
proc download data=hilo out=windata.hilo; 
run;

   /* End the remote submitted block of code. */ 
endrsubmit;
   /* Terminate the most recently referenced connection. */ 
signoff; 












