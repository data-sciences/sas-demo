/*------------------------------------------------------------------- */
 /*                  The Complete Guide to SAS Indexes                */
 /*                       by Michael A. Raithel                       */
 /*       Copyright(c) 2006 by SAS Institute Inc., Cary, NC, USA      */
 /*                                                                   */
 /*                     ISBN-13: 978-1-59047-849-3                    */
 /*                     ISBN-10: 1-59047-849-5                        */  
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
 /* Attn: Michael Raithel                                             */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Michael Raithel                                  */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/*----------------------------------------------------------*/
/* Example 7.1 - Creating a Simple SAS Index in a DATA Step */
/*----------------------------------------------------------*/
data indexlib.prodindx(index=(seqno /unique /nomiss));
set  indexlib.prodsale;
run;


/*-------------------------------------------------------------------*/
/* Example 7.2 - Creating Multiple Simple SAS Indexes in a DATA Step */
/*-------------------------------------------------------------------*/
data indexlib.prodindx(index =(seqnum /unique /nomiss 
                               state / nomiss 
                               county
                               year / nomiss));
set  indexlib.prodsale;
run;


/*-------------------------------------------------------------*/
/* Example 7.3 - Creating a Composite SAS Index in a DATA Step */
/*-------------------------------------------------------------*/
data indexlib.prodcomp(index=(country_state=(country state) / nomiss));
set  indexlib.prodsale;
run;


/*----------------------------------------------------------------------*/
/* Example 7.4 - Creating Multiple Composite SAS Indexes in a DATA Step */
/*----------------------------------------------------------------------*/
data indexlib.prodcomp(index=(country_state=(country state) / nomiss
                              year_and_quarter=(year quarter)
                              state_product=(state product)));
set  indexlib.prodsale;
run;


/*----------------------------------------------------------*/
/* Example 7.5:  Creating a Simple Index in a SAS Procedure */
/*----------------------------------------------------------*/
proc summary data=indexlib.prodsale;
       class country state county prodtype product;
       var   actual predict;
output out=templib.sum_products(index=(_type_)) sum=;
run;


/*-------------------------------------------------------------*/
/* Example 7.6 - Creating a Composite Index in a SAS Procedure */
/*-------------------------------------------------------------*/
proc sort 
     data=indexlib.prodsale
     out=templib.prodindx(index=(coun_stat_cnty=(country state county) / nomiss));
	 by country state county;
run;


/*------------------------------------------------------------------------*/
/* Example 7.7 - Creating Simple and Composite Indexes in a SAS Procedure */
/*------------------------------------------------------------------------*/
proc sort 
   data=indexlib.prodsale
   out=templib.prodindx(index=(seqnum / unique
                               daymonyr / nomiss
                               coun_stat_cnty = (country state county) / nomiss
                               prodtype_product = (prodtype 
                                                   product)));
   by country state county;
run;


/*-------------------------------------------*/
/* Example 8.1:  Creating a Simple SAS Index */
/*-------------------------------------------*/
proc datasets library=indexlib;
  modify prodindx;
    index create seqnum /nomiss unique updatecentiles=10;
  run;
quit;


/*----------------------------------------------------*/
/* Example 8.2:  Creating Multiple Simple SAS Indexes */
/*----------------------------------------------------*/
proc datasets library=indexlib;
  modify prodindx;
    index create seqnum /nomiss unique updatecentiles=10;
    index create state / nomiss;
    index create county;
    index create year /nomiss;
  run;
quit;


/*----------------------------------------------*/
/* Example 8.3:  Creating a Composite SAS Index */
/*----------------------------------------------*/
proc datasets library=indexlib;
  modify prodcomp;
    index create country_state=(country state) / nomiss;
  run;
quit;


/*-------------------------------------------------------*/
/* Example 8.4:  Creating Multiple Composite SAS Indexes */
/*-------------------------------------------------------*/
proc datasets library=indexlib;
  modify prodcomp;
    index create country_state=(country state) / nomiss;
    index create year_and_quarter=(year quarter) / updatecentiles = 10;
    index create state_product=(state product);
  run;
quit;


/*-----------------------------------------------------------------*/
/* Example 9.1:  Creating a Simple Index for an Existing SAS Table */
/*-----------------------------------------------------------------*/
proc sql;
   create unique index seqnum on indexlib.prodindx;
quit;


