/*------------------------------------------------------------------- */
 /*          Tuning SAS Applications in the OS/390 and z/OS           */
/*                 Environments, Second Edition                       */
 /*                 by  Michael A. Raithel                            */
 /*       Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 58172                  */
 /*                        ISBN 1-59047-337-X                         */
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
 /* Books by Users                                                    */
 /* Attn: Michael Raithel                                             */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Michael Raithel                                  */
 /*                                                                   */
 /*-------------------------------------------------------------------*/





------------
Chapter 3
------------
/* The following code appears in Chapter 3, p. 69 */

        libname corpdata 'corp.sales.saslib';

        proc contents data=corpdata._all_ details;
        run;


        libname corpdata 'corp.sales.saslib';

        proc contents data=corpdata.clientfl directory details;
        run;


        libname corpdata 'corp.sales.saslib';

        proc contents data=corpdata.clientfl directory details centiles;
        run;


/* The following code appears in Chapter 3, p. 73 */

        proc catalog;
           copy in=inlib.cat
              out=outlib.cat blksize=value;
                 select entryname.entrytype;
        run;


        proc catalog;
           copy in=inlib.cat out=outlib.cat blksize=value;
        run;


/* The following code appears in Chapter 3, p. 74 */

        proc catalog;
           copy in=inlib.cat out=outlib.cat;
        run;


        libname catlib 'corp.sales.catlib';

        proc catalog catalog=catlib.catalog1;
           contents stat;
        run;


/* The following code appears in Chapter 3, p. 77 */

        proc options;
        run;


/* The following code appears in Chapter 3, p. 78 */

        proc options group=groupname;
        run;


        proc options define;
        run;


/* The following code appears in Chapter 3, p. 79 */

        proc options value;
        run;


/* The following code appears in Chapter 3, p. 80 */

        proc options option=blksize(other) define;
        run;

	proc options option=bufno value;
	run;


/* The following code appears in Chapter 3, p. 83 */

        libname corpdata 'corp.sales.saslib' disp=shr;
        filename flatfile 'nonsas.corp.flatfile' disp=shr;
        options memrpt stats fullstats;


/* The following code appears in Chapter 3, p. 84 */

        options memrpt stats fullstats;


/* The following code appears in Chapter 3, p. 85 */

        options blksize=27648;


/* The following code appears in Chapter 3, p. 86 */

        options blksize=0;


/* The following code appears in Chapter 3, p. 87 */

         options blksize(3380)=half
                 blksize(3390)=27648;

         options blksize(dasd)=half;


/* The following code appears in Chapter 3, p. 88 */

	options bufno=5;

	options bufsize=55296;
	

/* The following code appears in Chapter 3, p. 98 */

        //JOBCARD....
        //STEP01 EXEC SAS
        //TAPE1 DD UNIT=TAPE,DISP=SHR,VOL=SER=T01865
        //SYSIN DD *
          proc tapelabel ddname=tape1;
          run;
        /*

        //JOBCARD....
        //STEP01 EXEC SAS
        //TAPE1 DD UNIT=TAPE,DISP=SHR,VOL=SER=T01066
        //TAPE2 DD UNIT=TAPE,DISP=SHR,VOL=SER=T01492
        //TAPE3 DD UNIT=TAPE,DISP=SHR,VOL=SER=T01766
        //SYSIN DD *
          proc tapelabel ddname=(tape1 tape2 tape3) page;
          run;
        /*

------------
Chapter 4
------------
/* The following code appears in Chapter 4, p. 120*/

        data _null_;
           set dasd.testfile;
        run;


/* The following code appears in Chapter 4, p. 124 */

        data _null_;
           set tape.tapefile;
        run;


------------
Chapter 5
------------
/* The following code appears in Chapter 5, p. 133 */

        options bufno=5;

        data sales.q1curyr;
           set raw.salesytd;
           more SAS statements
        run;


/* The following code appears in Chapter 5, p. 135 */

        options bufno=5;

        data sales.q1curyr (bufno=10);
                set raw.salesytd;
                more SAS statements
        run;


/* The following code appears in Chapter 5, p. 136 */

        options bufno=5;

        data sales.q1curyr;
           set raw.salesytd (bufno=10);
           more SAS statements
        run;


/* The following code appears in Chapter 5, p. 137 */

        proc summary nway data=raw.q1curyr;
           class region;
           var lastnum;
           output out=summed.q1curyr(bufno=10) sum=;
        run;

        data _null_ ;
           set testfile(bufno=value);
        run;


