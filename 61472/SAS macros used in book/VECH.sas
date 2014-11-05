
/*======================= MACRO VECH ==========================
  Author:    Edward F. Vonesh, PhD 
  Written:   March 4, 2011      
  Modified:                                    
  Program:   This macro program performs the following:
          1) Macro VECH creates a vech representation of the 
             intra-cluster covariance matrix defined in the 
             NLMIXED code for any particular application that
             requires an intra-cluster or within-subject 
             covariance structure (see Ch. 5, Example 5.4.1)
===============================================================
 
 
===============================================================
  NOTES 1.This macro was written for applications involving  
          nonlinear mixed-effects models in which one wishes 
          to include an intra-subject covariance matrix using
          the NLMIXED procedure. The sole purpose of this
          macro is to provide a naming convention to the 
          variance-covariance parameters of the intra-subject
          covariance matrix so that one can easily specify 
          this covariance structure using the RANDOM statement
          in NLMIXED. Examples of its use are included at the 
          end of the macro code in this file as well as in 
          Chapter 5 (Examples 5.4.1, and 5.4.3).        
===============================================================
 
   Macro Key:
   DIM      = Defines the dimension of the within-subject     
              variance-covariance matrix that one wishes
              to include within a RANDOM statement of NLMIXED
   COV      = Defines the array name within the NLMIXED program
              that is used to define the within-subject      
              variance-covariance matrix. For example, if
              one were to define a 7 x 7 covariance matrix
              using the ARRAY statement 
                 ARRAY VARCOV[7,7];
              which one then assigns values to using DO 
              statements from within a call to NLMIXED, then
              one would specify 
                 COV=VARCOV
              The default value is
                 COV=cov 
              and there is very little reason to ever change 
              this default name.
   VECHCOV  = Defines the name of the VECH vector created by 
              the macro containing the unique lower diagonal 
              elements of the within-subject covariance matrix
              that is defined by the COV array name above. 
              The default value is
                 VECHCOV=vechcov 
              and there is very little reason to ever change 
              this default name.
   NAME     = Defines a prefix name for each of the lower      
              diagonal components of the variance-covariance 
              matrix, or equivalently, the vector components  
              of the VECH vector defined by VECHCOV. For 
              example, if one wishes all of the lower diagonal
              elements to start with the letters COV and the 
              dimension of the original covariance matrix is 
              say 5 x 5 then one would specify
                 NAME=COV
              and the VECHCOV vector would be a 15x1 vector of 
              dimension 15 = 5*(5+1)/2 with components
              VEC1, VEC2,...., VEC15. 
              The default value is
                 NAME=c 
              which makes inputting the covariance structure  
              in NLMIXED reasonably simple (see the orange
              tree example, Example 5.4.1 for an example).
=============================================================*/
%macro vech(dim=4, cov=cov, vechcov=vechcov, name=c);
    %global n vech;
    %let n=%eval(&dim*(&dim+1)/2);
    array &vechcov.[&n] &name.1-&name.&n;
    %let k=0;
    %do i=1 %to &dim;
     %do j=1 %to &i;
        %let k=%eval(&k+1);
        &vechcov.[&k] = &cov.[&i, &j];
     %end;
    %end;
    %let temp = &name.1;
    %do i=2 %to &n;
     %let temp=&temp,&name.&i;
    %end;
    %let vech = &temp;
%mend vech;