/*-----------------------------------------------------------*/
/* Example 9.2:  Creating a Simple Index for a New SAS Table */
/*-----------------------------------------------------------*/
proc sql;
   create table indexlib.prodindx as
   select * from indexlib.prodsale;
   create unique index seqnum on indexlib.prodindx;
quit;


/*--------------------------------------------------------------------------*/
/* Example 9.3:  Creating Multiple Simple Indexes for an Existing SAS Table */
/*--------------------------------------------------------------------------*/
proc sql;
   create unique index seqnum on indexlib.prodindx;
   create index county on indexlib.prodindx;
   create index state on indexlib.prodindx;
   create index year on indexlib.prodindx;
quit;


/*--------------------------------------------------------------------*/
/* Example 9.4:  Creating a Composite Index for an Existing SAS Table */
/*--------------------------------------------------------------------*/
proc sql;
   create index country_state on indexlib.prodcomp(country, 
          state);
quit;


/*--------------------------------------------------------------*/
/* Example 9.5:  Creating a Composite Index for a New SAS Table */
/*--------------------------------------------------------------*/
proc sql;
   create table indexlib.prodcomp as
   select * from indexlib.prodsale;
   create index country_state on indexlib.prodcomp(country, state);
quit;


/*-----------------------------------------------------------------------------*/
/* Example 9.6:  Creating Multiple Composite Indexes for an Existing SAS Table */
/*-----------------------------------------------------------------------------*/
proc sql;
   create index country_state on indexlib.prodcomp(country, state);
   create index year_and_quarter on indexlib.prodcomp(year, quarter);
   create index state_product on indexlib.prodcomp(state, product);
quit;


/*----------------------------------------------------------------------------*/
/* Example 10.1:  Using a WHERE Expression in a DATA Step with a Simple Index */
/*----------------------------------------------------------------------------*/
options msglevel=I;
data canada_sales;
   set  indexlib.prodindx;

   where state in('British Columbia', 'Ontaria', 'Quebec', 'Saskatchewan');

run;


/*-------------------------------------------------------------------------------*/
/* Example 10.2:  Using a WHERE Expression in a DATA Step with a Composite Index */
/*-------------------------------------------------------------------------------*/
options msglevel=I;
data sample1;
   set  indexlib.prodcomp;

   where country eq "U.S.A." and (state = "Florida" or state = "Texas");

run;


/*----------------------------------------------------------------------------*/
/* Example 10.3:  Using a WHERE Expression in a PROC Step with a Simple Index */
/*----------------------------------------------------------------------------*/
proc summary nway data=indexlib.prodindx(where=(1999 < year < 2004));
      class product;
      var actual predict;
output out=sales2000_2003 sum=;
run;


/*-------------------------------------------------------------------------------*/
/* Example 10.4:  Using a WHERE Expression in a PROC Step with a Composite Index */
/*-------------------------------------------------------------------------------*/
proc univariate data=indexlib.prodcomp(where=(year = 2005 and quarter = 1 and actual > 1000));
run;


/*-------------------------------------------------------------------------*/
/* Example 10.5:  Using a WHERE Expression in PROC SQL with a Simple Index */
/*-------------------------------------------------------------------------*/
proc sql;
   create table bed_sales as
   select * from indexlib.prodindx
   where product eq "BED";
quit;


/*----------------------------------------------------------------------------*/
/* Example 10.6:  Using a WHERE Expression in PROC SQL with a Composite Index */
/*----------------------------------------------------------------------------*/
proc sql;
   create table first_half_2005 as
   select * from indexlib.prodcomp
   where year eq 2005 and quarter in(1, 2);
quit;


/*-------------------------------------------------------------------------------*/
/* Example 11.1:  Using a BY Statement in a DATA Step to Exploit a  Simple Index */
/*-------------------------------------------------------------------------------*/
data canada;
   set indexlib.prodindx(where=(state in('British Columbia' 
                                         'Ontario' 'Quebec'
                                         'Saskatchewan')));
     by state;
run;


/*---------------------------------------------------------------------------------*/
/* Example 11.2:  Using a BY Statement in a DATA Step to Exploit a Composite Index */
/*---------------------------------------------------------------------------------*/
data newyears;
set  indexlib.prodcomp;
        by year;
run;


/*------------------------------------------------------------------------------*/
/* Example 11.3:  Using a BY Statement in a PROC Step to Exploit a Simple Index */
/*------------------------------------------------------------------------------*/
proc rank data=indexlib.prodindx(where=(year between 2000 and 2005)) 
          out=studyears;
     by year;
     var    year    actual;
     ranks  yearank actualrank;
  run;


