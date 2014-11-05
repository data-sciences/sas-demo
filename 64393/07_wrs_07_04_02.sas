/*Create a format with the preferred sort order for the values */
libname mylib ‘c:\’;

proc format lib=mylib;
value fmt_product	
 1= “Boot” 		    
 2= “Men’s Casual”   
 3= “Women’s Casual” 
 4= “Men’s Dress”    
 5= “Women’s Dress”  
 6= “Sandal”  	    
 7= “Slipper”  	    
 8= “Sport Shoe” ;
run;

libname sasenv
 “<configuration directory>\Lev1\SASApp\SASEnvironment\SASFormats”;

options fmtsearch=(sasenv);

/*register the format in the catalog */
proc catalog cat=exists.formats;
    copy out=sasenv.formats;
run;

/*Create a second version of dataset with new format */
libname sales meta library=”Sales Data” metaout=data;

data sales.newshoes;
set sales.shoes;

if PRODUCT = “Boot” 		then NEWPRODUCT=1;
if PRODUCT = “Men’s Casual” 	then NEWPRODUCT=2;
if PRODUCT = “Women’s Casual” then NEWPRODUCT=3;
if PRODUCT = “Men’s Dress” 	then NEWPRODUCT=4;
if PRODUCT = “Women’s Dress” 	then NEWPRODUCT=5;
if PRODUCT = “Sandal” 		then NEWPRODUCT=6;
if PRODUCT = “Slipper” 		then NEWPRODUCT=7;
if PRODUCT = “Sport Shoe” 	then NEWPRODUCT=8;

format NEWPRODUCT fmt_product.;
run;
/*END OF PROGRAM */
