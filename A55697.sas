 /*-------------------------------------------------------------------*/
 /*       The Next Step: Integrating the Software Life Cycle          */
 /*                     with SAS Programming                          */
 /*                         by Paul Gill                              */
 /*     Copyright(c) 1997 by SAS Institute Inc., Cary, NC, USA        */
 /*                SAS Publications order # 55697                     */
 /*                       ISBN 1-58025-030-0                          */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS  Institute Inc.  There   */
 /* are no warranties, express or implied, as to merchantability or   */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /*    SAS Institute Inc.                                             */
 /*    Books by Users                                                 */
 /*    Attn: Paul Gill                                                */
 /*    SAS Campus Drive                                               */
 /*    Cary, NC   27513                                               */
 /*                                                                   */
 /* If you prefer, you can send e-mail to sasbbu@sas.com with         */
 /* "comment for Paul Gill" as the subject line.                      */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

This file contains example code that is used in Appendix 1, "Coding 
Samples," in the book, "The Next Step: Integrating the Software Life
Cycle with SAS(R) Programming" by Paul Gill.
     
*************************************************************************



**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 1 on p. 284.*** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:    MAKEFORM                                      *** ;
***                                                          *** ;
*** Type:      Utility                                       *** ;
***                                                          *** ;
*** Function: Automatically creates PROC FORMATS             *** ;
***                                                          *** ;
*** Usage:    You must pass in the following parameters:     *** ;
***                                                          *** ;
***           DATASET  which contains the name of the SAS    *** ;
***                    data set containing the table data.   *** ;
***                                                          *** ;
***           FORMNAME is the format name that you wish to   *** ;
***                    create in the PROC FORMAT statement.  *** ;
***                                                          *** ;
***           VALUE    is the variable name in the SAS data  *** ;
***                    set that contains the lookup values.  *** ;
***                                                          *** ;
***           DESCRIPT is the description that each value    *** ;
***                    maps to.                              *** ;
***                                                          *** ;
*** Example:   You have a data set named LOOKUP.ETHNIC       *** ;
***            that contains a mapping of race codes and     *** ;
***            their respective races. The value of ETHNICID *** ;
***            maps to ETHNICGR:                             *** ;
***                                                          *** ;
***            obs  ethnicid ethnicgr                        *** ;
***             1      4      Asian                          *** ;
***             2      7      White                          *** ;
***             3      9      Black                          *** ;
***                                                          *** ;
*** Assume that you want to create a format called "race".   *** ;
*** You would then call the macro as follows:                *** ;
***                                                          *** ;
*** %makeform ( dataset = lookup.ethnic ,                    *** ;
***             formname = race ,                            *** ;
***             value = ethnicid ,                           *** ;
***             descript = ethnicgr )                        *** ;
***                                                          *** ;
**************************************************************** ;

%macro makeform ( dataset = ,
                  formname =,
                  value = ,
                  descript = ) ;


**************************************************************** ;
*** Set up variables required by the CNTLIN option of PROC   *** ;
*** FORMAT. START contains the value, LABEL is the des-      *** ;
*** cription and FMTNAME is the format name you wish to      *** ;
*** assign.                                                  *** ;
**************************************************************** ;

    data control ( rename = 
      ( &value = start &descript = label )) ;
        set &dataset ;

    fmtname = "&formname" ;
    run ;
%mend makeform ;

**************************************************************** ;
*** Create the formats automatically                         *** ;
**************************************************************** ;

%makeform ( dataset = lookup.ethnic ,
            formname = race ,
            value = ethnicid ,
            descript = ethnicgr )

proc format cntlin = control ;
run ;







**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 2 on p. 285.*** ;
***                                                          *** ;
**************************************************************** ;



**************************************************************** ;
***                                                          *** ;
*** Source:    QADATA.SAS                                    *** ;
***                                                          *** ;
*** Type:      Utility                                       *** ;
***                                                          *** ;
*** Function: To ensure that data are transferred correctly  *** ;
***           from the in-house data base to the production  *** ;
***           SAS data sets.                                 *** ;
***                                                          *** ;
*** Logic:    Data from the data base are written out to a   *** ;
***           set of text files.  The name of the file       *** ;
***           should correspond to the name of the SAS       *** ;
***           data set. i.e. CONCOM.SSD and CONCOM.TXT.      *** ;
***           Then, the SAS data sets are read to gather     *** ;
***           information about their format. This allows    *** ;
***           you to write code that generates the proper    *** ;
***           input and length statements for reading the    *** ;
***           text file into a SAS data set. Then, the two   *** ;
***           sets of SAS data are compared with PROC        *** ;
***           COMPARE.  If the two data sets are equal,      *** ;
***           we can feel pretty confident that the trans-   *** ;
***           fer process is occurring correctly.            *** ;
***                                                          *** ;
*** Usage:    The two key variables are the pointers to the  *** ;
***           SAS data sets and the text file directory.     *** ;
***           These are set up in the macro %libchek.        *** ;
***                                                          *** ;
***            %libchek ( lib = permsas ,                    *** ;
***                       text_dir = c:\ascii ,              *** ;
***                       maxlrecl = 256 ,                   *** ;
***                       titlecnt = 3 )                     *** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
*** This format will be used to differentiate between char-  *** ;
*** acter and numeric variables.                             *** ;
**************************************************************** ;

proc format ;

value _vartype
    1 = ' '
    2 = '$'
    ;
run ;


%macro libchek ( lib = work ,      /* Input SAS data library */
                 text_dir = ,      /* Input text file library */
                 maxlrecl = 256 ,  /* Max length of text files */
                 titlecnt = 3 ) ;  /* Where to place title */
   
**************************************************************** ;
***                                                          *** ;
***                     V A R I A B L E S                    *** ;
***                                                          *** ;
**************************************************************** ;
%local i ;           * Loop counter ;
%local mem_list ;    * List of library members ;
%local mem_cnt ;     * Number of members in library ;
%local memname ;     * Library member name ;

%let lib = %upcase ( &lib ) ;

**************************************************************** ;
*** Get a list of all the library members and place it into  *** ;
*** a macro variable.  Also, get a count of the number of    *** ;
*** members in the library.                                  *** ;
**************************************************************** ;

proc sql noprint ;
    select memname into : mem_list separated by " "
    from dictionary.columns
    where libname = "&lib"
    ;
    %let mem_cnt = &sqlobs ;
quit ;

**************************************************************** ;
*** Pick off the current member name.  This allows us to     *** ;
*** find both the SAS data set and ASCII text file with that *** ;
*** name.                                                    *** ;
*** Continually call MEMCHEK which does the actual creating  *** ;
*** of the secondary SAS data set as well as  the file       *** ;
*** comparison.                                              *** ;
**************************************************************** ;

%do i = 1 %to &mem_cnt ;
    %let memname = %qscan ( &mem_list, &i ) ;
    %memchek ( sasdata = &lib..&memname,
               textfile = &text_dir\&memname..txt,
               lrecl = &maxlrecl
              )
%end ;

%mend libchek ;

**************************************************************** ;
*** MEMCHEK will read the first record of the text file to   *** ;
*** retrieve the SAS variable names.  Then a PROC CONTENTS   *** ;
*** will enable us to retrieve the variable attributes of    *** ;
*** the SAS variables.  This will provide the requisite      *** ;
*** information to create the appropriate length and input   *** ;
*** statements for the text file.                            *** ;
**************************************************************** ;

%macro memchek ( sasdata = _last_ , /* SAS input data set      */
                 textfile = ,       /* Comma separated direct. */ 
                 lrecl= ,           /* logical record length   */
                 titlecnt = 3 ) ;   /* Title loc for report    */
    
**************************************************************** ;
***                                                          *** ;
***                     V A R I A B L E S                    *** ;
***                                                          *** ;
**************************************************************** ;
%local i ;          * Loop counter ;
%local len_list ;   * Holds lengths of all variables ;
%local inp_list ;   * Holds list of input variables ;
%local fixlist  ;   * List of variables that must be fixed ;

%if %upcase ( &sasdata) = _LAST_ %then
    %let sasdata = &syslast ;

filename _in "&textfile" ;

**************************************************************** ;
*** Read just the first record of the text file. This con-   *** ;
*** tains the list of SAS variable names.                    *** ;
**************************************************************** ;

data _textvar ( keep = var seq ) ;

length var $ 8 ;
infile "&textfile" dsd missover obs = 1 ;
input var $ @ ;

do while ( var ^= " " ) ;
    seq + 1 ;
    output _textvar ;
    input var $ @ ;
end ;
run ;

proc contents data = &sasdata noprint
    out = _sas_var ( keep = name length type format ) ;
run ;

proc sql noprint ;

create table _specs as
    select name, length, type, format, seq
    from _textvar as csv, _sas_var as sas
    where upcase ( var ) = name
    order by seq
    ;

select name || put ( type, _vartype.) || put ( length, 4. )
    into : len_list separated by " "
    from _specs
    ;

select case
    when ( type = 1 and format = "DATETIME" ) then
        name || " :" || "MMDDYY8. "
    when ( type = 2 ) then
        name || ' $'
    else name
    end
    into : inp_list separated by ' '
    from _specs
    ;

%let fixlist = ;
select name || '=86400 * ' || name
    into : fixlist separated by ";"
    from _specs
    where format = "DATETIME"
    ;

quit ;

**************************************************************** ;
*** We now know how to input the fields from the ASCII file. *** ;
*** The length and input statements were established from    *** ;
*** previous steps.                                          *** ;
**************************************************************** ;

data _text ;
    infile "&textfile" dsd firstobs = 2 ;
    length &len_list ;
    input &inp_list ;
    &fixlist ;
run ;

**************************************************************** ;
*** Compare the original SAS data set with the one that was  *** ;
*** created from the text file.  If the transfer was ok,     *** ;
*** then the procedure should report no differences.         *** ;
**************************************************************** ;

title&titlecnt "Summary comparison for &sasdata and &textfile" ;

proc compare base = &sasdata compare = _text
   criterion = .00001 brief;
run ;

**************************************************************** ;
*** Clean up the environment.                                *** ;
**************************************************************** ;

proc datasets lib = work ;
    delete _textvar _sas_var _specs _text ;
quit ;

filename _in clear ;

%mend memchek ;








**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 3 on p. 289.*** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***                                                          *** ;
*** Source:    DATAFREQ.SAS                                  *** ;
***                                                          *** ;
*** Type:      Utility                                       *** ;
***                                                          *** ;
*** Function:  Creates a listing of all values for all       *** ;
***            data sets in this library.                    *** ;
***                                                          *** ;
*** Data sets: Uses all data sets in library.                *** ;
***                                                          *** ;
*** Usage:     Set the macro variable &DROPVARS to those     *** ;
***            variables that you want to drop from the      *** ;
***            PROC FREQ.  This list globally drops these    *** ;
***            variables from all the work data sets. If the *** ;
***            variable is not found in a data set, a Warn-  *** ;
***            ing is issued by SAS, but the step continues  *** ;
***            to execute.                                   *** ;
***                                                          *** ;
***            %let dropvars = date_cre date_end ;           *** ;
***                                                          *** ;
***            If you prefer not to drop any variables,      *** ;
***            set the macro variable to null:               *** ;
***                                                          *** ;
***            %let dropvars = ;                             *** ;
***                                                          *** ;
***            Also, set the library with &LIB.              *** ;
***                                                          *** ;
**************************************************************** ;