/* The following code appears in Chapter 5, p. 140 */

        options bufno=5;

        data allfiles;
           set testfil1(bufno=10)
               testfil2;
        run;


/* The following code appears in Chapter 5, p. 143 */

        options bufsize=27648;

        data sales.q1curyr;
           set raw.salesytd;
           more SAS statements
        run;

/* The following code appears in Chapter 5, p. 145 */

        options bufsize=27648;

        data sales.q1curyr (bufsize=55296)
           sales.q1curyrrej;
           set raw.salesytd;
           more SAS statements
        run;

/* The following code appears in Chapter 5, p. 146 */

        proc summary nway data=raw.q1curyr;
           class region;
           var lastnum;
           output out=summed.q1curyr(bufsize=55296) sum=;
        run;

/* The following code appears in Chapter 5, p. 147 */

        options bufno=3;

        data _null_ ;
           set testfile;
        run;

/* The following code appears in Chapter 5, p. 153 */

        options compress=yes reuse=yes;

        data sales.q1curyr;
           set raw.salesytd;
           more SAS statements
        run;

/* The following code appears in Chapter 5, p. 155 */

        data sales.q1curyr (compress=yes)
           sales.region;
           set raw.salesytd;
           more SAS statements
        run;

        proc summary nway data=sales.q1curyr;
           class region;
           var lastnum;
           output out=summed.q1curyr(compress=yes) sum=;
        run;


/* The following code appears in Chapter 5, p. 159 */
        proc copy in=sales out=work;
           select q3curyr;
        run;

        data _null_;
           set sales.q3curyr;
        run;

        proc sort data=sales.q3curyr out=q3curyr;
           by region district store;
        run;

        proc summary nway data=sales.q3curyr;
           class region district store;
           var lastnum;
           output out=sumq3cyr sum=;
        run;


/* The following code appears in Chapter 5, p. 168 */

	libname fiscdata 'prod.fiscal.data';

	sasfile fiscdata.lastyear.data open;

	data q1lastyr;
	set fiscdata.lastyear(where=(quarter='Q1'));
	modsales = sales * .55;
	run;

	data q2lastyr;
	set fiscdata. lastyear (where=(quarter='Q2'));
	modsales = sales * .75;
	run;

	proc print data=fiscdata.lastyear(where=(sales = salesgoal));
	title 'Last Year Sales that Met the Sales Goal';
	run;

	data fiscdata lastyear;
	modify fiscdata.lastyear;
	select(quarter);
		when('Q1') comision = sales * 1.11;
		when('Q2') comision = sales * 1.12;
		when('Q3') comision = sales * 1.13;
		when('Q4') comision = sales * 1.14;

	end;
	run;
	sasfile fiscdata.lastyear.data close;
	?more SAS program statements?

------------
Chapter 6
------------
/* The following code appears in Chapter 6, p. 181 */

        proc datasets library=libref;
           modify SAS-data-set;
           index create varlist / unique nomiss
			updatecentiles= always | never | integer;
        run;


/* The following code appears in Chapter 6, p. 182 */
        proc datasets library=sales;
           modify q1curryr;
           index create itemid / unique updatecentiles=10;
         run;


/* The following code appears in Chapter 6, p. 183 */

        proc datasets library=sales;
           modify q1curryr;
           index create regdist=(region district store) / nomiss
	     updatecentiles=always;
        run;


/* The following code appears in Chapter 6, p. 184 */

        proc sql;
           create unique index itemid on sales.1curryr;
        quit;

        proc sql;
           create unique index regdist on sales.1curryr(region, district,
		store);
        quit;


/* The following code appears in Chapter 6, p. 185 */

        data sales.q1curryr(index=(itemid / unique));
           set raw.salesytd;
           more SAS statements
        run;

        data sales.q1curryr(index=(regdist=(region district store)
	     updatecentiles=always));
           set raw.salesytd;
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 189 */

        proc datasets library=prod;
           mofify q1curryr;
           index centiles store / refresh;
        run;


        proc datasets library=prod;
           mofify q1curryr;
           index centiles district updatecentiles=15;
        run;