/*---------------------------------------------------------------------------------*/
/* Example 11.4:  Using a BY Statement in a PROC Step to Exploit a Composite Index */
/*---------------------------------------------------------------------------------*/
proc print data=indexlib.prodcomp;
      by state product;
      var  state product daymonyr predict actual;
      sum                daymonyr predict actual;
run;


/*-----------------------------------------------------------------------*/
/* Example 12.1:  Unique Index Key Variable Values in Both SAS Data Sets */
/*-----------------------------------------------------------------------*/
data indexlib.prodfile;
set  indexlib.tranfile;
modify  indexlib.prodfile key=seqnum;

select (_iorc_);
	when(%sysrc(_sok)) do; /* A match was found, update master */
		actual = newactual;
		predict = newpredict;
		replace;
	end;
	when (%sysrc(_dsenom)) do; /* No match was found */
		_error_ = 0;
	end;
	otherwise do;
		length errormessage $200.;
		errormessage = iorcmsg();
		put "ATTENTION: unknown error condition: "
			errormessage;
	end;
end;

run;


/*------------------------------------------------------------------------------------*/
/* Example 12.2:  Duplicate Index Key Variable Values in the Transaction SAS Data Set */
/*------------------------------------------------------------------------------------*/
data indexlib.prodfile;
set  indexlib.tranfile;
modify  indexlib.prodfile key=seqnum / unique;

select (_iorc_);
	when(%sysrc(_sok)) do; /* A match was found, update master */
		actual  = actual + newactual;
		predict = predict + newpredict;
		replace;
	end;
	when (%sysrc(_dsenom)) do; /* No match was found, add to master */
		actual  = newactual;
		predict = newpredict;
		output;
		_error_ = 0;
	end;
	otherwise do;
		length errormessage $200.;
		errormessage = iorcmsg();
		put "ATTENTION: unknown error condition: "
			errormessage;
	end;
end;

run;


/*-------------------------------------------------------------------------------*/
/* Example 12.3:  Duplicate Index Key Variable Values in the Master SAS Data Set */
/*-------------------------------------------------------------------------------*/
data indexlib.prodfile;
set  indexlib.tranfile;

do until (_iorc_=%sysrc(_dsenom));
	modify  indexlib.prodfile key=country_state;

	select (_iorc_);
		when(%sysrc(_sok)) do; /* A match was found, update master */
			actual = newactual;
			predict = newpredict;
			replace;
		end;
		when (%sysrc(_dsenom)) do; /* No match was found */
			_error_ = 0;
		end;
		otherwise do;
			length errormessage $200.;
			errormessage = iorcmsg();
			put "ATTENTION: unknown error condition: "
				errormessage;
		end;
	end;
end;
run;


/*---------------------------------------------------------------------------------------------------------*/
/* Example 12.4:  Duplicate Index Key Variable Values in Both the Master and the Transaction SAS Data Sets */
/*---------------------------------------------------------------------------------------------------------*/
data indexlib.prodfile;
set  indexlib.tranfile;  
	by notsorted country state;  

flag = 0;  

do until (_iorc_=%sysrc(_dsenom));  

	if flag = 1 then country = input('0000'x,$10.);  

	modify  indexlib.prodfile key=country_state;

	select (_iorc_);
		when(%sysrc(_sok)) do;     /* A match was found */  
			actual = actual + newactual;
			predict = predict + newpredict;
			replace;
		end;
Å		when (%sysrc(_dsenom)) do; /* No match was found */  
		    _error_ = 0;
		    if not last.country and not last.state and not flag then do; 
			    flag = 1;
			    _IORC_ = 0;
		    end;		
		end;
		otherwise do;
			length errormessage $200.;
			errormessage = iorcmsg();
			put "ATTENTION: unknown error condition: "
				errormessage;
		end;
	end;
end;

run;


/*------------------------------------------------------------------------*/
/* Example 13.1:  Unique Index Key Variable Values in Both  SAS Data Sets */
/*------------------------------------------------------------------------*/
data extract(drop=newactual newpredict);
set  indexlib.tranfile;
set  indexlib.prodfile key=country_state;

length errormessage $200.;
drop errormessage;