%let lib = MAPS ;

**************************************************************** ;
*** DROPVARS is a macro variable that lists all the vari-    *** ;
*** ables you do not want to run a PROC FREQ on.  These      *** ;
*** variables are dropped from their respective data sets.   *** ;
**************************************************************** ;

%let dropvars = ;

**************************************************************** ;
*** Set up a scratch file.                                   *** ;
**************************************************************** ;

filename instruct "c:\instruct.dat" ;

**************************************************************** ;
*** Get a list of all the library members in this directory. *** ;
**************************************************************** ;

proc contents data = &lib.._all_
     short noprint out = contents ;
run ;

**************************************************************** ;
*** We do not need the variables in each SAS data set.  We   *** ;
*** just want a list of the library members.                 *** ;
**************************************************************** ;

proc sort data = contents nodupkey
    out = final ( keep = memname )  ;
    by memname ;
run ;

**************************************************************** ;
*** This step loops through the list of library members,     *** ;
*** creates a temporary SAS data set, drops any variables    *** ;
*** specified by &DROPVARS, and runs a PROC FREQ for all     *** ;
*** remaining variables in that data set.                    *** ;
**************************************************************** ;

data _null_ ;
    set final ;

**************************************************************** ;
*** Write instructions out to a file that are %INCLUDED      *** ;
*** later.                                                   *** ;
**************************************************************** ;

file instruct ;

put "proc freq data = &lib.." memname "(drop = &dropvars) ;" ;
put "title1 " "Raw data dump for &lib.." memname " ;" ;
put "tables _all_  ;" ;
put "run ;" ;

run ;

**************************************************************** ;
*** Now execute the SAS instructions set up in the previous  *** ;
*** step.                                               *** ;
**************************************************************** ;

%include instruct ;







**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 4 on p. 291.*** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***                                                          *** ;
*** Source:    STUDYRUN.SAS                                  *** ;
***                                                          *** ;
*** Type:      Utility                                       *** ;
***                                                          *** ;
*** Function:  Runs all source modules in a given directory. *** ;
***                                                          *** ;
*** Usage:     Set the following macro variables:            *** ;
***                                                          *** ;
***            DIR_LIST is the filename of directory list    *** ;
***            SAS_CODE is scratch area for instructions     *** ;
***            SAS_DIR is directory that contains source.    *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
*** Scratch files                                            *** ;
**************************************************************** ;

%let dir_list = c:\mysas\dir_list.dat ;
%let sas_code = c:\mysas\sas_code.sas ;
%let sas_dir  = c:\mysas ;

**************************************************************** ;
*** Filename references for scratch files.                   *** ;
**************************************************************** ;

filename dir_list  "&dir_list" ;
filename sas_code  "&sas_code" ;

**************************************************************** ;
*** We do not want user to have to interact with DOS.        *** ;
**************************************************************** ;

options noxwait ;

**************************************************************** ;
*** Erase old copies of output file, easier for debugging!   *** ;
**************************************************************** ;

x  "erase &dir_list" ;
x  "erase &sas_code" ;

**************************************************************** ;
*** Get a listing of all the SAS source code files.          *** ;
**************************************************************** ;

x "dir/b &sas_dir\*.sas | sort > &dir_list" ;

x "type &dir_list" ;

data _null_ ;
    infile "&dir_list" truncover ;

length the_file $12 ;  * Scratch file ;
input the_file $ ;     * Work area for file entries ;

**************************************************************** ;
*** Write entries back out to temp file.                     *** ;
**************************************************************** ;

file "&sas_code" ;

put "%include "  "'" "&sas_dir\" the_file "'"  " ; " ;

run ;

**************************************************************** ;
***  Code to execute the source files one at a time.         *** ;
**************************************************************** ;

%include sas_code ;





**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 5 on p. 292.*** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:   PARSER.SAS                                     *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: Parsing routine.  Sometimes because of space   *** ;
***           limitations, it is necessary to split a var-   *** ;
***           iable (parse it) over two or more observations.*** ;  
***           This routine will only update a SAS data set   *** ; 
***           by adding an observation whenever needed to    *** ;  
***           accommodate the parsed variable.               *** ;
***                                                          *** ;
*** Usage:    Set up the following:                          *** ;
***                                                          *** ;
***           &VARS is the variable(s) to be parsed.         *** ;
***                                                          *** ;
***           &IN_DATA is data set that contains the parsed  *** ;
***           variable(s).                                   *** ;
***                                                          *** ;
***           &LEN_MAX is the maximum number of characters   *** ;
***           that you wish to allow for the variable per    *** ;
***           output line on the report.  For example, if    *** ;
***           you set &LEN_MAX to 20 and your variable       *** ;
***           contains 63 characters, your output will       *** ;
***           probably be parsed to 4 lines.  I say          *** ; 
***           probably because the parser will never allow a *** ;
***           variable to be split in the middle of a word,  *** ;
***           so it is possible that the parsed word may     *** ;
***           occupy more lines than anticipated.            *** ;
***                                                          *** ;
***           &KEEPVARS are any variables that you wish to   *** ;
***           keep on continuation lines besides the parsed  *** ; 
***           variables.  If you only want the parsed var-   *** ; 
***           iables, then set &KEEPVARS to null.            *** ;
***                                                          *** ;
***           &SPACES is the number of spaces you want to    *** ; 
***           indent for each line after the first one.      *** ; 
***           This is usually preferred since cosmetically   *** ; 
***           it is easier to read the output.  You can      *** ; 
***           specify 0 if you do not want any indention.    *** ; 
***           My personal preference is 2. Remember, that if *** ; 
***           you decide you want indention for subsequent   *** ; 
***           lines, you must specify the $CHAR format for   *** ; 
***           the parsed variable in the output report.      *** ;
***                                                          *** ;
***           Example: (for parsing one variable)            *** ;
***                                                          *** ;
***           %let vars = crf_term ;                         *** ;
***           %let in_data = adverse ;                       *** ;
***           %let len_max = 45 ;                            *** ;
***           %let spaces = 2 ;                              *** ;
***           %let keepvars = body_sys organ ;               *** ;
***           %include parser ;                              *** ;
***                                                          *** ;
***           Example: (for parsing several variables)       *** ;
***                                                          *** ;
***           Make sure that for multiple variables that you *** ;
***           specify a length (&LEN_MAX) and indention      *** ;
***           (&SPACES) for EACH variable that you parse:    *** ;
***                                                          *** ;
***           %let vars = histolog cause_of body_sys         *** ;
***           %let in_data = pat_info ;                      *** ;
***           %let len_max = 30 45 25 ;                      *** ;
***           %let spaces =   2  0  2 ;                      *** ;
***           %let keepvars = pat_num ;                      *** ;
***           %include parser ;                              *** ;
***                                                          *** ;
***           Note:                                          *** ;
***           Two variables will be added to your data set.  *** ; 
***           One is _LINEPOS which stands for "line         *** ;
***           position".  This may be useful to allow a more *** ; 
***           cosmetic formatting of the output.  For        *** ;
***           example, you may want to only print the        *** ;
***           continued parsed out variable on the contin-   *** ; 
***           uation lines, not the rest of the detail       *** ;
***           record.  Let us say, you have a report in      *** ;
***           which you want to print the patient number     *** ;
***           (PAT_NUM), the body system (BODY_SYS) and      *** ;
***           costart term (COSTART).  The body system       *** ;
***           term (BODY_SYS) is the variable that is to be  *** ; 
***           parsed. After calling the parser routine as    *** ;
***           specified above, you would include the follow- *** ;
***           ing code in your DATA _NULL_. This code would  *** ;
***           cause all report variables to print on the     *** ;
***           first line, but only the parsed out variable   *** ; 
***           on subsequent lines.                           *** ;
***           The other variable is _SEQ_NUM.  This identi-  *** ;
***           fies the observation number from the original  *** ;
***           data set. Thus, if the first record is parsed  *** ;
***           into three records, the _SEQ_NUM will be "1"   *** ;
***           for all three records and the _LINEPOS will be *** ;
***           "1", "2" and "3" respectively for the three    *** ;
***           records.                                       *** ;
***                                                          *** ;
***           if _linepos = 1 then                           *** ;
***               put @010 pat_num                           *** ;
***                   @030 body_sys $char.                   *** ;
***                   @50  costart                           *** ;
***                   ;                                      *** ;
***           else                                           *** ;
***               put @030 body_sys $char. ;                 *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
*** Add a variable to the original data set which is the     *** ;
*** sequence number for each record.  This will ensure that  *** ; 
*** the data is merged back properly.                        *** ;
**************************************************************** ;

data  &in_data _final ;
    set &in_data ;

retain _seq_num 0 ;

_linepos = 1 ;

_seq_num + 1 ;

output ;

run ;

**************************************************************** ;
*** Point to the first variable in the &vars list.  Also,    *** ;
*** pick up the length and indention specified by the user.  *** ;
**************************************************************** ;

%let count = 1 ;

%let var_name = %scan ( &vars, &count ) ;
%let max_len =  %scan ( &len_max, &count ) ;
%let indent =   %scan ( &spaces, &count ) ;

**************************************************************** ;
***          B E G I N N I N G   O F   M A C R O             *** ;
**************************************************************** ;

%macro parse ;

%do %until ( &_abort = "YES" or &var_name = ) ;

**************************************************************** ;
*** Create a scratch data set which keeps just the parsed    *** ;
*** variable, the total lines occupied by the parsed var-    *** ;
*** iable, and the variables used to sort the data set.      *** ;
**************************************************************** ;

data _scratch ( keep = &var_name _linepos _seq_num &keepvars ) ;
    set &in_data ;

**************************************************************** ;
***                                                          *** ;
***                       V A R I A B L E S                  *** ;
***                                                          *** ;
**************************************************************** ;
length _avail    8    ;  * Available space on line.              ;
length _indent   8    ;  * Indention for lines 2 and greater     ;
length _linenum  8    ;  * Line number(record)                   ;
length _linepos  8    ;  * Line position (record)                ;
length _old_len  8    ;  * Length of old word                    ;
length _new_len  8    ;  * Length of new word                    ;
length _textout  $200 ;  * Text to be written out to file        ;
length _word     $200 ;  * Field to be parsed into words         ;
length _wordcnt  8    ;  * Which word am I parsing in variable?  ;

**************************************************************** ;

**************************************************************** ;
*** The repeat function always gives one more space than the *** ; 
*** user specified, so we want to correct this.              *** ;
**************************************************************** ;

_indent = &indent - 1 ;

**************************************************************** ;
*** Start at first line and first word.                      *** ;
**************************************************************** ;

_linenum = 1 ;
_wordcnt = 1 ;

**************************************************************** ;
*** Save parsed variable in hold area.                       *** ;
**************************************************************** ;

_string = &var_name ;


**************************************************************** ;
*** Continually parse out one word at a time from the string.*** ;
*** If a word is greater than the available space on the     *** ;
*** line, and can not be parsed then set up abort variables. *** ;
**************************************************************** ;

_linepos = 0 ;

