libname SPI (SASUSER);                  /* location of data sets */

   ods exclude ModelANOVA;
   proc glm data=SPI.Vehicles;
      model Mpg_Hwy = Engine_Liters | Engine_Liters;
      output out=GLMOut P=Pred R=Resid;
   quit;

   /* compute mean of revenue for each rating category */
proc iml;
   use SPI.Movies;                    /* or use dobj.GetVarData()      */
   read all var {"MPAARating" "US_Gross"};
   close SPI.Movies;  

   u = unique(MPAARating);            /* find the MPAA categories      */
   NumGroups = ncol(u);               /* how many categories?          */
   GrossMean = j(1,NumGroups);        /* allocate a vector for results */
   do i = 1 to NumGroups;             /* for each group...             */
      idx = loc(MPAARating=u[i]);     /* find the movies in that group */
      m = US_Gross[idx];
      GrossMean[i] = m[:];            /* compute group mean            */
   end;
   print GrossMean[c=u];

quit;


