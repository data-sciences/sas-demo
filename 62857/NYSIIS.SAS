
%macro nysiis(name_,code_);
length &code_ $20;

** 'local' variables;
length wrk_ $20;
wrk_ = lowcase(&name_);
if (wrk_ eq ' ') then len_ = 0;
else len_ = length(wrk_);
&code_ = ' ';
drop wrk_ len_ wndx_ cndx_ next_ last_;

do while (len_ gt 0);

  ** remove any jr or sr suffix on name;
  if (len_ gt 1) then do;
    if ( substr(wrk_, (len_ - 1), 2) in ('jr', 'sr') ) then do;
      substr(wrk_, (len_ - 1), 2) = '  ';
      len_ = len_ - 2;
    end;
  end;
  if (len_ le 0) then leave;

  ** remove all s's and z's from the end of the name;
  if (len_ gt 1) then do;
    do while ( substr(wrk_, len_, 1) in ('s', 'z') );
      substr(wrk_, len_, 1) = ' ';
      len_ = len_ - 1;
    end;
  end;
  if (len_ le 0) then leave;

  ** change name beginnings;
  /* mac to mcc */
  if (wrk_ eq: 'mac') then substr(wrk_, 1, 3) = 'mcc';

  /* pf to ff */
  if (wrk_ eq: 'pf')  then substr(wrk_, 1, 2) = 'ff';

  ** change name endings;
  if (len_ gt 1) then do;
    select ( substr(wrk_, (len_ - 1), 2) );
      /* ix to ic */
        when ('ix')  substr(wrk_, (len_ - 1), 2) = 'ic';
      /* ex to ec */
        when ('ex')  substr(wrk_, (len_ - 1), 2) = 'ec';
      /* ye, ee, ie to y */
        when ('ye', 'ee', 'ie') do;
          substr(wrk_, (len_ - 1), 2) = 'y ';
          len_ = len_ - 1;
        end;
      /* dt, rt, rd to d */
        when ('dt', 'rt', 'rd') do;
          substr(wrk_, (len_ - 1), 2) = 'd ';
          len_ = len_ - 1;
        end;
      /* nt, nd to n */
        when ('nt', 'nd') do;
          substr(wrk_, (len_ - 1), 2) = 'n ';
          len_ = len_ - 1;
        end;
      otherwise;
    end;
  end;
  if (len_ le 0) then leave;

  ** recodes unless first char of name;
  wrk_ = substr(wrk_, 1, 1) ||
         tranwrd(substr(wrk_, 2), 'ev', 'ef');     ** ev -> ef;
  wrk_ = substr(wrk_, 1, 1) ||
         translate(substr(wrk_, 2), 'ngs', 'mqz'); ** n|g|s <- m|q|z;

  ** recode all vowels to 'a';
  wrk_ = translate(wrk_, 'aaaa', 'eiou');

  ** recode characters;
  wrk_ = tranwrd(wrk_, 'aw', 'aa');
  wrk_ = tranwrd(wrk_, 'dg', 'gg');
  wrk_ = tranwrd(wrk_, 'ght', 'gtt');

  wrk_ = substr(wrk_, 1, 1) ||
         tranwrd(substr(wrk_, 2), 'ha', 'aa');
  wrk_ = tranwrd(wrk_, 'ah', 'aa');

  wrk_ = tranwrd(wrk_, 'kn', 'nn');
  wrk_ = translate(wrk_, 'c', 'k');

  wrk_ = tranwrd(wrk_, 'ph', 'ff');

  if (len_ gt 1) then do;
    if (substr(wrk_, (len_ - 1), 2) eq 'sh')  then substr(wrk_, (len_ - 1), 2) = 'sa';
  end;
  wrk_ = tranwrd(wrk_, 'sh', 'ss');

  if (len_ gt 2) then do;
    if (substr(wrk_, (len_ - 2), 3) eq 'sch') then substr(wrk_, (len_ - 2), 3) = 'ssa';
  end;
  wrk_ = tranwrd(wrk_, 'sch', 'sss');

  wrk_ = tranwrd(wrk_, 'wr', 'rr');

  if (len_ gt 2) then do;
    wrk_ = substr(wrk_, 1, 1) ||
           translate(substr(wrk_, 2), 'a', 'y') || substr(wrk_, len_, 1);
  end;

  wrk_ = tranwrd(wrk_, 'yw', 'yy');

  ** remove any terminal vowels ('a');
  do while (len_ gt 1  and substr(wrk_, len_, 1) eq 'a');
    substr(wrk_, len_, 1) = ' ';
    len_ = len_ - 1;
    if (len_ lt 1) then leave;
  end;
  if (len_ le 0) then leave;

  ** construct nysiis code;
  if (substr(wrk_, 1, 1) eq 'a') then
       substr(&code_, 1, 1) = substr(&name_, 1, 1);
  else substr(&code_, 1, 1) = substr(wrk_, 1, 1);
  cndx_ = 2;
  last_ = substr(&code_, 1, 1);
  do wndx_ = 2 to len_;
    next_ = substr(wrk_, wndx_, 1);
    if (next_ ne last_) then do;
      substr(&code_, cndx_, 1) = next_;
      last_ = next_;
      cndx_ + 1;
    end;
  end;  ** end-do (wndx_);
  len_ = 0;
end;  ** end-do-while loop;

&code_ = upcase(&code_);
%mend;