do until ( _word = " " ) ;
    _word = scan ( _string, _wordcnt, " " ) ;
    _len = length ( trim ( _word )) ;
    if _linepos = 0 then
        _avail = &max_len - 1 ;
    else
        _avail = &max_len - &indent - 1 ;
    if length ( trim ( _word )) gt _avail then
    do ;
        call symput ( '_abort', 'YES' ) ;
        call symput ( '_reason', 'PARSER' ) ;
        call symput ( '_string', _string ) ;
        call symput ( '_word', _word ) ;
        call symput ( '_len', _len ) ;
        call symput ( '_max_len', &max_len ) ;
        call symput ( '_indent', &indent ) ;
        call symput ( '_varname', "&var_name" ) ;
        stop ;
    end ;

**************************************************************** ;
*** If this is the last word and more than one word is pro-  *** ; 
*** cessed and this is not first line for this parsed text,  *** ; 
*** then blank out all variables on the next line except the *** ; 
*** parsed word, which is kept and indented the amount       *** ;
*** requested by the user.                                   *** ;
**************************************************************** ;

    if _word = " " and _wordcnt gt 1 then
    do ;
        if _linenum gt 1 then
        do ;
            if _indent ge 0 then
                _textout = repeat ( " ", _indent ) || trim
                  (_textout) ;
            else
                _textout = trim ( _textout ) ;
        end ;
        &var_name = trim ( _textout ) ;
        _linepos + 1 ;
        output ;
        _linenum + 1 ;
        file log ;
        put _linepos= _linenum= ;
    end ;
    if _wordcnt = 1 then
        _textout = _word ;


**************************************************************** ;
*** Here we add up the length of the current string so far   *** ; 
*** and the current word.  If the total of these two is      *** ;
*** greater than the maximum length allowed for the line     *** ; 
*** (specified by &MAX_LEN), then we need to output the      *** ;
*** record and start building a string on the next line.     *** ;
**************************************************************** ;

    if _word ne " " and _wordcnt gt 1 then
    do ;
        _old_len = length ( trim ( left ( _textout ))) ;
        _new_len = length ( trim ( left ( _word ))) ;
        if _old_len + _new_len gt ( &max_len - &INDENT -1 ) then
        do ;
            if _linenum gt 1 then
            do ;
                if _indent ge 0 then
                    _textout = repeat ( " ", _indent ) || 
                      trim (  _textout ) ;
                else
                    _textout = trim ( _textout ) ;
            end ;


**************************************************************** ;
*** Here we output the record and start building the string  *** ; 
*** for the next line.                                       *** ;
**************************************************************** ;

            &var_name = trim ( _textout ) ;
            _linepos + 1 ;
            output ;
            _linenum + 1 ;
            _textout = _word ;
            put _linepos= _linenum= ;
        end ;

        if _old_len + _new_len le ( &max_len - &indent - 1 ) then
            _textout = trim ( _textout) || R R || trim ( _word ) ;
    end ;

**************************************************************** ;
*** Increase word count, so we can parse out the next word.  *** ;
**************************************************************** ;

    _wordcnt + 1 ;

end ;

return ;


**************************************************************** ;
***  This step will continually add the parsed variables to  *** ; 
***  the master SAS data set.                                *** ; 
**************************************************************** ;

data _final ;
    update _final
           _scratch
           ;
    by _seq_num _linepos ;
run ;

**************************************************************** ;
*** Update the count so that we can pick off the next var-   *** ; 
*** iable to be parsed and its maximum length and indention. *** ; 
**************************************************************** ;

%let count =    %eval ( &count + 1 ) ;
%let var_name = %scan ( &vars, &count ) ;
%let max_len =  %scan ( &len_max, &count ) ;
%let indent =   %scan ( &spaces, &count ) ;

%end ;

**************************************************************** ;
*** Replace the original data set with the final data set.   *** ;
**************************************************************** ;

data &in_data ;
    set _final ;
run ;

**************************************************************** ;
*** Clean up.                                                *** ;
**************************************************************** ;

proc datasets ;
    delete _scratch _final ;
run ;

%mend parse ;

**************************************************************** ;
***              E N D   O F   M A C R O (parse)             *** ;
**************************************************************** ;

**************************************************************** ;
*** This macro is the main driver routine for parsing the    *** ;
*** variables in the SAS data set.                           *** ;
**************************************************************** ;

%parse  



**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 6 on p. 302.*** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:    PREVIEW.SAS                                   *** ;
***                                                          *** ;
*** Type:      Source module                                 *** ;
***                                                          *** ;
*** Function:  To allow the user the opportunity to first    *** ;
***            preview the maximum lengths of formatted var- *** ;
***            iables and maximum word sizes before using    *** ;
***            the parser routine.                           *** ;
***                                                          *** ;
*** Usage:     Specify &IN_DATA, which is your input data set*** ; 
***            DELIM which is the delimiters other than      *** ;
***            blank that are acceptable for causing a word  *** ; 
***            break to the next line.  For example:         *** ;
***                                                          *** ;
***            %let in_data = sasdata.concom ;               *** ;
***            %let delim = / ;                              *** ;
***            %include preview ;                            *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***         F I L E N A M E    D E F I N I T I O N S         *** ;
**************************************************************** ;

filename find_max "find_max.sas" ;  * Find max var lengths       ;
filename set_attr "set_attr.sas" ;  * Set variable attributes    ;

%let lib = WORK ;
%let member = SUNNY ;
%let delim = / ;

**************************************************************** ;
*** List out the member names of the data set.  Place the    *** ;
*** list of names into a macro variable and also into a data *** ;
*** set.                                                     *** ; 
**************************************************************** ;

proc sql noprint ;
    create table contents as
        select name, type, format 
        from dictionary.columns
        where libname = "&lib" and memname = "&member" ;
    select name into : _thelist separated by " "
    from dictionary.columns
    where libname = "&lib" and memname = "&member" ;
    %let mem_cnt = &sqlobs ;
quit ;


**************************************************************** ;
*** Source:    PUT_LEN                                       *** ;
*** Type:      macro                                         *** ;
*** Function:  Will write out variable lengths.              *** ;
**************************************************************** ;

%macro put_len ;
    %do  i = 1 %to &varcount ;
        _origvar = "%scan ( &_thelist, &i )" ;
        put  ;
        put "length  "  "_v&i._var" " $ " _v&i._len " ; " ;
        put "label   "  "_v&i._var" " = " _origvar  " ; " ;
        put "format  "  "_v&i._var "  _v&i._max +(-1) "." " ; " ;
    %end ;
%mend put_len ;

**************************************************************** ;
*** Source:    MAX_SIZE.SAS                                  *** ;
*** Type:      macro                                         *** ;
*** Function:  Will spin through all the SAS data sets and   *** ;
***            find the largest formatted value for each     *** ;
***            variable.                                     *** ;
**************************************************************** ;

%macro max_size ;

**************************************************************** ;
*** Write out code on the fly to determine the maximum size  *** ;
*** formatted size of each variable.                         *** ;
**************************************************************** ;

    data _null_ ;
        set contents end = last_one  ;

    file find_max ;

**************************************************************** ;
*** You only want to write out one time the important infor- *** ;
*** mation for doing the calculations in the included file.  *** ;
**************************************************************** ;

    if _n_ = 1 then
    do ;
        put "data _str_len ; " ;
        put "set &lib..&member end = last_one ; " ;
        put / "length _workvar $200 ; " ;
        put   "length _origvar $8 ; " ;
        put   "length _chunk $200 ; " ;
        put   "length _delim $50 ; " ;
        put   "retain ; " ;
        put   '_delim = "&delim" ; ' ;
    end ;

    retain _count 0 ;
    length _var $8 ;
    length char_cnt $8 ;


    if format = '$' then
        format = " " ;

    _count + 1 ;
    char_cnt = _count ;
    _var = "_v" ||  trim ( left ( char_cnt )) || "_len" ;

    put / ;

    if format ne " " then
    do ;
        put "_len = length ( trim ( left  ( put
         ( "  name " , " format " )))) ; " ;
        put "_workvar = trim ( left  ( put
         ( "  name " , " format " ))) ; " ;
    end ;
    else
    do ;
        put "_len = length ( trim  ( left (  "  name " ))) ; " ;
        put "_workvar = trim  ( left (  "  name " )) ; " ;
    end ;

    put _var " = max (  _len , " _var " ) ; " ;

    str = "_v" ||  trim ( left ( char_cnt )) || "_max" ;

    put " " ;
    put "_partcnt = 1 ; " ;
    put "_maxpart = 0 ; " ;
    put "do until ( _chunk = ' ' ) ; " ;
    put "    _chunk = scan ( _workvar  , _partcnt, _delim ) ; " ;
    put "    _partlen = length ( trim ( left ( _chunk ))) ; " ;
    put "    _maxpart = max ( _maxpart, _partlen ) ; " ;
    put "    _partcnt + 1 ; " ;
    put "end ; " ;
    put str " = max ( " str ", _maxpart ) ; " ;

    call symput ('varcount', _count ) ;

    if last_one then
    do ;
        put / "if last_one then " ;
        put "do ; " ;
        put "    file set_attr ; " ;
        put "    %" "put_len ;" ;
        put "    title1 Maximum word/variable lengths for
           &lib..&member ;" ;
        put "end ; " ;
        put / "run ; " ;
    end ;

    run ;


**************************************************************** ;
*** Include code that finds the maximum length of each var-  *** ;
*** iable.                                                   *** ;
**************************************************************** ;

    %include find_max ;

    data _str_len ;

**************************************************************** ;
*** Set the variables attributes here.                       *** ;
**************************************************************** ;

    %include set_attr ;

    run ;

**************************************************************** ;
*** Get a list of variables in the final data set that con-  *** ;
*** tains the maximum lengths for all variables.             *** ;
**************************************************************** ;

    proc contents data = _str_len noprint out = _str_len ;
    run ;

**************************************************************** ;
*** Print the variables and their maximum lengths.           *** ;
**************************************************************** ;

    proc print label data = _str_len split = "*" ;
        var label length formatl ;
        where upcase ( substr ( left (  name ) , 1, 2 )) = "_V" ;
        label label   = "Variable*Name"
              length  = "Maximum Length*of Entire Field"
              formatl = "Maximum*Word*Length" ;
    run ;

%mend max_size ;

**************************************************************** ;
***                 E n d   of   m a c r o (MAX_SIZE)        *** ;
**************************************************************** ;


**************************************************************** ;
*** This is the main driver routine that will determine the  *** ;
*** maximum formatted length of the variables.               *** ;
**************************************************************** ;

%max_size 





**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 7 on p. 306.*** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:   INIT.SAS                                       *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: This module sets up the study environment.     *** ;
***           All global definitions for each study should   *** ;
***           be placed in this module.  In addition, any    *** ;
***           initialization programs should also be run     *** ;
***           here.  This module should be included at the   *** ;
***           beginning of each program.                     *** ;
***                                                          *** ;
*** Usage:    Please read the documentation carefully and    *** ;
***           you should be able to modify this INIT file    *** ;
***           for any study.  Note:  Whenever setting up a   *** ; 
***           list using a macro variable, use a space as    *** ;
***           a delimiter.                                   *** ;
***                                                          *** ;
***          %let conc = 100 300 600 900 ;                   *** ;
***                                                          *** ; 
**************************************************************** ;