/* The following code appears in Chapter 6, p. 192 */

        data newfile;
           set sales.q1curryr;
           where itemid eq 'ABCD1234';
           more SAS statements
        run;


        data newfile;
           set sales.q1curryr;
           where itemid eq 'ABCD1234' or state='MD';
           more SAS statements
        run;


        data newfile;
           set sales.q1curryr;
           where region=1 and district='54';
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 193 */

        proc sql;
           create table newfile as
           select * from sales.q1curryr
	     where region=1 and district='54;
           more SAS SQL statements
        run;


/* The following code appears in Chapter 6, p. 194 */

        data newfile;
           set sales.q1curryr;
           by itemid;
           more SAS statements
        run;

        data newfile2;
           set sales.q1curryr;
           by itemid store;
	  run;


/* The following code appears in Chapter 6, p. 195 */

        data newfile;
           set sales.q1curryr;
           by region district;
           more SAS statements
        run;

        data newfile;
           set inquiry.file(keep=inqnum inqname itemid);
           set sales.q1curryr key=itemid;
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 196 */

        data newfile;
           set inquiry.file(keep=inqnum inqname itemid);
           set sales.q1curryr key=itemid;
           if _iorc_=%sysrc(_dsenom) then
              put 'ITEM NOT FOUND:' itemid;
           more SAS statements
        run;

        data sales.q1curryr;
           set update.file(keep=itemid n_stornm);
           modify sales.q1curryr key=itemid;
           storname=n_stornm;
           more SAS statements
        run;

/* The following code appears in Chapter 6, p. 197 */

        data sales.q1curryr;
           set update.file(keep=itemid n_stornm);
           modify sales.q1curryr key=itemid;
           storname=n_stornm;
           if _iorc_=%sysrc(_dsenom) then
              put 'ITEM NOT FOUND:' itemid;
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 198 */

        data newfile2;
           set sales.q1curryr(idxname=itemid);
           where itemid eq 'ABCD1234' and state='MD';
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 199 */

        data newfile2;
           set sales.q1curryr(idxwhere=yes);
           where itemid eq 'ABCD1234' and state='MD';
           more SAS statements
        run;


        data newfile2;
           set sales.q1curryr(idxwhere=no);
           where itemid eq 'ABCD1234' and state='MD';
           more SAS statements
        run;


/* The following code appears in Chapter 6, p. 200 */

	options msglevel=I;


------------
Chapter 7
------------

/* The following code appears in Chapter 7, p. 212 */

        filename goodata 'the.data.set.name';

        data _null_;
           file goodata;
           input    @1   field1 $100.
                    @101 field2 $100.
                    @201 field3 $100.
                    ;
        run;


/* The following code appears in Chapter 7, p. 216 */

        proc options;
        run;


        options fileblksize(3390)=half filedev=sysda filespri=5
                filespsec=1 fileunit=cyls filevol=vol002;

        filename seq1 'alias1.seqfile1' disp=new
           space=(cyl,(40,5))
           volume=vol001 lrecl=300
           blksize=27900 recfm=fb;

        filename seq2 'alias2.seqfile2' disp=new
           lrecl=300 recfm=fb;


/* The following code appears in Chapter 7, p. 220 */

        input name         $  1-10
              payrate        15-17
              reghours       25-26
              othours        35-36;


        input name          $char10.   +4
              payrate             3.   +7
              reghours            2.   +8
              othours             2.;


        input name          $
              payrate
              reghours
              othours;


        input @1 name       $char10.
              @15 payrate     3.
              @25 reghours    2.
              @35 othours     2.;


/* The following code appears in Chapter 7, p. 221 */

        input @1 name       $char10.
              @35 othours         2.;


/* The following code appears in Chapter 7, p. 222 */

        data workers.overtime;
           infile timecard 'weekly.timecard.data';

           input @35 othours 2. @;

           if othours > 0 then do;
              input   @1 name $char10.
                      @15 payrate     3.
                      @25 reghours    2.;

           end;
           else delete;
        run;


/* The following code appears in Chapter 7, p. 223 */

        data workers.overtime;
           infile timecard 'weekly.timecard.data';

           input  @1 name  $char10.  @;

           if substr(name,1,1) lt 'N' then do;
              input   @15 payrate 3.1
                      @25 reghours 2.
                      @35 othours 2.;
           end;
           else stop;
        run;


------------
Chapter 8
------------
/* The following code appears in Chapter 8, p. 233 */

        filename tapedata 'tape.data.set.name';

        data _null_;
           file tapedata;
           input @1   field1 $100.
                 @101 field2 $100.
                 @201 field3 $100.
                 ;
        run;


