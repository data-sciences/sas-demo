filename in  "input.txt";
filename out "output.txt";

data _null_;
file in;
input; 
put infile_;
datalines4;
GET /index.html HTTP/1.1

;;;;

proc http in=in out=out url="http://<server-name>";
run;