options nocenter ;      * Maximizes display, avoids scrolling ; 
options ls = 90 ;       * Your terminal width, avoids scrolling ;
options missing = "." ; * To change SAS default in one place ;
options source2 ;       * %INCLUDE used often, aids in debugging ;
options nocaps ;        * Can always UPCASE if need to ;
options nodate ;        * Prefer own data formatting ;
options fmterr ;        * Must be alerted to format error ;
options nonumber ;      * Use your own page numbering schemes ;
options noreplace ;     * Don't accidentally overwrite data ;
options obs = max ;     * Often changed when debugging ;
options pagesize = 86 ; * Perfect for portrait mode ;
options source ;        * Useful for debugging ;
options symbolgen ;     * Best macro debugger known on earth ;
title1 ;                * Write your own title positioning rtn. ;
footnote ;              * Write your own footnote pos. rtn. ;


%let _abort = NO ;      * If need to abort, set this to YES ;
%let _reason =   ;      * Reason for aborting program.      ;
%let misschar = '.' ;   * What to print for missing char values;

%let drive = g ;

%let code_loc = &drive:\medstudy\source ;
%let study = Diabetes ;
%let phase = Phase IV ;
%let all_conc = 10 20 40 60 80 120 220 ;

**************************************************************** ;
***                                                          *** ;
*** These variables control the routing of output.           *** ;
***                                                          *** ;
*** &redirect determines where you want to direct the output *** ;
*** of your log files and report output.  The options are:   *** ;
***                                                          *** ;
*** TERMINAL  which is the default and routes your output    *** ;
***           to the terminal.                               *** ;
***                                                          *** ;
*** PRINTER   sends your output to a local printer as        *** ;
***           specified in the filename LOCALPRT.            *** ;
***                                                          *** ;
*** STUDYDIR  routes your output to the files specified      *** ;
***           in the RPTOUT and LOGOUT variables.            *** ;
***                                                          *** ;
*** &RPTOUT   specifies the directory where you want to      *** ;
***           route your report output. (You must specify    *** ;
***           REDIRECT = STUDYDIR)                           *** ;
***                                                          *** ;
*** &LOGOUT   specifies the directory where you want to      *** ;
***           route your log output. (You must specify       *** ;
***           REDIRECT = STUDYDIR)                           *** ;
***                                                          *** ;
*** &PRINT    Is an option on the file statement.  You do    *** ;
***           not need to set this.  The program auto-       *** ;
***           matically changes this on the fly to redirect  *** ;
***           your output.                                   *** ;
***                                                          *** ;
*** &STUDYRUN is a flag to determine if this is a batch      *** ;
***           study run.  You do not need to change this.    *** ;
***           If you are running the utility program         *** ;
***           STUDYRUN.SAS, this variable is automatically   *** ;
***           changed to YES at the appropriate time.        *** ;
***                                                          *** ;
*** &RESET    resets the printer to normal mode for the HP   *** ;
***           LASER JET 4SI. This should not be changed      *** ;
***           unless you change printers.                    *** ;
***                                                          *** ;
*** &LANDCODE Sets escape sequence characters to force the   *** ;
***           printer to print in landscape mode.  You       *** ;
***           should not change this unless you change       *** ;
***           printers.                                      *** ;
***                                                          *** ;
**************************************************************** ;

%let datadump = &drive:\medstudy\datadump ;
%let landcode = '1B266C314F'x ;
%let logout   = &drive:\medstudy\log ;
%let orient = portrait ;
%let print = print ;
%let redirect = TERMINAL ;
%let rptout   = &drive:\medstudy\reports ;
%let reset    = '1B45'x ;
%let studyrun = NO ;
%let sysfoot = 0 ;

libname sasdata  "&drive:\medstudy\&study\data" ;
libname origdata "&drive:\medstudy\&study\origdata\sasdata" ;
libname lookup   "&drive:\medstudy\&study\origdata\lookup" ;
* ... and so on.;

%let inc_loc = includes ;  * Location of include files ;
filename abortit    "&drive:\medstudy\&inc_loc\abortit.sas" ;
filename cleanup    "&drive:\medstudy\&inc_loc\cleanup.sas" ;
* ... and so on.;

%let bot_mar =   82 ;           * Bottom Print margin           ;
%let left_mar =  16 ;           * Left Print Margin             ;
%let linesize = 133 ;           * linesize for page width       ;
%let rite_mar = 121 ;           * Right Print margin            ;
%let page_wid = 133 ;           * Page width for printed output ;
%let top_mar =   05 ;           * Top print margin              ;

%include rename ;  
%include formats ;

**************************************************************** ;
*** This macro is useful to change the print destination     *** ;
*** without having to change the REDIRECT variable in this   *** ;
*** module. Thus, the OVERRIDE macro variable can be set to  *** ;
*** YES in another program to temporarily change the value   *** ;
*** the REDIRECT variable.  REDIRECT will be reset to its    *** ;
*** default value after the other program finishes executing.*** ;
*** Note: OVERRIDE is initially set outside of INIT.SAS      *** ;
**************************************************************** ;

%macro override ;
    %if &override = YES %then
        %let redirect = STUDYDIR ;
%mend override ;

**************************************************************** ;
*** Change the print destination if the user changed the     *** ;
*** override macro variable = "YES".                         *** ;
**************************************************************** ;

%override  






**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 8 on p. 309.*** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
*** Project:   Insurance                                     *** ;
*** Source:    FINDINIT.SAS (Find proper init file)          *** ;
*** Type:      Source module                                 *** ;
*** Function:  To load the appropriate initialization file   *** ;
***            based on the user selection.                  *** ;
**************************************************************** ;

data _null_ ;

retain ;

**************************************************************** ;
***                  V A R I A B L E S                       *** ;
**************************************************************** ;

length choice   $  1 ;    * User selection ;
length err_msg  $ 60 ;    * Error message ;
length prom_msg $ 60 ;    * Prompt message ;

retain col_01     20 ;    * Field location ;
retain col_02     30 ;    * Field location ;
retain left_mar    3 ;    * Left margin ;
retain prom_msg "Please select 1-4 or 5 to quit" ;

%let tit_col  = red ;     * Title color ;
%let text_col = blue ;    * Text color ;
%let err_col = pink ;     * Error color ;
%let inp_col = green ;    * Input field color ;
%let bot_col = red ;      * Bottom of screen color ;
%let prom_col = blue ;    * Prompt message color ;

bot_line = repeat ( "=", 60 ) ;
choice = " " ;

**************************************************************** ;
*** Create the selection window.                             *** ;
**************************************************************** ;

window start_up

#1  @col_01   "_________________________________" color = &tit_col
#2  @col_01   "|                               |" color = &tit_col
#3  @col_01   "|     Select Insurance type     |" color = &tit_col
#4  @col_01   "|_______________________________|" color = &tit_col

#6  @col_02   " 1.  Auto"   color = &text_col
#7  @col_02   " 2.  Life"   color = &text_col
#8  @col_02   " 3.  Home"   color = &text_col
#9  @col_02   " 4.  Health" color = &text_col
#10 @col_02   " 5.  Quit"   color = &text_col

#12 @left_mar bot_line color = &bot_col protect = yes
#13 @left_mar bot_line color = &bot_col protect = yes

#16 @left_mar "Selection" @col_01 choice $1. color = &inp_col
#18 @left_mar prom_msg protect= yes  persist= yes 
  color = &prom_col
#19 err_msg  protect= yes  persist= yes 
  color = &err_col ;

display start_up ;

**************************************************************** ;
*** Include the appropriate startup file based on selection. *** ;
**************************************************************** ;

if choice ge 1 and choice le 5 then
do ;
    if choice = 1 then
        call execute ( "%include 'c:\insure\auto.sas' ; " ) ;
    if choice = 2 then
        call execute ( "%include 'c:\insure\life.sas' ; " ) ;
    if choice = 3 then
        call execute ( "%include 'c:\insure\home.sas' ; " ) ;
    if choice = 4 then
        call execute ( "%include 'c:\insure\health.sas' ; " ) ;
    stop ;
end ;
else
    err_msg = choice || " is an invalid selection. Try again." ;

run ;





**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 9 on p. 310.*** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***                                                          *** ;
*** Source:    TITLES.SAS                                    *** ;
***                                                          *** ;
*** Type:      External flat file                            *** ;
***                                                          *** ;
*** Function:  Contains titles and footnotes for all medical *** ;
***            summary programs                              *** ;
***                                                          *** ;
*** Usage:     You create this file by writing titles and    *** ;
***            footnotes for an entire study in this file.   *** ;
***            There are 3 types of titles and footnotes and *** ;
***            they must appear in this order:               *** ;
***            (1) Study wide titles                         *** ;
***            (2) Report specific titles and footnotes      *** ;
***            (3) Study wide footnotes                      *** ;
***                                                          *** ;
***            The first entry in this file is the studywide *** ;
***            titles.  Directly under this entry, enter     *** ;
***            zero, one or as many titles that you wish.    *** ;
***            These titles will appear at the top of your   *** ; 
***            report before any report specific titles.     *** ;
***            Next enter a line that contains the           *** ;
***            "stopsign" for processing this code.  The     *** ;
***            stopsign symbol is set up in the include      *** ;
***            module HEADFOOT.SAS if you wish to change it. *** ;
***            This symbol tells the SAS program to end      *** ;
***            processing of this component and start        *** ;
***            processing the next one.                      *** ;
***            The next set of entries (and the bulk of this *** ;
***            file) contains report specific titles and     *** ;
***            footnotes. First enter the SAS program name   *** ; 
***            followed by the word titles and the report    *** ;
***            number.  The report number should start at    *** ; 
***            one and be incremented by 1 for each add-     *** ;
***            itional report.  In the SAS program itself    *** ;
***            (that generates the medical summary), you     *** ;
***            must set a macro variable RPT_CNT = 1 ; to    *** ; 
***            to process the first report, RPT_CNT = 2 ; to *** ;
***            process the second report etc. Finally, enter *** ; 
***            the stopsign symbol as noted above. The logic *** ;
***            for footnotes is the same as for the titles.  *** ;
***                                                          *** ;
***            The last entry at the bottom of the file is   *** ;
***            the study wide footnotes. These will appear   *** ; 
***            at the bottom of the report page, following   *** ; 
***            the report specific footnotes.  You do not    *** ;
***            have to worry about their location, page      *** ;
***            breaks etc. This is all taken care of in the  *** ;
***            SAS include modules headfoot, header, footer  *** ; 
***            and in the beginning of the DATA NULL step    *** ; 
***            that makes reference to the LINE_CNT.         *** ;
***                                                          *** ;
***            NOTE: You should include a titles and foot-   *** ; 
***            notes entry for every program, even if it is  *** ;
***            blank. You will note that many of the pro-    *** ;
***            grams in this file have no footnotes. The     *** ;
***            blank spaces between entries is not required, *** ;
***            they are there for readability.               *** ;
***                                                          *** ;
***            Footnotes are by default centered.  However,  *** ;
***            if you wish footnotes to be centered, but     *** ;
***            all left justified underneath one another,    *** ;
***            enclose the footnotes in double quotes. This  *** ;
***            may be useful if you are listing items such   *** ; 
***            as Lab locations.                             *** ;
***            If you want to left justify your footnotes to *** ; 
***            the left margin, then precede the footnote    *** ;
***            with #L and begin the actual footnote in      *** ;
***            column 4.                                     *** ;
***                                                          *** ;
**************************************************************** ;

