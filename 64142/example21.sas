%let name=example21;

data mydata1;
  length id $10;
  do Timestamp = 0 to 720 by 15;
    do Angle = 0 to Timestamp;
      radians=Angle*(atan(1)/45);
      Value = sin(radians); id='SinLine'; output;
      Value = cos(radians); id='CosLine'; output;
      if Angle eq Timestamp then do;
       Value = sin(radians); id='Sine'; output;
       Value = cos(radians); id='Cosine'; output;
      end;
    end;
  end;
run;

proc sort data=mydata1 out=mydata2;
by descending Timestamp descending Angle;
run;

data mydata;
 set mydata1 mydata2;
run;


%let dataset=mydata;
%let x_var=Angle;
%let y_var=Value;
%let id_var=id;
%let by_var=Timestamp;

/* ODS hasn't automated doing a simple gifanimation yet, so we have to do some 
   manual scripting of the html file ... */

/**  Script out the HTML file that will display the GIF animation.  **/
data _null_;
   file "&name..htm";
   put '<HTML>';
   put '<title>Trig Waves (SAS/Graph gifanim) </title>';
   put '<BODY>';
   put '<BLOCKQUOTE>';
   put '<P><img src="' "&name..gif" '" title="Trig Waves (SAS/Graph gifanim)">';
   put '</BLOCKQUOTE>';
   put '</BODY>';
   put '</HTML>';

filename gifname "&name..gif";

/* Set the GOPTIONs necessary for the animation */
goption reset  
  device=gifanim  
  gsfname=gifname  
  gsfmode=replace      /* For the first graph, gsfmode=replace */
  disposal=background  /* none, background, previous, or unspecified */
  userinput            /* allow user input during animation, if supported by browser */
  delay=20             /* .20 seconds between images */
  iteration=2          /* loop through animation 2 time (0=endless) */
;

goptions noborder;
goptions cback=white;
goptions gunit=pct htitle=4 htext=3 ftitle="albany amt/bold" ftext="albany amt";
goptions xpixels=900 ypixels=600;

options nobyline;
title1 "Trig Wave Animation";
title2 "Angle = #byval(&by_var)";

axis1 order=(-1 to 1 by .5) value=(color=gray) minor=none offset=(0,0);
axis2 order=(0 to 720 by 90) value=(color=gray) minor=none offset=(0,0);

symbol1 color=cx66CD00 i=join value=none;
symbol2 color=cx66CD00 font="wingdings 3" v='70'x h=4.5 r=1;  /* green */
symbol3 color=cx6600FF i=join value=none;
symbol4 color=cx6600FF font="wingdings 2" v='98'x h=4.5 r=1;  /* purple */

legend1 label=none position=(right middle) value=(' ' 'Cosine' ' ' 'Sine') across=1;

proc gplot data=&dataset;
by &by_var notsorted;
plot &y_var*&x_var=&id_var /
 vref=(-.5 0 .5)
 cvref=(graydd black graydd)
 href=(90 180 270 360 450 540 630)
 chref=(graydd graydd graydd black graydd graydd graydd)
 vaxis=axis1
 haxis=axis2
 legend=legend1
 ;
run;

/*
Now, write out the end of the animatd gif trailer - otherwise it won't play in some gif players.

Internet Explorer will sometimes display animated GIFs that do not have it,
but the W3C spec says it is required.  Office 2002 and 2003 apparently do not
recognize the files unless they include this trailer.
*/
data _null_;
   file gifname recfm=n mod;
   put '3B'x;
run;

quit;