/* The following code appears in Chapter 8, p. 236 */

        options fileblksize(tape)=max filedev=3590 filevol=;

        filename tape1 'tapefil1.seqfile1' disp=new
                        lrecl=300 blksize=27900
                        recfm=fb unit=3590;
        filename tape2  'tapefil2.seqfile2' disp=new
                        lrecl=300 recfm=fb;


/* The following code appears in Chapter 8, p. 241 */

        data work.tape1;
           file  tape1;
           input @1 field1 $100.
                 ;
        run;

        more SAS code

        data work.tape2;
           file  tape2;
           input @1 field1 $100.
                  ;
        run;

        more SAS code

        data work.tape3;
           file  tape3;
           input @1 field1 $100.
                                ;
        run;

        more SAS code


/* The following code appears in Chapter 8, p. 242 */

        data work.tape1;
        SAS code
           file tape1;
           input @1 field1 $100.;
        more SAS code
        run;

 
/* The following code appears in Chapter 8, p. 244 */

        data work.tape1;
           file tape1;
           put @1 field1 $100.;
        run;

        more SAS code

        data work.tape2;
           file tape2;
           put @1 field1 $100.;
        run;

        more SAS code

        data work.tape3;
           file tape3;
           put @1 field1 $100.;
        run;

        more SAS code


/* The following code appears in Chapter 8, p. 205 */

        data work.tape1;
           file tape1;
           input @1 field1 $100.;
        run;
        lots more SAS code


------------
Chapter 9
------------

/* The following code appears in Chapter 9, p. 259 */

	   infile vsamdata vsam key=partkey genkey skip bufnd=21 bufni=5;


/* The following code appears in Chapter 9, p. 260 */

        //STEP01 EXEC PGM=IDCAMS
        //SYSPRINT DD SYSOUT=*
        //SYSIN DD *
        LISTC ENT(vsam.data.set.name) ALL
        //


/* The following code appears in Chapter 9, p. 262 */

	   infile vsamdata vsam key=partkey genkey skip bufnd=7 bufni=1;


	   infile vsamdata vsam bufnd=7;


	   infile vsamdata vsam rrn=relno skip feedback=fb bufnd=7;


/* The following code appears in Chapter 9, p. 265 */

        //STEP01 EXEC PGM=IDCAMS
        //SYSPRINT DD SYSOUT=*
        //TRANFILE DD DSN=transaction.data.set.name,DISP=SHR
        //VSAMFILE DD DSN=vsam.data.set.name,DISP=OLD,AMP=(ÔBUFND=25Õ)
        //SYSIN DD *
        REPRO -
        INFILE(TRANFILE) -
        OUTFILE(VSAMFILE)
        //

------------
Chapter 10
------------

/* The following code appears in Chapter 10, p. 277 */

        libname storlib 'prod.storprog.complib'    disp = old;
        libname sales   'prod.saleslib.firstqtr'   disp = old;
        libname raw     'prod.translib.firstqtr'   disp = shr;

        data sales.firstqtr /pgm=storlib.prog0001;
           set raw.salesq1;
           where 9 < storenum < 31;
           format procdate date7. proctime time.;
           if storenum < 21 then region = 'Mid Atlantic';
              else region = 'Southern';
           procdate = today();
           proctime = time();
        run;


        libname storlib 'prod.storprog.complib' disp=shr;

        proc contents data=storlib._all_ details;
        run;


/* The following code appears in Chapter 10, p. 278 */

        libname storlib 'prod.storprog.complib' disp = shr;

	  data pgm=storlib.prog0001;
		 describe;
	  run;


	  libname storlib 'prod.storprog.complib' disp=shr;

	  proc printto log='test.pds(prg0001)' new;

	  data pgm=storlib.prog0001;
		 describe;
	  run;

	  proc printto;
	  run;


/* The following code appears in Chapter 10, p. 280 */

        libname sales   'prod.saleslib.firstqtr' disp=old;
        libname raw     'prod.translib.firstqtr' disp=shr;
        libname storlib 'prod.storprog.complib'  disp=shr;

        data pgm=storlib.prog0001;
        run;


        libname sales   'prod.saleslib.firstqtr' disp=old;
        libname raw     'prod.translib.firstqtr' disp=shr;
        libname storlib 'prod.storprog.complib'  disp=shr;

        data pgm=storlib.prog0001;
	     describe;
	     execute;
        run;