- - - - - - - - - - Study Wide Titles - - - - - - - - - - - - - 
STUDYWIDE TITLES
#L Diabetes Trial 3CM
++++

- - - - - - - - Report Specific Titles/Footnotes - - - - - - - - 


AE_DATA.SAS TITLES 1
#L Data Listing 8
Patients Adverse Events
(All Patients)
PAGE HOLDER
++++
AE_DATA.SAS FOOTNOTES 1
#L 1 All terms mapped to preferred terms of Costart version 4.
++++


AE_ARA.SAS TITLES 1
#L Safety Summary Table 31
Number of Adverse Events by Relationship to Study Drug
(All Patients in Lymphoma and Leukemia Arms)
PAGE HOLDER
++++
AE_ARA.SAS FOOTNOTES 1
#L "Note:  All data are listed in data listing 8."
#L "       Includes only new events or changes in severity"
++++


AE_ARA.SAS TITLES 2
#L Safety Summary Table 31
Number of Adverse Events by Relationship to Study Drug
(All Patients in Lymphoma and Leukemia Arms)
PAGE HOLDER
++++
AE_ARA.SAS FOOTNOTES 2
#L "Note:  All data are listed in data listing 8. 
++++


AE_DRUG.SAS TITLES 1
#L Safety Summary Table 29
Number of Adverse Events by Relationship to Study Drug
(All Patients Receiving Study Drug)
PAGE HOLDER
++++
AE_DRUG.SAS FOOTNOTES 1
#L "Note:  All data are listed in data listing 11"
++++


- - - - - - - - - - Study Wide Footnotes - - - - - - - - - - - -
STUDYWIDE FOOTNOTES

#L Company Confidential
++++



**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 10          *** ;
*** on p. 313.                                               *** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Project:   Home Based Business                           *** ;
***                                                          *** ;
*** Source:    MONEY.SAS                                     *** ;
***                                                          *** ;
*** Type:      Source module                                 *** ;
***                                                          *** ;
*** Function:  To create a report that shows how much money  *** ;
***            is made by selling magazine subscriptions     *** ;
***            over the telephone.                           *** ;
***                                                          *** ;
*** Data sets: sasdata.mags                                  *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
*** Call routine that initializes project environment.       *** ;
**************************************************************** ;

%let filename = money.sas ;
%include "c:\home\includes\init.sas" ;      


**************************************************************** ;
*** Sort the data for report ordering.                       *** ;
**************************************************************** ;

proc sort data = sasdata.mags out = mags ;
    by cust_num ;
run ;

**************************************************************** ;
*** Several variables are too wide for the report and need   *** ;
*** to be parsed.                                            *** ;
**************************************************************** ;

%let len_max = 20 30 ;       
%let vars = custname address ;  
%let spaces = 0 0 ;               
%let in_data = mags ;
%let keepvars = cust_num ;
%include parser ;

**************************************************************** ;
*** Add variable _rec_cnt to data set so that you have a     *** ;
*** count of records per group.                              *** ;
**************************************************************** ;

%getcount ( in_data = mags , 
            var_name = cust_num )   

proc sort data = mags ;
    by _seq_num _linepos cust_num ;
run ;

**************************************************************** ;
*** Set the report counter.                                  *** ;
**************************************************************** ;

%let rpt_cnt = 1 ;

**************************************************************** ;
*** Set the print destination.                               *** ;
**************************************************************** ;

%include printloc ;    

**************************************************************** ;
*** Include this module whenever you print in landscape.     *** ;
**************************************************************** ;

%include landscap ;   

**************************************************************** ;
*** Print the report.                                        *** ;
**************************************************************** ;

data _null_ ;


**************************************************************** ;
*** Abort the program if a previous step requests this.      *** ;
**************************************************************** ;

%include abortit ;   

    set mags end = last_one ;
    by _seq_num _linepos cust_num ;

file &print ;

**************************************************************** ;
*** Retrieve module that gets titles and footnotes.          *** ;
**************************************************************** ;

%include headfoot ;  

**************************************************************** ;
*** Print the header before reading first record.            *** ;
**************************************************************** ;

if _n_ = 1 then
    link header ;

%let dash_cnt = %eval (&rite_mar - &left_mar + 1 ) ;

**************************************************************** ;
*** If near the bottom of the page and cannot print all of   *** ;
*** the records for one group, then eject a new page.        *** ;
**************************************************************** ;

if first._seq_num and line_cnt gt ( bot_mar - _rec_cnt + 1 ) then
do ;
    put @&left_mar &dash_cnt*'_' ;
    put @&left_mar "'.' Indicates Data are Missing"
        @ ( &left_mar + &dash_cnt -11 ) "(Continued)"
    link footer ;
    link header ;
end ;

if first._seq_num then
do ;
    line_cnt + 1 ;
    put ;
end ;

**************************************************************** ;
*** Print the detail records.                                *** ;
**************************************************************** ;

retain col_01  21 ;
retain col_02  35 ;
retain col_03  57 ;
retain col_04  72 ;

if _linepos = 1 then
put @ ( col_01 + 0 ) cust_num
    @ ( col_02 + 0 ) custname
    @ ( col_03 + 4 ) money $2.
    @ ( col_04 + 0 ) address
    ;
else
put
    @ ( col_02 + 0 ) custname
    @ ( col_04 + 0 ) address
    ;

line_cnt + 1 ;

**************************************************************** ;
*** Processing after all records have been read              *** ;
**************************************************************** ;

if last_one then
do ;
    put @&left_mar &dash_cnt*'_' ;
    put @&left_mar " '.' Indicates Data are Missing"
    link footer ;
end ;

return ;

**************************************************************** ;
*** Print the titles.                                        *** ;
**************************************************************** ;

%include header ;   

**************************************************************** ;
*** Print underlines around column headings.                 *** ;
**************************************************************** ;

put @&left_mar &dash_cnt*'_' ;
put ;
line_cnt + 2 ;

**************************************************************** ;
*** Print the column headers.                                *** ;
**************************************************************** ;

put @ ( col_01 + 0 ) "Customer"
    @ ( col_02 + 0 ) "Customer"
    @ ( col_03 + 1 ) "Cash from"
    @ ( col_04 + 0 ) "Address"
    ;

line_cnt + 1 ;

put @ ( col_01 + 1 ) "Number"
    @ ( col_02 + 2 ) "Name"
    @ ( col_03 + 0 ) "Transaction"
    ;

line_cnt + 1 ;

**************************************************************** ;
*** Print underlines around column headings.                 *** ;
**************************************************************** ;

put @&left_mar &dash_cnt*'_' /;
line_cnt + 2 ;

return ;

**************************************************************** ;
*** Print the footnotes.                                     *** ;
**************************************************************** ;

%include footer ;  

run ;

**************************************************************** ;
*** Cleanup the environment.                                 *** ;
**************************************************************** ;

%include cleanup ;  
**************************************************************** ;
***           E N D   O F   M O D U L E  (money)        *** ;
**************************************************************** ;



  
**************************************************************** ;
*** Source:   LANDSCAP.SAS                                   *** ;
*** Type:     %INCLUDE Module                                *** ;
*** Function: Sets parameters properly for printing in       *** ;
***           landscape mode.                                *** ;
*** Use:      Include this module anywhere before your       *** ;
***           DATA _NULL_                                    *** ;
** Example :  %include landscap ;                            *** ;
**************************************************************** ;

**************************************************************** ;
***        G L O B A L   S Y S T E M   O P T I O N S         *** ;
**************************************************************** ;

options ls = 175 ;       * Set default linesize                  ;
options pagesize = 66 ;  * Set page size                         ;


**************************************************************** ;
***                 G L O B A L   V A R I A B L E S          *** ;
**************************************************************** ;

%let bot_mar  =  67 ;       * Bottom print margin                ;
%let left_mar =  16 ;       * Left print margin                  ;
%let linesize = 175 ;       * Sets the linesize for centering    ;
%let orient   = landscape ; * Print in landscape mode            ;
%let page_wid = 175 ;       * Page width                         ;
%let rite_mar = 159 ;       * Right print margin                 ;
%let top_mar =   05 ;       * Top print margin                   ;

**************************************************************** ;
***                                                          *** ;
*** Source:   ABORTIT.SAS                                    *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: The function of this routine is to abort a     *** ;
***           program.  This may happen for example, when    *** ; 
***           the user tries to parse a variable and sets    *** ; 
***           the maximum length of the parsed variable less *** ;
***           than the length of one of the words to be      *** ;
***           parsed.                                        *** ;
***                                                          *** ;
*** Usage:    Include this module at the very beginning of   *** ;  
***           your DATA _NULL_.                              *** ;
***                                                          *** ;
***           Example:                                       *** ;
***                                                          *** ;
***           DATA _NULL_ ;                                  *** ;
***           %include abortit ;                             *** ;
***                                                          *** ;
***           To turn on ABORT in your routine, set _ABORT   *** ; 
***           and &_REASON                                   *** ;
***                                                          *** ;
***           Example:                                       *** ;
***                                                          *** ;
***           %let _abort = YES ;                            *** ;
***           %let _reason = Laboratory file is Missing!     *** ;
***                                                          *** ;
**************************************************************** ;

retain _colinit 20 ;   * Where to print ERROR messages.          ;

* ... code to handle other abort situations ;

if "&_abort" = "YES" and "&_reason" = "PARSER" then
do ;
    _xname   = "&_varname"
    _xword   = "&_word"
    _xlen    = "&_len"
    _xmaxlen = "&_max_len"
    _xindent = "&_indent"
    _xstring = "&_string"
    file log  ;
    %include parsemsg ;
    file print  ;
    %include parsemsg ;
    stop ;
end ;

where PARSEMSG contains the error messages for a parser type 
error:


**************************************************************** ;
***                                                          *** ;
*** Source:   PARSEMSG.SAS                                   *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: The function of this routine contains the      *** ;
***           message returned from the parser.sas %include  *** ; 
***           module.                                        *** ;
*** Usage:    Is automatically included when a program       *** ;
***           aborts because of a parsing problem.           *** ;
***                                                          *** ;
**************************************************************** ;

put @_colinit'*************************************************' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '*** Your program has aborted.  This is a     ***' ;
put @_colinit '*** programmer created abort situation.      ***' ;
put @_colinit '*** When using the parser routine, a word    ***' ;
put @colinit  '*** was longer than allowed based on para-   ***' ;
put @_colinit '*** meters passed into the parser.  The      ***' ;
put @_colinit '*** following parameters are causing the     ***' ;
put @_colinit '*** problem:                                 ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '    The variable name:           ' _xname ;
put @_colinit '    The parsed word:             ' _xword ;        
put @_colinit '    The word length:             ' _xlen ;         
put @_colinit '    The maximum length specified  ' _xmaxlen ;       
put @_colinit '    The indention  specified:     ' _xindent ;       
put @_colinit '    The string containing the word is:       ***' ;
put @_colinit ' ' ;
put @_colinit '    ' _xstring ;
put @_colinit '***                                          ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '*** In order to correct this problem,        ***' ;
put @_colinit '*** resubmit your program, but either        ***' ;
put @_colinit '*** increase the maximum length allowed for  ***' ; 
put @_colinit '*** a variable to be parsed (&len_max)       ***' ;
put @_colinit '*** and/or decrease the amount of indention  ***' ;
put @_colinit '*** for the continuation lines (&spaces).    ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '***              E R R O R                   ***' ;
put @_colinit '***                                          ***' ;
put @_colinit '************************************************' ;