select (_iorc_);
	when(%sysrc(_sok)) do;     /* A match was found */
	    actual = newactual;
	    predict = newpredict;
	    output;
	end;
	when (%sysrc(_dsenom)) do; /* No match was found */
		_error_ = 0;
	end;
	otherwise do;
		errormessage = iorcmsg();
		put "ATTENTION: unknown error condition: "
			errormessage;
	end;
end;

run;


/*------------------------------------------------------------------------------------*/
/* Example 13.2:  Duplicate Index Key Variable Values in the Transaction SAS Data Set */
/*------------------------------------------------------------------------------------*/
data extract(drop=newactual newpredict);
set  indexlib.tranfile;
set  indexlib.prodfile key=seqnum / unique;
length errormessage $200.;
drop errormessage;
select (_iorc_);
	when(%sysrc(_sok)) do;     /* A match was found */
		actual = actual + newactual;
		predict = predict + newpredict;
	output;
	end;
	when (%sysrc(_dsenom)) do; /* No match was found */
		_error_ = 0;
	end;
	otherwise do;
		errormessage = iorcmsg();
		put "ATTENTION: unknown error condition: "
			errormessage;
	end;
end;

run;


/*-------------------------------------------------------------------------------*/
/* Example 13.3:  Duplicate Index Key Variable Values in the Master SAS Data Set */
/*-------------------------------------------------------------------------------*/
data extract;
set  indexlib.tranfile;

length errormessage $200.;
drop errormessage;

do until (_iorc_=%sysrc(_dsenom));
	set  indexlib.prodfile key=country_state;

	select (_iorc_);
		when(%sysrc(_sok)) do;     /* A match was found */
			output;
		end;
		when (%sysrc(_dsenom)) do; /* No match was found */
			_error_ = 0;
		end;
		otherwise do;
			errormessage = iorcmsg();
			put "ATTENTION: unknown error condition: "
				errormessage;
		end;
	end;
end;

run;


/*---------------------------------------------------------------------------------------------------------*/
/* Example 13.4:  Duplicate Index Key Variable Values in Both the Master and the Transaction SAS Data Sets */
/*---------------------------------------------------------------------------------------------------------*/
data extract(drop=newactual newpredict flag);
set  indexlib.tranfile;  
	by notsorted country state;  

flag = 0;  

length errormessage $200.;
drop errormessage;

do until (_iorc_=%sysrc(_dsenom));  

	if flag = 1 then country = input('0000'x,$10.);  

	set  indexlib.prodfile key=country_state;

	select (_iorc_);
		when(%sysrc(_sok)) do;     /* A match was found */  
			actual = actual + newactual;
			predict = predict + newpredict;
			output;
		end;
		when (%sysrc(_dsenom)) do; /* No match was found */  
		  _error_ = 0;
		  if not last.country and not last.state and not flag 
            then do; 
			flag = 1;
			_IORC_ = 0;
		  end;
		end;
		otherwise do;
			errormessage = iorcmsg();
			put "ATTENTION: unknown error condition: "
				errormessage;
		end;
	end;

end;

run;


/*--------------------------------------------------------*/
/* Example 14.1:  Using the IDXNAME Option in a DATA Step */
/*--------------------------------------------------------*/
data Illinois;
      set indexlib.prodindx(IDXNAME=state);
      where state eq 'Illinois' and product in('BED' 'DESK');
run;


/*--------------------------------------------------------*/
/* Example 14.2:  Using the IDXNAME Option in a Procedure */
/*--------------------------------------------------------*/
proc univariate 
data=indexlib.prodindx(where=(year <= 2005 and quarter = 1 and actual > 1000)
                              idxname=year);
run;


/*---------------------------------------------------------*/
/* Example 14.3:  Using the IDXWHERE Option in a DATA Step */
/*---------------------------------------------------------*/
data y2000_q3_4;
      set indexlib.prodindx(IDXWHERE=yes);
      where year gt 2000 and quarter > 2;
run;


/*---------------------------------------------------------*/
/* Example 14.4:  Using the IDXWHERE Option in a Procedure */
/*---------------------------------------------------------*/
proc summary nway data=indexlib.prodindx(where=(1999 < year < 2004)
                                         IDXWHERE=no);
      class product;
      var actual predict;
output out=sales2000_2003 sum=;
run;


/*---------------------------------------------------------------*/
/* Example 14.5:  Using the IDXWHERE Option in the SQL Procedure */
/*---------------------------------------------------------------*/
proc sql;
   create table ontario as
       select * from indexlib.prodcomp(idxwhere=no)
           where country eq 'Canada' and state eq 'Ontario';
quit;

