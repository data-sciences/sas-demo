%let name=example07;
filename odsout '.';


goptions device=png;
goptions border;
 
ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" (title="Space Around Graph") style=minimal;

goptions gunit=pct htitle=4.0 htext=2.25  ftitle="albany amt/bo" ftext="albany amt";

axis1 label=none minor=none;
axis2 label=none value=(angle=90);

pattern1 v=solid color=grayee;

title1 ls=3.5 "Main Title, with ls=3.5";
title2 h=5 "title2 h=5";
title3 h=7 a=90 "h=7 a=90";
title4 h=15 a=-90 "h=15 a=-90";
footnote1 h=10 "footnote h=10";
footnote2 h=2 "footnote2 h=2";

proc gchart data=sashelp.class;
vbar name / type=sum sumvar=height descending
 raxis=axis1 maxis=axis2
 des='' name="&name";
run;

title1 ls=3.5 "Same Graph, with Blank Titles";
title2 h=5 " ";
title3 h=7 a=90 " ";
title4 h=15 a=-90 " ";
footnote1 h=10 " ";
footnote2 h=2 " ";

proc gchart data=sashelp.class;
vbar name / type=sum sumvar=height descending
 raxis=axis1 maxis=axis2
 des='' name="&name";
run;


quit;
ODS HTML CLOSE;
ODS LISTING;