**************************************************************** ;
***                                                          *** ;
*** Source:   HEADFOOT.SAS                                   *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: Used by all reports to generate header titles  *** ; 
***           and footnotes.                                 *** ;
***                                                          *** ;
*** Use:      Include this module at the beginning of your   *** ;
***           DATA _NULL_                                    *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***                                                          *** ;
***                     IMPORTANT NOTE                       *** ;
***                                                          *** ;
*** Variables have been defined so that the following spec-  *** ; 
*** ifications are met for the reports:                      *** ;
***                                                          *** ;
*** (1) Header margins should be approximately 1 inch.       *** ;
*** (2) Footer margins should be approximately 1 inch.       *** ;
*** (3) The left margin should be at least 1.5 inches.       *** ;
*** (4) The right margin should be at least 1 inch.          *** ;
***                                                          *** ;
*** Reports are currently printed with the following font:   *** ;
***                                                          *** ;
*** Lineprinter pitch 8                                      *** ;
***                                                          *** ;
*** If either the font changes or the margin requirements    *** ;
*** change it will be  necessary to adjust the numbers in    *** ;
*** the following variable table to account for these        *** ;
*** changes.                                                 *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***     *** ;
***                       V A R I A B L E S     *** ;
***     *** ;
**************************************************************** ;
%let cont_cnt = 2 ; * Count of lines needed for continuation     ;
%let stopsign = ++++ ;     * End of record in titles file
%let sysfoot1 = Company Confidential ;
%let sysfoot = 2 ;   * Count of system footnotes                 ;
**************************************************************** ;
array tit_ary  {*} $200 title_01-title_10 ; * Report titles      ;
array foot_ary {*} $200 foot_01-foot_10 ; * Report footnotes     ;
**************************************************************** ;
length fetch_it   $3 ;  * Whether or not to grab next record     ;
length _type      $9 ;  * Type of record ( title or footnote )   ;
length _word_     $12 ; * Scratch area for word                  ;
**************************************************************** ;
retain bot_mar      0 ;    * Bottom margin , is calculated       ;
retain foot_cnt   0 ;      * Number of footnotes for this report ;
retain foot_01-foot_10 ;   * Holds report footnotes              ;
retain fetchit 'no' ;      * Whether or not to grab next record  ;
retain in_len 133 ;        * Input record length for input file  ;
retain titlecnt 0 ;        * Number of titles for this report    ;
retain title_01-title_10 ; * Holds report titles                 ;
retain _type " " ;         * Type of record (footnote or header) ;
**************************************************************** ;

**************************************************************** ;
*** Read in the titles file to get a list of study specific  *** ; 
*** titles and footnotes.                                    *** ;
**************************************************************** ;

infile titles length = in_len end = last_rec ;

**************************************************************** ;
*** If this is first record read, then process this routine. *** ;
*** The title file will be read in its entirety.  First      *** ;
*** search on studywide titles and add these to the title    *** ;  
*** array. Then using the filename as the search key         *** ;
*** (i.e. DEMODATA.SAS ), scan for this filename and grab    *** ;
*** all the titles associated with this report.  Then grab   *** ; 
*** the footnotes that are used in this report and put them  *** ; 
*** in the footnote array.                                   *** ;  
**************************************************************** ;

if _n_ = 1 then
do until ( last_rec ) ;
    input in_line $varying133. in_len ;
    check = index ( in_line, "&stopsign" ) ;
    if check gt 0 then
        fetch_it = 'no' ;
    if fetch_it = 'yes' and _type = 'TITLES' then
    do ;
        titlecnt + 1 ;
        tit_ary ( titlecnt ) = in_line ;
    end ;
    if fetch_it = 'yes' and _type = 'FOOTNOTES' then
    do ;
        foot_cnt + 1 ;
        foot_ary ( foot_cnt ) = put ( in_line, $char133. ) ;
    end ;

    check = index ( in_line, "STUDYWIDE FOOTNOTES" ) ;
    if check gt 0 then
    do ;
        _type = 'FOOTNOTES' ;
        fetch_it = 'yes' ;
    end ;

    check = index ( in_line, "STUDYWIDE TITLES" ) ;
    if check gt 0 then
    do ;
        _type = 'TITLES' ;
        fetch_it = 'yes' ;
    end ;
    _word_ = scan ( in_line, 1, " " ) ;
    check = index ( _word_, ".SAS" ) ;
    if check gt 0 then
    do ;
        _type = scan ( in_line, 2, " " ) ;
        rpt_cnt = scan ( in_line, 3, " " ) ;
    end ;
    if upcase ( _word_ ) = upcase ( "&filename" )
        and rpt_cnt = &rpt_cnt then
    do ;
        fetch_it = 'yes' ;
    end ;
end ;

**************************************************************** ;
*** Here you calculate the logical bottom of the page. It is *** ;
*** determined by starting at the system determined bottom   *** ; 
*** margin and subtracting the system footer count, the      *** ;
*** report specific footer count (one additional line if     *** ;
*** there is at least one footnote, so that you can have a   *** ; 
*** separation between the bottom of the report, the report  *** ;  
*** footer and the studywide footer), the lines needed for   *** ; 
*** the continuation text and continuation and one more      *** ;
*** space between the continuation text and the bottom of    *** ;
*** the report.                                              *** ;
**************************************************************** ;

if foot_cnt = 0 then
    bot_mar = &bot_mar - &sysfoot - &cont_cnt - 1 ;
else
    bot_mar = &bot_mar - &sysfoot -foot_cnt -1 - &cont_cnt - 1 ;



**************************************************************** ;
***                                                          *** ;
*** Source:   HEADER.SAS                                     *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: Prints report headers.                         *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
*** This routine simply centers the titles and prints them.  *** ;
**************************************************************** ;

header: ;

**************************************************************** ;
*** Eject a new page.                                        *** ;
**************************************************************** ;

put _page_ ;

**************************************************************** ;
*** Set the line count = top margin.                         *** ;
**************************************************************** ;

line_cnt = &top_mar ;

**************************************************************** ;
*** Center and print each title. The titles are stored in    *** ;
*** the title array.  They were originally placed there by   *** ; 
*** the %INCLUDE module HEADFOOT.SAS.                        *** ;
**************************************************************** ;

length _scratch $200  ;

do i = 1 to titlecnt ;
    the_len = trim ( length ( tit_ary {i} )) ;
    check = index ( tit_ary {i}, "#L" ) ;
    if check gt 0 then
    do ;
        _scratch = substr ( tit_ary {i}, 4 ) ;
        put #line_cnt @&left_mar _scratch ;
    end ;
    else
    do ;
        the_loc = ( &page_wid - the_len + 2 ) / 2 ;
        put #line_cnt @the_loc tit_ary {i} ;
    end ;
    line_cnt + 1 ;
end ;



**************************************************************** ;
***                                                          *** ;
*** Source:   FOOTER.SAS                                     *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: Prints the footnotes at bottom of the page.    *** ;
***                                                          *** ; 
**************************************************************** ;

footer: ;

**************************************************************** ;
*** If the code #L is found in the footnote array, then the  *** ; 
*** foot note is left justified, otherwise it is center      *** ;
*** justified.                                               *** ;  
**************************************************************** ;

length scratch $175 ;    * scratch work area ;

do i = 1 to foot_cnt ;
    the_len = trim ( length ( foot_ary {i} )) ;
    foot_out = translate ( foot_ary {i},' ','"') ;
    check = index ( foot_out, "#L" ) ;
    if check gt 0 then
    do ;
        scratch = substr ( foot_out, 4 ) ;
        put # ( bot_mar + i + 3 ) @&left_mar 
          scratch $varying175. the_len ;
    end ;
    else
    do ;
        the_loc = (( &page_wid - the_len + 2 ) / 2 ) ;
        put # ( bot_mar + i + 3 ) @the_loc 
          foot_out $varying175. the_len ;
    end ;
end ;

put # ( bot_mar + i + 3 ) @ ( &left_mar + 1 )
      "Dir: &code_loc\&filename - &coder - &sysdate &systime"

return ;



**************************************************************** ;
***                                                          *** ;
*** Source:   CLEANUP.SAS                                    *** ;
***                                                          *** ;
*** Type:     %INCLUDE Module                                *** ;
***                                                          *** ;
*** Function: Does general report cleanup.                   *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
*** Redirecting report output closes the print file and      *** ;
*** allows you to view any recently created file in the      *** ;
*** program editor. In addition, resetting procedure output  *** ; 
*** is useful for debugging.                                 *** ;
**************************************************************** ;

proc printto ;
run ;

**************************************************************** ;
*** If this is a study run, then put the page number on each *** ;
*** SAS program output.                                      *** ;
**************************************************************** ;

%macro putpage ;
    %if &redirect = STUDYDIR %then
        %include putpage ;
%mend putpage ;

%putpage 

**************************************************************** ;
*** Deleting the work library is useful if you are running   *** ;
*** multiple jobs in a batch.                                *** ;
**************************************************************** ;

proc datasets library = work kill memtype = ( data ) ;
run ;
quit ;







**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 11          *** ;
*** on p. 325.                                               *** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:   RPT_GEN.SAS (Report Generator)                 *** ;
***                                                          *** ;
*** Type:     Utility                                        *** ;
***                                                          *** ;
*** Function: To automatically generate a DATA _NULL without *** ;
***           coding any PUT statements by using a pre-      *** ;
***           formatted layout program.                      *** ;
***                                                          *** ;
*** Inputs:   RPTGEN fileref points to the proposed report   *** ;
***           layout.                                        *** ;
***           DATASET is the name of the SAS data set that   *** ;
***           is input to the report generator.              *** ;
***                                                          *** ;
*** Vars:     See below                                      *** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
*** Input data set and report layout                         *** ;
**************************************************************** ;

libname sasdata "c:\mysas"      * Name of SAS library ;

%let dataset = sasdata.stocks ;   * Name of input data set ;     

filename rptgen   "c:\rptgen.dat"

**************************************************************** ;
*** Input variables to this routine                          *** ;
**************************************************************** ;
%let control = # ;          * Character to designate control     ;
%let delim = / ;            * Delims besides space for parser?   ;
%let page_wid = 78 ;        * Screen or report width             ;
%let preview = N ;          * Do not want preview of variables   ;
%let sort_by = broker  ;    * Sort data set by this variable     ;
%let spaces = 2 ;           * # spaces to indent contin. lines   ;
%let varstart = "#"         * Character that starts var position ;
**************************************************************** ;
***                      G L O B A L S  *** ;
**************************************************************** ;

