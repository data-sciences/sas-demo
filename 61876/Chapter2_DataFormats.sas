
******************************************************;
* Data formats needed at the top of code to open     *;
* the chapter 2 dataset chapter2_data_ados           *;
******************************************************;


proc format;
     value txf      1 = 'A'                              
                    0 = '_B';
	 value sexf     1='Male'
				    0='_Female';
     value ynf      1='Yes'
				    0='_No';
run;
   
