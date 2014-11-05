/*-------------------------------------------------------------------*/
 /*       Applied Multivariate Statistics with SAS Software           */
 /*          by Ravindra Khattree and Dayanand N. Naik                */
 /*       Copyright(c) 1999 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 56903                  */
 /*                        ISBN 1-58025-357-1                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Ravindra Khattree and Dayanand N. Naik                      */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Ravindra Khattree and Dayanand N. Naik           */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

/* Program 1.1 */
        options ls=64 ps=45 nodate nonumber;
        data cork; 
        infile 'cork.dat' firstobs = 1;
        input north east south west;
        proc calis  data = cork kurtosis;
        title1 j=l "Output 1.1";
        title2 "Computation of Mardia's Kurtosis";
        lineqs
        north = e1,
        east = e2,
        south = e3,
        west = e4;
        std 
        e1=eps1, e2=eps2, e3=eps3, e4=eps4;
        cov 
        e1=eps1, e2=eps2, e3=eps3, e4=eps4;
        run ;


        /* Program 1.2 */
        
        title 'Output 1.2';
        options ls = 64 ps=45 nodate nonumber;

        /* This program is for testing the multivariate 
        normality using Mardia's skewness and kurtosis measures.  
        Application on C. R. Rao's cork data */

        proc iml ; 
        y ={
        72 66 76 77,
        60 53 66 63,
        56 57 64 58,
        41 29 36 38,
        32 32 35 36,
        30 35 34 26,
        39 39 31 27,
        42 43 31 25,
        37 40 31 25,
        33 29 27 36,
        32 30 34 28,
        63 45 74 63,
        54 46 60 52,
        47 51 52 43,
        91 79 100 75,
        56 68 47 50,
        79 65 70 61,
        81 80 68 58,
        78 55 67 60,
        46 38 37 38,
        39 35 34 37,
        32 30 30 32,
        60 50 67 54,
        35 37 48 39,
        39 36 39 31,
        50 34 37 40,
        43 37 39 50,
        48 54 57 43} ;
        /* Matrix y can be created from a SAS data set as follows:
        data cork;
        infile 'cork.dat';
        input y1 y2 y3 y4;
        run;
        proc iml;
        use cork;
        read all into y;



        See Appendix 1 for details.
        */ 
        /* Here we determine the number of data points and the dimension 
        of the vector. The variable dfchi is the degrees of freedom for 
        the chi square approximation of Multivariate skewness. */

        n = nrow(y) ; 
        p = ncol(y) ; 
        dfchi = p*(p+1)*(p+2)/6 ;

        /* q is projection matrix, s is the maximum likelihood estimate 
        of the variance covariance matrix, g_matrix is n by n the matrix 
        of g(i,j) elements, beta1hat and beta2hat are respectively the 
        Mardia's sample skewness and kurtosis measures, kappa1 and kappa2 
        are the test statistics based on skewness and kurtosis to test 
        for normality and pvalskew and pvalkurt are corresponding p 
        values. */

        q = i(n) - (1/n)*j(n,n,1);
        s = (1/(n))*y`*q*y ; s_inv = inv(s) ;
        g_matrix = q*y*s_inv*y`*q;
        beta1hat = (  sum(g_matrix#g_matrix#g_matrix)  )/(n*n);
        beta2hat =trace(  g_matrix#g_matrix  )/n ;

        kappa1 = n*beta1hat/6 ;
        kappa2 = (beta2hat - p*(p+2) ) /sqrt(8*p*(p+2)/n) ;

        pvalskew = 1 - probchi(kappa1,dfchi) ;
        pvalkurt = 2*( 1 - probnorm(abs(kappa2)) ); 
        print s ; 
        print s_inv ;
        print 'TESTS:';
        print 'Based on skewness: ' beta1hat kappa1 pvalskew ;
        print 'Based on kurtosis: ' beta2hat kappa2 pvalkurt;



/* Program 1.3 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 1.3';
title2 'Testing Multivariate Normality (Cube Root Transoformation)';

data D1;
infile 'cork.dat';
input t1 t2 t3 t4 ;
/* 
t1=north, t2=east, t3=south, t4=west 
n is the number of observations
p is the number of variables
*/
data D2(keep=t1 t2 t3 t4 n p);
set D1;
n=28;
p=4;
run;
data D3(keep=n p);
set D2;
if _n_ > 1 then delete;
run;
proc princomp data=D2 cov std out=D4 noprint;
var t1-t4;
data D5(keep=n1 dsq n p);
set D4;
n1=_n_;
dsq=uss(of prin1-prin4);
run;
data D6(keep=dsq1 n1 );
set  D5;
dsq1=dsq**((1.0/3.0)-(0.11/p));
run;

proc iml;
use D3;
read all var {n p};
u=j(n,1,1);
use D6;
do k=1 to n;
setin D6 point 0;
sum1=0;
sum2=0;
do data;
read next var{dsq1 n1} ;
if n1 = k then dsq1=0;
sum1=sum1+dsq1**2;
sum2=sum2+dsq1;
end;
u[k]=(sum1-((sum2**2)/(n-1)))**(1.0/3);
end;
varnames={y};
create tyy from u (|colname=varnames|);
append from u;
close tyy;
run;
quit;

data D7;
set D6; set tyy;
run;
proc corr data=D7 noprint outp=D8;
var dsq1;
with y;
run;
data D9;
set D8;
if _TYPE_ ^='CORR' then delete;
run;
data D10(keep=zp r tnp pvalue);
set D9(rename=(dsq1=r));
set D3;
zp=0.5*log((1+r)/(1-r));
b1p=3-1.67/p+0.52/(p**2);
a1p=-1.0/p-0.52*p;
a2p=0.8*p**2;
mnp=(a1p/n)-(a2p/(n**2));
b2p=1.8*p-9.75/(p**2);
ssq1=b1p/n-b2p/(n**2);
snp=ssq1**0.5;
tnp=abs(abs(zp-mnp)/snp);
pvalue=2*(1-probnorm(tnp));
run;
proc print data=D10;
run;




        /* Program 1.4 */

        options ls = 64 ps=45 nodate nonumber;
        title1 'Output 1.4';

        /* Generate n random vector from a p dimensional population 
        with mean mu and the variance covariance matrix sigma */

        proc iml ;
        seed = 549065467 ;
        n = 4 ;
        sigma = { 4 2 1,
                  2 3 1,
                  1 1 5 };

        mu = {1, 3, 0};
        p = nrow(sigma); 
        m = repeat(mu`,n,1) ;
        g =root(sigma);
        z =normal(repeat(seed,n,p)) ;
        y = z*g + m ;
        print 'Multivariate Normal Sample';
        print y;


        options ls=64 ps=45 nodate nonumber; 
        title1 'Output 1.5'; 
        /* Generate n Wishart matrices of order p by p 
        with degrees of freedom f */
 
        proc iml;
        n = 4 ; 
        f = 7 ;


        seed = 4509049 ;
        sigma = {4 2 1,
                 2 3 1,
                 1 1 5 } ;
        g = root(sigma);
        p = nrow(sigma) ;
        print 'Wishart Random Matrix'; 
        do i = 1 to n ;
        t = normal(repeat(seed,f,p)) ;
        x = t*g ;       
        w = x`*x ;
        print w ; /* Program 2.1 */

        filename gsasfile "prog21a.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=40 nodate nonumber;
        title1 h=1.5 'Two Dimensional Scatter Plot '; 
        title2 j=l 'Output 2.1';
        title3 'Cork Data: Source C.R. Rao (1948)'; 
        data cork;
        infile 'cork.dat';
        input n e s w; * n:north,e:east,s:south,w:west;
        run;
        proc gplot data=cork;
        plot n*e='star';
        label n='Direction: North'
      e='Direction: East';
        run;

        data d1;
        set cork;
        y1=n-s; 
        y2=e-w;
        run;
        filename gsasfile "prog21b.graph";
        title1 h=1.5 'Two Dimensional Scatter Plot of Contrasts';
        title2 j=l 'Output 2.1';
        title3 'Cork Data: Source C.R. Rao (1948)'; 
        proc gplot data=d1;                                                    
        plot y1*y2='star';

label y1='Contrast: North-South' 
      y2='Contrast: East-West';
        run;

        data d2 d3;
        set cork;
        proc sort data=d2;
        by n;
        data d3;
        set d3;
        n_decr=n;
        drop n;
        proc sort data=d3;
        by descending n_decr;
        data both;
        merge d2 d3;
        filename gsasfile "prog21c.graph";      
        title1 h=1.5 'Testing Symmetry of Data on North Direction';
        title2 j=l 'Output 2.1';
        title3 'Cork Data: Source C.R. Rao (1948)'; 
        proc gplot data=both;                                                    
        plot n_decr*n='star';
        label n_decr='Descending Ordered Data' 
        n='Ascending Ordered Data';
        run;
  
 
        /* Program 2.2 */

        filename gsasfile "prog22.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=45 nodate nonumber;
        data cork;
        infile 'cork.dat';
        input n e s w;
        title1 h=1.5 'Three-D Scatter Plot for Cork Data';
        title2 j=l 'Output 2.2';
 
        title3 'by weight of cork boring';
        title4 'Source: C.R. Rao (1948)';
        footnote1 j=l 'N:Cork boring in North'
                  j=r 'E:Cork boring in East';
        footnote2 j=l 'S:Cork boring in South'
                  j=r 'W:West boring is not shown';
        proc g3d data=cork;
        scatter n*s=e;
        run;

/* Program 2.3 */

        filename gsasfile "prog23.graph";
        goptions gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in; 
        options ls=64 ps=40 nodate nonumber;
        data cork;
        infile 'cork.dat';                                                            
        input n e s w;                                                                 
        c1=n-e-w+s;                                                                     
        c2=n-s;                                                                         
        c3=e-w;                                                                         
        title1 h=1.5 'Three-Dimensional Scatter Plot for Cork Data';
        title2 j=l 'Output 2.3';
        title3 'Contrasts of weights of cork boring';
        title4 'Source: C.R. Rao (1948)';
        footnote1 j=l 'C1:Contrast N-E-W+S'
                  j=r 'C2:Contrast N-S';
        footnote2 j=r 'C3:Contrast E-W';
        proc g3d data=cork;
        scatter c1*c2=c3;
        run;

/* Program 2.4 */

        filename gsasfile "prog24.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;                      
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=40 nodate nonumber;                                            
        title1 h=1.5 'Scatter Plot Matrix for Cork Data';
        title2 'Output 2.4';
        data cork;
        infile 'cork.dat';
        input n e s w;
        proc insight data=cork;
        run;




/* Program 2.5 */
         
        filename gsasfile "prog25.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        options ls=64 ps=45 nodate nonumber;
        data cork;
        infile 'cork.dat';
        input y1 y2 y3 y4; /*y1=north, y2=east, y3=south, y4=west*/
        tree=_n_;
        proc transpose data=cork
        out=cork2 name=directn;
        by tree;
        proc gplot data=cork2(rename=(col1=weight));
        /* 
           data plot; 
           set cork;
           array y{4} y1 y2 y3 y4;
           do directn=1 to 4;
           weight =y(directn); 
           output; 
           end;


           drop y1 y2 y3 y4;
           proc gplot data=plot;
        */
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        plot weight*directn=tree/
                vaxis=axis1 haxis=axis2 legend=legend1;
        axis1 label=(a=90 h=1.2 'Standardized Weight of Cork Boring');
        axis2 offset=(2) label=(h=1.2 'Direction');

        symbol1 i=join v=star;
        symbol2 i=join v=+;
        symbol3 i=join v=A;
        symbol4 i=join v=B;
        symbol5 i=join v=C;
        symbol6 i=join v=D;     
        symbol7 i=join v=E;
        symbol8 i=join v=F;
        symbol9 i=join v=G;
        symbol10 i=join v=H;
        symbol11 i=join v=I;
        symbol12 i=join v=J;
        symbol13 i=join v=K;
        symbol14 i=join v=L;
        symbol15 i=join v=M;
        symbol16 i=join v=N;
        symbol17 i=join v=O;
        symbol18 i=join v=P;
        symbol19 i=join v=Q;
        symbol20 i=join v=R;
        symbol21 i=join v=S;
        symbol22 i=join v=T;
        symbol23 i=join v=U;
        symbol24 i=join v=V;
        symbol25 i=join v=W;
        symbol26 i=join v=X;
        symbol27 i=join v=Y;
        symbol28 i=join v=Z;  
        legend1 across=4;
        title1 h=1.5 'Profiles of Standardized Cork Data';
        title2 j=l 'Output 2.5';
        title3 'Source: C.R. Rao (1948)';
        run;


/* Program 2.6 */

        filename gsasfile "prog26.graph";                                             
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;                     
        options ls=64 ps=40 nodate nonumber;                                            
        title1 h=1.5 'Andrews Function Plot for Cork Data';
        *title1 h=1.5 'Modified Andrews Function Plot for Cork Data';
        title2 j=l 'Output 2.6'; 
        data andrews;                                                                   
        infile 'cork.dat';                                                            
        input y1-y4;
        tree=_n_;
        pi=3.14159265;                                                                  
        s=1/sqrt(2);                                                                    
        inc=2*pi/100;
        /* The function z defines the Andrews function and is used for 
        plotting Andrews plot.  The function mz defines the Modified 
Andrews 
        function and is used for plotting Modified Andrews plot. */
                                                                      
        do t=-pi to pi by inc;                                                         
        z=s*y1+sin(t)*y2+cos(t)*y3+sin(2*t)*y4;                                        
        *mz=s*(y1+(sin(t)+cos(t))*y2+(sin(t)-cos(t))*y3+
        (sin(2*t)+cos(2*t))*y4);
        output;
        end;

        symbol1 i=join v=star;
        symbol2 i=join v=+;
        symbol3 i=join v=A;
        symbol4 i=join v=B;
        symbol5 i=join v=C;
        symbol6 i=join v=D;
        symbol7 i=join v=E;
        symbol8 i=join v=F;
        symbol9 i=join v=G;
        symbol10 i=join v=H;
        symbol11 i=join v=I;
        symbol12 i=join v=J;
        symbol13 i=join v=K;
        symbol14 i=join v=L;
        symbol15 i=join v=M;
        symbol16 i=join v=N;
        symbol17 i=join v=O;
        symbol18 i=join v=P;
        symbol19 i=join v=Q;
        symbol20 i=join v=R;
        symbol21 i=join v=S;
        symbol22 i=join v=T;
        symbol23 i=join v=U;
        symbol24 i=join v=V;



        symbol25 i=join v=W;
        symbol26 i=join v=X;
        symbol27 i=join v=Y;
        symbol28 i=join v=Z; 
        legend1 across=4;
        proc gplot data=andrews;                                                     
        plot z*t=tree/vaxis=axis1 haxis=axis2 legend=legend1;
        *plot mz*t=tree/vaxis=axis1 haxis=axis2 legend=legend1;
        axis1 label=(a=90 h=1.5 f=duplex 'f(t)');
        axis2 label=(h=1.5 f=duplex 't')offset=(2);
        run;



        /* Program 2.7 */

        filename gsasfile "prog27.graph"; 
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;  
        goptions horigin=1in vorigin=2in;
        goptions hsize=7in vsize=8in;           
        options ls=64 ps=45 nodate nonumber;
        title1 'Output 2.7';
        data cork;
        infile 'newcork.dat';
        input tree$ north east south west; 
        %include biplot; /* Include the macro "biplot.sas" */
        %biplot( data = cork, var = North East South West,                
                 id = TREE, factype=SYM, std =STD  );                                  
        proc gplot data=biplot;                                                        
        plot dim2 * dim1  /anno=bianno frame                                      
                  href=0 vref=0 lvref=3 lhref=3                          
                  vaxis=axis2 haxis=axis1 vminor=1 hminor=1; 
        axis1 length=6 in order=(-.8 to .8 by .2)          
                offset=(2) label = (h=1.3 'Dimension 1');
        axis2 length=6 in order =(-.8 to .8 by .2)                                  
                offset=(2) label=(h=1.3 a=90 r=0  'Dimension 2');
        symbol v=none;
        title1 h=1.5 'Biplot of Cork Data ';
        title2 j=l 'Output 2.7';
        title3 'Observations are points, Variables are vectors';                       
        run;


/* The BIPLOT Macro: biplot.sas */

%macro BIPLOT(                                                             
        data=_LAST_,                                                            
        var =_NUMERIC_,

                                                         
         id = ID,                                                               
        dim = 2,                                                                
     factype=SYM,                                                               
       scale=1,                                                                 
         out=BIPLOT,                                                            
        anno=BIANNO,                                                            
         std=MEAN,                                                              
       pplot=YES);                                                              
                                                                                
%let factype=%upcase(&factype);                                                 
       %if &factype=GH  %then %let p=0;                                         
%else  %if &factype=SYM %then %let p=.5;                                        
%else  %if &factype=JK  %then %let p=1;                                         
%else %do;                                                                      
   %put  BIPLOT:  FACTYPE must be GH, SYM, or JK.
        "&factype" is not valid.;       
   %goto done;                                                                  
   %end;                                                                        
                                                                                
Proc IML;                                                                       
Start BIPLOT(Y,ID,VARS,OUT,power,scale);                                        
   N = nrow(Y);                                                                 
   P = ncol(Y);                                                                 
   %if &std = NONE                                                              
       %then Y = Y - Y[:] %str(;);    /*remove grand mean */       
       %else Y = Y - J(N,1,1)*Y[:,] %str(;); /*remove column means*/       
   %if &std = STD %then  %do;                                                   
       S = sqrt(Y[##,]);                                                
       Y = Y * diag (1/S);                                                      
   %end;                                                                        
                                                                                
*_ _  Singular value decomposition:                                             
       Y is expressed as U diag(Q) V prime                                      
       Q contains singular values in descending order;                          
   call svd(u,q,v,y);                                                           
                                                                                
   reset fw=8 noname;                                                           
   percent = 100*q##2 / q[##];                                                  
      *__ cumulate by multiplying by lower 
triangular matrix of 1s;             
                                                                                
    j = nrow(q);                                                                
    tri = (1:j)` * repeat(1,1,j) >= repeat(1,j,1)*(1:j);                        
    cum = tri*percent;                                                          
    Print "Singular values and variance accounted for",,                        
           q       [colname={'Singular Values'} format=9.4]                     
           percent [colname={'Percent'} format=8.2]                             
           cum     [colname={'cum % '} format = 8.2];                           
                                                                                
     d = &dim;                                                                  
    *__extract  first d columns of U & V,and first d elements of Q;            
                                                                                
      U=U[,1:d];                                                                
      V=V[,1:d];                                                                
      Q=Q[1:d];                                                                 
                                                                                
     *__ scale the vectors by QL ,QR;                                           
                                                                                
     QL= diag(Q ## power);                                                      


     QR= diag(Q ## (1-power));                                                  
     A = U * QL;                                                                
     B = V * QR # scale;                                                        
     OUT=A // B;                                                                
                                                                                
     *__ Create observation labels;                                             
     id = id // vars`;                                                           
     type = repeat({"OBS "},n,1) //  repeat({"VAR "},p,1);                        
      id  = concat(type,id);                                                    
                                                                                
     factype = {"GH" "Symmetric" "JK"}[1+2#power];                              
     print "Biplot Factor Type",factype;                                        
     cvar = concat(shape({"DIM"},1,d),char(1:d,1.));                            
     print "Biplot coordinates",                                                
            out[rowname=id colname=cvar];                                       
     %if &pplot = YES %then                                                     
     call pgraf(out,substr(id,5),'Dimension 1','Dimension 2','Biplot');         
     ;                                                                          
     create &out from out[rowname=id colname=cvar];                             
     append from out[rowname=id];                                               
    finish;                                                                     
                                                                                
      use &data;                                                                
      read all var{&var} into y[colname=vars rowname=&id];                      
      power=&p;                                                                 
      scale=&scale;                                                             
      run biplot(y,&id,vars,out,power,scale);                                   
      quit;                                                                     
                                                                                
     /*__ split id into _type_ and _Name_*/                                     
                                                                                
      data &out;                                                                
           set &out;                                                            
           drop id;                                                             
           length _type_  $3 _name_ $16;                                        
           _type_ = scan(id,1);                                                 
           _name_ = scan(id,2);                                                 
                                                                                
       /*Annotate  observation labels and variable vectors */                   
       data &anno;                                                              
            set &out;                                                           
            length function text $8;                                            
            xsys='2'; ysys='2';                                                 
            text=_name_;                                                        
                                                                                
        if _type_='OBS' then do;                                                
            color = 'BLACK';                                                    
            x = dim1;y = dim2;                                                  
            position='5';                                                       
            function='LABEL     ';output;                                       
            end;                                                                
                                                                                
         if _type_ ='VAR' then do;    /*Draw  line from*/          
            color='RED   ';                                                     
            x=0; y=0;                /*the origin to*/             
            function ='MOVE'     ;output;                                       
            x=dim1;y=dim2;             /* the variable point*/       
            function ='DRAW'     ;output;                                       
            if dim1>=0
                                                        
                then position ='6';        /*left justify*/             
                else position ='2';        /*right justify*/            
            function='LABEL      ';output;  /* variable name */          
            end;                                                                
                                                                                
 %done:                                                                         
 %mend BIPLOT;                                                                  
run;                                                                                



        /* Program 2.8 */
                                                              
        filename gsasfile "prog28.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=45 nodate nonumber;
        title1 h=1.5 'Q-Q Plot for Assessing Normality';

        title2 j=l 'Output 2.8';
        title3 'Cork Data';                                                      
        data a;                                                                         
        infile 'cork.dat';                                                            
        input y1-y4;      
        proc princomp data=a cov std out=b noprint;                                     
        var y1-y4;                                                                      
        data chiq;                                                                      
        set b;                                                                          
        dsq=uss(of prin1-prin4);                                                        
        proc sort; 
        by dsq;                                                              
        proc means noprint;                             
        var dsq;                                                                       
        output out=chiqn n=totn;                                                       
        data chiqq;                                                                    
        if(_n_=1) then set chiqn;                                                      
        set chiq; 
        novar=4; /* novar=number of variables. */
        chisq=cinv(((_n_-.5)/ totn),novar);
        if mod(_n_,2)=0 then chiline=chisq;
        proc gplot;                          
        plot dsq*chisq chiline*chisq/overlay;                                   
        label dsq='Mahalanobis D Square'                                                
            chisq='Chi-Square Quantile';
        symbol1 v=star;
        symbol2 i=join v=+;                                              
        run;     


/* Program 2.9 */

        filename gsasfile "prog29a.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=45 nodate nonumber;
        data a;                                                                         
        infile 'cork.dat';                                                            
        input y1-y4;
        run;
        proc princomp data=a cov std out=b noprint;                                     
        var y1-y4;
        run;
        data qq;                                                                        
        set b;                                                                          
        dsq=uss(of prin1-prin4);
        run;
        title1 h=1.5 'Q-Q Plot for Assessing Normality';
        title2 j=l 'Output 2.9';
        title3 'Cork Data';                        
        proc capability data=qq noprint graphics;
        qqplot dsq/gamma(alpha=2 sigma=2 theta=0);
        run;

filename gsasfile "prog29b.graph";
        title1 h=1.5 'PROB Plot for Assessing Normality';
        title2 j=l 'Output 2.9';
        title3 'Cork Data';                        
        proc capability data=qq noprint graphics;
        probplot dsq/gamma(alpha=2 sigma=2 theta=0);
        run;

        filename gsasfile "prog29c.graph";
        title1 h=1.5 'P-P Plot for Assessing Normality';
        title2 j=l 'Output 2.9';
        title3 'Cork Data';                        
        proc capability data=qq noprint graphics;
        ppplot dsq/gamma(alpha=2 sigma=2 theta=0);
        run;



/* Program 2.10 */                                                              

        filename gsasfile "prog210.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        options ls=64 ps=45 nodate nonumber;
        title1 'Output 2.10';       
        data a;                                                                         
        infile 'cork.dat';                                                            
        input y1-y4;                                                                    
        totn=28.0; * totn is the no. of observations;
        novar=4.0; * novar=number of variables;
        proc princomp data=a cov std out=b noprint;                                     
        var y1-y4;                                                                      
        data chiq;                                                                      
        set b;                                                                          
        tree=_n_;
        dsq=uss(of prin1-prin4); 
        rdsq=(totn/(totn-1))**2*(((totn-2)*dsq/(totn-1))/
                        (1-(totn*dsq/(totn-1)**2)));       
        proc sort; 
        by rdsq;
        data chiq; 
        set chiq;
        chisq=cinv(((_n_-.5)/ totn),novar);
        if mod(_n_,2)=0 then chiline=chisq; 
        run;
        proc print data=chiq;
        var tree rdsq chisq;
        run;
        proc gplot;                            
        plot rdsq*chisq chiline*chisq/overlay;                          
        label rdsq='Robust Mahalanobis D Square'                                        
              chisq='Chi-Square Quantile';
        symbol1 v=star;
        symbol2 i=join v=+;
        title1 h=1.5 'Chi-square Q-Q Plot of Robust Squared Distances';
        title2 j=l 'Output 2.10';
        run;


/* Program 2.11 */                                           

        filename gsasfile "prog211.graph";                      
        goptions reset=all gaccess=gsasfile  autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;                     
        options ls=64 ps=45 nodate nonumber;                                           
        title1 h=1.5 'PDF of Bivariate Normal Distribution';
        title2 j=l 'Output 2.11'; 
        title3 'Mu_1=0, Mu_2=0, Sigma_1^2=2, Sigma_2^2=1 and Rho=0.5';
        data normal;                                                                   
        mu_1=0.0;
        mu_2=0.0;
        vy1=2; 
        vy2=1; 
        rho=.5;                                                             
        keep y1 y2 z;                                          
        label z='Density';                                                              
        con=1/(2*3.141592654*sqrt(vy1*vy2*(1-rho*rho)));       
        do y1=-4 to 4 by 0.10;                                  
        do y2=-3 to 3 by 0.10;                                 
        zy1=(y1-mu_1)/sqrt(vy1); 
        zy2=(y2-mu_2)/sqrt(vy2);                                                   
        hy=zy1**2+zy2**2-2*rho*zy1*zy2;                        
        z=con*exp(-hy/(2*(1-rho**2)));                                                  
        if z>.001 then output;                                                          
        end; 
        end;                                                                       
        proc g3d data=normal; 
        plot y1*y2=z;
        *plot y1*y2=z/ rotate=30;
        run;


        /* Program 2.12 */                              

        filename gsasfile "prog212.graph";   
        goptions reset=all gaccess=gsasfile  autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;     
        options ls=64 ps=45 nodate nonumber;     
        title1 h=1.5 'Contours of Bivariate Normal Distribution'; 
        title2 j=l 'Output 2.12';
        title3 'Mu_1=0, Mu_2=0, Sigma_1^2=2, Sigma_2^2=1 and Rho=0.5';
        data normal;                                                                   
        vy1=2; 
        vy2=1; 
        rho=.5;                                 
        keep y1 y2 z;                             
        label z='Density';                        
        con=1/(2*3.141592654*sqrt(vy1*vy2*(1-rho*rho)));
        do y1=-4 to 4 by 0.3;                     
        do y2=-3 to 3 by 0.10;                    
        zy1=y1/sqrt(vy1); 
        zy2=y2/sqrt(vy2);                                                   
        hy=zy1**2+zy2**2-2*rho*zy1*zy2;
        z=con*exp(-hy/(2*(1-rho**2)));                                                  
        if z>.001 then output;                                                          
        end; 
        end;                                                                       
        proc gcontour data=normal;                                                      
        plot y2*y1=z/levels=.02 .03 .04 .05 .06 .07 .08;
        run;




        /* Program 3.1 */

        options ls=64 ps=45 nodate nonumber; 
        data cork; 
        infile 'cork.dat' firstobs = 1 ;
        input north east south west;
        y1=north;
        y2=east;
        y3=south;
        y4=west;
        /* Hotelling's T-square by creating the differences */
        dne=y1-y2;
        dns=y1-y3;
        dnw=y1-y4;
        proc glm data=cork;




        manova h=intercept;
        title1 ' Output 3.1 ';
        title2 ' Equality of the Components of the Mean Vector ';
        title3 ' Cork Data';
        run;


/* Program 3.2 */

        options ls=64 ps=45 nodate nonumber;
        data cork; 
        infile 'cork.dat' firstobs=1;
        input north east south west;
        y1=north;
        y2=east;
        y3=south;
        y4=west;
        /* Hotelling's T-square using m = option*/
        proc glm data=cork;
        model y1 y2 y3 y4= /nouni;
        manova h=intercept
        m=y2-y1, y3-y1, y4-y1
        mnames=d1 d2 d3;
        title1 ' Output 3.2 ' ;
        title2 'Use of m=option for Testing Equal Means for Cork Data';
        run;


        /* Program 3.3 */

        options ls=64 ps=45 nodate nonumber;  
        title1 'Output 3.3';
        data fish;
        infile 'fish.dat' firstobs = 1;
        input p1 p2 p3 p4 p5 dose wt @@;
        y1=arsin(sqrt(p1));
        y2=arsin(sqrt(p2));
        y3=arsin(sqrt(p3));
        y4=arsin(sqrt(p4));
        y5=arsin(sqrt(p5));
        x1=log(dose); 
        x2=wt;
        proc print data=fish;
        var p1 p2 p3 p4 p5 dose x2;
        title2 'Data on Proportions of Dead Fish';
        run;
        proc print data=fish;
        var y1 y2 y3 y4 y5 x1 x2;
        title2 'Transformed Fish Data';
        run;
        proc glm data=fish;
        model y1 y2 y3 y4 y5=x1 x2/nouni;
        manova h=x1 x2/printe printh;
        title2 'Multivariate Regression for Fish Data';
        run;
        /* 
        mtest option of proc reg can be used instead of manova 
        option of proc glm to get the same results.  This is done 
        using the last two statements of the following program. 
        */
        proc reg data=fish;
        model y1 y2 y3 y4 y5=x1 x2;
        Model: mtest x1, x2/print;
        Onlyx1: mtest x1/print;
        Onlyx2: mtest x2/print;





        /* Program 3.4 */                                                               

        options ls=64 ps=45 nodate nonumber;
        data fish;
        infile 'fish.dat';
        input p1 p2 p3 p4 p5 dose wt @@;
        y1=arsin(sqrt(p1));
        y2=arsin(sqrt(p2));
        y3=arsin(sqrt(p3));
        y4=arsin(sqrt(p4));
        y5=arsin(sqrt(p5));
        x1=log(dose);
        x2=wt;
        title1 'Output 3.4 ';
        title2 ' Stepdown Analysis';
        /*The following program performs the Stepdown Analysis */
        proc reg data=fish;
        model y1=x1 x2;
        fishwt: test x2=0.0;
        fmodel: test x1=0.0,x2=0.0;
        proc reg data=fish;
        model y2=x1 x2 y1;
        fishwt: test x2=0.0;
        fmodel: test x1=0.0,x2=0.0;
        proc reg data=fish;
        model y3=x1 x2 y1 y2;
        fishwt: test x2=0.0;
        fmodel: test x1=0.0,x2=0.0;
        proc reg data=fish;
        model y4=x1 x2 y1 y2 y3;
        fishwt: test x2=0.0; 
        fmodel: test x1=0.0,x2=0.0; 
        proc reg data=fish;
        model y5=x1 x2 y1 y2 y3 y4; 
        fishwt: test x2=0.0;
        fmodel: test x1=0.0,x2=0.0; 
        run;


        /* Program 3.5 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 3.5';
        proc iml;
        alpha = .05 ;
        n = 28;
        /* 
        Calculations for simultaneous confidence intervals are shown 
below. 
           r_t =Rank (H+E)=p=4, Rank(L)=1, k=0 
           df of error matrix = dferror = 27 
           s = min(r, r_t) = 1, h=max(r,r_t)=4 
           m1 = .5(|r-r_t| - 1) = 1 
           m2 = .5(n-k-r_t-2) = 11. 
           lambda  = [h/(n-k-h+r-1)]F(alpha,h, n-k-h+r-1)
        */
        r_t=4;
        r=1; 
        k=0;
        s = min(r, r_t);
        h=max(r,r_t); 
        m1 = .5*(abs(r-r_t) - 1);
        m2 = .5*(n-k-r_t-2); 
        lambda  = (h/(n-k-h+r-1))*finv(1-alpha,h,n-k-h+r-1);
        cutoff = sqrt(lambda);
        /* 
        Cut-off point for Bonferroni intervals will be computed as 
follows: 
          dferror = 27 ; * dferror=n-1; 
          g=3.0; * g is the no. of comparisons; 
          cutoff = tinv(1-(alpha/(2*g)),dferror);
          cutoff=cutoff/sqrt(dferror);
        */
        xpx = {28};
        e = {7840.9643 6041.3214 7787.8214 6109.3214,
             6041.3214 5938.1071 6184.6071 4627.1071,
             7787.8214 6184.6071 9450.1071 7007.6071, 
             6109.3214 4627.1071 7007.6071 6102.1071}; 
        bhat = {50.535714 46.178571 49.678571 45.178571}; 
        l = {1} ; 
        c={1}; 
        d1={1,-1,1,-1}; 
        d2={0,0,1,-1}; 
        d3={1,0,-1,0};  
        clbhatd1=c`*l*bhat*d1;
        clbhatd2=c`*l*bhat*d2;  
        clbhatd3=c`*l*bhat*d3;
        cwidth1=cutoff*sqrt((c`*l*(inv(xpx))*l`*c)*(d1`*e*d1));
        cwidth2=cutoff*sqrt((c`*l*(inv(xpx))*l`*c)*(d2`*e*d2)); 
        cwidth3=cutoff*sqrt((c`*l*(inv(xpx))*l`*c)*(d3`*e*d3));
        cl11=clbhatd1-cwidth1; 
        cl12=clbhatd1+cwidth1; 
        cl21=clbhatd2-cwidth2; 
        cl22=clbhatd2+cwidth2; 
        cl31=clbhatd3-cwidth3; 
        cl32=clbhatd3+cwidth3; 
        print 'Simultaneous Confidence Intervals';  
        print 'For first contrast: (' cl11', '  cl12 ')'; 
        print 'For second contrast:(' cl21', ' cl22 ')'; 
        print 'For third contrast: (' cl31', ' cl32 ')';
        run;




        /* Program 3.6 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 3.6'; 
        data wash; 
        input temp time wratio sprness tba cookloss whitness ;
        x1 = (temp - 33)/7.0 ; 
        x2 = (time - 5.5)/2.7 ; 
        x3 = (wratio-22.5)/4.5 ;
        x1sq =x1*x1; 
        x2sq = x2*x2; 
        x3sq = x3*x3;
        x1x2 = x1*x2; 
        x1x3 = x1*x3; 
        x2x3 = x2*x3;
        y1= sprness; 
        y2= tba; 
        y3 = cookloss; 
        y4= whitness ;
        lines;
        26.0  2.8   18.0  1.83 29.31 29.50 50.36 
        40.0  2.8   18.0  1.73 39.32 19.40 48.16
        26.0  8.2   18.0  1.85 25.16 25.70 50.72
        40.0  8.2   18.0  1.67 40.81 27.10 49.69
        26.0  2.8   27.0  1.86 29.82 21.40 50.09
        40.0  2.8   27.0  1.77 32.20 24.00 50.61
        26.0  8.2   27.0  1.88 22.01 19.60 50.36
        40.0  8.2   27.0  1.66 40.02 25.10 50.42 
        21.2  5.5   22.5  1.81 33.00 24.20 29.31
        44.8  5.5   22.5  1.37 51.59 30.60 50.67
        33.0  1.0   22.5  1.85 20.35 20.90 48.75
        33.0  10.0  22.5  1.92 20.53 18.90 52.70 
        33.0  5.5   14.9  1.88 23.85 23.00 50.19
        33.0  5.5   30.1  1.90 20.16 21.20 50.86
        33.0  5.5   22.5  1.89 21.72 18.50 50.84
        33.0  5.5   22.5  1.88 21.21 18.60 50.93
        33.0  5.5   22.5  1.87 21.55 16.80 50.98
        ;
        /* Source: Tseo et al. (1983).  Reprinted by permission of 
        the Institute of Food Technologists. */
        proc standard data=wash mean=0 std=1 out=wash2 ;
        var  y1 y2 y3 y4 ;
        run;
        proc reg data = wash2;
        model y1 y2 y3 y4 = x1 x2 x3 x1sq x2sq x3sq 
                                x1x2 x1x3 x2x3 ;
        Linear: mtest x1sq, x2sq, x3sq, x1x2, x1x3, 
                                x2x3/print;

        Nointctn: mtest x1x2,x1x3,x2x3/print;
        Noquad: mtest x1sq, x2sq, x3sq/print;
        title2 'Quality Improvement in Mullet Flesh';
        run;
        proc reg data = wash2;
        model y1 y2 y3 y4 = x1 x2 x3 x1sq x2sq x3sq ;
        run;



        /* Program 3.7 */ 

        options ls=64 ps=45 nodate nonumber;
        data semicond;
        input x1 x2 y1 y2 y3;
        z1=y1-y2;z2=y2-y3;
        lines;
        46 22 45.994 46.296 48.589
        56 22 48.843 48.731 49.681
        66 22 51.555 50.544 50.908
        46 32 47.647 47.846 48.519
        56 32 50.208 49.930 50.072
        66 32 52.931 52.387 51.505
        46 42 47.641 49.488 48.947
        56 42 51.365 51.365 50.642
        66 42 54.436 52.985 51.716
        ;
        /* Source: Guo and Sachs (1993).  Reprinted by permission of the 
           Institute of Electrical and Electronics Engineers, Inc. 
           Copyright 1993 IEEE. */
        proc reg data = semicond ;
        model y1 y2 y3 =  x1 x2 ;
        AllCoef: mtest y1-y2,y2-y3,intercept,x1,x2/print;
        X1andX2: mtest y1-y2,y2-y3,x1,x2/print;
        title1 ' Output 3.7 ';
        title2 'Spatial Uniformity in Semiconductor Processes' ;
        run;



        /* Program 3.8 */

        options ls=64 ps=45 nodate nonumber; 
        title1 'Output 3.8'; 
        title2 'Testing the Precisions of Five Thermocouples';
        data calib ;
        infile 'thermoco.dat' obs=64; 
        input  tc1  tc2  tc3  tc4  tc5  @@ ;
        tcbar = (tc1+tc2+tc3+tc4+tc5)/5 ;
        y1tilda = tc1 - tcbar ;
        y2tilda = tc2 - tcbar ;
        y3tilda = tc3 - tcbar ;
        y4tilda = tc4 - tcbar ;
        y5tilda = tc5 - tcbar ;

        /*
        proc glm data = calib;
        model  y2tilda y3tilda y4tilda y5tilda = tcbar /nouni;
        manova h = tcbar/printe printh;
        */
        proc reg data = calib ;
        model  y2tilda y3tilda y4tilda y5tilda = tcbar;
        EqualVar:mtest tcbar/print;
        Bias_Var:mtest intercept, tcbar/print;
        run;



        /* Program 3.9 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 3.9';
        title2 'Multivariate Regression Diagnostics'; 
        data rohwer;
        infile 'rohwer.dat' firstobs=3;
        input ind y1 y2 y3 x1-x5;
        run;

        /* Store all the residuals, predicted values and the diagonal 
        elements (p_ii) of the projection matrix, (X(X'X)^-1X'), in a 
        SAS data set (we call it B in the following) */
        proc reg data=rohwer;
        model y1-y3=x1-x5/noprint; 
        output out=b r=e1 e2 e3 p=yh1 yh2 yh3 h=p_ii;

        /* Test for multivariate normality using the skewness and kurtosis 
        measures of the residuals.  Since the sample means of the 
residuals 
        are zeros, Program 1.2 essentially works. */ 
        proc iml; 
        use b;
        read all var {e1 e2 e3} into y;
        n = nrow(y) ; 
        p = ncol(y) ; 
        dfchi = p*(p+1)*(p+2)/6;
        q = i(n) - (1/n)*j(n,n,1);
        s = (1/(n))*y`*q*y; /* Use the ML estimate of Sigma */
        s_inv = inv(s);
        g_matrix = q*y*s_inv*y`*q;
        beta1hat = ( sum(g_matrix#g_matrix#g_matrix) )/(n*n);
        beta2hat =trace( g_matrix#g_matrix )/n;
        kappa1 = n*beta1hat/6;
        kappa2 = (beta2hat - p*(p+2) ) /sqrt(8*p*(p+2)/n);
        pvalskew = 1 - probchi(kappa1,dfchi);
        pvalkurt = 2*( 1 - probnorm(abs(kappa2)) ) ;
        print beta1hat ; 
        print kappa1 ; 
        print pvalskew;
        print beta2hat ; 
        print kappa2 ; 
        print pvalkurt;

        /* Q-Q plot for checking the multivariate normality using 
        Mahalanobis distance of the residuals;*/
        data b; 
        set b;
        totn=32.0;  /* totn is the number of observations */ 
        k=5.0;  /* k is the no. of indep. variables */
        p=3.0; /* p is the number of dep. variables */
        proc princomp data=b cov std out=c noprint;
        var e1-e3;
        data sqd;
        set c; 
        student=_n_;
        dsq=uss(of prin1-prin3);
        dsq=dsq*(totn-k-1)/(totn-1); 
        * Divide the distances by (1-p_ii);
        dsq=dsq/(1-p_ii);
        data qqp; 
        set sqd;
        proc sort; 
        by dsq;                    
        data qqp; 
        set qqp;
        stdnt_rs=student;
        chisq=cinv(((_n_-.5)/ totn),p);
        proc print data=qqp;
        var stdnt_rs dsq chisq;
  
        * goptions for the gplot;
        filename gsasfile "prog39a.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;

        title1 h=1.5 'Q-Q Plot for Assessing Normality';
        title2 j=l 'Output 3.9';
        title3 'Multivariate Regression Diagnostics'; 
        proc gplot data=qqp;
        plot dsq*chisq='star';
        label dsq = 'Mahalanobis D Square' 
             chisq= 'Chi-Square Quantile';
        run;

        * Q-Q plot for detection of outliers using Robust distance;
        *             (Section 3.10.3);
        data qqprd;             
        set sqd;
        rdsq=((totn-k-2)*dsq/(totn-k-1))/(1-(dsq/(totn-k-1))); 
        proc sort; 
        by rdsq;
        data qqprd; 
        set qqprd;
        stdnt_rd=student;
        chisq=cinv(((_n_-.5)/ totn),p);   
        proc print data=qqprd;
        var stdnt_rd rdsq chisq;
        filename gsasfile "prog39b.graph";
        title1 h=1.5 'Q-Q Plot of Robust Squared Distances';
        title2 j=l 'Output 3.9';
        title3 'Multivariate Regression Diagnostics';         
        proc gplot; 
        plot rdsq*chisq='star';
        label rdsq = 'Robust Mahalanobis D Square' 
              chisq= 'Chi-Square Quantile';
        run;

        * Influence Measures for Multivariate Regression;
        *             (Section 3.10.4);
        * Diagonal Elements of Hat (or Projection) Matrix;
        data hat;
        set sqd;
        proc sort; 
        by p_ii;
        data hat; 
        set hat; 
        stdnt_h=student;

        keep stdnt_h p_ii;
        run;

        * Cook's type of distance for detection of influential obs.;
        data cookd;
        set sqd;
        csq=dsq*p_ii/((1-p_ii)*(k+1));
        proc sort; 
        by csq;
        data cookd; 
        set cookd; 
        stdnt_co=student;
        keep stdnt_co csq;
        run;

        * Welsch-Kuh type statistic for detection of influential obs.;
        data wks;
        set qqprd;
        wksq=rdsq*p_ii/(1-p_ii);
        proc sort; 
        by wksq;
        data wks; 
        set wks; 
        stdnt_wk=student;
        keep stdnt_wk wksq;
        run;

        * Covariance Ratio for detection of influential obs.;
        data cvr;
        set qqprd;
        covr=((totn-k-2)/(totn-k-2+rdsq))**(k+1)/(1-p_ii)**p;
        covr=covr*((totn-k-1)/(totn-k-2))**((k+1)*p);
        proc sort; 
        by covr;
        data cvr; 
        set cvr;
        stdnt_cv=student;
        keep stdnt_cv covr;
        run;

        * Display of Influence Measures;
        data display;
        merge hat cookd wks cvr;
        title2 'Multivariate Regression Diagnostics'; 
        title3 'Influence Measures';
        proc print data=display noobs;
        var stdnt_h p_ii stdnt_co csq stdnt_wk wksq stdnt_cv covr;
        run;


        /* Program 3.10 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 3.10';
        title2 'Multivariate Regression: D-D Plot'; 
        * The data set containing independent and dependent variables.;
        data pollut;
        infile 'airpol.dat' firstobs=6;
        input x1 x2 y1-y5;
        * Make transformations if necessary;
        data pollut; 
        set pollut;
        x1=log(x1); 

        x2=log(x2); 
        y1=log(y1); 
        y2=log(y2);
        y3=log(y3); 
        y4=log(y4); 
        y5=log(y5); 
        proc reg data=pollut;
        model y3 y4=x1 x2/noprint; 
        output out=b r=e1 e2 p=yh1 yh2 h=p_ii;

        /* Univariate residual plots;
        proc reg data=pollut;
        model y3 y4=x1 x2 /noprint;
        plot student.*p.;
        title2 'Univariate Residual Plots';
        run;
        */

        * The Mahalanobis distances of residuals and predicted values;  
        proc iml; 
        use b;
        read all var {e1 e2} into ehat;
        read all var {yh1 yh2} into yhat;
        read all var {p_ii} into h;
        n = nrow(ehat); 
        p = ncol(ehat);
        k = 2.0; *The no. of independent variables in the model; 
        sig=t(ehat)*ehat;
        sig=sig/(n-k-1); /* Estimated Sigma */
        dsqe=j(n,1,0);
        dsqyh=j(n,1,0);
        do i=1 to n;
        dsqe[i,1]=ehat[i,]*inv(sig)*t(ehat[i,])/(1-h[i]);
        dsqyh[i,1]=yhat[i,]*inv(sig)*t(yhat[i,])/h[i];
        end;
        dsqe=sqrt(dsqe);
        dsqyh=sqrt(dsqyh);
        dsqpair=dsqyh||dsqe;
        varnames={dsq1 dsq2}; 
        create ndat1 from dsqpair (|colname=varnames|);
        append from dsqpair;
        close ndat1;  
        * D-D Plot;
        data ndat1; 
        set ndat1;
        filename gsasfile "prog310.graph";
        goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=6in vsize=8in;
        title1 h=1.5 'D-D Plot';
        title2 j=l 'Output 3.10';
        title3 'Residual Analysis: Multivariate Regression';         
        proc gplot data=ndat1;
        plot dsq2*dsq1='star';
        label dsq1='Distance of Predicted Value' 
               dsq2='Distance of Residual';
        run;





        /* Program  4.1 */

        options ls = 64 ps=45 nodate nonumber;
        data jack;
        input lab method1 method2;
        lines;
        1 10.1 10.5
        1 9.3 9.5
        1 9.7 10.0
        1 10.9 11.4
        2 10.0 9.8
        2 9.5 9.7
        2 9.7 9.8
        2 10.8 10.7
        3 11.3 10.1
        3 10.7 9.8
        3 10.8 10.1
        3 10.5 9.6
        ;
        /* Source: Jackson (1991, p. 301). Principal Components.  
Copyright 
           1991 John Wiley & Sons, Inc.  Reprinted by permission of 
           John Wiley & Sons, Inc. */
        
        Title1 'Output 4.1' ;
        title2 'Balanced One-Way MANOVA';
        proc glm data = jack;
        class lab;
        model method1 method2 = lab/nouni;
        manova h = lab/printe printh ;
        run;
        /* proc glm data = jack ;
        class lab ;
        model method1 method2 = lab/nouni;
        contrast 'Test: lab eff.' lab 1 -1  0,
                                  lab 1  0  -1;
        manova/printe printh;
        run; */


        /* Program 4.2 */

        options ls=64 ps=45 nonumber nodate; 
        data phytask ;
        input group min1 min5 min10 ;
        lines ;
        1 7.6  8.7  7.0 
        1 10.1 8.9  8.6
        1 11.2 9.5  9.4
        1 10.8 11.5 11.4
        1 3.9  4.1  3.7
        1 6.7  7.3  6.6
        1 2.2  2.5  2.4
        1 2.1  2.0  2.0
        2 8.5  5.6  8.4
        2 7.5  5.0  9.5
        2 12.9 13.6 15.3
        2 8.8  7.9  7.3
        2 5.5  6.4  6.4
        2 3.2  3.4  3.2
        ;
        /* Source: Crowder and Hand (1990, p. 8). */

        title1 'Output 4.2';
        title2 'Unbalanced One-Way MANOVA'; 
        proc glm data = phytask;
        class group;
        model min1 min5 min10 = group/nouni;
        manova h = group m = min1-min5,
                     min5-min10/printe printh ;
        manova h = intercept m = min1-min5,
                     min5-min10/printe printh ;
        run;


        /* Program 4.3 */
 
        options ls=64 ps=45 nodate nonumber;
        data wtloss ; 
        input sex $ drug $  week1 week2 ; 
        lines;
        male   a  5  6 
        male   a  5  4
        male   a  9  9
        male   a  7  6
        male   b  7  6
        male   b  7  7
        male   b  9 12
        male   b  6  8
        male   c 21 15
        male   c 14 11
        male   c 17 12
        male   c 12 10
        female a  7 10
        female a  6  6
        female a  9  7
        female a  8 10
        female b 10 13
        female b  8  7
        female b  7  6
        female b  6  9
        female c 16 12
        female c 14  9

        female c 14  8
        female c 10  5
        ;
        /* Source: Morrison (1976, p. 190). Multivariate Statistical 
           Methods, McGraw-Hill, Inc.  Reproduced with permission
           of  McGraw-Hill, Inc. */

        proc glm data = wtloss ;
        class sex drug ;
        model week1 week2= sex|drug/nouni ;
        *model week1 week2= sex drug sex*drug/nouni ;
        manova h = sex drug sex*drug/printe printh ;
        title1 'Output 4.3';
        title2 'Balanced Two-Way MANOVA';
        run;



        /* Program 4.4 */

        options ls=64 ps=45 nodate nonumber;
        data etch; 
        input press power etch1 etch2 unif1 unif2 ;
        select = etch1/etch2 ;
        x1 = (press-265)/25 ;
        x2 = (power-110)/20 ; 
        x2sq = x2*x2 ; 
        lines ;
        240  90  793 300 13.2 25.1
        240  90  830 372 15.1 24.6
        240  90  843 389 14.2 25.7
        240 110 1075 400 15.8 25.9
        240 110 1102 410 14.9 25.1
        240 130 1060 397 15.3 24.9
        240 130 1049 427 14.7 23.8
        290  90  973 350  7.4 18.3
        290  90  998 373  8.3 17.7
        290 110  940 365  8.0 16.9
        290 110  935 365  7.1 17.2
        290 110  953 342  8.9 17.4
        290 110  928 340  7.3 16.6
        290 130 1020 402  8.6 16.3
        290 130 1034 409  7.5 15.5
        ;
        title1 'Output 4.4';
        title2 'Unbalanced Two-Way Classification: MANOVA' ;
        title3 'Effects of Factors on Etch Uniformity and Selectivity';
        proc glm data = etch ;
        class press power ;
        model select unif1 unif2= press power press*power/ss1 nouni ;
        manova h = press power press*power/printe printh ;

        proc glm data = etch ;
        class press power ;
        model select unif1 unif2=press power press*power/ss2 nouni ;
        manova h = press power press*power/printe printh ;
 
        proc glm data = etch ;
        class press power ;
        model select unif1 unif2=press power press*power/ss3 nouni ;
        manova h = press power press*power/printe printh ;
 
        proc glm data = etch ;
        model select unif1 unif2  = x1 x2 x2sq /ss1 nouni;
        manova h = x1 x2 x2sq /printe printh ;

        /* proc glm data = etch ;
        model select unif1 unif2  = x1 x2 x2sq /ss2 nouni;
        manova h = x1 x2 x2sq /printe printh ;
  
        proc glm data = etch ;
        model select unif1 unif2  = x1 x2 x2sq /ss3 nouni;
        manova h = x1 x2 x2sq /printe printh; */


        /* Program 4.5 */

        options ls=64 ps=45 nodate nonumber;
        data corn1; 
        input ew  $ ns $ variety  $ height yield;
        lines ;
        a1 b1 c2 65 24
        a1 b2 c3 66 20
        a1 b3 c1 65 24
        a1 b4 c4 65 26
        a2 b1 c3 68 21
        a2 b2 c2 63 23
        a2 b3 c4 67 25
        a2 b4 c1 64 25
        a3 b1 c4 67 26
        a3 b3 c2 64 19
        a3 b4 c3 64 25
        a4 b1 c1 68 27
        a4 b2 c4 67 24
        a4 b3 c3 63 20
        ;
        /* Source: Srivastava and Carter (1983, p. 109). */

        title1 'Output 4.5';
        title2 "Latin Square Design: Corn Yield and Plant Height";
        proc glm data = corn1;
        class ew ns variety;
        model height yield = variety ew ns/ss3 nouni;
        manova h =variety/printe printh;
        run; 



        options ls = 64 ps=45 nodate nonumber;
        data actselct ; 
        infile 'chemist.dat' obs=32;
        input a b c d e f g h activt selectvt;
        ab = a*b; 
        ac = a*c;
        ad = a*d; 
        ae = a*e; 
        af = a*f; 
        ag = a*g; 
        ah = a*h; 
        bg = b*g; 
        bh = b*h; 
        ce = c*e; 
        cf = c*f; 
        cg = c*g; 
        ch = c*h; 
        dg = d*g; 
        dh = d*h; 
        eg = e*g; 
        eh = e*h; 
        fg = f*g; 
        fh = f*h; 
        gh = g*h; 
        title1 'Output 4.6';
        title2 'Fractional Factorial Experiment: Modeling a 
                                          Chemical Process'; 
        proc reg outest = est1  data = actselct ;
        model activt selectvt = a b c d e f g h ab ac ad ae af 
                ag ah bg bh ce cf cg ch dg dh eg eh fg fh gh ; 
        onlymain: mtest ab, ac, ad, ae, af, ag, ah, bg, bh, 
                ce, cf, cg, ch, dg, dh, eg, eh, fg, fh, gh ; 
        ag_eq_0: mtest ag;
        /*
        ab_eq_0: mtest ab ; 
        ac_eq_0: mtest ac ;
        ad_eq_0: mtest ad ;
        ae_eq_0: mtest ae ;
        af_eq_0: mtest af ;
        ah_eq_0: mtest ah ;
        bg_eq_0: mtest bg ;
        bh_eq_0: mtest bh ;
        ce_eq_0: mtest ce ;
        cf_eq_0: mtest cf ;
        cg_eq_0: mtest cg ;
        ch_eq_0: mtest ch ;
        dg_eq_0: mtest dg ;
        dh_eq_0: mtest dh ;
        eg_eq_0: mtest eg ;
        eh_eq_0: mtest eh ;
        fg_eq_0: mtest fg ;
        fh_eq_0: mtest fh ;
        gh_eq_0: mtest gh ;
        */
        data effects; 
        set est1 ;
        eff_a=2*a;
        eff_b=2*b;
        eff_c=2*c;
        eff_d=2*d;
        eff_e=2*e;
        eff_f=2*f;
        eff_g=2*g;
        eff_h=2*h;
        eff_ab=2*ab;
        eff_ac=2*ac;
        eff_ad=2*ad;
        eff_ae=2*ae;
        eff_af=2*af;
        eff_ag=2*ag;
        eff_ah=2*ah ;
        eff_bg=2*bg ;
        eff_bh=2*bh ;
        eff_ce=2*ce ;
        eff_cf=2*cf ;
        eff_cg=2*cg ;
        eff_ch=2*ch ;
        eff_dg=2*dg ;
        eff_dh=2*dh ;
        eff_eg=2*eg ;
        eff_eh=2*eh ;
        eff_fg=2*fg ;
        eff_fh=2*fh ;
        eff_gh=2*gh ;   
        proc print data = effects ;
        var _depvar_ eff_a eff_b eff_c eff_d eff_e eff_f 
                                                eff_g eff_h ;
        title2 'Effects for Main Factors';
        title3 'Coefficients are Half of the Effect of the Contrasts';  
        proc reg data = actselct ;
        model activt = a b c d e f g h ;
        model selectvt = activt a b c d e f g h ; 
        run;


        /* Program 4.7 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 4.7';
        title2 'Analysis of Covariance';

        data heat ;
        input foam $ fabric $ hr5 hr10 hr15 wt; 
        lines ;
        foam_a fabric_x 9.2 18.3 20.4 10.3 
        foam_a fabric_x 9.5 17.8 21.1 10.1
        foam_a fabric_y 10.2 15.9 18.9 10.5
        foam_a fabric_y 9.9 16.4  19.2  9.7
        foam_a fabric_z 7.1 12.8 16.7 9.8
        foam_a fabric_z 7.3 12.6 16.9 9.9
        foam_b fabric_x 8.2 12.3 15.9 9.5
        foam_b fabric_x 8.0 13.4 15.4 9.3
        foam_b fabric_y 9.4 17.7 21.4 11.0
        foam_b fabric_y 9.9 16.9 21.6 10.8
        foam_b fabric_z 8.8 14.7 20.1 9.3
        foam_b fabric_z 8.1 14.1 17.4 7.7
        foam_c fabric_x 7.7 12.5 17.3 10.0
        foam_c fabric_x 7.4 13.3 18.1 10.5
        foam_c fabric_y 8.7 13.9 18.4 9.8
        foam_c fabric_y 8.8 13.5 19.1 9.8
        foam_c fabric_z 7.7 14.4 18.7 8.5
        foam_c fabric_z 7.8 15.2 18.1 9.0
        ;
        proc glm data = heat;
        class foam fabric ;
        model hr5 hr10 hr15=wt foam fabric foam*fabric/ss1 nouni;
        contrast '(a,z) vs. (c,x)' 
        intercept 0 foam 1 0 -1 fabric -1 0 1 
                           foam*fabric  0 0 1 0 0 0 -1 0 0 ;
        contrast 'foam a vs b ' foam 1 -1 0 ;
        manova h = foam fabric foam*fabric/ printe printh ;
        run;

        /*
        proc glm data = heat ;
        class foam fabric ;
        model hr5 hr10 hr15=wt foam fabric foam*fabric/ss3 nouni;
        lsmeans foam fabric foam*fabric ;
        contrast 'Foam a vs b ' foam 1 -1 0 ;
        contrast '(a,z) vs. (c,x)' 
                intercept 0 foam 1 0 -1 fabric -1 0 1 
                   foam*fabric  0 0 1 0 0 0 -1 0 0 ;
        manova h = foam fabric foam*fabric/ printe printh ;
        run;
        */


        /* Program  5.1 */
 
        options ls = 64 ps=45 nodate nonumber; 
        data memory ; 
        input y1 y2 y3 ; 
        lines ;
        19 18 18
        15 14 14
        13 14 15
        12 11 12
        16 15 15
        17 18 19
        12 11 11
        13 15 12
        19 20 20
        18 18 17
        ;
        /* Source: Srivastava and Carter (1983, p. 201). */
        filename gsasfile "prog51.graph";
        goptions gaccess=gsasfile dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=5in vsize=7in;
        title1 h=1.5 'Profile for Memory Data';
        title2 j=l 'Output 5.1' ;
        proc summary data=memory;
        var y1 y2 y3;
        output out=new mean=my1-my3;
        data plot;
        set new;
        array my{3} my1-my3;
        do test =1 to 3;
        Response=my(test);
        output; 
        end;
        drop my1-my3;
        proc gplot data = plot;
        plot response*test /vaxis=axis1 haxis=axis2 vminor=3
        legend=legend1 ;
        axis1  order =(14 to 16) label =(a=90 h=1.2 'Response');
        axis2 offset=(2) label=(h=1.2 'Test');
        symbol1 v=+ i = join;
        legend1 across = 3;
        run;



        /* Program 5.2 */

        options ls = 64 ps=45 nodate nonumber;
        title1 'Output 5.2';
        title2  'Analysis of Memory data';
        data memory ; 
        input y1 y2 y3 @@; 
        lines ;
        19 18 18 15 14 14 13 14 15
        12 11 12 16 15 15 17 18 19
        12 11 11 13 15 12 19 20 20 18 18 17
        ;
        proc glm data = memory ;
        model y1 y2 y3 = /nouni ;
        manova h=intercept m=(1 0 -1,
                              0 1 -1)/printe printh;
        run;
        proc glm data = memory ;
        model y1 y2 y3 = /nouni ;



        /* Program  5.3 */
 
        options ls = 64 ps=45 nodate nonumber;
        proc iml;       
        y={
        19 18 18,
        15 14 14,
        13 14 15,
        12 11 12,
        16 15 15,
        17 18 19,
        12 11 11,
        13 15 12,
        19 20 20,
        18 18 17};      
        Title1 'Output 5.3' ;
        p=ncol(y);
        n=nrow(y);
        s=y`*(I(n)-(1/n)*j(n,n))*y;
        svar=s/(n-1);
        /*
        *Test for sphericity;
        const1=-((n-1)-(2*p*p+p+2)/(6*p));
        wlam=( det(svar)/((trace(svar)/p)**p) );
        llam=wlam**(2/n);
        print llam;
        test=const1*log(wlam);
        print const1 wlam test;
        */
        * Test of Compound Symmetry;
        detment=det(svar);
        square=sum (diag(svar));
        sumall=sum(svar);
        ssquare=square/p;
        correl=(sumall-square)/(p*(p-1)*ssquare);
        lrlam=detment /( (ssquare**p)*((1-correl)**(p-1))
                                        *(1+(p-1)*correl) );
        correct=(n-1)-( p*(p-1)**2*(2*p-3))/(6*(p-1)*(p*p+p-4));
        lrstat=-correct*log(lrlam);
        df=p*(p+1)/2-2;
        pvalue=probchi(lrstat,df);
        pvalue=1-pvalue;
        print 'Test of Compound Symmetry for Memory Data' ;     
        print ssquare correl detment lrlam;
        print lrstat pvalue;
        run; 



        /* Program  5.4 */
 
        options ls = 64 ps=45 nodate nonumber;
        title1 'Output 5.4';
        /* This program computes the LRT for testing circular
        covariance structure vs. general cov. Ref. Olkin & Press, 
                                AMS, 1969,40, 1358-1373.*/
        data cork;
        infile 'cork.dat';
        input y1 y2 y3 y4;
        run;
        proc iml;
        use cork;
        read all var {y1 y2 y3 y4} into y;
        p=ncol(y);
        n=nrow(y);
        s=y`*(I(n)-(1/n)*j(n,n))*y;
        svar=s/(n-1);
        pi=3.1415927;
        gam=I(p);
        do k=1 to p;
         do l=1 to p;
         gam(|k,l|)=(p**(-0.5))*(cos(2*pi*(k-1)*(l-1)/p)+
         sin(2*pi*(k-1)*(l-1)/p));
         end;
        end;
        m=floor(p/2);
        if(m = p/2) then b = (2*p**3+9*p**2-2*p-18)/
                                        (12*(p**2-2)) ;
        else b = (2*p+9)/12 ;
        if(m = p/2) then f = (p**2-2)/2 ;
        else f = (p**2-1)/2 ;
         v=gam*s*gam`;
        x=j(p);
        nu=x(|,1|);
         do k=1 to p;
         nu(|k|)=v(|k,k|);
         end;
         snu=x(|,1|);
         snu(|1|)=nu(|1|);
        if (m=p/2) then
         snu(|m+1|)=nu(|m+1|);
         else
         snu(|m+1|)=nu(|m+1|)+nu(|m+2|);
          do k=2 to m;
          kp=p+2-k;
          snu(|k|)=nu(|k|)+nu(|kp|);
          end;
          do k=m+2 to p;
          snu(|k|)=snu(|p-k+2|);
          end;
         pdt=1.0;
          do k=1 to p;
          pdt=pdt*snu(|k|);
          end;
          wlamda=(2**(2*(p-m-1)))*det(v)/pdt;
          wlamda=wlamda**(n/2);
          lrstat=-2*(1-2*b/n)*log(wlamda);
        pvalue=probchi(lrstat,f);
        pvalue=1-pvalue;
        print 'Test of Circular Structure for Cork Data' ;
        print wlamda lrstat pvalue;
        run;



        /* Program 5.5 */

        options ls=64 ps=45 nodate nonumber;
        data fish;
        infile 'fish.dat' firstobs = 1;
        input p1 p2 p3 p4 p5 dose wt @@;
        y1=arsin(sqrt(p1));
        y2=arsin(sqrt(p2));
        y3=arsin(sqrt(p3));
        y4=arsin(sqrt(p4));
        y5=arsin(sqrt(p5));
        x1=log(dose); 
        x2=wt;
        Title1 'Output 5.5' ;
        title2 'Polynomial Fitting for Fish Data' ;
        data growth;
        set fish;
        keep y1-y5;
        proc iml; 
        use growth;
        read all into z0;
        vec={8 14 24 36 48};
        opoly=orpol (vec,4);
        print 'Orthogonal Polynomial Matrix';
        print opoly;
        z=z0*opoly;
        varnames={z1 z2 z3 z4 z5};
        create newdata from z (|colname=varnames|);
        append from z;
        close newdata;
        data newdata;
        set newdata fish; 
        merge newdata fish;
        run;
        proc sort data=newdata; 
        by dose ;
        run;

        proc glm data = newdata; 
        by dose;
        model z4 z5 = /nouni;
        manova h=intercept;
        title3 'Second Degree Polynomial Fit for Individual Doses';
        run;

        proc glm data = newdata; 
        by dose;
        model  z5 = /nouni;
        manova h=intercept;
        title3 'Third Degree Polynomial Fit for Individual Doses';
        run;

        proc glm data = newdata; 
        class dose;
        model  z5 = dose /nouni;
        manova h=intercept;
        title3 'Common 3rd degree Polynomial Fit';
        run;



        /* Program 5.6 */

        options ls=64 ps=45 nodate nonumber;
        data dog ; 
        input high_noh low_noh high_h low_h ;
        y1 = high_noh; 
        y2 = low_noh ; 
        y3 = high_h; 
        y4 = low_h;
        z=y1+y2-y3-y4;
        lines ;
        426 609 556 600
        253 236 392 395
        359 433 349 357
        432 431 522 600
        405 426 513 513
        324 438 507 539
        310 312 410 456
        326 326 350 504
        375 447 547 548
        286 286 403 422
        349 382 473 497
        429 410 488 547
        348 377 447 514
        412 473 472 446
        347 326 455 468
        434 458 637 524
        364 367 432 469
        420 395 508 531
        397 556 645 625
        ;
        /* Original Data Source: Dr. J. Atlee, III, M.D.  Reproduced 
           with permission from Dr. J. Atlee. */
        title1 'Output 5.6 ';
        title2 'Two-way Factorial Experiment: Dog Data';
        proc glm data = dog ;
        model high_noh low_noh high_h low_h = /nouni;
        /* Test for Factor halothane; 
        manova h=intercept m=high_noh + low_noh -high_h -low_h 
                                                /printe printh; 
        *Test for Factor Co2 ; 
        manova h=intercept m=high_noh - low_noh +high_h -low_h
                                                 /printe printh;

        *Test for interaction Co2*halothane; 
        manova h=intercept m=high_noh - low_noh -high_h +low_h 
                                                /printe printh; */

        *Testing Both factors and interaction simultaneously: 
        Comparing all treatments;
        manova h=intercept m=high_noh+low_noh -high_h -low_h , 
                             high_noh - low_noh +high_h -low_h ,
                             high_noh - low_noh -high_h +low_h 
                                                /printe printh ;
        run;





        /* Program 5.7 */

        options ls=64 ps=45 nodate nonumber;    
        title1 'Output 5.7';
        data react;
        input patient y1-y7;
        lines;
        1   0.22 0.00 1.03 0.67 0.75 0.65 0.59
        2   0.18 0.00 0.96 0.96 0.98 1.03 0.70
        3   0.73 0.37 1.18 0.76 1.07 0.80 1.10
        4   0.30 0.25 0.74 1.10 1.48 0.39 0.36
        5   0.54 0.42 1.33 1.32 1.30 0.74 0.56
        6   0.16 0.30 1.27 1.06 1.39 0.63 0.40
        7   0.30 1.09 1.17 0.90 1.17 0.75 0.88
        8   0.70 1.30 1.80 1.80 1.60 1.23 0.41
        9   0.31 0.54 1.24 0.56 0.77 0.28 0.40
        10 1.40 1.40 1.64 1.28 1.12 0.66 0.77
        11 0.60 0.80 1.02 1.28 1.16 1.01 0.67
        12 0.73 0.50 1.08 1.26 1.17 0.91 0.87
        ;
        /* Source: Crowder and Hand (1990, p. 32). */
        proc glm data = react;
        model y1-y7= /nouni;
        manova h=intercept  
        m=3*y1+3*y2-2*y3-2*y4-2*y5, 2*y3+2*y4+2*y5-3*y6-3*y7;
        title2 'Comparison of Dietary Regime Treatments';
        run;


        /* Program 5.8 */

        options ls=64 ps=45 nodate nonumber;
        data heart; 
        infile 'heart.dat';
        input drug $ y1 y2 y3 y4; 
        title1 ' Output 5.8';
        title2 'Comparison of Drugs: Profile Analysis'; 
        proc glm data = heart; 
        class drug;
        model y1 y2 y3 y4 = drug/nouni;
        manova h = drug/printe printh ;
        run;

        filename gsasfile "prog58.graph";
        goptions gaccess=gsasfile dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=5in vsize=7in;
        title1 h=1.5 'Comparison of Drugs: Profiles of the Means';
        title2 j=l ' Output 5.8';
        proc summary nway data=heart;
        class drug;
        var y1 y2 y3 y4;
        output out=new mean=my1-my4;
        data plot; 
        set new;
        array my{4} my1-my4;
        do test =1 to 4;
        Response=my(test);
        output; 
        end;
        drop my1-my4;
        proc gplot data = plot;
        plot response*test=drug /vaxis=axis1 haxis=axis2 
        vminor=3 legend=legend1 ;
        axis1 label =(a=90 h=1.2 'Response');
        axis2 offset=(2) label=(h=1.2 'Test');
        symbol1 v=+ i = join;
        symbol2 v=x i=join;
        symbol3 v=* i=join;
        legend1 across = 3;
        run;

        title1 ' Output 5.8';
        title2 'Comparison of Drugs: Profile Analysis'; 
        proc glm data = heart ;
        class drug;
        model y1 y2 y3 y4 =drug/nouni;
        contrast '"bww9 vs. control"' drug 0 1  -1;
        contrast '"ax23 vs. the rest"'  drug 2 -1 -1;   
        contrast '"parallel?"' drug 1 0 -1, drug  0 1 -1; 
        contrast '"horizontal?"' intercept 1;
        manova h=drug 
       m= (1 -1 0 0,   1 0 -1 0,  1 0 0 -1)/printe printh;
        contrast '"coincidental?"' drug  1 0 -1, drug  0 1 -1;
        manova h=drug m=(1 1 1 1) /printe printh;
        run;



        /* Program 5.9 */

        title1 'Output 5.9';
        title2 'Univariate Analysis of Heart Rate Data';
        options ls=64 ps=45 nodate nonumber;
        data heart; 
        infile 'heart.dat';
        input drug $ y1 y2 y3 y4;
        data split;
        set heart ;
        array t{4} y1-y4;
        subject+1;
        do time=1 to 4;
        y=t{time};
        output; 
        end; 
        drop y1-y4;
        proc glm data = split;
        class subject drug time;
        model y = drug subject(drug) time time*drug;
        random subject(drug)/test;
        run;



        /* Program 5.10 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.10';
        title2 'Repeated Measures Analysis of Heart Rate Data';
        data heart; 
        infile 'heart.dat';
        input drug $ y1 y2 y3 y4; 
        proc glm data = heart;
        class drug ;
        model y1 y2 y3 y4 = drug/ nouni ;
        repeated time 4 profile/ printe;
        run;
        proc glm data = heart;
        class drug ;
        model y1 y2 y3 y4 = drug/ nouni ;
        repeated time 4 polynomial/summary printm printe;
        run;



        /* Program 5.11 */

        options ls=64 ps=45 nodate nonumber;
        title1 ' Output 5.11';
        data box;
        infile 'box.dat';
        input surftrt $ fill $ prop y1 y2 y3 ; 
        title2 'Repeated Measures in Factorials: Tire Wear Data';
        proc glm data = box;
        class surftrt fill prop;
        model y1 y2 y3 =surftrt|fill|prop/nouni;
        contrast '"prop-parallel?"' prop 1 0 -1,
                                    prop  0 1 -1; 
        contrast '"prop-horizontal?"' intercept 1;
        manova h=prop m= (1 -1 0, 1 0 -1)/printe printh;
        contrast '"prop-concidental?"'  prop  1 0 -1,
                                        prop 0 1 -1 ;
        manova h = prop m=(1 1 1) /printe printh;
        run;
        proc glm data = box;
        class surftrt fill prop;
        model y1 y2 y3  = surftrt|fill|prop/ nouni ;
        repeated revolutn 3 polynomial/summary printm printe ;  
        title2 'Univariate Split Plot Analysis of Tire Wear Data';
        run;
        data boxsplit; 
        set box;
        array yy{3} y1-y3;
        subject+1;
        do time=1 to 3;
        y=yy(time);
        output; 
        end;
        run;
        proc mixed data = boxsplit  method = reml ;
        class surftrt fill prop subject;
        model y =  surftrt fill prop surftrt*fill surftrt*prop 
        fill*prop  surftrt*time  fill*time  prop*time  
        surftrt*fill*time surftrt*prop*time fill*prop*time/chisq;
        repeated /type = ar(1) subject = subject r ;
        title2 'Analysis of Tire Wear Data Using PROC MIXED';
        run;



        /*  Program 5.12 */

        option ls=64 ps=45 nodate nonumber;
        title1 'Output 5.12';
        title2 'Analysis with Two Repeated Factors';
        data react;
        input y1 y2 y3 y4; 
        lines;
        77 67 82 72
        84 76 90 80
        102 92 109 97
        ;
        proc glm;
        model y1-y4= /nouni;
        repeated drug 2, time 2;
        run; 




        /* Program 5.13 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.13';
        title2 'Three Factors Case with Two Repeated Factors';
        data read;
        input group y1-y6;
        lines;
        1 61 50 60 55 59 62
        1 64 55 62 57 63 63
        1 59 49 58 52 60 58
        1 63 59 65 64 67 70
        1 62 51 61 56 60 63
        2 57 42 56 46 54 50
        2 61 47 58 48 59 55
        2 55 40 55 46 57 52
        2 59 44 61 50 63 60
        2 58 44 56 49 55 49
        ;
        /* Source: Cody, R. P./Smith, J. K. APPLIED STATISTICS AND SAS
        PROGRAMMING LANGUAGE, 3/E, 1991, p. 194.  Reprinted by permission 
of 
        Prentice-Hall, Inc. Englewood Cliffs, N.J. */
        proc glm data=read;
        class group;
        model y1-y6=group/nouni;
        repeated year 3, season 2;
        run;
        proc glm data=read;
        class group;
        model y1-y6=group/nouni;
        repeated year 3(1 2 3) polynomial, 
                        season 2/summary nom nou;
        run;



        /* Program 5.14 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.14';
        data task;
        infile 'task.dat';
        input group$ x1 x2 y1-y10;
        title2 'Multivariate Analysis of Covariance (MANCOVA)';
        proc glm data=task;
        class group;
        model y1-y4=x1 x2 group group*x1 group*x2/nouni ss3;
        manova  h=group x1 x2 group*x1 group*x2/printe printh;
        run;
        title2 'MANCOVA: Profile Analysis';
        proc glm data = task ;
        class group;
        model y1-y4 = x1 x2 group/nouni;
        contrast '"parallel?"' group 1 -1 0 0, group 1 0 -1 0, 
                                                group 1 0 0 -1;                      
        *contrast '"horizontal?"' intercept 1;
        manova h=group m=y1-y2,y1-y3,y1-y4/printe printh;
        run;
        proc glm data = task;
        class group;
        model y1-y4 = group/nouni;
        contrast '"coincidental?"' group 1 -1 0 0, 
                        group 1 0 -1 0, group 1 0 0 -1; 
        manova h = group m=(1 1 1 1)/printe printh;
        run;
        title2 'Analysis as in Srivastava and Carter (1983)';
        data task; 
        set task; 
        z1=y2-y1;
        z2=y3-y2;
        z3=y4-y3;
        ybar = (y1+y2+y3+y4)/4; 
        proc glm data = task;
        class group;
        model ybar = z1 z2 z3 x1 x2 group;
        run;
        title2 'MANCOVA with Repeated Measures: Using repeated statement';
        proc glm data=task;
        class group;
        model y1-y4=x1 x2 group x1*group x2*group/nouni ss3;
        repeated time 4 (1 2 3 4) polynomial/printe;
        run;



        /* Program 5.15 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.15';
        title2 'Analysis of Diabetic Patients Study';
        data task;
        infile 'task.dat';
        input group$ x1 x2 y1-y10;
        data task; 
        set task; 
        ybar = mean(y1,y2,y3,y4);
        if group = 'control' then z11=x1;
        if group = 'control' then z12 =0; 
        if group = 'control' then z13 =0;
        if group = 'control' then z14 =0;
        if group = 'control' then z21=x2;
        if group = 'control' then z22 =0; 
        if group = 'control' then z23 =0;
        if group = 'control' then z24 =0;
        if group = 'dinocom' then z11 =0;  
        if group = 'dinocom' then z12=x1;  
        if group = 'dinocom' then z13 =0; 
        if group = 'dinocom' then z14 =0;
        if group = 'dinocom' then z21 =0; 
        if group = 'dinocom' then z22=x2; 
        if group = 'dinocom' then z23 =0; 
        if group = 'dinocom' then z24 =0;
        if group = 'dihypot' then  z11=0;  
        if group = 'dihypot' then z12 =0;  
        if group = 'dihypot' then z13=x1; 
        if group = 'dihypot' then z14 =0;
        if group = 'dihypot' then z21 =0; 
        if group = 'dihypot' then z22=0 ; 
        if group = 'dihypot' then z23=x2; 
        if group = 'dihypot' then z24 =0;
        if group = 'dihyper' then  z11=0;  
        if group = 'dihyper' then  z12=0;  
        if group = 'dihyper' then  z13=0; 
        if group = 'dihyper' then z14=x1;
        if group = 'dihyper' then  z21=0; 
        if group = 'dihyper' then  z22=0; 
        if group = 'dihyper' then  z23=0; 
        if group = 'dihyper' then z24=x2;
        data nomiss; 
        set task ; 
        if x1 > 0; 
        title3 'Subject Model';
        proc glm data =nomiss;
        classes group ;
        model ybar = group z11 z12 z13 z14 z21 z22 z23 z24;     
        run;
        proc glm data =nomiss;
        classes group ;
        model ybar = group;
        title3 'Subject Model: No Covariates';




        /* Program 5.16 */                                             

        /* This is a growth curve anlysis program where 
                dog data is used (Grizzle and Allen, 1969). */
        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.16';
        title2 'Growth Curves Analysis of Dog Data';
        data dog;                                                                       
        infile "dog.dat";                                                            
        input d1 d2 d3 d4 d5 d6 d7;
        dog+1;                                                                         
        if (dog<10 and dog>0) then group='control';                                     
        if (dog<19 and dog>9) then group='treat1';                                      
        if (dog<28 and dog>18) then group='treat2';                                     
        if (dog<37 and dog>27) then group='treat3';                                     
        output;
        drop dog;
        run;

        filename gsasfile "prog516.graph";
        goptions gaccess=gsasfile dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=5in vsize=7in;
        title1 h=1.5 'Modeling Growth: Profiles of the Means';
        title2 j=l 'Output 5.16';
        proc summary nway data=dog;
        class group;
        var d1 d2 d3 d4 d5 d6 d7;
        output out=new mean=md1-md7;
        data plot; 
        set new;
        array md{7} md1-md7;
        do i =1 to 7;
        meanresp=md(i);
        time=i*2-1;
        output; 
        end;
        keep group time meanresp;
        run;
        proc gplot data = plot;
        plot meanresp*time=group/ vaxis=axis1 haxis=axis2;
        axis1 label =(a=90 h=1.2 'Dog Response Time');
        axis2 offset=(2) label=(h=1.2 'Time of Test');
        symbol1 v=+ i = join;
        symbol2 v=x i=join;
        symbol3 v=* i=join;
        symbol4 v=- i=join;
        run;

        proc iml;
        use dog;                                                                       
        read all into y0;                                                             
        /*Generating the Orthogonal Polynomial of degree p-1=6*/                            
        vec1={1 3 5 7 9 11 13};                                                         
        c=orpol(vec1,6);                                                                
        y=y0*c;                                                                         
        /* Converting Y matrix to a data set Trandata*/                            
        varnames={y1 y2 y3 y4 y5 y6 y7};                                                
        create trandata from y (|colname=varnames|);                                    
        append from y;                                                                  
        close trandata;                                                                 
        /* Creating the independent variable named group*/                             
        data trandata;                                                                  
        set trandata;                                                                   
        dog+1;                                                                         
        if (dog<10 and dog>0) then group='control';                                     
        if (dog<19 and dog>9) then group='treat1';                                      
        if (dog<28 and dog>18) then group='treat2';                                     
        if (dog<37 and dog>27) then group='treat3';                                     
        output;
        run;
        /* Testing the adequacy of a 3rd degree polynomial */
        proc glm data=trandata;                                                         
        model y5 y6 y7= /nouni;                                                         
        manova h=intercept;                                                             
        run;
        /* Fitting a 3rd degree polynomial using 
                                        Rao-Khatri method*/
        /* Contrast statement defines a 3 by 4 L matrix.*/                                        
        proc glm data=trandata;                                                         
        classes group;                                                                  
        model y1 y2 y3 y4=group y5 y6 y7/nouni;                                         
        contrast 'growth curves' group 1 -1 0 0,                                        
                                 group 1 0 -1 0,                                        
                                 group 1 0 0 -1/E;                                      
        manova h=group;                                                                 
        run;
        *To obtain the estimates use one of the following 
                                                two programs;         
        proc glm data=trandata;                                                         
        classes group;                                                                  
        model y1 y2 y3 y4=group y5 y6 y7;                                               
        estimate 'es1' intercept 1 group 1 0 0 0 ;                                      
        estimate 'es2' intercept 1 group 0 1 0 0 ;                                      
        estimate 'es3' intercept 1 group 0 0 1 0 ;                                      
        estimate 'es4' intercept 1 group 0 0 0 1 ;                                      
        run;
        proc glm data=trandata;                                                         
        classes group;                                                                  
        model y1 y2 y3 y4=group y5 y6 y7/noint;                                         
        estimate 'es1' group 1 0 0 0 ;                                                  
        estimate 'es2' group 0 1 0 0 ;                                                  
        estimate 'es3' group 0 0 1 0 ;                                                  
        estimate 'es4' group 0 0 0 1 ;                                                  
        run;



        /* Program 5.17 */

        options ls=64 ps=45 nodate nonumber;
        data mice;                                                                      
        input d1 d2 d3 d4 d5 d6 d7;                                                    
        lines;                                                                          
        0.190 0.388 0.621 0.823 1.078 1.132 1.191                                       
        0.218 0.393 0.568 0.729 0.839 0.852 1.004                                       
        0.141 0.260 0.472 0.662 0.760 0.885 0.878                                       
        0.211 0.394 0.549 0.700 0.783 0.870 0.925                                       
        0.209 0.419 0.645 0.850 1.001 1.026 1.069                                       
        0.193 0.362 0.520 0.530 0.641 0.640 0.751                                       
        0.201 0.361 0.502 0.530 0.657 0.762 0.888                                       
        0.202 0.370 0.498 0.650 0.795 0.858 0.910                                       
        0.190 0.350 0.510 0.666 0.819 0.879 0.929                                       
        0.219 0.399 0.578 0.699 0.709 0.822 0.953                                       
        0.225 0.400 0.545 0.690 0.796 0.825 0.836                                       
        0.224 0.381 0.577 0.756 0.869 0.929 0.999                                       
        0.187 0.329 0.441 0.525 0.589 0.621 0.796                                       
        0.278 0.471 0.606 0.770 0.888 1.001 1.105                                       
        ;
        /* Source: Izenman and Williams (1989).  Reproduced by 
        permission of the International Biometric Society. */
        
        filename gsasfile "prog517.graph";
        goptions gaccess=gsasfile dev=pslmono;
        goptions horigin=1in vorigin=2in;
        goptions hsize=5in vsize=7in;
        title1 h=1.5 'Mice Data with Profile of the Mean';
        title2 j=l 'Output 5.17';
        data plot1;
        set mice;
        array d{7} d1-d7;
        do i=1 to 7;
        weight=d(i);
        day=i*3-1;
        output;
        end;
        keep day weight;
        run;
        proc summary nway data=mice;
        var d1 d2 d3 d4 d5 d6 d7;
        output out=new mean=md1-md7;
        data plot2; 
        set new;
        array md{7} md1-md7;
        do i =1 to 7;
        mean_wt=md(i);
        output; 
        end;
        keep mean_wt;
        run;    
        data plot;
        merge plot1 plot2;
        run;
        proc gplot data = plot;
        plot (weight mean_wt)*day/overlay vaxis=axis1 haxis=axis2;
        axis1 label =(a=90 h=1.2 'Weights of Mice');
        axis2 offset=(2) label=(h=1.2 'Days after Birth');
        symbol1 v=square i = none;
        symbol2 v=dot i=join;
        run;

        proc iml;       
        use mice;                                                                      
        read all into y0;                                                             
        print y0;                                                                     
        /* Generating the Ortho. Poly. of degree p-1=6*/                            
        vec1={2 5 8 11 14 17 20};                                                       
        c=orpol(vec1,6);                                                                
        y=y0*c;                                                                         
        /* Convert Y matrix to a data set Trandata*/                            
        varnames={y1 y2 y3 y4 y5 y6 y7};                                                
        create trandata from y (|colname=varnames|);                                    
        append from y;                                                                  
        close trandata;                                                                 
        proc glm data=trandata;                                                         
        model y1 y2 y3=y4 y5 y6 y7/nouni;                                              
        manova h=intercept/printe;                                                     
        proc reg data=trandata;                                                         
        model y1 y2 y3= ;                                                               
        model y1 y2 y3=y4;                                                              
        model y1 y2 y3=y4 y5;                                                           
        model y1 y2 y3=y4 y5 y6;                                                        
        model y1 y2 y3=y4 y5 y6 y7;                                                     
        title1 'Output 5.17';
        title2 'Growth Curve Analysis: Mice Data';
        run;


        /* Program 5.18 */

        option ls=64 ps=45 nodate nonumber;
        title1 'Output 5.18';
        data a;
        input line $ date $ @;
        do i=1 to 5;
        input x y@;
        output; drop i;
        end;
        lines;
        lin1 dat1 2.5 51 2.2 55 3.1 45 4.3 42 2.5 53
        lin1 dat1 4.3 50 3.8 50 4.3 52 1.7 56 3.1 49
        lin1 dat2 3.0 65 2.8 52 2.8 41 2.7 51 2.6 41
        lin1 dat2 2.8 45 2.6 51 2.6 45 2.6 61 3.5 42
        lin1 dat3 2.2 54 1.8 59 1.6 66 2.1 54 3.3 45
        lin1 dat3 3.8 49 3.2 49 3.6 55 4.2 49 1.6 68
        lin2 dat1 2.0 58 2.4 55 1.9 67 2.8 61 1.7 67
        lin2 dat1 3.2 68 2.0 58 2.2 63 2.2 56 2.2 72
        lin2 dat2 4.0 52 2.8 70 3.1 57 4.2 58 3.7 47
        lin2 dat2 3.0 56 2.2 72 2.3 63 3.8 54 2.0 60
        lin2 dat3 1.5 78 1.4 75 1.7 70 1.3 84 1.7 71
        lin2 dat3 1.6 72 1.4 62 1.0 68 1.5 66 1.6 72
        ;
        /* Source: Rawlings (1988, p. 219).  Reprinted by permission
                of the Wadsworth Publishing Company. */ 
        data cabbage; 
        set a;
        if (line='      lin1' and date='dat1') then d1=1;
          else d1=0;
        if (line='      lin1' and date='dat2') then d2=1;
          else d2=0;
        if (line='      lin1' and date='dat3') then d3=1;
          else d3=0;
        if (line='      lin2' and date='dat1') then d4=1;
          else d4=0;
        if (line='      lin2' and date='dat2') then d5=1;
          else d5=0;
        if (line='      lin2' and date='dat3') then d6=1;
          else d6=0;
        output;
        data cabbage; 
        set cabbage;
        xd1=x*d1;
        xd2=x*d2; 
        xd3=x*d3;
        xd4=x*d4; 
        xd5=x*d5; 
        xd6=x*d6;
        title2 'Homogeneity of Regression';
        proc reg data=cabbage;
        model y=d1-d6 xd1-xd6/noint;
        test xd1=xd2=xd3=xd4=xd5=xd6;
        run;


        /* Program 5.19*/

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.19';
        title2 'Nonlinear Growth Curve Analysis';
        data fish;                                                                      
        input length d1 d2 age@@;                                                       
        lines;                                                                          
        15.40 1 0 1.0 26.93 1 0 2.0 42.23 1 0 3.3 
        44.59 1 0 4.3 47.63 1 0 5.3           
        49.67 1 0 6.3 50.87 1 0 7.3 52.30 1 0 8.3 
        54.77 1 0 9.3 56.43 1 0 10.3          
        55.88 1 0 11.3                                                                  
        15.40 0 1 1.0 28.03 0 1 2.0 41.18 0 1 3.3 
        46.20 0 1 4.3 48.23 0 1 5.3           
        50.26 0 1 6.3 51.82 0 1 7.3 54.27 0 1 8.3 
        56.98 0 1 9.3 58.93 0 1 10.3          
        59.00 0 1 11.3 60.91 0 1 12.3 61.83 0 1 13.3                                    
        ;
        /* Source: Kimura (1980).  U. S. Fishery Bulletin. */
        /* The following code fits von Bertalanffy model 
                                        under Omega*/                  
        proc nlin data=fish maxiter=100;                                                
        parms l1=55 k1=.276 t1=0 l2=60 k2=.23 t2=0;                                     
        model length= l1*d1*(1-exp(-k1*(age-t1)))+
                        l2*d2*(1-exp(-k2*(age-t2))); 
        run;
        /* The following code fits von Bertalanffy model 
                                under omega 1:l1=l2=l*/ 
        /* The initial estimate of l is taken as the average 
                                        of that of l1 and l2*/ 
        proc nlin data=fish maxiter=100;                                                
        parms l=57.5 k1=.276 t1=0 k2=.23 t2=0;                                          
        model length= l*d1*(1-exp(-k1*(age-t1)))+
                        l*d2*(1-exp(-k2*(age-t2)));    
        run;
        /* The following code fits von Bertalanffy model 
                                under omega 2:k1=k2=k*/        
        /* The initial estimate of k is taken as the average 
                                        of that of k1 and k2*/ 
        proc nlin data=fish maxiter=100;                                                
        parms l1=55 k=.253 t1=0 l2=60 t2=0;                                             
        model length= l1*d1*(1-exp(-k*(age-t1)))+
                        l2*d2*(1-exp(-k*(age-t2))); 
        run;
        /* The following code fits von Bertalanffy model 
                                under omega 3:t1=t2=t*/        
        /* The initial estimate of t is taken as the average 
                                        of that of t1 and t2*/ 
        proc nlin data=fish maxiter=100;                                                
        parms l1=55 k1=.276 t=0 l2=60 k2=.23;                                           
        model length= l1*d1*(1-exp(-k1*(age-t)))+
                        l2*d2*(1-exp(-k2*(age-t)));       
        run;
        /* The following code fits von Bertalanffy model 
                                        under omega 4:                 
        l1=l2 ,k1=k2 and t1=t2*/                                                        
        proc nlin data=fish maxiter=100;                                                
        parms l=57.5 k=.253 t=0 ;                                                       
        model length= l*d1*(1-exp(-k*(age-t)))+
                                l*d2*(1-exp(-k*(age-t)));     
        run;                                                                            


        /* Program 5.20 */

        options ls= 64 ps=45 nodate nonumber;
        title1 'Output 5.20';
        title2 'Analysis of Crossover Design';
        data  bp; 
        infile 'bpress.dat';
        input patient $ y treat $ carry $ period center subject;
        proc glm data = bp ;
        class treat carry period subject;
        model y = subject period treat carry/ ss1 ;
        random subject/test ;
        contrast ' a vs. b' treat 1 -1 0;
        contrast ' a vs. c' treat 1 0 -1;
        contrast ' b vs. c' treat 0 1 -1;
        run;     
        proc glm data = bp ;
        class treat carry period subject;
        model y = subject period treat carry/ ss3 ;
        random subject/test ;
        contrast ' a vs. b' treat 1 -1 0;
        contrast ' a vs. c' treat 1 0 -1;
        contrast ' b vs. c' treat 0 1 -1;
        run;



        /* Program 5.21 */ 

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.21';
        title2 'Multivariate Analysis of Crossover Design';
        data onion;
        infile 'onion.dat'; 
        input patient meal$ y11 y12 y13 y14 y15 y16 group 
        patient2 meal2$ y21 y22 y23 y24 y25 y26 group2;
        run;
        proc glm data = onion ;
        class group ;
        model y11 y12 y13 y14 y15 y16 y21 y22 y23 y24 y25 y26=
                                                group / nouni;
        contrast 'Group*Time  Interaction' group 1 -1 ;
        manova  
                m = y11-y12+y21-y22, 
                y12-y13+y22-y23, 
                y13-y14+y23-y24,
                y14-y15+y24-y25, 
                y15-y16+y25-y26;
        title3 'Test for Group*Time Interaction';
        run;
        proc glm data = onion;
        class group;
        model y11 y12 y13 y14 y15 y16 y21 y22 y23 y24 y25 y26=
                                                group / nouni;
        contrast 'Carryover  Effect' group 1 -1 ;
        manova 
        m = y11+y12+y13+y14+y15+y16+y21+y22+y23+y24+y25+y26;  
        title3 'Test for Equality of Carryover Effects';
        run;
        proc glm data = onion;
        class group ;
        model y11 y12 y13 y14 y15 y16 y21 y22 y23 y24 y25 y26=
                                                group / nouni;
        contrast 'Teatment*Time  Interaction' group 1 -1 ;



        /* Program 5.22 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.22';
        title2 'Generation of a Latin Square Crossover Design';
        title3 ' 4 Treatments, 4 Time Points in 12 Subjects';
        proc factex;
        factors row col t1-t3/nlev=4;
        size design=16;
        model resolution=3;
        output out=latinsq;
        run;
        data latinsq1;
        set latinsq;
        keep t1-t3;
        proc iml; 
        use latinsq1;
        read all into z0;
        p=4;
        latin1 = i(p);
        latin2 = i(p);
        latin3 = i(p);
        do i = 1 to p;
        do j = 1 to p;
        ij = (j-1)*p +i ;
        latin1[i,j] = z0[ij,1];
        latin2[i,j] = z0[ij,2];
        latin3[i,j] = z0[ij,3];
        end;
        end;
        cross = ((latin1//latin2)//latin3);
        print cross;



        /* Program 5.23 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 5.23';
        title2 'Williams Design: p Treatments in p Time points ';
        proc iml;
        p=5;
        p2=p*2;
        pover2 =p/2;
        /*Initialize the matrices;
        a is the circular p by p Latin Square, b is
        its mirror image and the specific;*/
        a=i(p);
        b=i(p);
        w=j(p,p2);
        *Create the matrix a;
        do i = 1 to p;
        i1=i-1;
        do j = 1 to p;
        if (i = 1) then  a[i,j] =j;
        if (i >1) then do;
        if (j < p) then do ;
        jmod = j+1;
        a[i,j] = a[i1,jmod] ;
        end ;
        if (j = p) then do ;
        jmod = 1 ;
        a[i,j] = a[i1,jmod] ;
        end ;
        end ;
        end ;
        end ;
        * Create b, the mirror image of a;
        do i = 1 to p;
        do j = 1 to p;
        jj=(p+1-j);
        b[i,j] = a[i,jj];
        end ;
        /*Interlace the Circular Latin Square and its
        mirror image;*/
        do k = 1 to p2;
        kby2 =k/2;
        if  kby2=floor(kby2) then do;
        w[i,k] = b[i,kby2];
        end;
        if  kby2>floor(kby2) then do;
        kk= floor(kby2)+1;
        w[i,k] = a[i,kk];
        end;
        end;
        end;
        print 'p is equal to ' p;
        print 'The following is the Desired Williams Design: ';
        print '_____________________________________________ ';
        /*
        Design requires p (if p even) or 2p subjects (if p odd).
        If p is even take first p or last p columns.
        If p is odd slice after first p columns
        and augment last p columns below it.
        */
        w1 = w*(i(p)//j(p,p,0));
        w2 =w*(j(p,p,0)//i(p));
        if pover2 > floor(p/2) then do;
        williams =w1//w2;
        end;
        else williams =w1 ;
        print williams;



/* Program 6.1 */

options ls =64 ps=45 nodate nonumber;
title1 'Output 6.1';
title2 'Test for Markov Covariance Structure: Glucose Data';
data a;
infile 'glucose.dat' obs=36;
input id group$ before y1-y9; 
run;
data c; 
set a;
array t{9} y1-y9;
subj+1;
do timept=1 to 9;
y=t{timept};
if timept = 1 then realtime = 0;
if timept = 2 then realtime = .5;
if timept = 3 then realtime = 1;
if timept = 4 then realtime = 1.5;
if timept = 5 then realtime = 2;
if timept = 6 then realtime = 3;
if timept = 7 then realtime = 4;
if timept = 8 then realtime = 5;
if timept = 9 then realtime = 6;
output;
end;
drop y1-y9;
run;
proc mixed method=ml;
class subj  group timept;
model y= group timept group*timept;
repeated/type=un subject=subj;
title3 'Unstructured Covariance';
run;
proc mixed method=ml;
class subj group timept;
model y=group timept group*timept;
repeated/type=sp(pow)(realtime) subject=subj;
title3 'Markov Covariance';
run;



/* Program 6.2 */

options ls =64 ps=45 nodate nonumber;
title1 'Output 6.2';
 
title2 'Test for Linear Structure: Circulant for Cork Data';
data cork; 
infile 'cork.dat';
input n e w s;
data cork1; 
set cork;
array t{4} n e s w;
tree+1;
do dir = 1 to 4;
dir1 = dir;
y = t{dir};
output;
end;
drop n e s w;
run;
data circ;
input parm row col1-col4; 
datalines;
1 1 1 0 0 0
1 2 0 1 0 0
1 3 0 0 1 0
1 4 0 0 0 1
2 1 0 1 0 1
2 2 1 0 1 0
2 3 0 1 0 1
2 4 1 0 1 0
3 1 0 0 1 0
3 2 0 0 0 1
3 3 1 0 0 0
3 4 0 1 0 0
;
proc mixed data =cork1 method = ml;
class tree dir;
model y =dir;
repeated/ type =un subject = tree;
title3 'Unstructured Covariance';
run;
proc mixed data = cork1 method = ml;
class tree dir;
model y = dir;
repeated/type = lin(3) ldata = circ subject = tree;
parms (190) (30) (70);
title3 'Circulant';
run;



/* Program 6.3 */

options ls =64 ps=45 nodate nonumber;
title1 'Output 6.3';
title2 'Test for \Sigma =\Sigma_0: Warpage Data';
data warpage; 
input y1 y2 y3;
lines;
3.3 3.7 3.8
4.1 4.3 4.9
2.1 1.9 2.0
1.8 1.4 2.2
3.9 3.9 3.7
2.5 2.7 2.5
4.4 3.9 4.0
3.3 3.7 4.0
4.4 3.8 4.2
1.1 1.7 1.5
1.8 1.4 1.8
4.4 4.8 4.3
3.4 3.4 3.9
2.9 2.5 2.4
3.6 3.1 3.8
;
data warpage1; 
set warpage;
array t{3} y1-y3;
panel+1;
do location = 1  to 3;
y = t{location};
output;
end;
drop y1-y3;
run;
data matrix;
input parm row col1-col3; 
datalines;
1 1 1 1 1
1 2 1 1 1
1 3 1 1 1
2 1 1 0 0
2 2 0 1 0
2 3 0 0 1
;
proc mixed data =warpage1 method = ml;
class panel location ;
model y =location ;
repeated/ type =cs subject = panel;
title3 'Compound Symmetry';

run;
proc mixed data =warpage1 method = ml;
class panel location ;
model y =location ;
parms (1) (.1)/noiter;
repeated/ type =lin(2) ldata =matrix subject = panel;
title3 'Known Fixed \Sigma_0';
run;




        /* Program 6.4 */

        options ls=64 ps=45 nodate nonumber; 
        title1 ' Output 6.4';
        title2 'Analysis of Heart Rate Data';
        data heart; 
        infile 'heart.dat';
        input drug $ y1 y2 y3 y4; 

        proc glm data=heart;
        class drug;
        model y1-y4=drug/nouni;
        repeated time 4;
        run; 
        data split;
        set heart;
        array t{4} y1-y4;
        subject+1;
        do time=1 to 4;
        y=t{time};
        output; 
        end; 
        drop y1-y4;
        run;
        * AR(1) Covariance Structure;
        proc mixed data = split covtest method = reml;
        class drug subject time;
        model y =  drug time time*drug;
        repeated /type = ar(1) subject = subject r ;
        title3 'AR(1) Covariance Structure';
        run;
       *Compound Symmetry Structure;
        proc mixed data = split covtest method = reml;
        class drug subject time;        
        model y =  drug time time*drug;
        repeated /type = cs subject = subject r ;
        title3 'Compound Symmetry Structure';
        *Unstructured Covariance;
        proc mixed data = split covtest method = reml;
        class drug subject time;
        model y =  drug time time*drug;
        repeated /type = un subject = subject r ;
        title3 'Unstructured Covariance';
        run;




        /* Program 6.5 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 6.5';
        data aud;
        infile 'audiology.dat';
        input gp$ y1-y4;
        data aud_n;
        set aud;
        array t{4} y1-y4;
        subject+1;
        do i=1 to 4;
        if (i=1) then time=1;
        if (i=2) then time=9;
        if (i=3) then time=18;
        if (i=4) then time=30;
        time1=time;
        y=t{i};
        output;
        end;
        drop i y1-y4;
        run;
        title2 'Fit Different Quadratic Curves for Groups A and B';
        proc mixed data=aud_n method=reml covtest;
        class gp subject;
        model y= gp time time*gp time*time time*time*gp/htype=1;
        repeated/type=sp(pow)(time1) subject=subject r;
        run;
        title2 'Common Quadratic Term for Groups A and B';
        proc mixed data=aud_n method=reml covtest;
        class gp subject;
        model y= gp time time*gp time*time;
        repeated/type=sp(pow)(time1) subject=subject r;
        run;
        title2 'Common Linear and Quadratic Terms for Groups A and B';
        proc mixed data=aud_n method=reml covtest;
        class gp subject;
        model y= gp time time*time/s;
        repeated/type=sp(pow)(time1) subject=subject r;
        run;
        title2 'Common Quadratic Curve for Groups A and B';
        proc mixed data=aud_n method=reml covtest;
        class gp subject;
        model y= time time*time/s;
        repeated/type=sp(pow)(time1) subject=subject r;
        run;


        /* Program 6.6 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 6.6';
        data task;
        infile 'task.dat';
        input group$ x1 x2 y1-y10;
        data a;
        set task;
        array t{10} y1-y10;
        subject+1;
        do time=1 to 10;
        y=t{time};
        output;
        end;
        drop y1-y10;
        run;
        proc mixed data=a method=reml covtest;
        classes group time subject;
        model y=group time time*group x1 x2 time*x1 time*x2 group*x1 
        group*x2 time*group*x1 time*group*x2; 
        repeated /type=cs subject=subject r;
        title2 'Analysis Under CS Covariance Structure';
        run;
        proc mixed data=a method=reml covtest;
        classes group time subject;
        model y=group time time*group x1 x2 time*x1 time*x2 group*x1 
        group*x2 time*group*x1 time*group*x2; 
        repeated /type=ar(1) subject=subject r;
        title2 'Analysis Under AR(1) Covariance Structure';
        run;




        /* Program 6.7 */

        option ls=64 ps=45 nodate nonumber; 
        title1 'Output 6.7';
        title2 'Multivariate Analysis of Time Varying 
        Covariates Data';
        proc iml;
y={66      59      47     -16     -29     6.9     -16
   29     5.8     -40     -80      13    -1.6      60
   16     -17,
  -12      59     6.7     2.6     -53     -29     2.6
  -40     -29     -60     170     -45     4.1     6.6
  -73     -38,
   60      46     6.7   -18.4     -61     -35   -18.4
  -38     5.8     -58      80     -25    -7.1     0.2
  -41     -50};
a={1       1       1       1       1       1       0
   0       0       0       0       0       0       0
   0       0,
   0       0       0       0       0       0       1
   1       1       1       1       1       1       1
   1       1};
x1={135     21      55      22     -22     7.6     55
    875     23      86    -9.6     -16      46     31
     15     13,
    545     97      78     -28     155     169    158
    158     56     121     2.4     0.2     104     81
     85     54,
    840    224     210     -33     629     754    133
    133    177      82      76     -16      25    442
    830    205};

        /* Enter the parameters for each problem */
        n=16; 
        p=3; 
        eps=10;
        * Computation of gamma hat;
        z=block(y, x1);
        g=i(n)-(a`*inv(a*a`)*a);
        * Initial value of Vhat;
        nvhat=i(p);
        do iteratio=1 to 50 while (eps > 0.0001);
        vhat=nvhat;
        pihat=log(det(vhat));
        vhatinv=inv(vhat);
        w=vhatinv#(y*g*x1`);
        T=vhatinv#(x1*g*x1`);
        onep=j(1,p,1);
        gamma=onep*W*inv(T);

        * Computation of xihat;
        irp=repeat(i(p), 1, 2);
        icn=i(n) // -i(n);
        * Compute ygx= Y-Sum(Gamma*X);
        gone=onep || gamma;
        irpp=irp*diag(gone);
        ygx=irpp*z*icn;
        xihat= ygx*a`*inv(a*a`);

        * Compute new Vhat and new pihat;
        nvhat=(ygx-xihat*a)*(ygx-xihat*a)`;
        npihat=log(det(nvhat));
        eps=abs(pihat-npihat);
        end;
        * keep vhat for the computation of lambda;
        vhat=nvhat;
        print vhat;

        /* Compute Vhat under the null hypothesis of 
        no covariate effect (we called this value sighat).  
        We have used PRINTE option of MANOVA statement of 
        PROC GLM for getting this value. These statements 
        are commented out in the program */
        /*
        yt=y`;
        at=a`;
        var1=({y1 y2 y3});
        var2=({a1 a2});
        create ndata1 from yt [colname=var1];
        append from yt;
        close ndata1;
        create ndata2 from at [colname=var2];
        append from at;
        close ndata2;
        data ndata;
        merge ndata1 ndata2;
        proc glm data=ndata;
        model y1 y2 y3=a1 a2/noint nouni;
        manova/printe;
        */
        sighat={21554.744333   -8727.857667   3420.5183333, 
                -8727.857667   49988.409333   29065.183333,
                3420.5183333   29065.183333   25186.393333};
        * Test for testing no covariate effect;
        lambda1=(det(vhat*inv(sighat)))**(n/2);
        print lambda1;
        chi1=-2*log(lambda1);
        print chi1;
        pval1=1-probchi(chi1,3);
        print pval1;

        * Test of hypothesis: No time effect, algorithm;
        /* Give L and M matrices */
        L=i(2); 
        M={ 1 -1 0, 1 0 -1}; 
        eps=10;
        /* Use nvhat and gamma from the previous step as initial 
        values. So initial value of ygx=Y-Sum(Gamma*X) is also from 
        the previous step */
        do iter=1 to 50 while (eps > 0.0001);
        pihat=log(det(nvhat));
        delta=2*inv(m*nvhat*m`)*(m*ygx*a`*inv(a*a`)*l)*
        inv(l`*inv(a*a`)*l);
        * Compute xi-tilde;
        xtilde=(ygx*a`-0.5*nvhat*m`*delta*l`)*inv(a*a`);
        vtilde=(ygx-xtilde*a)*(ygx-xtilde*a)`;
        vtnv=inv(vtilde);
        W=vtnv#(y*g*x1`);
        T=vtnv#(x1*g*x1`);
        onep=j(1,p,1);
        gmt=onep*W*inv(T);
        /* Update ygx=Y-Sum(gmt*X) in preparation for the next 
        iteration irp and icn are defined earlier */
        icn=i(n) // -i(n);
        gtn=onep || gmt;
        irpp=irp*diag(gtn);
        ygx=irpp*z*icn;
        npihat=log(det(vtilde));
        eps=abs(pihat-npihat);
        nvhat=vtilde;
        end;
        print vtilde;
        lambda=(det(vhat*inv(vtilde)))**(n/2);
        print lambda;
        chi=-2*log(lambda);
        print chi;
        pval2=1-probchi(chi,2);
        print pval2;
        quit;




        /* Program 6.8 */

        options ls=64 ps=45 nodate nonumber;
        title1 'Output 6.8';
        title2 'Analysis of Time Varying Covariates Data';
        title3 'Analysis with Independent Error for Subjects';
        data one;
        infile 'sheep.dat';
        input group$ sheep time pra anp map;
        data one;
        set one;
        y=pra; 
        x=anp; 
        z=map;
        run;
        proc mixed data=one method=reml;
        classes group time sheep;
        model y=group time group*time time*z group*z group*time*z z;
        repeated /type=simple subject=sheep r;
        run;
        title3 'Analysis with Compound Symmetry Error for Subjects';
        proc mixed data=one method=reml;
        classes group time sheep;
        model y=group time group*time time*z group*z group*time*z z;
        repeated /type=cs subject=sheep r;
        run;




        /* Program 6.9 */

        options ls = 64 ps = 45 nodate nonumber;
        title1 'Output 6.9';
        title2 'A Pharmaceutical Stability Study';
        data rc;
        input batch age@;
        do i=1 to 6;
        input y@; 
        output; 
        end;
        cards;
        1 0 101.2 103.3 103.3 102.1 104.4 102.4
        1 1 98.8 99.4 99.7 99.5 . .
        1 3 98.4 99.0 97.3 99.8 . .
        1 6 101.5 100.2 101.7 102.7 . .
        1 9 96.3 97.2 97.2 96.3 . .
        1 12 97.3 97.9 96.8 97.7 97.7 96.7
        2 0 102.6 102.7 102.4 102.1 102.9 102.6
        2 1 99.1 99.0 99.9 100.6 . .
        2 3 105.7 103.3 103.4 104.0 . .
        2 6 101.3 101.5 100.9 101.4 . .
        2 9 94.1 96.5 97.2 95.6 . .
        2 12 93.1 92.8 95.4 92.5 92.2 93.0
        3 0 105.1 103.9 106.1 104.1 103.7 104.6
        3 1 102.2 102.0 100.8 99.8 . .
        3 3 101.2 101.8 100.8 102.6 . .
        3 6 101.1 102.0 100.1 100.2 . .
        3 9 100.9 99.5 102.5 100.8 . .
        3 12 97.8 98.3 96.9 98.4 96.9 96.5
        ;
        /*Source: Obenchain (1990). Data Courtesy of R. L. Obenchain*/

        proc mixed data=rc;
        class batch;
        model y=age/s;
        random int age/type=un sub=batch s;
        run;





        /* Program 6.10 */
                                                                             
        options ls = 64 ps=45 nodate nonumber;
        title1 'Output 6.10';
        title2 'Analysis of Ramus Data';
        data ramus; 
        input boy y1 y2 y3 y4;
        y=y1;
        age=8; 
        output;
        y=y2;
        age=8.5;
        output;
        y=y3;
        age=9;
        output;
        y=y4;
        age=9.5;
        output;
        lines;
        1 47.8 48.8 49.  49.7
        2 46.4 47.3 47.7 48.4 
        3 46.3 46.8 47.8 48.5 
        4 45.1 45.3 46.1 47.2 
        5 47.6 48.5 48.9 49.3 
        6 52.5 53.2 53.3 53.7 
        7 51.2 53. 54.3 54.5 
        8 49.8 50. 50.3 52.7 
        9 48.1 50.8 52.3 54.4 
        10 45. 47. 47.3 48.3 
        11 51.2 51.4 51.6 51.9 
        12 48.5 49.2 53. 55.5 
        13 52.1 52.8 53.7 55. 
        14 48.2 48.9 49.3 49.8 
        15 49.6 50.4 51.2 51.8 
        16 50.7 51.7 52.7 53.3 
        17 47.2 47.7 48.4 49.5 
        18 53.3 54.6 55.1 55.3 
        19 46.2 47.5 48.1 48.4 
        20 46.3 47.6 51.0 51.8 
        ;
        /* Source: Elston and Grizzle (1962).  Reproduced by 
        permission of the International Biometric Society. */ 
        proc mixed data=ramus covtest;
        class boy;
        model y=age/s;
        random age /type = simple subject = boy;
        title3 'Only slope is random';
        run;
        /*
        proc mixed data=ramus covtest;
        class boy;
        model y=age/s;
        random int /type = simple subject = boy;
        title3 'Only intercept is random';
        run;
        proc mixed data=ramus covtest;
        class boy;
        model y=age/s;
        random int age /type = simple subject = boy;
        title3 'Both intercept and slope are random';
        run;
        */






        /* Program 6.11 */

        option ls=64 ps=45 nodate nonumber;
        title1 'Output 6.11';
        data a;
        input y1-y9;
        cards;
         117    59     10.5   117.5   59    16.5  118.5  60    16.5
         109    60     30.5   110.5   61.5  30.5  111    61.5  30.5
         117    60     23.5   120     61.5  23.5  120.5  62    23.5
         112    67.5   33     126     70.5  32    127    71.5  32.5
         116    61.5   24.5   118.5   62.5  24.5  119.5  63.5  24.5
         123    65.5   22     126     61.5  22    127    67.5  22
         130.5  68.5   33     132     69.5  32.5  134.5  71    32
         126.5  69     20     128.5   71    20    130.5  73    20
         113    58     25     116.5   59    25    118    60.5  24.5
         128    67     24     129     67.5  24    131.5  69    24
         116.5  63.5   28.5   120     65    29.5  121.5  66    29.5
         121.5  64.5   26.5   125.5   67.5  27    127    69    27
         109.5  54     18     112     55.5  18.5  114    57    19
         133    72     34.5   136     73.5  34.5  137.5  75.5  34.5
         120    62.5   26     124.5   65    26    126    66    26
         129.5  65     18.5   133.5   68    18.5  134.5  69    18.5
         122    64.5   18.5   124     65.5  18.5  125.5  66    18.5
         125    65.5   21.5   127     66.5  21.5  128    67    21.6
        ;
        /* This data set is from Timm, N.H. (1980).  Courtesy of Dr. 
Thomas Zullo, 
        School of Dental Medicine, University of Pittsburgh. */
        data b;  set a;
        if _n_<10 then group='1';
        else group='2';
        run;
        data b; set b; 
        subj=_n_;
        y=y1; m_var='var1'; time=1; output;
        y=y2; m_var='var2'; time=1; output;
        y=y3; m_var='var3'; time=1; output;
        y=y4; m_var='var1'; time=2; output;
        y=y5; m_var='var2'; time=2; output;
        y=y6; m_var='var3'; time=2; output;
        y=y7; m_var='var1'; time=3; output;
        y=y8; m_var='var2'; time=3; output;
        y=y9; m_var='var3'; time=3; output;
        drop y1-y9;
        title2 'Analysis of Multivariate Repeated Measures';
        title3 'Kronecker Product Covariance Structure';
        proc mixed data=b method=reml covtest;
        classes group subj m_var time;
        model y = m_var group time group*time;
        repeated m_var time/type=un@ar(1) subject=subj;
        run;





Appendix B;

/* CORK DATA SET: cork.dat */

72 66 76 77                                                                     
60 53 66 63                                                                     
56 57 64 58                                                                     
41 29 36 38                                                                     
32 32 35 36                                                                     
30 35 34 26                                                                     
39 39 31 27                                                                     
42 43 31 25                                                                     
37 40 31 25                                                                     
33 29 27 36                                                                     
32 30 34 28                                                                     
63 45 74 63                                                                     
54 46 60 52                                                                     
47 51 52 43                                                                     
91 79 100 75                                                                    
56 68 47 50                                                                     
79 65 70 61                                                                     
81 80 68 58                                                                     
78 55 67 60                                                                     
46 38 37 38                                                                     
39 35 34 37                                                                     
32 30 30 32                                                                     
60 50 67 54                                                                     
35 37 48 39                                                                     
39 36 39 31                                                                     
50 34 37 40                                                                     
43 37 39 50                                                                     
48 54 57 43                                                                     
/* Cork Boring Data: Source: C. R. Rao (1948). Reproduced 
   with permission of the Biometrika Trustees. */


/* NEWCORK DATA SET: newcork.dat */

 /* In Cork Boring Data of C.R.Rao (1948) the trees have 
    been numbered as T1-T28 */

T1 72 66 76 77
T2 60 53 66 63
T3 56 57 64 58
T4 41 29 36 38
T5 32 32 35 36
T6 30 35 34 26
T7 39 39 31 27
T8 42 43 31 25
T9 37 40 31 25
T10 33 29 27 36
T11 32 30 34 28
T12 63 45 74 63
T13 54 46 60 52
T14 47 51 52 43
T15 91 79 100 75
T16 56 68 47 50
T17 79 65 70 61
T18 81 80 68 58
T19 78 55 67 60
T20 46 38 37 38
T21 39 35 34 37
T22 32 30 30 32
T23 60 50 67 54
T24 35 37 48 39
T25 39 36 39 31
T26 50 34 37 40
T27 43 37 39 50
T28 48 54 57 43


/* FISH DATA SET: fish.dat */

        0 0. .25 .25 .25 270 .6695
        0. .10 .30 .30 .30 410 .6405
        0. .5 .75 .9 .9 610 .729
        .15 .65 1.0 1.0 1.0 940 .77
        .45 1. 1. 1. 1. 1450 .5655
        0. .05 .20 .20 .2 270 .782
        .05 .1 .3 .3 .3 410 .812
        .05 .45 .95 1. 1. 610 .8215
        .1 .7 1. 1. 1. 940 .869
        .2 .85 1. 1. 1. 1450 .8395
        0. 0. 0. 0. .05 270 .8615
        0. .05 .15 .25 .30 410 .9045
        0. .15 .95 .95 .95 610 1.028
        0. .55 .95 1. 1. 940 1.0445
        .1 .85 1. 1. 1. 1450 1.0455
        0. 0. 0. .05 .10 270 .6195
        0. .05 .15 .20 .25 410 .5305
        .1 .45 .95 .95 .95 610 .597
        .1 .7 1 1 1 940 .6385
        .35 .95 1. 1. 1. 1450 .6645
        0 .05 .20 .20 .20 270 .5685
        0 0 .15 .25 .25 410 .604
        0 .4 .9 1. 1. 610 .6325
        .05 .65 1 1. 1. 940 .6845
        .3 .85 1. 1. 1. 1450 .723
/* Source: Srivastava and Carter (1983, p. 143). */


/* THERMOCOUPLES DATA SET: thermoco.dat */

        326.06  321.92 326.03 323.59   322.84   
        326.09 322.00 326.06 323.63  322.92
        326.07  321.98 326.03 323.62   322.88   
        326.08 321.99 326.06 323.64  322.91
        326.05  321.96 326.02 323.64   322.89   
        326.05 321.96 326.02 323.60  322.89
        326.03  321.94 326.01 323.62   322.87   
        326.08 321.86 326.01 323.64  322.89
        326.00  321.85 325.99 323.58   322.85   
        326.16 322.05 326.13 323.70  322.98
        326.00  321.90 325.97 323.55   322.84   
        326.20 322.12 326.20 323.76  323.03
        325.97  321.89 325.95 323.55   322.82   
        326.20 322.10 326.18 323.74  323.02
        326.07  321.99 326.04 323.66   322.93   
        326.11 322.02 326.08 323.66  322.93
        326.00  321.91 325.98 323.57   322.82   
        326.20 322.11 326.16 323.75  323.03
        326.13  322.04 326.12 323.70   322.95   
        326.12 322.03 326.08 323.68  322.95
        326.14  322.04 326.11 323.69   322.94   
        326.15 322.05 326.12 323.70  322.97
        326.07  321.96 326.03 323.62   322.89   
        326.11 322.00 326.08 323.66  322.93
        326.07  321.97 326.03 323.62   322.89   
        326.13 322.02 326.07 323.67  323.02
        326.01  321.92 325.99 323.58   322.85   
        326.22 322.25 326.19 323.77  323.03
        326.08  321.97 326.05 323.63   322.90   
        326.16 322.06 326.12 323.70  322.97
        325.99  321.91 325.96 323.55   322.81   
        326.14 322.03 326.11 323.68  322.93
        325.97  321.86 325.94 323.51   322.80   
        326.17 322.06 326.14 323.70  322.99
        326.02  321.93 325.99 323.58   322.84   
        326.14 322.04 326.11 323.71  322.96
        326.03  321.93 325.98 323.59   322.86   
        326.10 321.99 326.08 323.66  322.91
        326.02  321.91 325.98 323.56   322.93   
        326.15 322.04 326.13 323.69  322.96
        326.10  322.00 326.03 323.64   322.91   
        326.05 321.96 326.02 323.63  322.88
        326.07  321.96 326.04 323.61   322.88   
        326.00 321.90 325.97 323.57  322.84
        326.07  321.98 326.04 323.62   322.89   
        325.96 321.86 325.90 323.51  322.80
        326.08  321.98 326.05 323.63   322.88   
        326.09 321.99 326.06 323.65  322.92
        326.06  321.96 326.01 323.61   322.86   
        326.11 322.01 326.00 323.65  322.93
        326.10  321.99 326.06 323.65   322.90   
        326.12 322.02 326.07 323.67  322.94
        326.05  322.11 326.02 323.62   322.87   
        326.03 321.95 326.00 323.60  322.87
        326.07  321.98 326.05 323.62   322.89   
        326.14 321.95 326.01 323.62  322.89
        326.09  322.00 326.06 323.65   322.91   
        326.04 321.93 326.01 323.60  322.87
        326.17  322.08 326.14 323.72   322.99   
        326.10 321.88 326.07 323.65  322.92
        326.02  321.95 326.00 323.59   322.86   
        326.11 322.02 326.08 323.67  322.94
        326.07  321.96 326.04 323.65   322.90   
        326.07 321.98 326.03 323.62  322.89
        /* Source: Christensen and Blackwood (1993).  Reprinted with 
           permission from Technometrics.  Copyright 1993 by the American 
           Statistical Association and the American Society for Quality 
           Control.  All rights reserved. */


/* ROHWER's DATA SET: rohwer.dat */

    OBS    PPVT    RPMT    SAT     N     S    NS    NA    SS

      1      68     15      24     0    10     8    21    22
      2      82     11       8     7     3    21    28    21
      3      82     13      88     7     9    17    31    30
      4      91     18      82     6    11    16    27    25
      5      82     13      90    20     7    21    28    16
      6     100     15      77     4    11    18    32    29
      7     100     13      58     6     7    17    26    23
      8      96     12      14     5     2    11    22    23
      9      63     10       1     3     5    14    24    20
     10      91     18      98    16    12    16    27    30
     11      87     10       8     5     3    17    25    24
     12     105     21      88     2    11    10    26    22
     13      87     14       4     1     4    14    25    19
     14      76     16      14    11     5    18    27    22
     15      66     14      38     0     0     3    16    11
     16      74     15       4     5     8    11    12    15
     17      68     13      64     1     6    10    28    23
     18      98     16      88     1     9    12    30    18
     19      63     15      14     0    13    13    19    16
     20      94     16      99     4     6    14    27    19
     21      82     18      50     4     5    16    21    24
     22      89     15      36     1     6    15    23    28
     23      80     19      88     5     8    14    25    24
     24      61     11      14     4     5    11    16    22
     25     102     20      24     5     7    17    26    15
     26      71     12      24     0     4     8    16    14
     27     102     16      24     4    17    21    27    31
     28      96     13      50     5     8    20    28    26
     29      55     16       8     4     7    19    20    13
     30      96     18      98     4     7    10    23    19
     31      74     15      98     2     6    14    25    17
     32      78     19      50     5    10    18    27    26


/* AIR-POLLUTION DATA SET: airpol.dat */

/* These are 42 measurements on air-pollution variables recorded 
   at 12:00 noon in the Los Angeles area on different days.
   The variables respectively are Wind, Solar rad., CO, NO, 
   NO_2, O_3, and HC. (Ref. Johnson and Wichern (1992, pp. 29-30).

8 98 7 2 12 8 2
7 107 4 3 9 5 3
7 103 4 3 5 6 3
10 88 5 2 8 15 4
6 91 4 2 8 10 3
8 90 5 2 12 12 4
9 84 7 4 12 15 5
5 72 6 4 21 14 4
7 82 5 1 11 11 3
8 64 5 2 13 9 4
6 71 5 4 10 3 3
6 91 4 2 12 7 3
7 72 7 4 18 10 3
10 70 4 2 11 7 3
10 72 4 1 8 10 3
9 77 4 1 9 10 3
8 76 4 1 7 7 3
8 71 5 3 16 4 4
9 67 4 2 13 2 3
9 69 3 3 9 5 3
10 62 5 3 14 4 4
9 88 4 2 7 6 3
8 80 4 2 13 11 4
5 30 3 3 5 2 3
6 83 5 1 10 23 4
8 84 3 2 7 6 3
6 78 4 2 11 11 3
8 79 2 1 7 10 3
6 62 4 3 9 8 3
10 37 3 1 7 2 3
8 71 4 1 10 7 3
7 52 4 1 12 8 4
5 48 6 5 8 4 3
6 75 4 1 10 24 3
10 35 4 1 6 9 2
8 85 4 1 9 10 2
5 86 3 1 6 12 2
5 86 7 2 13 18 2
7 79 7 4 9 25 3
7 79 5 2 8 6 2
6 68 6 2 11 14 3
8 40 4 3 6 5 2



/* CHEMISTRY DATA: chemist.dat */

        1  1  1  1  1  1  1 -1 4.99 92.2 
        1  1  1  1  1  1 -1  1 5.00 93.9
        1  1  1  1 -1 -1  1  1 5.61 94.6
        1  1  1  1 -1 -1 -1 -1 4.76 95.1
        1  1 -1 -1  1  1  1  1 5.23 91.8 
        1  1 -1 -1  1  1 -1 -1 4.77 94.1
        1  1 -1 -1 -1 -1  1 -1 4.99 95.4 
        1  1 -1 -1 -1 -1 -1  1 5.17 93.4
        1 -1  1 -1  1 -1  1  1 4.90 94.1
        1 -1  1 -1  1 -1 -1 -1 4.90 93.2
        1 -1  1 -1 -1  1  1 -1 5.24 92.8
        1 -1  1 -1 -1  1 -1  1 4.95 93.8
        1 -1 -1  1  1 -1  1 -1 4.96 91.6
        1 -1 -1  1  1 -1 -1  1 5.03 92.3
        1 -1 -1  1 -1  1  1  1 5.14 90.6
        1 -1 -1  1 -1  1 -1 -1 5.05 93.4
        -1  1  1 -1  1 -1  1 -1 4.97 93.1
        -1  1  1 -1  1 -1 -1  1 4.83 93.3
        -1  1  1 -1 -1  1  1  1 5.27 92.0
        -1  1  1 -1 -1  1 -1 -1 5.20 92.5
        -1  1 -1  1  1 -1  1  1 5.34 91.9 
        -1  1 -1  1  1 -1 -1 -1 5.00 92.1
        -1  1 -1  1 -1  1  1 -1 5.28 91.9
        -1  1 -1  1 -1  1 -1  1 4.93 93.7
        -1 -1  1  1  1  1  1  1 4.91 91.0
        -1 -1  1  1  1  1 -1 -1 4.71 92.9
        -1 -1  1  1 -1 -1  1 -1 4.99 94.8
        -1 -1  1  1 -1 -1 -1  1 4.91 94.1
        -1 -1 -1 -1  1  1  1 -1 4.86 91.7
        -1 -1 -1 -1  1  1 -1  1 4.65 89.4
        -1 -1 -1 -1 -1 -1  1  1 5.24 92.8
        -1 -1 -1 -1 -1 -1 -1 -1 5.05 93.7
        /* Source: Daniel and Riblett (1954).  Reprinted with 
           permission from American Chemical Society. Copyright 1954,
           American Chemical Society. */



/* HEART RATE DATA: heart.dat */

        ax23    72 86 81 77
        ax23    78 83 88 82
        ax23    71 82 81 75
        ax23    72 83 83 69
        ax23    66 79 77 66
        ax23    74 83 84 77
        ax23    62 73 78 70
        ax23    69 75 76 70
        bww9    85 86 83 80
        bww9    82 86 80 84
        bww9    71 78 70 75
        bww9    83 88 79 81
        bww9    86 85 76 76
        bww9    85 82 83 80
        bww9    79 83 80 81
        bww9    83 84 78 81
        control 69 73 72 74
        control 66 62 67 73
        control 84 90 88 87
        control 80 81 77 72
        control 72 72 69 70
        control 65 62 65 61
        control 75 69 69 68
        control 71 70 65 65

/* Source: Spector (1987, pp. 1174-1177).  "Strategies for 
   Repeated Measures Analysis of Variance", SUGI 1987. */


/* DATA SET FROM BOX (1950): box.dat */

        yes a 25 194 192 141
        yes a 25 208 188 165
        yes a 50 233 217 171
        yes a 50 241 222 201
        yes a 75 265 252 207
        yes a 75 269 283 191

        yes b 25 239 127 90
        yes b 25  187 105 85
        yes b 50 224 123 79
        yes b 50 243 123 110
        yes b 75 243 117 100
        yes b 75 226 125 75

        no a 25 155 169 151
        no a 25  173 152 141
        no a 50 198 187 176
        no a 50 177 196 167
        no a 75 235 225 166
        no a 75 229 270 183

        no b 25 137 82 77
        no b 25  160 82 83 
        no b 50 129 94 78
        no b 50 98 89 48
        no b 75 155 76 91
        no b 75 132 105 67

        /* Source: Box (1950).  Reproduced by permission of the 
           International Biometric Society. */



/* DOG DATA SET: dog.dat */

        4. 4. 4.1 3.6 3.6 3.8 3.1                                                       
        4.2 4.3 3.7 3.7 4.8 5.0 5.2                                                     
        4.3 4.2 4.3 4.3 4.5 5.8 5.4                                                     
        4.2 4.4 4.6 4.9 5.3 5.6 4.9                                                     
        4.6 4.4 5.3 5.6 5.9 5.9 5.3                                                     
        3.1 3.6 4.9 5.2 5.3 4.2 4.1                                                     
        3.7 3.9 3.9 4.8 5.2 5.4 4.2                                                     
        4.3 4.2 4.4 5.2 5.6 5.4 4.7                                                     
        4.6 4.6 4.4 4.6 5.4 5.9 5.6                                                     
        3.4 3.4 3.5 3.1 3.1 3.7 3.3                                                     
        3.0 3.2 3.0 3.0 3.1 3.2 3.1                                                     
        3.0 3.1 3.2 3.0 3.3 3.0 3.0                                                     
        3.1 3.2 3.2 3.2 3.3 3.1 3.1                                                     
        3.8 3.9 4.0 2.9 3.5 3.5 3.4                                                     
        3.0 3.6 3.2 3.1 3.0 3.0 3.0                                                     
        3.3 3.3 3.3 3.4 3.6 3.1 3.1                                                     
        4.2 4.0 4.2 4.1 4.2 4.0 4.0                                                     
        4.1 4.2 4.3 4.3 4.2 4.0 4.2                                                     
        4.5 4.4 4.3 4.5 5.3 4.4 4.4                                                     
        3.2 3.3 3.8 3.8 4.4 4.2 3.7                                                     
        3.3 3.4 3.4 3.7 3.7 3.6 3.7                                                     
        3.1 3.3 3.2 3.1 3.2 3.1 3.1                                                     
        3.6 3.4 3.5 4.6 4.9 5.2 4.4                                                     
        4.5 4.5 5.4 5.7 4.9 4.0 4.0                                                     
        3.7 4.0 4.4 4.2 4.6 4.8 5.4                                                     
        3.5 3.9 5.8 5.4 4.9 5.3 5.6                                                     
        3.9 4.0 4.1 5.0 5.4 4.4 3.9                                                     
        3.1 3.5 3.5 3.2 3.0 3.0 3.2                                                     
        3.3 3.2 3.6 3.7 3.7 4.2 4.4                                                     
        3.5 3.9 4.7 4.3 3.9 3.4 3.5                                                     
        3.4 3.4 3.5 3.3 3.4 3.2 3.4                                                     
        3.7 3.8 4.2 4.3 3.6 3.8 3.7                                                     
        4.0 4.6 4.8 4.9 5.4 5.6 4.8                                                     
        4.2 3.9 4.5 4.7 3.9 3.8 3.7                                                     
        4.1 4.1 3.7 4.0 4.1 4.6 4.7                                                     
        3.5 3.6 3.6 4.2 4.8 4.9 5.0
        /* Source: Grizzle and Allen (1969).  Reproduced by permission 
        of the International Biometric Society. */



/* BLOOD PRESSURE DATA: bpress.dat */

        1 206 c 0 1 1 1
        1 220 a c 2 1 1
        1 210 b a 3 1 1
        2 174 a 0 1 1 2
        2 146 b a 2 1 2
        2 164 c b 3 1 2
        3 192 a 0 1 1 3
        3 150 c a 2 1 3
        3 160 b c 3 1 3
        4 184 b 0 1 1 4
        4 192 a b 2 1 4
        4 176 c a 3 1 4
        5 136 b 0 1 1 5
        5 132 c b 2 1 5
        5 138 a c 3 1 5
        1 190 c 0 1 4 6
        1 145 b c 2 4 6
        1 160 a b 3 4 6 
        1 145 a 0 1 2 7
        1 125 b a 2 2 7
        1 130 c b 3 2 7
        2 160 c 0 1 2 8
        2 180 a c 2 2 8
        2 145 b a 3 2 8
        3 145 b 0 1 2 9
        3 154 c b 2 2 9
        3 166 a c 3 2 9   
        1 230 a 0 1 3 10 
        1 174 b a 2 3 10
        1 200 c b 3 3 10
        2 194 b 0 1 3 11
        2 210 c b 2 3 11
        2 190 a c 3 3 11
        3 180 c 0 1 3 12
        3 180 b c 2 3 12
        3 208 a a 3 3 12
        4 140 b 0 1 3 13
        4 150 a b 2 3 13
        4 150 c a 3 3 13
        5 194 a 0 1 3 14
        5 208 c a 2 3 14
        5 160 b c 3 3 14
        6 188 c 0 1 3 15
        6 200 a c 2 3 15
        6 190 b a 3 3 15
        7 240 a 0 1 3 16
        7 130 b a 2 3 16
        7 195 c b 3 3 16
        8 180 b 0 1 3 17
        8 180 c b 2 3 17 
        8 190 a c 3 3 17 
        9 210 c 0 1 3 18 
        9 160 b c 2 3 18 
        9 226 a b 3 3 18
        10 175 a 0 1 3 19
        10 152 c a 2 3 19
        10 175 b c 3 3 19
        11 155 b 0 1 3 20
        11 230 a b 2 3 20 
        11 226 c a 3 3 20
        12 202 a 0 1 3 21
        12 160 c a 2 3 21
        12 180 b c 3 3 21
        13 180 b 0 1 3 22
        13 185 a b 2 3 22
        13 190 c a 3 3 22
        14 185 c 0 1 3 23
        14 180 b c 2 3 23
        14 200 a b 3 3 23
 
        /* Source: Jones and Kenward (1989, p. 230).  Reprinted 
           by permission of the  Chapman and Hall, Andover, England. */



/* ONION DATA SET: onion.dat */

        1 a 0146 3756 2172 3956 3806 4990 1
        1 b 9666 8496 12056 8216 5076 -1568 1
        2 a 5767 12321 16440 15736 12760 8504 1
        2 b 2784 9668 9138 8096 9286 7413  1
        3 a 2723 3177 3427 3549 4084 4754 1
        3 b 2595 4959 6993 5614 5108 2690 1
        4 a 3365 3567 3646 5120 5390 5051 1
        4 b -2191 1281 1184 1750 0532 1328 1
        5 a 3238 8804 6480 7221 5680 4439 1
        5 b 1872 3655 4810 4737 3776 0682 1
        6 a 3567 2820 5878 4410 6988 7962 1
        6 b -1640 1063 0430 0476 0145 -3326 1
        7 a 1878 3832 3459 4300 3010 2541 1
        7 b 2126 2041 0771 1985 -1914 -0537 1
        8 a -0408 0392 1310 -0619 0770 1310 1
        8 b 2412 0000 3102 3953 3536 1671 1
        9 a 3933 5674 5878 9235 8089 7676 2
        9 b -0119 -3483 0000 2208 0791 5132 2
        10 a 6373 5902 7357 7357 5021 4888 2
        10 b -1424 0601 0546 3289 2284 0000 2
        11 a  0426 0834 8285 7357 6022 6101 2
        11 b 1773 8579 6931 6473 4774 2839 2
        12 a 8249 12011 13649 15364 14803 9191 2
        12 b 2800 6698 8755 8228 6737 -1947 2
        13 a 5623 7302 7482 0370 -1861 0370 2
        13 b 3716 4055 9555 15041 11151 2231 2
        14 a -0089 4361 4893 5001 7493 6025 2
        14 b 0517 0785 4068 3931 4776 2918 2
        ;
        /* Source: Dunsmore (1981).  Reprinted by permission of the 
           Royal Statistical Society. */



/* GLUCOSE DATA SET: glucose.dat */

    1   g1    4.90  4.50  7.84   5.46   5.08  4.32  3.91  3.99  4.15  4.41
    2   g1    4.61  4.65  7.90   6.13   4.45  4.17  4.96  4.36  4.26  4.13
    3   g1    5.37  5.35  7.94   5.64   5.06  5.49  4.77  4.48  4.39  4.45
    4   g1    5.10  5.22  7.20   4.95   4.45  3.88  3.65  4.21  4.38  4.44
    5   g1    5.34  4.91  5.69   8.21   2.97  4.30  4.18  4.93  5.16  5.54
    6   g1    5.24  5.04  8.72   4.85   5.57  6.33  4.81  4.55  4.48  5.15
    7   g2    4.91  4.18  9.00   9.74   6.95  6.92  4.66  3.45  4.20  4.63
    8   g2    4.16  3.42  7.09   6.98   6.13  5.36  6.13  3.67  4.37  4.31
    9   g2    4.95  4.40  7.00   7.80   7.78  7.30  5.82  5.14  3.59  4.00
   10   g2    3.82  4.00  6.56   6.48   5.66  7.74  4.45  4.07  3.73  3.58
   11   g2    3.76  4.70  6.76   4.98   5.02  5.95  4.90  4.79  5.25  5.42
   12   g2    4.13  3.95  5.53   8.55   7.09  5.34  5.56  4.23  3.95  4.29
   13   g3    4.22  4.92  8.09   6.74   4.30  4.28  4.59  4.49  5.29  4.95
   14   g3    4.52  4.22  8.46   9.12   7.50  6.02  4.66  4.69  4.26  4.29
   15   g3    4.47  4.47  7.95   7.21   6.35  5.58  4.57  3.90  3.44  4.18
   16   g3    4.27  4.33  6.61   6.89   5.64  4.85  4.82  3.82  4.31  3.81
   17   g3    4.81  4.85  6.08   8.28   5.73  5.68  4.66  4.62  4.85  4.69
   18   g3    4.61  4.68  6.01   7.35   6.38  6.16  4.41  4.96  4.33  4.54
   19   g4    4.05  3.78  8.71   7.12   6.17  4.22  4.31  3.15  3.64  3.88
   20   g4    3.94  4.14  7.82   8.68   6.22  5.10  5.16  4.38  4.22  4.27
   21   g4    4.19  4.22  7.45   8.07   6.84  6.86  4.79  3.87  3.60  4.92
   22   g4    4.31  4.45  7.34   6.75   7.55  6.42  5.75  4.56  4.30  3.92
   23   g4    4.30  4.71  7.44   7.08   6.30  6.50  4.50  4.36  4.83  4.50
   24   g4    4.45  4.12  7.14   5.68   6.07  5.96  5.20  4.83  4.50  4.71
   25   g5    5.03  4.99  9.10  10.03   9.20  8.31  7.92  4.86  4.63  3.52
   26   g5    4.51  4.50  8.74   8.80   7.10  8.20  7.42  5.79  4.85  4.94
   27   g5    4.87  5.12  6.32   9.48   9.88  6.28  5.58  5.26  4.10  4.25
   28   g5    4.55  4.44  5.56   8.39   7.85  7.40  6.23  4.59  4.31  3.96
   29   g5    4.79  4.82  9.29   8.99   8.15  5.71  5.24  4.95  5.06  5.24
   30   g5    4.33  4.48  8.06   8.49   4.50  7.15  5.91  4.27  4.78  5.72
   31   g6    4.60  4.72  9.53  10.02  10.25  9.29  5.45  4.82  4.09  3.52
   32   g6    4.33  4.10  4.36   6.92   9.06  8.11  5.69  5.91  5.65  4.58
   33   g6    4.42  4.07  5.48   9.05   8.04  7.19  4.87  5.40  4.35  4.51
   34   g6    4.38  4.54  8.86  10.01  10.47  9.91  6.11  4.37  3.38  4.02
   35   g6    5.06  5.04  8.86   9.97   8.45  6.58  4.74  4.28  4.04  4.34
   36   g6    4.43  4.75  6.95   6.64   7.72  7.03  6.38  5.17  4.71  5.14

/*
The data are ID, group, y1-y10 (the observations taken at the time points
-15 0 30 60 90 120 180 240 300 and 360  minutes.
From Crowder and Hand (1990) page 14.
*/


/* AUDIOLOGY DATA SET: audiology.dat */

        a 28.57 53.00 57.83 59.22
        a .     13.00 21.00 26.50
        a 60.37 86.41 .     .
        a 33.87 55.60 61.06 .
        a 26.04 61.98 67.28 .
        a .     59.00 66.80 83.20
        a 11.29 38.02 .     .
        a .     35.10 37.79 54.80
        a 16.00 33.00 45.39 40.09
        a 40.55 50.69 41.70 52.07
        a  3.90 11.06  4.15 14.90
        a   .00 17.74 44.70 48.85
        a 64.75 84.50 92.40 95.39
        a 38.25 81.57 89.63 .
        a 67.50 91.47 92.86 .
        a 45.62 58.00 .     .
        a   .00   .00 37.00 .
        a 51.15 66.13 .     .
        a   .00 48.16 .     .
        b  8.76 24.42 .     .
        b   .00 20.79 27.42 31.80
        b  2.30 12.67 28.80 24.42
        b 12.90 28.34 .     .
        b .     45.50 43.32 36.80
        b 68.00 96.08 97.47 99.00
        b 20.28 41.01 51.15 61.98
        b 65.90 81.30 71.20 70.00
        b   .00  8.76 16.59 14.75
        b  9.22 14.98  9.68 .
        b 11.29 44.47 62.90 68.20
        b 30.88 29.72 .     .
        b 29.72 41.40 64.00 .
        b   .00 43.55 48.16 .
        b  8.76 60.00 .     .
        b  8.00 25.00 30.88 55.53

/* Nunez-Anton and Woodworth (1994).  
 Biometrics, 50,445-456).  */


/* SHEEP DATA: sheep.dat */ 
young 528  5   66     135    -20      
young 528 15  -12     545    -28      
young 528 30   60     840    -24      
young 502  5   59      21      9.8    
young 502 15   59      97     20      
young 502 30   46     224     45      
young 505 5    47      55     20      
young 505 15    6.7    78     41      
young 505 30    6.7   210     39      
young 24  5   -16      22     13      
young 24  15    2.6   -28     36      
young 24  30  -18.4   -33     49      
young 599 5   -29     -22     19      
young 599 15  -53     155     45      
young 599 30  -61     629     50      
young 49  5     6.9     7.6   16      
young 49  15  -29     169     44      
young 49  30  -35     754     60      
old   717 5   -16      55     18      
old   717 15  -40     158     18      
old   717 30  -38     133     24      
old   722 5    29     875     35      
old   722 15  -40     158     18      
old   722 30  -38     133     24      
old   617 5    5.8     23      4.3    
old   617 15 -29       56     -2.1    
old   617 30   5.8    177     -2.1    
old   618 5  -40       86      7.4    
old   618 15 -60      121     22      
old   618 30 -58       82     28     

/* Data courtesy of Dr.Barbara Hargrave of Biological 
Sciences department, Old Dominion University. */ 


