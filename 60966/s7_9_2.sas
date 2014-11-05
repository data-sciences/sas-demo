* S7_9_2.sas
*
* Creating concatenated fields.;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Combining Values in One Field';

proc report data=rptdata.clinics
            nowd;
   column region n
            ('Patient'
            ('   Weight' wt=wtmean wt wtval)  
            ('  Height' ht=htmean ht htval));  
   define region / group format=$regname. 'Area'; 
   define n      / format=3. ' N';  
   define wtmean / analysis mean noprint;  
   define wt     / analysis std  noprint;  
   define wtval  / computed ' Mean (SD)';  
   define htmean / analysis mean noprint;
   define ht     / analysis std  noprint;
   define htval  / computed 'Mean (SD)';

   * Combine the WT values;  
   compute wtval / char length=15;
      wtval = cats(put(wtmean,5.1),
                   ' (',
                   put(wt.std,7.1),
                   ')');
   endcomp;

   * Combine the HT values;
   compute htval / char length=15;
      htval = cats(put(htmean,5.1),' (',
                  put(ht.std,7.1),')');
   endcomp;
   run;
