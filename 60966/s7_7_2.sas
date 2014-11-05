* S7_7_2.sas
*
* Repeating Group variable values;

	proc format;
	   value $regname
	     '1','2','3' = 'No. East'  
	     '4'         = 'So. East'
	     '5' - '8'   = 'Mid West' 
	     '9', '10'   = 'Western';
	   run;
	
	title1 'Extending Compute Blocks';
	title2 'Repeating a Group Name';
	
	proc report data=rptdata.clinics
                       (where=(region in('1' '2' '3' '4')))
	            nowd split='*';
	   column region regname clinnum 
               ('Patient Weight' wt=wtn wt);
	   define region / group format=$regname. noprint;  
	   define regname/ computed  'Region';  
	   define clinnum/ group     'Clinic*Number';
	   define wtn    / analysis n 
	                   format=5. 'N';
	   define wt     / analysis mean 
	                   format=4. 'Mean';
	
	   compute before region;
		 * Load the formatted region into a temporary variable; 
	      rname = put(region,$regname.);  
	   endcomp;
	   compute regname / character  length=12;
		 * Move region from temporary variable to a report item;
	      regname = rname;  
	   endcomp;
	   break after region/ suppress skip;
	   run;
