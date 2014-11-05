/*====================================================================*/
/*Establish connection to the default Format catalog */
libname FMTS '<configuration directory>\Lev1\SASApp\SASEnvironment\SASFormats';

/*Create the format and assigned to the FMTS library*/
PROC FORMAT lib=FMTS;
value $cust_grps
	"Bulls Eye Emporium" 	= "Convenience"
	"Harry Koger" 		= "Grocery"
	"Super Low Wholesaler" 	= "Grocery"
	"Nile Online" 		= "Web"
	other 				= "Other";
RUN;
/*====================================================================*/
