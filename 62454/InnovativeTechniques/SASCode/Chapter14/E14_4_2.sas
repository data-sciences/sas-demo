*E14_4_2.sas
*
* Using DM commands;
dm log 'clear';

dm  af "pgm off; af cat = appls.allproj.passwd.program";

dm 'log; file "&path\logdump1.log"';

dm post "this is a message";

dm "post ""Use &path""";


dm 'wedit "C:\InnovativeTechniques\sascode\chapter14\e14_3_1.sas"' ;
%* alternate forms when a macro variable is present;
/*dm "wedit ""&path\SASCode\Chapter14\e14_3_1.sas""";*/
/*%unquote(dm %bquote(')wedit "&path\SASCode\Chapter14\e14_3_1.sas"%bquote(');)*/

dm "viewtable advrpt.demog colheading=names";

dm 'keydef f12 "log;clear"';

dm 'keydef "shf f9" "next VIEWTABLE:; end"'; 
