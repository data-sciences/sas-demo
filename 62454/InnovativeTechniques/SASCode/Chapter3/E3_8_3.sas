*E3_8_3.sas
*
* DATA step execution;

data a;
if eof then put total=;
set sashelp.class end=eof;
end=eof;
total+age;
put 'last ' age= total= eof=;
run;
