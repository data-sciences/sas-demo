* E1_3_1.sas
*
* Using ? and ??;

data base;
input age ?? name $;
datalines;
15   Fred
14   Sally
x    John
run;
