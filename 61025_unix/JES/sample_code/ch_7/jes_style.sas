



/*=== Define the JES Style ===*/
PROC TEMPLATE;
	DEFINE STYLE JES; 
	PARENT=STYLES.D3D;
	STYLE Color_List from Color_List /
		'FGA'  = White    /* Title */
		'FGA3' = DarkBlue /* Table Headers */
 		'FGB2' = DarkBlue /* Links */
    	'BGA'  = cx666699 /* Background */
    	'BGA2' = White    /* Table Cell Background */
		'BGA3' = GRAYB0   /* TOC and Table Header Background */;
   	STYLE Colors from Colors/
		'datafg' = Color_List('FGA3')  /* Table cell foreground */ 	;
	STYLE GraphColors from GraphColors/
		'gwalls' = White;    /* Background of the plot area */
	CLASS  GraphBackground from GraphBackground/ /*Background of the area around the plot */
		BackgroundColor=Color_List('BGA3'); 
	END;
RUN; 

/* Add url information for links */
DATA Results_Tab_2; SET JES.Results_Tab_2;
	Print_Link = CATS('<A HREF="',Vendor,'.html" 
		TARGET="_blank">',Vendor,'</A>');
	LABEL Print_Link="Vendor";
RUN;
DATA Results_Tab; SET JES.Results_Tab;
	Report_Link=CATS(Vendor,'.html');
	Point_Link=CATS('HREF="',Vendor,'.html"');
	Legend_Link=CATS('HREF="',Vendor,'.html" TARGET="_blank"');
RUN;


/*=== Create a web page using the JES Style ===*/
OPTIONS NODATE;
GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT HTEXT=4 HTITLE=5 HSIZE=9IN VSIZE=6IN; 
ODS LISTING CLOSE;
	AXIS1 OFFSET=(5,5);
	SYMBOL1 COLOR=Red   HEIGHT=3 VALUE=Square   I=JOIN;
	SYMBOL2 COLOR=Blue  HEIGHT=3 VALUE=Triangle I=JOIN;
	SYMBOL3 COLOR=Green HEIGHT=3 VALUE=Circle   I=JOIN;
ODS HTML PATH="&JES.ods_output/page4" (URL=NONE)
	BODY="Jes_Body.html"
	CONTENTS="Jes_TOC.html"
	FRAME = "Jes_Frame.html"
	STYLE=JES;
	%INCLUDE "&JES.sample_code/ch_7/vendors_1a.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_2b.sas";
	%INCLUDE "&JES.sample_code/ch_7/vendors_3a.sas";
ODS HTML CLOSE;
ODS LISTING;