%let need_cut = N ;         * Assume no variables need parsed    ;
                                                                 
**************************************************************** ;
***          F I L E N A M E    D E F I N I T I O N S        *** ;
**************************************************************** ;

filename parsemsg  "c:\parsemsg.sas" ;
filename layout    "c:\layout.sas" ;
filename setparse  "c:\setparse.sas" ;
filename head      "c:\head.inc" ;
filename layout    "c:\layout.sas" ;
filename foot      "c:\foot.inc" ;
filename parser    "c:\parser.sas" ;
filename abortit   "c:\abortit.sas" ;

**************************************************************** ;
*** Clear out title and footnote definitions.   *** ;
**************************************************************** ;

footnote1 ;                 * Clear out footnotes                ;
title1 ;                    * Clear out titles                   ;

**************************************************************** ;
*** Get a list of variables for the SAS data set.            *** ;
**************************************************************** ;

proc sort data = &dataset out = sas_data nodupkey ;
    by &sort_by ;
run ;

proc contents data = sas_data noprint out = sas_cont ;
run ;

**************************************************************** ;
*** Make a first pass through the file to determine the      *** ;
*** amount of space required for each variable.              *** ;
**************************************************************** ;

data max ( keep = the_word word_loc ) ;

infile rptgen length = in_len ;

**************************************************************** ;
*** Find the start of the detail lines.                      *** ;
**************************************************************** ;

maxcount = 1 ;
do until ( det_chk gt 0 or maxcount gt 50 ) ;
    input @001 in_line $varying200. in_len ;
    det_chk = index ( in_line, ":DETAIL:" ) ;
    maxcount + 1 ;
end ;

**************************************************************** ;
*** Now input the next line which contains the list of vars. *** ;
**************************************************************** ;

input @001 in_line $varying200. in_len ;

**************************************************************** ;
*** Now find the maximum allocated space for each variable.  *** ;
*** In this step, just find each word and its starting       *** ;
*** location.                                                *** ;
**************************************************************** ;

length the_word $9 ;

var_num = 0 ;
col_pos = 1 ;
do until ( col_pos gt in_len ) ;
    byte = substr ( in_line, col_pos, 1 ) ;
    if byte = &varstart then
    do ;
        var_num + 1 ;
        word_loc = col_pos ;
        on_word = 'Y' ;
        the_word = " " ;
    end ;
    if byte not in ( " ", &varstart ) then
    do ;
        on_word = 'Y' ;
        the_word = trim ( left ( the_word )) || byte ;
    end ;
    if ( byte = " " or col_pos = in_len )  and on_word = 'Y' then
    do ;
        on_word = 'N' ;
        output ;
        the_word = " " ;
    end ;
    col_pos + 1 ;
end ;

stop ;
run ;

**************************************************************** ;
*** Now find the maximum allocated space for each variable.  *** ;
**************************************************************** ;

data max ( keep = maxparse label ) ;
    set max end = last_01 ;

length lastword $8 ;  * The previous word                        ;
retain last_loc 0 ;   * Location of last word                    ;
retain lastword " " ; * The previous word                        ;

**************************************************************** ;
*** Compare the current word location with the start loc-    *** ;
*** ation of the next word.                                  *** ;
**************************************************************** ;

if _n_ gt 1 then
do ;
    maxparse = word_loc - last_loc - 1 ;
    label = upcase ( lastword ) ;
    output ;
end ;

**************************************************************** ;
*** The last word cannot use the next word as a boundary, so *** ;
*** use the right margin.                                    *** ;
**************************************************************** ;

if last_01 then
do ;
    label = upcase ( the_word  ) ;
    maxparse = &page_wid - word_loc ;
    output ;
end ;

**************************************************************** ;
*** Keep track of the last word and its location.            *** ;
**************************************************************** ;

lastword = the_word ;
last_loc = word_loc ;

run ;

**************************************************************** ;
*** The true length allocated for the variable is meaning-   *** ;
*** less. We want to determine the maximum formatted length  *** ; 
*** of each variable in the data set.  This module will      *** ;
*** return the maximum actual formatted length of each var-  *** ; 
*** iable and will be used to calculate how much space is    *** ;
*** allocated for each variable on the report.               *** ;
**************************************************************** ;

%include "c:\preview.sas"  * See Coding Sample #6 ;

**************************************************************** ;
*** We want to merge the results of the preview module with  *** ;
*** maximum number of spaces allocated for each variable by  *** ;
*** reading the physical layout.                             *** ;
**************************************************************** ;

proc sort data = _str_len ;
    by label ;
run ;

proc sort data = max ;
    by label ;
run ;

**************************************************************** ;
*** Determine if we have to do a wordwrap on any variables.  *** ;
*** Pass the number of wrapped variables and the variable    *** ;
*** names through global macro variables.                    *** ;
**************************************************************** ;

data final ( keep = label maxparse length need_cut type ) ;
    merge  max      ( in = in_max )
           _str_len ( in = In_var ) ;
    by label ;

length parsvars $200 ;   * Name of all parsed variables          ;
length max_size   $200 ; * Maximum size list of parsed vars      ;
retain parsvars ;        * Name of all parsed variables          ;
retain max_size ;        * Maximum size list of parsed vars      ;
retain cut_cnt 0 ;       * Increment if variable needs parsing   ;

if in_max and not in_var then
do ;
    put '*** Warning ***' ;
    put 'There are variables in layout but not in SAS data set' ;
    put '*** Warning ***' ;
end ;

if in_max and in_var ;

if length gt maxparse then
    do ;
        need_cut = "Y" ;
        cut_cnt + 1 ;
        parsvars = trim ( left ( parsvars )) || " " || label ;
        put parsvars= label= ;
        max_size   = trim ( left ( max_size )) || " " 
         || maxparse ;
        call symput ('parsvars', parsvars ) ;
        call symput ('max_size', max_size ) ;
    end ;
else
    need_cut = "N" ;

call symput ( 'cut_cnt', cut_cnt ) ;

run ;

**************************************************************** ;
*** Dynamically create the input parameters to the parser.   *** ;
**************************************************************** ;

data _null_ ;

length curr_var $8 ;     * the current variable                  ;
length max_size $200 ;   * maximum size of parsed variables      ;
length parsvars $200 ;   * parsed variables                      ;

parsvars = "&parsvars" ;
max_size   = "&max_size" ;

if &cut_cnt gt 0 then
do ;
    file setparse ;
    put "%"  "let in_data = sas_data ; " ;
    put "%" "let sort_by = ; " ;
    do i = 1 to &cut_cnt ;
        if i = 1 then
             put "%" "let vars = " ;
        curr_var = scan ( parsvars, i ) ;
        put curr_var ;
    end ;
    put " ; " ;
    do i = 1 to &cut_cnt ;
        if i = 1 then
             put "%" "let len_max = " ;
        max_var = scan ( max_size, i ) ;
        put max_var ;
    end ;
    put " ; " ;
    do i = 1 to &cut_cnt ;
        if i = 1 then
             put "%" "let spaces = "  ;
        put "&spaces"  ;
    end ;
    put " ; " ;
    put "%include parser ; " ;
end ;

stop ;

run ;

**************************************************************** ;
*** The last step dynamically created the input parameters   *** ;
*** to the parser routine.  Now run the parser.              *** ;
**************************************************************** ;

%include setparse ;

title1 ;


**************************************************************** ;
*** Dynamically create the final data_null_ step that will   *** ;
*** actually write out the report.                           *** ;
**************************************************************** ;

data _null_ ;

parsvars = "&parsvars" ;
max_size = "&max_size" ;

file layout ;
put   @001 "data _null_ ; " ;
put / @001 "%include abortit ; " ;
put   @001 "set sas_data end = last_01  ; " ;
put   @005 "by  &sort_by  ; " ;
put / @001 "file print linesleft = numlines ; ";
put   @001 " " ;

infile rptgen length = in_len ;

maxcount = 1 ;

do until ( titcheck gt 0 or maxcount gt 50 ) ;
    input @001 in_line $varying200. in_len ;
    titcheck = index ( in_line, ":TITLES:" ) ;
    maxcount + 1 ;
end ;

head_chk = 'N' ;

put "if _n_ = 1 then " ;
put "    link header ; " ;
put " " ;

file head ;

put "header: ; " ;


**************************************************************** ;
*** Print titles.                                            *** ;
**************************************************************** ;

titcount = 0 ;
do until ( head_chk gt 0 ) ;
    input @001 in_line $varying200. in_len ;
    head_chk = index ( in_line, ":HEADINGS:" ) ;
    if head_chk = 0 then
    do ;
        titcount + 1 ;
        length new_word $2 ;
        new_word = "&control" || "A" ;
        a_check = index ( in_line, new_word ) ;
        if a_check gt 0 then
        do ;
            in_line = substr ( in_line, ( a_check + 2 )) ;
            put 'put @001' '"' in_line $char. '"'  ' ; ' ;
        end ;
        new_word = "&control" || "L" ;
        l_check = index ( in_line, new_word ) ;
        if l_check gt 0 then
        do ;
            in_line = "  " ||
              trim ( left ( substr ( in_line, ( l_check + 2 )))) ;
            put 'put @001' '"' in_line '"'  ' ; ' ;
        end ;
        new_word = "&control" || "R" ;
        r_check = index ( in_line, new_word ) ;
        if r_check gt 0 then
        do ;
            in_line = trim ( left ( substr 
              ( in_line, r_check + 2 ))) ;
            the_len = length ( trim ( left ( in_line ))) ;
            rite_pos = ( &page_wid - the_len ) ;
            put 'put @' rite_pos  '"' in_line '"'  ' ; ' ;
        end ;
        new_word = "&control" || "C" ;
        c_check = index ( in_line, new_word ) ;
        if c_check gt 0 then
        do ;
            in_line = trim ( left ( substr 
              ( in_line, c_check + 2 ))) ;
            the_len = length ( trim ( left ( in_line ))) ;
            cent_pos = int (( &page_wid - the_len ) / 2 )  + 1 ;
            put 'put @' cent_pos  '"' in_line '"'  ' ; ' ;
        end ;
        if a_check = 0 and l_check = 0 and r_check = 0
           and c_check = 0 then
        do ;
            the_len = length ( trim ( left ( in_line ))) ;
            cent_pos = int (( &page_wid - the_len ) / 2 ) + 1  ;
            put 'put @' cent_pos  '"' in_line '"'  ' ; ' ;
        end ;

    end ;
end ;

put " " ;

**************************************************************** ;
*** Print headings.                                          *** ;
**************************************************************** ;

head_cnt = 0 ;
maxcount = 1 ;
do until ( det_chk gt 0 or maxcount gt 50 ) ;
    input @001 in_line $varying200. in_len ;
    det_chk = index ( in_line, ":DETAIL:" ) ;
    if det_chk = 0 then
    do ;
    head_cnt + 1 ;
    the_len = length ( trim ( in_line )) ;
    put 'put @001 ' '"' in_line $varying200. the_len '"'  ' ;' ;
    end ;
    maxcount + 1 ;
end ;

put " " ;

put "return ; " ;

**************************************************************** ;
*** Print detail lines.                                      *** ;
**************************************************************** ;

file layout ;

length testword $8 ;
length the_word $9 ;