/* The following code appears in Chapter 10, p. 281 */

        libname sales   'prod.saleslib.firstqtr' disp=old;
        libname newlib  'prod.newtrans.firstq95' disp=shr;
        libname storlib 'prod.storprog.complib'  disp=shr;

        data pgm=storlib.prog0001;
           redirect input raw.salesq1=newlib.salesq1;
           redirect output sales.firstqtr=sales.currentq;
        run;


        libname templib 'temp.prog.complib'     disp=shr;
        libname storlib 'prod.storprog.complib' disp=old;

        proc datasets library=storlib;
           delete prog001z / memtype=program;
           change prog0001=prog001z / memtype=program;
           copy in=templib out=storlib;
              select prog0001 / memtype=program;
        run;


/* The following code appears in Chapter 10, p. 288 */

        libname sales   'prod.saleslib.firstqtr' disp=old;
        libname raw     'prod.translib.firstqtr' disp=shr;
        libname storlib 'prod.storprog.complib'  disp=shr;

        data pgm=storlib.prog0001;
        run;

        proc sort data=raw.salesq1;
           by region stornum;
        run;

        proc print noobs labels;
           var region stornum totsales totexpns;
        run;



        libname sales  'prod.saleslib.firstqtr' disp=old;
        libname raw    'prod.translib.firstqtr' disp=shr;

        libname storlib 'prod.storprog.complib' disp=old;

        data sales.firstqtr /pgm=storlib.prog0001;
           set raw.salesq1;
           where 9 < storenum < 31;
           format procdate date7. proctime time.;
           if storenum < 21 then region='Mid Atlantic';
              else region='Southern';
           procdate=today();
           proctime=time();
        run;


/* The following code appears in Chapter 10, p. 289 */
        //JOBCARD jobcard information
        //STEP01        EXEC SAS
        //DATALIB       DD DSN=production-DATA-step-library-name,disp=shr
        //SYSIN DD *
            %include datalib(prod0001);
        //


/* The following code appears in Chapter 10, p. 290 */

        libname sales   'devl.saleslib.firstqtr' disp=old;
        libname raw     'devl.translib.firstqtr' disp=shr;
        libname storlib 'devl.storprog.complib'  disp=shr;

        data pgm=storlib.prog0001;
        run;

        proc sort data=raw.salesq1;
           by region storenum;
        run;

        proc print noobs labels;
           var region stornum totsales totexpns;
        run;


/* The following code appears in Chapter 10, p. 291 */

        libname sales   'devl.saleslib.firstqtr' disp=old;
        libname raw     'devl.translib.firstqtr' disp=shr;
        libname storlib 'devl.storprog.complib' disp=old;

        data sales.firstqtr /pgm=storlib.prog0001;
           set raw.salesq1;
           where 9 < storenum < 31;
           format procdate date7. proctime time.;
           if storenum < 21 then region='Mid Atlantic';
              else region='Southern';
           procdate=today();
           proctime=time();
        run;


        //JOBCARD jobcard information
        //STEP01 EXEC SAS
        //DATALIB DD DSN=development-DATA-step-library-name,disp=shr
        //SYSIN DD *
                %include datalib(prod0001);
        //

------------
Chapter 11
------------

/* The following code appears in Chapter 11, p. 299 */

        libname kashmir '&templib' hip;


/* The following code appears in Chapter 11, p. 304 */

        *libname x '&temp';           /* temp library to dasd */
        *libname x '&temp' hip; /* temp library to hiperspace */

        data x.newfile;
           set inquiry.masterfl;
           where district > 5;
        run;

        proc summary nway data=x.newfile;
           by district;
           var totsales;
           output out=x.sum1 sum=;
        run;

        proc print noobs;
           by district;
           id district;
           var totsales _freq_;
           sum totsales _freq_;
           title1 'total sales for districts > 5';
        run;


------------
Chapter 12
------------
/* The following code appears in Chapter 12, p. 314 */

        //SASFILE DD DSN=PROD.SAS.DATA,DISP=OLD


        libname sasfile 'prod.sas.data' disp=old;


/* The following code appears in Chapter 12, p. 320 */

        data file01;
           set input.data;

        other SAS code

        run;

        proc summary data=file01;
           class storenum;
           var sales;
           output out=sum1 sum=;
        run;

        proc datasets library=work;
           delete file01;
        run;

        data mergall;
           merge sum1(in=a) input.newdata(in=b);
           by storenum;
           if a;

           other SAS code

        run;

        the rest of the SAS program