input @001 in_line $varying200. in_len ;

var_num = 0 ;
col_pos = 1 ;
do until ( col_pos gt in_len ) ;
    byte = substr ( in_line, col_pos, 1 ) ;
    if byte = &varstart then
    do ;
        var_num + 1 ;
        word_loc = col_pos ;
        on_word = 'Y' ;
        the_word = " " ;
    end ;
    if byte not in ( " ", &varstart ) then
    do ;
        on_word = 'Y' ;
        the_word = trim ( left ( the_word )) || byte ;
    end ;
    if  ( byte = " " or col_pos = in_len ) and on_word = 'Y' then
    do ;
        on_word = 'N' ;
        char_var = "N" ;
        pointer = 1 ;
        do until ( pointer gt num_obs ) ;
            set sas_cont nobs = num_obs point = pointer ;
            if trim ( left ( upcase ( name ))) =
               trim ( left ( upcase (the_word ))) 
                 and type = 2 then
                char_var = "Y" ;
            pointer + 1 ;
        end ;
        the_len = 0 ;
        do i = 1 to &cut_cnt ;
            testword = scan ( parsvars, i ) ;
            if upcase ( trim ( left ( testword ))) =
                upcase ( trim ( left ( the_word ))) then
                the_len = scan ( max_size, i ) ;
        end ;
        if var_num = 1 then
            put "put " ;
        put "    " "@" word_loc the_word @ ;
        if char_var = "Y" and the_len gt 0 then
            put " $char" the_len +(-1) "." ;
        else
            put ;
        the_word = " " ;
    end ;
    col_pos + 1 ;
end ;

put "    ; " ;

put /  @001  "if last_01 then" ;
put    @005  "link footer ; " ;
put /  @001  "return ; " ;

**************************************************************** ;
*** Print footnotes.                                         *** ;
**************************************************************** ;

file foot ;

put "footer: ; " ;

max_cnt = 1 ;

do until ( foot_chk gt 0 or max_cnt = 50 ) ;
    input @001 in_line $varying200. in_len ;
    foot_chk = index ( in_line, ":FOOTNOTES:" ) ;
    if foot_chk gt 0 then
    do until ( bot_chk gt 0 ) ;
        input @001 in_line $varying200. in_len ;
        bot_chk = index ( in_line, ":BOTTOM OF PAGE:" ) ;
        if bot_chk = 0 then
            put 'put @001' '"' in_line $char. '"'  ' ; ' ;
    end ;
    max_cnt + 1 ;
end ;

put "return ; " ;

stop ;
run ;

%include layout ;
%include head ;
%include foot ;

run ;


**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 12          *** ;
*** on p. 334.                                               *** ;
***                                                          *** ;
**************************************************************** ;


**************************************************************** ;
***                                                          *** ;
*** Source:   ERRORLOG.SAS                                   *** ;
***                                                          *** ;
*** Type:     Utility                                        *** ;
***                                                          *** ;
*** Function: Searches the log directory and reports all     *** ;
***           references to warnings and errors.             *** ;
***                                                          *** ;
*** Note:     You can actually use certain utilities like    *** ;
***           Norton's Filefind or other micro based utili-  *** ;
***           ties to perform a similar function. I use this *** ;
***           program to fine tune or customize my searches  *** ;
***           exactly the way I want them, and format the    *** ;
***           output the way I prefer.                       *** ;
***                                                          *** ;
*** Usage:    Set the macro variable &path to the location   *** ;
***           of the SAS logs.                               *** ;
***                                                          *** ;
***           In the macro FIND_ERR, you can customize this  *** ;
***           program to print off the messages that are of  *** ;
***           interest to you.                               *** ;
***                                                          *** ;
***           A file is created in the log directory         *** ;
***           called ERROR.LST.  You can print it off and    *** ;
***           note all references to ERRORS and WARNINGS.    *** ;
***                                                          *** ;
**************************************************************** ;

%let path = c:\protocol\pls2g\log ;

**************************************************************** ;
*  Dont force user to press enter key for DOS commands.          ;
**************************************************************** ;

options noxwait ;

**************************************************************** ;
*** This is the file that will create the output listing.    *** ;
**************************************************************** ;

filename errorout  "&path\error.lst" ;

**************************************************************** ;
*  Delete old listing, because we are using mod file option      ;
**************************************************************** ;

data _null_ ;

if fexist ('errorout') then
    call system  ("del &path\error.lst") ;

run ;

**************************************************************** ;
*** These are intermediate work files that will be used by   *** ;
*** DOS to create a file with the listing of all *.log files.*** ;
**************************************************************** ;

%let rawlist = rawdata.dir ;

**************************************************************** ;
*** Get a list of all files in the log subdirectory.         *** ;
**************************************************************** ;

x "dir &path/b > &path\&rawlist" ;

**************************************************************** ;
***  Macro      Logscan                                      *** ;
***  Function:  Scans the file that contains the complete    *** ;
***             list of log entries and pulls out 1 log file *** ;
***             at a time.                                   *** ;
**************************************************************** ;

%macro log_scan ;

data _null_ ;

length in_line $80 ;         * Each input record ;

infile "&path\&rawlist" length = in_len eof = no_more ;

**************************************************************** ;
*** Input the record at the present record pointer.          *** ;
**************************************************************** ;

input #&rec_pos in_line $ varying. in_len ;

**************************************************************** ;
*** Retrieve the name of the log file.                       *** ;         
**************************************************************** ;

new_log = scan ( in_line, 1, ' ' ) ;
call symput ( 'logentry', put ( new_log,$12.) ) ;

stop ;

no_more:
call symput ( 'all_done','Y' ) ;

run ;


data _null_ ;

length in_line $120 ;           * input record ;
retain entrycnt 0 ;             * # times this entry written  ;

infile "&path\&logentry" length = in_len ;

input in_line $ varying. in_len ;

**************************************************************** ;
*** Search for the words "ERROR:" AND "WARNING".  If found,  *** ;
*** write out to the error file. Also search for "NOTES" of  *** ; 
*** interest.                                                *** ;
**************************************************************** ;

find_err = index ( upcase ( in_line ) , 'ERROR:' ) ;
findwarn = index ( upcase ( in_line ) , 'WARNING:' ) ;
findnote = index ( upcase ( in_line ) , 'NOTE:' ) ;

**************************************************************** ;
*** Here you can ignore any WARNINGS that you choose.        *** ;
**************************************************************** ;

if findwarn gt 0 then
do ;
    findlib = index ( upcase ( in_line ) ,
     'IS ALREADY ON THE LIBRARY' ) ;
    if findlib gt 0 then
        findwarn = 0 ;
    find_exp = index ( upcase ( in_line ) , 'THE BASE PRODUCT' ) ;
    if find_exp gt 0 then
        findwarn = 0 ;
end ;

**************************************************************** ;
*** Select any NOTES that you wish to print.                 *** ;
**************************************************************** ;

if findnote gt 0 then
do ;
    findzero = index ( upcase ( in_line ), 'DIVISION BY ZERO' ) ;
    findunin = index ( upcase ( in_line ), 'IS UNINITIALIZED.' ) ;
    find_wd  = index ( upcase ( in_line ), 'W.D. FORMAT' ) ;
end ;

if find_err gt 0 or findwarn gt 0 or findunin gt 0 or
  find_wd gt 0 or findzero gt 0 then
do ;
    entrycnt + 1 ;
    file errorout mod ;
    if entrycnt = 1 then
        put / "&logentry" ;
    put in_line ;
    file log ;
end ;

run ;

%mend log_scan ;

**************************************************************** ;
***  Macro      MASTER                                       *** ;
***  Function:  This is the master routine that will drive   *** ;
***             the whole application.                       *** ;
**************************************************************** ;

%macro master ;
    %local all_done rec_pos ;
    %let all_done = N ;
    %let rec_pos = 1 ;
    %do %until ( &all_done = Y ) ;
        %log_scan
        %let rec_pos = %eval ( &rec_pos + 1 ) ;
    %end ;
%mend master ;

%master

**************************************************************** ;
*** This will help to determine if program runs OK.          *** ;
**************************************************************** ;

x "type &path\error.lst | more" ;

**************************************************************** ;
*** Clean up.                                                *** ;
**************************************************************** ;

x "del &path\&rawlist" ;




**************************************************************** ;
***                                                          *** ;
*** The following code is found in Coding Sample 13          *** ;
*** on p. 337.                                               *** ;
***                                                          *** ;
**************************************************************** ;

**************************************************************** ;
***                                                          *** ;
*** Source:   MERGE_BY (Find MERGE and no BY)                *** ;
***                                                          *** ;
*** Type:     Utility                                        *** ;
***                                                          *** ;
*** Function: To find a MERGE without an associated BY       *** ;
***           statement.                                     *** ;
***                                                          *** ;
*** Inputs:   Specify the name of the SAS program to be      *** ;
***           scanned.                                       *** ;
***                                                          *** ;
*** Limits:   For the sake of brevity, we will assume the    *** ;
***           following limitations of this routine:         *** ;
***                                                          *** ;
*** (1) There are no comments imbedded within the code       *** ;
*** (2) There are no quoted fields within the code           *** ;
*** (3) We will only scan one file. For an example of pro-   *** ;
***     cessing multiple files, refer to Coding Sample 12.   *** ;
***                                                          *** ;
**************************************************************** ;

data _null_ ;

infile 'fileref' truncover ;

input in_line $120. ;
in_line = upcase ( in_line ) ;

retain in_merge 0 ;   * Are you in a merge area ;
retain semi_one 0 ;   * Find first semicolon after merge? ;
retain semi_two 0 ;   * Find second semicolon after merge? ;
retain curr_loc 1 ;   * Where is the current file pointer? ;

**************************************************************** ;
*** In not in a MERGE, then check if in a MERGE statemen     *** ;
*** If in a MERGE then mark the location.                    *** ;
**************************************************************** ;

curr_loc = 1 ;

if in_merge = 0 then
do ;
    in_merge = index ( in_line, 'MERGE' ) ;
    if in_merge gt 0 then
        curr_loc = in_merge + 5 ;
end ;

**************************************************************** ;
*** If in a MERGE statement and you have not found the       *** ;
*** first semicolon, look for it and mark its location.      *** ;
**************************************************************** ;

if in_merge gt 0 and semi_one = 0 then
do ;
    semi_one = index ( substr ( in_line, curr_loc ) , ";" ) ;
    if semi_one gt 0 then
        curr_loc = semi_one + 1 ;
end ;

**************************************************************** ;
*** In found semicolon, then look for a BY statement and     *** ;
*** another semicolon.  Compare their relative locations to  *** ; 
*** see if there is an error.                                *** ;
**************************************************************** ;

if semi_one gt 0 then
do ;
    find_by = index ( substr ( in_line, curr_loc ), "BY" ) ;
    semi_two= index ( substr ( in_line, curr_loc ), ";" ) ;
    if semi_two gt 0 then
    do ;
        if ( find_by gt 0 and find_by gt semi_two ) or
           ( find_by = 0 ) then
            put "BY statement expected on or before line #" _n_ ;
        in_merge = 0 ;
        semi_one = 0 ;
        semi_two = 0 ;
        curr_loc = 1 ;
    end ;
end ;

run ;



