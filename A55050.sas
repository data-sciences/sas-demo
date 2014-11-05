/*************************************************************************/
/*  The first part of this file contains the SAS/EIS application macros. */
/*  Submit the macros to the SAS system before running the examples.     */
/*  The examples follow in the second part of this file.                 */
/*************************************************************************/


/*****************************************************************/
/*                                                               */
/* The %EISSTRTB macro defines standard macro variables used     */
/* in a CREATE method. These variables are used in messages      */
/* to the user.                                                  */
/*                                                               */
/*****************************************************************/

%macro eisstrtb;
   %global emsg1 emsg2 emsg3 emsg4 emsg5 emsg6 emsg7 emsg8;
   %let emsg1=ERROR: Specified application is not unique.;
   %let emsg2=ERROR: Entered information is incorrect.;
   %let emsg3=ERROR: An application name is required.;
   %let emsg4=Specify or press Cancel to quit.;
   %let emsg5=WARNING: The object is not in sync with its class.;
   %let emsg6=Select Goback to resynchronize.;
   %let emsg7=ERROR: The edit method specified for the class;
   %let emsg8=does not exist.;
%mend eisstrtb;

%eis




/************************************************************************/
/*                                                                      */
/* The %APPLFNDB macro retrieves an application from the application    */
/* database to edit, browse, or test in a CREATE method. In addition,   */
/* it reads in the instance variables for an existing application. For  */
/* a new application, it sets up the lists that will contain the        */
/* instance variables.                                                  */
/*                                                                      */
/************************************************************************/

%macro applfndb;
   rc=fetch('\BLOCKCURON');
   %bookmark(PUSH);
   call method('wobjdsid.scl', 'wobjdsid', wdsid);
   rc=where(wdsid,"NAME EQ '" || appltype || "'");
   call set(wdsid);

/*****************************************************************/
/* If editing an existing application, create the application    */
/* list to be filled in with existing information.               */
/*****************************************************************/

   privdata=dsname(appldsid);
   call set(appldsid);
   applist=makelist(0);

/*****************************************************************/
/* Check to see if application exists.                           */
/*****************************************************************/

   if(applname^=' ') then
      do;

/*****************************************************************/
/* Locate the control record in the application database to      */
/* find existing application information.                        */
/*****************************************************************/

         rc=where(appldsid, "applname='" || trim(applname) ||
                  "'" || " and appltype='" || trim(appltype) || "'");
         rc1=fetch(appldsid);
         rc=fetch(wdsid);
         if rc1 eq 0 then
            do;

/*****************************************************************/
/* Fill the list with current information.                       */
/* Get the generic information in GETAPPLG and the specific      */
/* information in GETAPPL.                                       */
/*****************************************************************/

               link getapplg;
               link getappl;
               newflag=0;
               protect applname;
               cursor descript;
               if editpgm ne getvarc(appldsid,varnum(appldsid,'EDITPGM')) then
               do;
                  call display(%acatalog(eis,ERRMSG), 0,"&emsg5","&emsg6");
                  edit_flag=1;
                  goto term;
               end;
            end;
         end;
      else
         do;
            rc=fetch(wdsid);

/*****************************************************************/
/* Set "NEW" flag if creating a new application.                 */
/*****************************************************************/

            newflag=1;
            cursor applname;
         end;
      if userattr le 0 then
         do;
            userattr=makelist();
            applist=setniteml(applist,userattr,"USERATTR");
         end;
         link setfld;
   %mend applfndb;




/*****************************************************************/
/*                                                               */
/* The %APPLFNDR macro retrieves an application from the         */
/* application database at execution time. In addition, it       */
/* reads the instance variables in the application database      */
/* and places the application in the BOOKMARK stack.  This       */
/* macro runs any INITIALIZE methods that exist, and it sets     */
/* the pull-down menu and colors for the application.            */
/*                                                               */
/*****************************************************************/

%macro applfndr;

/*****************************************************************/
/* Locate the control record in the application database.        */
/*****************************************************************/

   call set(appldsid);
   rc=where(appldsid, "applname='" || trim(applname) ||
            "'" || " and appltype='" || trim(appltype) || "'");
   rc=fetch(appldsid);

/*****************************************************************/
/* Put this application in the BOOKMARK stack.                   */
/*****************************************************************/

   %bookmark(PUSH,X);

/*****************************************************************/
/* If the application does not exist, execute the TERM label.    */
/*****************************************************************/

   if (rc ne 0) then
      do;
         link term;
         return;
      end;

/*****************************************************************/
/* Otherwise, get the application list.                          */
/*****************************************************************/

   link getapplg;     /* Instance variables that are generic    */
                      /* to all object types.                   */
   link getappl;      /* Instance variables that are specific   */
                      /* to this object type.                   */

/*****************************************************************/
/*  Set up a named user control list.                            */
/*****************************************************************/

   userlist=makelist();
   userlist=setnitemc(userlist,
                      privdata || '.' || applname || '.' || appltype,
                      'APPLNAME');
   if (_Self_ > 0) then
      userlist=setnitemn(userlist,_self_,'FRAME_ID');
   userlist=setnitemc(userlist, ' '    , 'TEXT'    );
   userlist=setnitemc(userlist, ' '    , 'TYPE'    );
   userlist=setnitemn(userlist, 0      , 'POSITION');
   userlist=setnitemc(userlist, ' '    , 'COMMAND' );
   userlist=setnitemn(userlist, 0      , 'REFRESH' );
   userlist=setnitemc(userlist, ' '    , 'HOTSPOT' );
   userlist=setnitemc(userlist, ' '    , 'HCOLOR'  );
   userlist=setnitemc(userlist, ' '    , 'HATTR'   );
   userlist=setniteml(userlist, applist, 'APPLIST' );

/*****************************************************************/
/* Execute the INITIALIZE method (if it exists) for the object.  */
/*****************************************************************/

   call method('wobjdsid.scl', 'wobjdsid', wdsid);
   rc=where(wdsid,"NAME EQ '" || appltype || "'");
   if (fetch(wdsid)=0) then
      do;
         cinitpgm=searchpath(getvarc(wdsid,varnum(wdsid,'INITPGM')));
         if (cinitpgm ne ' ') then
         call display(cinitpgm,&eparmlst,userlist,rc);
         cclickpgm=searchpath(getvarc(wdsid,varnum(wdsid,'CLICKPGM')));
      end;

/********************************************************************/
/* Execute the INITIALIZE method (if it exists) for the application.*/
/********************************************************************/

   if (initpgm ne ' ') then call display(initpgm,&eparmlst,userlist,rc);

/********************************************************************/
/* Set the object-specific pull-down menus and colors, if specified.*/
/********************************************************************/

   pmenu=searchpath(getnitemc(applist,'MENU',1,1,' '));

   if (pmenu ne ' ') then
      do;
         call execcmd('setpmenu ' || pmenu);
         refresh;
      end;

   if (getnitemc(userattr, "CBACK",1,1,' ') ne ' ') then
      call execcmd("COLOR BACK " || getnitemc(userattr, "CBACK") ||
                 "; COLOR MENU " || getnitemc(userattr, "CBACK"));

   if (getnitemc(userattr, "CPMEN",1,1,' ') ne ' ') then
      call execcmd("COLOR COMMAND " || getnitemc(userattr, "CPMEN"));

   carrw=getnitemc(userattr, "CARRW",1,1," ");
   if ((carrw ne " ") and (_self_ gt 0)) then
      do;
         widgetlist=makelist();
         call notify(".", "_GET_WIDGETS_", widgetlist);
         do i=1 to 4;
            widget=scan("UP LEFT DOWN RIGHT",i," ");
            if nameditem(widgetlist,widget) then
               call notify(widget,"_SET_COLOR_",carrw);
         end;
            if nameditem(widgetlist,"JUMP") then
               call notify("JUMP","_SET_BORDER_COLOR_",carrw);
            rc=dellist(widgetlist,"Y");
      end;
%mend applfndr;




/*****************************************************************/
/*                                                               */
/* The %BOOKMARK macro provides the bookmark feature in a        */
/* CREATE or a RUN method. The macro places the application      */
/* in the BOOKMARK stack (also called a PUSH), it removes the    */
/* application from the BOOKMARK stack (also called a POP), and  */
/* it terminates the application when another bookmark is        */
/* selected (PROCESS).                                           */
/*                                                               */
/*****************************************************************/

%macro bookmark(event,flag);
   %if &event=PUSH %then
      %do;

/*****************************************************************/
/* Put this window on the bookmark list to indicate to SAS/EIS   */
/* that it has been displayed.                                   */
/*****************************************************************/

      %if &flag eq %then
         call display(%acatalog(eis, PSHSTCK), "&leg1", pos);
      %else
         %do;
            if (descript eq ' ') then
               descript=applds || '.' || applname || '.' || appltype;
            call display(%acatalog(eis, PSHSTCK), descript, pos);
         %end;
      %end;

   %else %if &event=POP %then
      %do;
         if (gbrc) then call display(%acatalog(eis,RMVSTCK));
      %end;

   %else %if &event=PROCESS %then
      %do;

/*****************************************************************/
/* Check the return code for subsequent program requests         */
/* to bookmark past the current point.                           */
/*****************************************************************/

         call display(%acatalog(eis, CHKSTCK), pos, gbrc);
         if (gbrc=1) then
            do;
               link term;
               return;
            end;
      %end;
%mend bookmark;





/*****************************************************************/
/* The %CHKDATA macro verifies that all window variables are     */
/* non-null and contain data. Although %CHKDATA is typically     */
/* used in CREATE methods, it can also provide error checking    */
/* in RUN methods.                                               */
/*****************************************************************/

%macro chkdata(flds);
   CHKDATA:
      link clrfld;
      %do i=1 %to %length(&flds);
         %let parm=%scan(&flds,&i,' ');
         %if &parm ne %then
            %do;
         if (&parm eq ' ') then
            do;
               call display(%acatalog(eis,ERRMSG), 0, "&&emsg2&i","&emsg4");
               _status_='R';
               if (gbrc) then call display(%acatalog(eis,RMVSTCK));
               cursor &parm;
               xrc=-2;
               link setfld;
               return;
            end;
         %end;
      %end;
      link userchks;
      link setfld;
   return;

   CLRFLD:
      call clrfld(REQUIRED
      %do i=1 %to 10;
         %let parm=%scan(&flds,&i,' ');
         %if &parm ne %then , &parm;
      %end;
      );
   return;

   SETFLD:
      call setfld(REQUIRED
      %do i=1 %to 10;
         %let parm=%scan(&flds,&i,' ');
         %if &parm ne %then , &parm;
      %end;
      );
   return;
%mend chkdata;




/*****************************************************************/
/*                                                               */
/* The %CHKNAME macro verifies that an application name is       */
/* unique within an application database. The macro is used      */
/* in a CREATE method.                                           */
/*                                                               */
/*****************************************************************/

%macro chkname;
   CHKNAME:
      erroroff applname;
      rc=where(appldsid, "applname='" || trim(applname) || "'" ||
               " and appltype='" || trim(appltype) || "'");
      if fetch(appldsid, 'NOSET')=0 then do;
         alarm;
         erroron applname;
         _MSG_="&emsg1";
      end;
      rc=where(appldsid, 'UNDO');
   return;
%mend chkname;





/*****************************************************************/
/*                                                               */
/* The %EISINIT macro assigns initial null values to several     */
/* SAS/EIS reserved variables in both CREATE and RUN methods.    */
/* It also sets CONTROL to ALWAYS to enable non-SAS command      */
/* processing by MAIN and to allow error checking in the SCL     */
/* for the methods.                                              */
/*                                                               */
/*****************************************************************/

%macro eisinit;
   %akeyfld;
   control always;
   _frame_   = _frame_;
   _cmd_     = ' ';
   runpgm    = _cmd_;
   editpgm   = ' ';
   cinitpgm  = ' ';
   initpgm   = ' ';
   cclickpgm = ' ';
   clickpgm  = ' ';
   pmenu     = ' ';
   notes     = ' ';
   descript  = ' ';
   catloc    = ' ';
   applist   = 0;
%mend eisinit;





/*****************************************************************/
/*                                                               */
/* The %EISSTART macro generates initial program statements in   */
/* both CREATE and RUN methods. The macro defines an ENTRY       */
/* statement and declares the length of several variables. In    */
/* addition, it contains the GETAPPLG label block (called by the */
/* %APPLFNDB macro in a CREATE method and by the %APPLFNDR macro */
/* in a RUN method), which identifies the location of the        */
/* application list in the database. The macro also gets other   */
/* generic information.                                          */
/*                                                               */
/*****************************************************************/

%macro eisstart;
   %eis;
   %eisentry applname
             appltype $ 8;

   length privdata $ 17
          editpgm
          runpgm
          cinitpgm
          initpgm
          cclickpgm
          clickpgm
          pmenu
          catloc $ 35
          rc 8;

/*****************************************************************/
/*  Find the application list and read generic information.      */
/*****************************************************************/

   GETAPPLG:
      privdata=dsname(appldsid);
      if scan(catloc, 3, ' .') ^= ' ' then
         catloc=trim(privdata)              ||
                '.'                         ||
                trim(scan(catloc, 3, ' .')) ||
                '.EIS';
      else catloc=trim(privdata) ||
                  '.'            ||
                  trim(catloc);

      if cexist(catloc) then
         do;
               /* Object already exists : read in generic data */
            applist  = makelist();
            rc       = fillist('eis', catloc, applist);
            initpgm  = searchpath(getnitemc(applist,'INITPGM',1,1,' '));
            clickpgm = searchpath(getnitemc(applist,'CLICKPGM',1,1,' '));
            pmenu    = searchpath(getnitemc(applist,'MENU',1,1,' '));
            userattr = getniteml(applist,'USERATTR',1,1,0);
         end;
   return;
%mend eisstart;










/*****************************************************************/
/*                                                               */
/* The %EISTERM macro generates the standard TERM label SCL      */
/* program statements in a CREATE method. The macro verifies     */
/* that the required information is present, it saves the        */
/* application in the application database, and it performs      */
/* other cleanup tasks. See the %EISTERMR macro for a similar    */
/* macro used in a RUN method.                                   */
/*                                                               */
/*****************************************************************/

%macro eisterm;
   rc=where(appldsid, 'UNDO');
   if (_STATUS_ ^= 'C') then
      do;

/*****************************************************************/
/* Make sure all required information is present before          */
/* closing the window.                                           */
/*****************************************************************/

      if (applname=' ') then
         do;
            call display(%acatalog(eis, ERRMSG), 0, "&emsg3", "&emsg4");
            _STATUS_='R';
            %bookmark(POP);
            cursor applname;
            return;
         end;
      else
            /* Check for other required information. */
         do;
            xrc=-1;
            link chkdata;
            if (xrc ne 0) then
            do;
               if (xrc eq -1) then
               call display(%acatalog(eis,ERRMSG), 0, "&emsg2", "&emsg4");
            else if (xrc gt 0) then
               call display(%acatalog(eis,ERRMSG), 0,
                            symget('emsg' || left(put(xrc,8.))), "&emsg4");
            _STATUS_='R';
            %bookmark(POP);
            return;
         end;
      end;
     link update;
     end;

/*****************************************************************/
/* Miscellaneous clean-up.                                       */
/*****************************************************************/

   if (applist>0) then rc=dellist(applist, 'Y');
   call display(%acatalog(eis, POPSTCK));
   if (edit_flag) then
      do;
         fullname=searchpath(editpgm);
         if ((fullname^=' ') and (cexist(fullname))) then
            call display(fullname, &EPARMLST, applname, appltype);
      else
         call display(%acatalog(eis, ERRMSG), 0, "&emsg7", "&emsg8");
      end;
   _STATUS_='H';
%mend eisterm;




/*****************************************************************/
/*                                                               */
/* The %EISTERMR macro generates the standard TERM label SCL     */
/* program statements in a RUN method. The macro deletes SCL     */
/* lists and removes the application from the BOOKMARK stack.    */
/* See the %EISTERM macro for a similar macro used in a CREATE   */
/* method.                                                       */
/*                                                               */
/*****************************************************************/

%macro eistermr;
   rc=where(appldsid, 'UNDO');
   if (applist) then rc=dellist(applist , 'Y');
   if (userlist) then rc=dellist(userlist, 'Y');
   call display(%acatalog(eis, POPSTCK));
   _STATUS_='H';
%mend eistermr;





/*****************************************************************/
/*                                                               */
/* The %GOTARGET macro generates program statements to execute   */
/* a target application or other selectable window element in    */
/* a RUN method.                                                 */
/*                                                               */
/*****************************************************************/

%macro gotarget;
   GOTARGET:
      if (userattr gt 0) then
         do;
            type=getnitemn(userattr,'TYPE',1,1,.);

            if (type eq 1) then
            do;
               target=getnitemc(userattr,'TARGET',1,1,' ');
               if (target ne ' ') then
               do;
                  call display(%acatalog(eis,RUNEIS),&eparmlst,target,rc);
                  return;
               end;
            end;
            else if (type eq 2) then
                 call execcmdi(getnitemc(applist,'_CMD_',1,1,' '));
            else if (type eq 3) then goto term;
            else if (type eq 4) then call execcmdi('HELP');
            else _msg_="NOTE: No target application specified.";
         end;
    return;
%mend gotarget;





/*****************************************************************/
/*                                                               */
/* The %MBQUERY2 macro provides compatibility for objects        */
/* running under Release 6.08 of the SAS System in a CREATE      */
/* or a RUN method. Objects running under later releases of      */
/* the SAS System should use the standard %MBQUERY macro. See    */
/* SAS/EIS Software: Reference, Version 6, First Edition         */
/* for more information.                                         */
/*                                                               */
/*****************************************************************/


%macro mbquery2(kbdsid,kbname,dlist,alist,scrvar,numsel);
   rlist=makelist();
   vlist=0;
   sort='ASCENDING';
   rpos='R';
   flag='MACRO';
   call display('mbquery2.frame',rlist,n,&kbdsid,&dlist,vlist,&alist,
                sort,&kbname,rpos,&scrvar,&numsel,flag);
   rc=dellist(rlist,'Y');
%mend mbquery2;





/*****************************************************************/
/*                                                               */
/* The %METHODS macro retrieves the INITIALIZE, SELECT, and      */
/* PMENU methods used in an application's RUN method.            */
/*                                                               */
/*****************************************************************/

%macro methods;
   METHODS:
      call display(%acatalog(eis,METHODS),&eparmlst,
                   initpgm,clickpgm,pmenu,appltype);
      applist=setnitemc(applist,initpgm,'INITPGM');
      applist=setnitemc(applist,clickpgm,'CLICKPGM');
      applist=setnitemc(applist,pmenu,'MENU');
      return;
%mend methods;





/*****************************************************************/
/*                                                               */
/* The %PREVIEW macro generates statements to execute an         */
/* application from within a CREATE method. The macro enables    */
/* you to test your application from within the CREATE method    */
/* (similar to the TEST button in most SAS/EIS objects).         */
/*                                                               */
/*****************************************************************/


%macro preview;
   PREVIEW:

/*****************************************************************/
/*  Preview the application as currently defined.                */
/*                                                               */
/*  Verify that all required information is present.             */
/*****************************************************************/

     link chkdata;
     if (xrc ne 0) then
        do;
           if (xrc eq -1) then
              call display(%acatalog(eis,ERRMSG), 0, "&emsg2", "&emsg4");
           else if (xrc gt 0) then
              call display(%acatalog(eis,ERRMSG), 0,
                           symget('emsg' || left(put(xrc,8.))), "&emsg4");
           return;
        end;


/*****************************************************************/
/*  Set up a temporary application to use for the preview.       */
/*****************************************************************/

     oldname=applname;
     ocatloc=catloc;
     applname='XTSTAPPX';

/*****************************************************************/
/* Find a location for the application list.                     */
/*****************************************************************/

     catloc=trim(privdata) || "." || trim(applname) || ".EIS";
     call display(%acatalog(eis, UNIQUE.SCL), catloc);

/*****************************************************************/
/*  Put the information in the list and save it.                 */
/*****************************************************************/

     link setappl;
     rc=savelist('EIS', catloc, applist, 0, descript);
     rc=append(appldsid);

/*****************************************************************/
/*  Run the application.                                         */
/*****************************************************************/

      call display(%acatalog(eis, RUNEIS), &EPARMLST,
                   trim(applname) || '.' || trim(appltype), rc);

/*****************************************************************/
/* Remove the temporary definition.                              */
/*****************************************************************/

     rc=where(appldsid, "applname='XTSTAPPX' and appltype='" ||
              trim(appltype) || "'");
     if fetch(appldsid)=0 then rc=delobs(appldsid);
     if cexist(catloc) then rc=delete(catloc, 'CATALOG');

/*****************************************************************/
/* Restore the environment.                                      */
/*****************************************************************/

      rc=where(appldsid);
      applname=oldname;
      catloc=ocatloc;
    return;
%mend preview;





/*****************************************************************/
/*                                                               */
/* The %TARGET macro generates program statements to enable a    */
/* user to interactively specify a target application within a   */
/* CREATE method.                                                */
/*                                                               */
/*****************************************************************/

%macro target;
   TARGET:

/*****************************************************************/
/* Set the target application.                                   */
/*****************************************************************/

      if (userattr gt 0) then call display(%acatalog(eis,TARGET.FRAME), applist);
   return;
%mend target;




/*****************************************************************/
/*                                                               */
/* The %UPDATE macro generates program statements to enable a    */
/* user to interactively change a target application within a    */
/* CREATE method.                                                */
/*                                                               */
/*****************************************************************/

%macro update;
   UPDATE:

/*****************************************************************/
/* Find a location for the application list.                     */
/*****************************************************************/

      if (catloc=' ') then
         do;
            catloc=trim(privdata) || "." || trim(applname) || ".EIS";
            call display(%acatalog(eis, UNIQUE.SCL), catloc);
         end;

      else if (scan(catloc, 3, ' .') ^= ' ') then
           catloc=trim(privdata)              || '.' ||
                  trim(scan(catloc, 3, ' .')) || '.EIS';

      else catloc=trim(privdata) || '.' || trim(catloc);

/*****************************************************************/
/* Put the information in the list and save it.                  */
/*****************************************************************/

      link setappl;
      rc=savelist('eis', catloc, applist, 0, descript);

/*****************************************************************/
/* Update the application database with the application          */
/* information.                                                  */
/*****************************************************************/

      rc=rewind(appldsid);
      catloc=trim(scan(catloc, 3, ' .')) || '.EIS';
      if (newflag) then rc=append(appldsid);
      else
         do;
            rc=where(appldsid, "applname='" || trim(applname) ||
                     "'" || " and appltype='" || trim(appltype) ||
                     "'");
            rc=fetch(appldsid,'NOSET');
            rc=update(appldsid);
            rc=where(appldsid,'UNDO');
         end;
    return;
%mend update;





/*****************************************************************/
/*                                                               */
/* The %USERCLK macro generates program statements to execute    */
/* a SELECT method within a RUN method, if a SELECT method       */
/* exists for the object.                                        */
/*                                                               */
/*****************************************************************/

%macro userclk;
   USERCLK:

/*****************************************************************/
/* Execute the user-defined application SELECT method            */
/* (if it exists).                                               */
/*****************************************************************/

      link upduserl;
      if (clickpgm ne ' ') then
          call display(clickpgm,&eparmlst,userlist,rc);
   return;
%mend userclk;




/*****************************************************************/
/*                                                               */
/* The %USERCLKC macro generates program statements to execute   */
/* a SELECT method within a RUN method, if a SELECT method       */
/* exists for the object.                                        */
/*                                                               */
/*****************************************************************/

%macro userclkc;
   USERCLKC:

/*****************************************************************/
/*  Execute the object SELECT method (if it exists).             */
/*****************************************************************/

      link upduserl;
      if (cclickpgm ne ' ') then
          call display(cclickpgm,&eparmlst,userlist,rc);
   return;
%mend userclkc;




/*****************************************************************/
/*                                                               */
/* The %UTILS macro invokes utility macros to use in the CREATE  */
/* method. See the descriptions of these macros for more         */
/* information.                                                  */
/*                                                               */
/*****************************************************************/

%macro utils;
   %target
   %update
   %preview
   %chkname
   %methods
%mend utils;





/*****************************************************************/
/*                                                               */
/* The %UTILSR macro invokes utility macros to use in a RUN      */
/* method.                                                       */
/*                                                               */
/*****************************************************************/

%macro utilsr;
   %userclkc
   %userclk
   %gotarget
%mend utilsr;





/*****************************************************************/
/*                                                               */
/* The %V608 macro provides compatibility for objects that run   */
/* under Release 6.08 of the SAS System. The macro generates     */
/* compatible versions of the macros %MBDIRLST and %MBVARLST.    */
/* See the note in the initial comment block of the macro before */
/* compiling it with your methods.                               */
/*                                                               */
/* For documentation on the %MBDIRLST and %MBVARLST macros, see  */
/* SAS/EIS Software: Reference.                                  */
/*                                                               */
/*****************************************************************/

%macro v608;
   %if &sysver=6.08 %then
      %do;
         %macro mbdirlst(select, mbdsid, mldsid, attr, numsel, msg, title,
                         andflag) / stmt;
         /*------------------------------------------------------------*/
         /*                                                            */
         /*  MACRO: MBDIRLST                                           */
         /*                                                            */
         /*  SUPPORT: youruserid                                       */
         /*                                                            */
         /*  USAGE: 1) %mbdirlst(select, mbdsid, mldsid, attr,         */
         /*                      numsel, msg, title, andflag);         */
         /*                                                            */
         /*  DESCRIPTION:                                              */
         /*    This macro is used in an SCL program to select a        */
         /*    SAS/EIS data set registration.                          */
         /*                                                            */
         /*  NOTES:                                                    */
         /*    This can be called as a statement style macro.          */
         /*                                                            */
         /*  HISTORY:                                                  */
         /*    ddMMMyy Initial coding                      youruserid  */
         /*                                                            */
         /*------------------------------------------------------------*/

         _MBRC_=0;
         _MBMSG_=_blank_;

         %if &numsel  = %then %let numsel   =1;
         %if &msg     = %then %let msg      =' ';
         %if &title   = %then %let title    =' ';
         %if &andflag = %then %let andflag  =' ';

         call display(%acatalog(eis, MBDIRLST), &mbdsid, &select, &msg, '',
                      &mldsid, &numsel, &title, &attr, &andflag);
         %mend mbdirlst;

         %macro mbvarlst(select, mbdsid, dsname, attr, numsel, msg, title,
                         selorder, exclvars, selvars, andflag) / stmt;
         /*------------------------------------------------------------*/
         /*                                                            */
         /*  MACRO: MBVARLST                                           */
         /*                                                            */
         /*  SUPPORT: youruserid                                       */
         /*                                                            */
         /*  USAGE: 1) %mbvarlst(select, mbdsid, dsname, attr, numsel, */
         /*                      msg, title, selorder, exclvars,       */
         /*                      selvars, andflag);                    */
         /*                                                            */
         /*  DESCRIPTION:                                              */
         /*    This macro is used in an SCL program to select a        */
         /*    SAS/EIS variable registration.                          */
         /*                                                            */
         /*  NOTES:                                                    */
         /*    This can be called as a statement-style macro.          */
         /*                                                            */
         /*  HISTORY:                                                  */
         /*    ddMMMyy Initial coding                    youruserid    */
         /*                                                            */
         /*------------------------------------------------------------*/

         _MBRC_=0;
         _MBMSG_=_blank_;

         %if &numsel   = %then %let numsel   =1;
         %if &msg      = %then %let msg      =' ';
         %if &title    = %then %let title    =' ';
         %if &selorder = %then %let selorder =' ';
         %if &exclvars = %then %let exclvars =' ';
         %if &selvars  = %then %let selvars  =' ';
         %if &andflag  = %then %let andflag  =' ';

         call display(%acatalog(eis, MBVARLST), &select, &mbdsid,
                      &dsname, &attr, &numsel, &msg, &selorder,
                      &exclvars, selvars, &andflag, &title);
         %mend mbvarlst;
         %end;
%mend v608;



/****************************************************************/
/****************************************************************/
/* The following can be used to run the examples in Chapter 2,  */
/* "Extending Your SAS/EIS Software Capabilities" with the 6.10 */
/* Release of SAS Software.  You may need to modify this sample */
/* code when running examples in other SAS Software releases.   */
/* You will need to create the FRAME entries that accompany     */
/* this sample code.                                            */
/* Copyright(c) 1994 by SAS Institute Inc., Cary, NC USA        */
/****************************************************************/
/****************************************************************/

/****************************************************************/
/* This example adds a new selection called NEWONE to the PMENU */
/* for the variance report object. When the user presses the    */
/* new selection, an existing SAS/EIS application runs.         */
/****************************************************************/
proc pmenu catalog=sasuser.sasappl desc 'New PMENU for Variance Report';

   menu runvar2;
      item  'Hotspot'   selection=hotspot  mnemonic='s';
      item  'View'      selection=view     mnemonic='v';
      item  'Print'     selection=print    mnemonic='p';
      item  'Notes'     selection=notes    mnemonic='n';
      item  'Newone'    selection=newone   mnemonic='o';
      item  'Goback'    selection=goback   mnemonic='g';
      item  'Bookmark'  selection=book     mnemonic='b';
      item  'Help'      selection=help     mnemonic='h';

      selection hotspot  "HOTSPOT";
      selection view     "VIEW";
      selection print    "PRINT";
      selection notes    "NOTES";
      selection newone   "NEWONE";
      selection goback   "GOBACK";
      selection book     "BOOKMARK";
      selection help     "HELP";
run;
quit;

/****************************************************************/
/*  The %EIS macro sets up legends and gets all the standard    */
/*  parameters needed to use SAS/EIS software.                  */
/*  Use the %EISENTRY macro to generate an SCL ENTRY statement. */
/****************************************************************/

%eis;
%eisentry methlist rc 8;

INIT:
    control enter;
    command = getnitemc(methlist, 'command');

/*************************************************************/
/*  When a user selects NEWONE on the menu bar, the SAS/EIS  */
/*  BLOCK application TSTASST in the application database    */
/*  SASUSER.SASAPPL runs.                                    */
/*************************************************************/

    if upcase(command) = 'NEWONE' then
        call display('sashelp.eis.runeis.program',&eparmlst,
                     'sasuser.sasappl.tstasst.block',eisrc);
return;

MAIN:
return;

TERM:
return;

/****************************************************************/
/****************************************************************/
/* End of sample code for Chapter 2 in "Extending SAS/EIS       */
/* Software Capabilities."                                      */
/****************************************************************/
/****************************************************************/

/****************************************************************/
/****************************************************************/
/* The following can be used to run the examples in Chapter 3,  */
/* "Extending Your SAS/EIS Software Capabilities" with the 6.10 */
/* Release of SAS Software.  You may need to modify this sample */
/* code when running examples in other SAS Software releases.   */
/* You will need to create the FRAME entries that accompany     */
/* this sample code.                                            */
/* Copyright(c) 1994 by SAS Institute Inc., Cary, NC USA        */
/****************************************************************/
/****************************************************************/



length rc 8;
%eis;
%eisentry parmlist 8 returncode 8;

INIT:
/**********************************************************/
/* Initialize the return code and the refresh flag.       */
/**********************************************************/

   returncode=0;
   rc=setnitemn(parmlist,0,'REFRESH');

/**********************************************************/
/* If the command in not DRILL, then return.              */
/**********************************************************/

   command=getnitemc(parmlist,'COMMAND');
   if upcase(command)^='DRILL' then return;

/**********************************************************/
/* Get the current report list (this is the last list     */
/* on the DRILL sublist of the method parameter list).    */
/**********************************************************/

   drill=getniteml(parmlist,'DRILL');
   current=getiteml(drill,listlen(drill));

/**********************************************************/
/* Get the current HIERARCHY list, WHERE list, ARROW list,*/
/* and DRILL VARIABLE list.                               */
/**********************************************************/

   hierarchy=getniteml(current,'HIERARCHY LIST');
   where=getniteml(current,'WHERE LIST');
   currentdrill=getnitemc(where,'DRILL VARIABLE');
   arrow=getniteml(current,'ARROW LIST');

/**********************************************************/
/* Build a list of all DRILL variables except the current */
/* one.                                                   */
/**********************************************************/

   drillvars=makelist();
   do i=1 to listlen(hierarchy);
      item=nameitem(hierarchy,i);
      drillvar=scan(item,3,'.');
      if drillvar^=currentdrill then
         rc=insertc(drillvars,drillvar,-1);
   end;

/**********************************************************/
/* Display the list of DRILL variables.                   */
/**********************************************************/

   sel=popmenu(drillvars);

/**********************************************************/
/* Return if no selection is made.                        */
/**********************************************************/

   if sel=0 then return;
   selectvar=getitemc(drillvars,sel);

/**********************************************************/
/* Find the position of the current and selected DRILL    */
/* variables.                                             */
/**********************************************************/

   do i=1 to listlen(hierarchy);
      item=nameitem(hierarchy,i);
      drillvar=scan(item,3,'.');
      if drillvar=currentdrill then
         currentpos=i;
      else if drillvar=selectvar then
         nextpos=i;
   end;

/**********************************************************/
/* Return if the value of NEXTPOS is CURRENTPOS + 1 (this */
/* is the process used by the default SELECT method).     */
/**********************************************************/

   if nextpos=currentpos+1 then return;

/**********************************************************/
/* Set the return code to 1 and the refresh flag to 1.    */
/**********************************************************/

   returncode=1;
   rc=setnitemn(parmlist,1,'REFRESH');

/**********************************************************/
/* Build a new report sublist using the current hierarchy */
/* list.                                                  */
/**********************************************************/

   newreport=makelist();
   rc=insertl(drill,newreport,-1);
   rc=setniteml(newreport,hierarchy,'HIERARCHY LIST');


/**********************************************************/
/* Copy the current ARROW list and update. More logic is  */
/* needed here to update left and right arrows.           */
/**********************************************************/

   newarrow=copylist(arrow);
   rc=setniteml(newreport,newarrow,'ARROW LIST');

/**********************************************************/
/* If the selected variable is at the top of the          */
/* hierarchy, do not display the UP arrow.                */
/**********************************************************/

   item=nameitem(hierarchy,1);
   drillvar=scan(item,3,'.');
   if drillvar=selectvar then rc=setnitemn(newarrow,0,'UP');
   else rc=setnitemn(newarrow,1,'UP');

/**********************************************************/
/* If the selected variable is at the bottom of the       */
/* hierarchy, do not display the DOWN arrow.              */
/**********************************************************/

   item=nameitem(hierarchy,listlen(hierarchy));
   drillvar=scan(item,3,'.');
   if drillvar=selectvar then rc=setnitemn(newarrow,0,'DOWN');
   else rc=setnitemn(newarrow,1,'DOWN');

/**********************************************************/
/* Copy the current WHERE list, store the values in the   */
/* method parameter list, and update the values.          */
/**********************************************************/

   newwhere=copylist(where,'Y');
   rc=setniteml(newreport,newwhere,'WHERE LIST');

/**********************************************************/
/* Need the variable type to store in the variable list   */
/* of WHERE list. Get the data set name from the          */
/* APPLICATION list on the method parameter list.         */
/**********************************************************/

   varlist=makelist();
   application=getniteml(parmlist,'APPLICATION');
   dsname=getnitemc(application,'DSNAME');

/**********************************************************/
/* Open the data set and get the variable type for the    */
/* current drill variable.                                */
/**********************************************************/

   dsid=open(dsname);
   vartype=vartype(dsid,varnum(dsid,currentdrill));
   rc=close(dsid);

/**********************************************************/
/* Get the selected text from the method parameter list,  */
/* and store it on the VARLIST.                           */
/**********************************************************/

   text=getnitemc(parmlist,'TEXT');
   rc=setnitemc(varlist,text,vartype,1);

/**********************************************************/
/* Remove the current drill variable from the variable    */
/* NEWWHERE, add the new VARLIST, and add back the        */
/* selected drill variable.                               */
/**********************************************************/

   rc=delnitem(newwhere,'DRILL VARIABLE');
   rc=insertl(newwhere,varlist,-1,currentdrill);
   rc=insertc(newwhere,selectvar,-1,'DRILL VARIABLE');

/**********************************************************/
/* Push to the BOOKMARK stack and store the value of      */
/* BOOKPOS in the method parameter list.                  */
/**********************************************************/

   text='...' || trim(selectvar);
   call display(%acatalog(eis,PSHSTCK),text,bookpos);
   rc=setnitemn(parmlist,bookpos,'BOOKPOS');
return;



/**********************************************************/
/* INITIALIZE Comment Block                               */
/*                                                        */
/* The following example shows the initial comment block  */
/* from a sample INITIALIZE method in which the           */
/* parameters are passed. Parameter values usually pass   */
/* between programs in the form of an SCL list.           */
/* INITIALIZE methods must be able to receive this list   */
/* and pass it back to the RUN method with the            */
/* appropriate values. The initial comment block for the  */
/* INITIALIZE method is shown below.                      */
/**********************************************************/


/**********************************************************/
/*  Name:     INITSAMP.SCL                                */
/*  Support:  J. Smith                                    */
/*  Product:  SAS/EIS                                     */
/*  Language: SCL                                         */
/*  Usage:    call display('8-char-init-method-name.SCL', */
/*                          &EPARMLST, methlist, rc)      */
/*  Purpose:  Initialization method for an object class.  */
/*  History:  initial coding - J. Smith                   */
/*  Notes:                                                */
/*  End                                                   */
/**********************************************************/

/**********************************************************/
/* SELECT Method Comment Block                            */
/*                                                        */
/* The following example shows the initial comment block  */
/* from a sample SELECT method in which the parameters    */
/* are passed. Parameter values usually pass between      */
/* programs in the form of an SCL list. SELECT methods    */
/* must be able to receive this list and pass it back     */
/* to the RUN method with the appropriate values.         */
/**********************************************************/


/**********************************************************/
/* Name:     SELESAMP.SCL                                 */
/* Support:  J. Smith                                     */
/* Product:  SAS/EIS                                      */
/* Language: SCL                                          */
/* Usage:    call display('8-char-select-method-name.SCL',*/
/*                         &EPARMLST, methlist, rc)       */
/* Purpose:  Select method form an object class.          */
/* History:  initial coding - J. Smith                    */
/* Notes:                                                 */
/* End                                                    */
/**********************************************************/

/**********************************************************/
/* CREATE Method Template                                 */
/*                                                        */
/* Use the following program template as the basis for    */
/* the SCL portion of the FRAME entry that build to use   */
/* as a CREATE method.                                    */
/**********************************************************/


/**********************************************************/
/*   Name:     CREATEX.SCL                                */
/*   Support:  youruserid                                 */
/*   Product:  SAS/EIS Software                           */
/*   Language: SCL                                        */
/*   Usage:    call display('entry-name.etype',           */
/*                           &EPARMLST);                  */
/*   Purpose:  CREATE method for the  XXXXXXX object      */
/*   History:  Initial coding       youruserid            */
/*   Notes:                                               */
/*   End                                                  */
/*                                                        */
/*   Copyright (c) 1993 by SAS Institute Inc.,            */
/*                         Cary, NC 27513  USA            */
/*   All rights reserved.                                 */
/**********************************************************/



/**********************************************************/
/* Specify SAS/EIS startup application macros to define   */
/* ENTRY and LENGTH statements for template variables.    */
/**********************************************************/

%eisstart;
%eisstrtb;

/**********************************************************/
/* Specify a description for the BOOKMARK list.           */
/**********************************************************/

%let leg1=SAS/EIS: Build a description-of-this-object;

/**********************************************************/
/* Specify application macros for standard default        */
/* lengths. Add other LENGTH statements as needed.        */
/**********************************************************/

INIT:
   %eisinit;
   %applfndb;

/**********************************************************/
/* Insert code to accomplish any tasks necessary when     */
/* creating a new application (versus editing an existing */
/* one). For example, creating an instance variable list  */
/* for a new application (versus reading one from a       */
/* catalog entry for an existing one). Remove comment     */
/* delimiters from statement to insert a specific list    */
/* name.                                                  */
/**********************************************************/

       if newflag then
       do;
          /* xxxlist=makelist(); */
       end;

/************************************************************/
/* Optional extra temporary list for utility tasks. For     */
/* example, variable selection, color selection, and so on. */
/************************************************************/

       etlist=makelist();
return;

MAIN:
   link clrfld;

/**********************************************************/
/* Call this application macro to handle known commands.  */
/* You can add WHEN clauses for additional commands.      */
/**********************************************************/

   %eselect(pos, gbrc);
      /* For example,
         when('WHATEVER') ...; */
            otherwise;
         end;

   %bookmark(PROCESS);

/**********************************************************/
/* Check for a unique application name.                   */
/**********************************************************/

      if modified(applname) then link chkname;
      link setfld;
return;

/**********************************************************/
/* Add your own labels for obtaining instance variable    */
/* values here. For example, insert a label with code to  */
/* query a metabase for variable names or other data.     */
/**********************************************************/

   /* DATASEL:
      rc=clearlist(etlist);
      etlist=insertc(etlist,'DRILL',-1,'ATTRIBUTE');
      call method(searchpath("methods.scl"),"mbquery2",
                    etlist,1,data,metabase);
      return; */

   /* VARSEL:
      if data = ' ' then return;
      rc=clearlist(etlist);
      etlist=insertc(etlist,'ANALYSIS',-1,'ATTRIBUTE');
      etlist=insertc(etlist, data     ,-1,'DSETNAME');
      call method(searchpath("methods.scl"),"mbquery2",
                  etlist,5,numvars,metabase);
      return; */

   TERM:
      if etlist then rc = dellist(etlist,"Y") ;
      %eisterm;
   return;

/***********************************************************/
/* Save the instance variable values for this application. */
/* For example, store a list of values in an application   */
/* database or in a metabase.                              */
/***********************************************************/

   SETAPPL:
      /* applist = setnitemc(applist, data,     'DATA');     */
      /* applist = setnitemc(applist, metabase, 'METABASE'); */
      /* applist = setnitemc(applist, xxxx,     'XXXX');     */
   return;

/**********************************************************/
/* Retrieve instance variable values, metabase data, or   */
/* other values if editing an existing application.       */
/**********************************************************/

   GETAPPL:
        /* data     = getnitemc(applist, 'DATA'     ,1,1,' ');  */
        /* metabase = getnitemc(applist, 'METABASE' ,1,1,' ');  */
        /* xxxx     = getnitemc(applist, 'XXXX'     ,1,1,' ');  */
   return;

/************************************************************/
/* Supply your own ERROR messages to prompt for required    */
/* information. Start with the macro variable EMSG21, and   */
/* enter error messages corresponding to the fields passed  */
/* in as parameters to macro %CHKDATA.  For example, if     */
/* you define ESMG21, EMSG22, and EMSG23, invoke %CHKDATA   */
/* with three variable names, as in                         */
/*        %chkdata(var1 var2 var3);                         */
/*                                                          */
/* The text in EMSG21 displays when VAR1 is empty, the      */
/* text in EMSG22 displays when VAR2 is empty, and so on.   */
/************************************************************/

   %let emsg21 = A data set is required.;
   %let emsg22 = Something-else is required...;

   %chkdata(data);

/**********************************************************/
/* Supply any other ERROR message and the code to display */
/* it. Start at EMSG31.                                   */
/**********************************************************/

   USERCHKS:
      /*  % call symput                                   */
      /*        ("emsg31","Own check error message...");  */

/************************************************************/
/* Insert code to do cross-reference checking here. Assign  */
/* XRC a return code of 0 for no errors, or the number      */
/* associated with a specific error message to cause that   */
/*  message to appear upon return from this label.          */
/************************************************************/

      xrc=0;

      /* if (data2 eq ' ' and vars2 eq ' ') or
            (data2 ne ' ' and vars2 ne ' ') then xrc=0;  */

      /* if (data2 ne ' ' and vars2 eq ' ') then xrc=31; */
   return;

/**********************************************************/
/* Define application-specific colors. Name items for the */
/* options you support. Support for background (CBACK)    */
/* and navigation arrow (CARRW) is automatic.             */
/**********************************************************/

   COLORS:
      rc=clearlist(etlist);
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CBACK",1,1,' '),"CBACK");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CPMEN",1,1,' '),"CPMEN");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CARRW",1,1,' '),"CARRW");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CTITL",1,1,' '),"CTITL");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CHEAD",1,1,' '),"CHEAD");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CAXIS",1,1,' '),"CAXIS");
      etlist=setnitemc
             (etlist,getnitemc(userattr,"CTEXT",1,1,' '),"CTEXT");

      if searchpath('objclrs.frame') eq ' ' then
         do;
            _msg_ = "ERROR: Not available.";
            return;
         end;
      call display(searchpath('objclrs.frame'),etlist)

      userattr=setnitemc
               (userattr,getnitemc(etlist,"CBACK",1,1,' '),"CBACK");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CPMEN",1,1,' '),"CPMEN");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CARRW",1,1,' '),"CARRW");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CTITL",1,1,' '),"CTITL");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CHEAD",1,1,' '),"CHEAD");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CAXIS",1,1,' '),"CAXIS");
      userattr=setnitemc
               (userattr,getnitemc(etlist,"CTEXT",1,1,' '),"CTEXT");
   return;

/**********************************************************/
/* Define an application-specific font.                   */
/**********************************************************/

   GFONT:
      rc=clearlist(etlist);
      etlist=setnitemc(etlist,getnitemc
                      (userattr,"TFONT",1,1,' '),"TFONT");
      if searchpath('objfont.frame') eq ' ' then
         do;
            _msg_ = "ERROR: Not available.";
            return;
         end;
      call display(searchpath('objfont.frame'),etlist);
      userattr=setnitemc(userattr,getnitemc
                        (etlist,"TFONT",1,1,' '),"TFONT");
   return;

/**********************************************************/
/* You can either invoke %UTILS, or choose among the      */
/* macros it contains, in your CREATE method as needed.   */
/**********************************************************/

   %utils;



/**********************************************************/
/* RUN Method Template                                    */
/*                                                        */
/* Use the following program template as the basis for    */
/* the SCL portion of the entry you build to use as a     */
/* RUN method.                                            */
/**********************************************************/

/**********************************************************/
/*   Name:     RUNEX.SCL                                  */
/*   Support:  youruserid                                 */
/*   Product:  SAS/EIS Software                           */
/*   Language: SCL                                        */
/*   Usage:    call display (entry-name.etype,            */
/*                           &EPARMLST, [applname],       */
/*                           [appltype]);                 */
/*   Purpose:  RUN method for the XXXXXXXX object         */
/*   History:  Initial coding          youruserid         */
/*   Notes:                                               */
/*   End                                                  */
/**********************************************************/

%eisstart;

/**********************************************************/
/* Insert LENGTH statements as needed here.               */
/**********************************************************/

length cback cpmen $20;
/* carrw ctitl chead ctext caxis $20;   */

/**********************************************************/
/* Insert any initialization tasks here. If your object   */
/* supports drill down, make sure the information that    */
/* the drill handler requires is available before your    */
/* code sends messages.                                   */
/**********************************************************/

INIT:

   %eisinit;
   %applfndr;


/**********************************************************/
/* Use this code to support drill down. Delete this code  */
/* if not used in your program.                           */
/*                                                        */
/* Instantiate an object to handle drill-down.            */
/**********************************************************/

   drl_handler=instance(loadclass(searchpath('DRLDWN.CLASS')));


/***********************************************************/
/* Specify the FRAME's listid so it can send messages      */
/* back. It will expect values of UP, DOWN, RIGHT, and     */
/* LEFT as navigational aids. Specify a TEXT or GTEXT      */
/* widget to put drill-down information in (optional).     */
/* Specify the starting drill level (optional; 1 is        */
/* the default).                                           */
/*                                                         */
/* Specify the metabase in which to find drill-down        */
/* hierarchy (this information is overridden if data set   */
/* is summarized). Specify the DSID or DSNAME of the data  */
/* set to use, optional 'YES' as the second parameter to   */
/* indicate that the data set is summarized. The way it is */
/* summarized will override the metabase drill-down        */
/* hierarchy. End optional drill-down support.             */
/*                                                         */
/***********************************************************/

      call send(drl_handler,'SET_FRAME_ID',_self_);
      call send(drl_handler,'SET_START_DRILL',start_level);
      call send(drl_handler,'SET_START_DRILL',start_level);
      call send(drl_handler,'SET_METABASE',metabase);
      call send(drl_handler,'SET_DSID/SET_DATASET',dsid/data,
                summarized);
   return;


/**********************************************************/
/* Retrieve instance variable values, metabase data, or   */
/* other values. These are list items in the list APPLIST */
/* in the application database.                           */
/**********************************************************/

   GETAPPL:
      /* data     = getnitemc(applist, 'DATA',1,1,' ');    */
      /* metabase = getnitemc(applist, 'METABASE',1,1,' ');*/
      /* xxxx     = getnitemc(applist, 'XXXX',1,1,' ');    */

/**********************************************************/
/* Get the color list information.  If a value is blank,
/* set the default value. The action to change the
/* default color for the background, the PMENUS, and the
/* navigation aid is already defined in the SAS/EIS
/* application macros. You need to define any other
/* action. The PMENU color changes only under UNIX.
/**********************************************************/

      cback=getnitemc
               (userattr,'CBACK',1,1,"GRAY"); /* Background */
      cpmen=getnitemc
               (userattr,'CPMEN',1,1,"BLACK");/* PMENU      */
      carrw=getnitemc
               (userattr,'CARRW',1,1,"BLUE"); /* Navigation */
      ctitl=getnitemc
               (userattr,'CTITL',1,1,"BLACK");/* Title      */
      chead=getnitemc
               (userattr,'CHEAD',1,1,"PINK"); /* Headings   */
      ctext=getnitemc
               (userattr,'CTEXT',1,1,"BLUE"); /* Other Text */
      caxis=getnitemc
               (userattr,'CAXIS',1,1,"GREEN");/* Graph Axis */

      if cback eq " " then cback = "GRAY";
      if carrw eq " " then carrw = "BLUE" ;
      if ctitl eq " " then ctitl = "BLACK" ;
      if chead eq " " then chead = "PINK" ;
      if ctext eq " " then ctext = "BLUE" ;
      if caxis eq " " then caxis = "GREEN" ;

   return;

/**********************************************************/
/* Call the application macro that handles known          */
/* commands.  You can add WHEN clauses for additional     */
/* commands. The example shows how to run a target        */
/* application.                                           */
/**********************************************************/

   MAIN:
      %eselect(pos, gbrc);
         /* For example,
         when('TARGET') link gotarget; */
         otherwise;
      end;

      %bookmark(PROCESS);

/**********************************************************/
/* This code handles arrow clicks. The appropriate        */
/* message will be sent to the Drill Handler              */
/* (UP/LEFT/RIGHT/DOWN/JUMP).                             */
/**********************************************************/


      call send(_self_,'_GET_CURRENT_NAME_',widget);
      if widget in ("UP","LEFT","RIGHT","DOWN","JUMP") then
      do;
         cmdline=widget;
         text=" ";
         link userclk;

/**********************************************************/
/* Regenerate the report or graph, refresh the extended   */
/* table, and so on.                                      */
/**********************************************************/

         call send(drl_handler,'DRILL',widget);
      end;

/**********************************************************/
/* Insert all of your own program statements here to      */
/* implement your object.                                 */
/*                                                        */
/* The following statement calls the object SELECT        */
/* method, if one exists in the object definition in the  */
/* object database.                                       */
/**********************************************************/

      link userclkc;
   return;

/**********************************************************/
/* Insert all other labels here. Interactive labels start */
/* with  CMDLINE=name-for-this-action;                    */
/*                                                        */
/* For example: LEFT, EDIT, RUN, and so on.               */
/* Labels will be passed to the selection methods. The    */
/* statement LINK USERCLK calls the object-specific       */
/* selection method.                                      */
/**********************************************************/

   /* SVERIGE:
      /* cmdline="SVERIGE"; */
      /* link userclk;        */
      /* {ob more SAS statements;}     */
   /* return;                 */

   TERM:
      %eistermr;

/**********************************************************/
/* Delete the drill handler if you defined one in this    */
/* object.                                                */
/**********************************************************/

      /* if drl_handler then call send
                                 (drl_handler,'_TERM_');  */
   return;

/**********************************************************/
/* Insert your own termination processing here. Update    */
/* the user control list.                                 */
/**********************************************************/

   UPDUSERL:
      /* userlist = setnitemc(userlist,text       ,'TEXT');          */
      /* userlist = setnitemn(userlist,x          ,'X_POSITION');    */
      /* userlist = setnitemn(userlist,y          ,'Y_POSITION');    */
      /* userlist = setnitemc(userlist,type       ,'TYPE');          */
      /* userlist = setnitemc(userlist,hotspot    ,'HOTSPOT');       */
      /* userlist = setnitemc(userlist,cmdline    ,'COMMAND ');      */
      /* userlist = setniteml(userlist,drl_handler,'DRILL_MANAGER'); */
      /* userlist = setnitemn(userlist,Y          ,'REFRESH');       */
      /* userlist = setnitemc(userlist,X          ,'HCOLOR');        */
      /* userlist = setnitemc(userlist,X          ,'HATTR');         */
      /* userlist = setnitemc(userlist,X          ,'XXXXX');         */
   return;

/**********************************************************/
/* You can either invoke %UTILSR or choose among the      */
/* macros it contains in your RUN method as needed.       */
/**********************************************************/

   %utilsr;

/****************************************************************/
/****************************************************************/
/* End of sample code for Chapter 3 in "Extending SAS/EIS       */
/* Software Capabilities."                                      */
/****************************************************************/
/****************************************************************/

/****************************************************************/
/****************************************************************/
/* The following can be used to run the examples in Chapter 4,  */
/* "Extending Your SAS/EIS Software Capabilities" with the 6.10 */
/* Release of SAS Software.  You may need to modify this sample */
/* code when running examples in other SAS Software releases.   */
/* You will need to create the FRAME entries that accompany     */
/* this sample code.                                            */
/* Copyright(c) 1994 by SAS Institute Inc., Cary, NC USA        */
/****************************************************************/
/****************************************************************/


/**********************************************************************/
/* libname.ORGCHART.ORGCHART.FRAME                                    */
/*                                                                    */
/* This entry generates an organization chart and allows the user     */
/* to view lower levels of the chart by clicking on a node in the     */
/* chart. The user can also drill down by selecting the DETAIL        */
/* option and then selecting the node. A list box provides a list     */
/* from which the user can also select to subset the chart or to      */
/* drill down. The RESET button restores the original chart.          */
/*                                                                    */
/* In this example, the DETAIL section executes a program that        */
/* displays detailed information for employees in the selected        */
/* chart. The user can also drill down by selecting the DETAIL        */
/* node.                                                              */
/**********************************************************************/


/**********************************************************************/
/* Initialize a series of variables and set their lengths. The        */
/* variables include:                                                 */
/*        afpgm    -- program to execute at drill down                */
/*        detailds -- data set used by entry in AFPGM                 */
/*        graphnm  -- initial graph entry                             */
/*        orgds    -- input data set                                  */
/*        textsel  -- holds user-selected text value.                 */
/**********************************************************************/


length afpgm    $35
       detailds $17
       graphnm  $32
       orgds    $17
       textsel  $20;


/**********************************************************************/
/* Submit the %SHWNODE macro definition.                              */
/* The macro could instead be called from an AUTOCALL library.        */
/**********************************************************************/

INIT:
   rc=preview('COPY','ORGCHART.ORGCHART.SHWNODE.SOURCE');


/**********************************************************************/
/* Compile the macro to create the chart subset.                      */
/**********************************************************************/

   submit continue;
   endsubmit;


/**********************************************************************/
/* Assign values.  These could be provided as entry parameters.       */
/**********************************************************************/

   orgds    = 'ORGCHART.ORGAN';
   graphnm  = 'ORGCHART.ORGCHART.CORP.GRSEG';
   afpgm    = 'ORGCHART.ORGCHART.VIEWNODX.SCL';
   detailds = 'ORGCHART.EMPLOYEE';
   reptmeth = 'NEXTLVL';


/**********************************************************************/
/* Load the initial graph into the SAS/GRAPH output widget.           */
/**********************************************************************/

   call notify('ORGCHART','_SET_GRAPH_',graphnm);


/**********************************************************************/
/* Fill the list box from the data set passed to the program.         */
/* Provide a message to the user.                                     */
/**********************************************************************/

   if exist(orgds) then
   do;
      dsid=open(orgds,'I');
      if dsid eq 0 then
      do;
         _status_='H';
      end;
      call set(dsid);
   end;


/**********************************************************************/
/* If data are not available, provide an error message to the user    */
/* and end the program.                                               */
/**********************************************************************/

   else do;
      _status_='H';
   end;
return;

MAIN:
return;

TERM:
   dsid=close(dsid);
return;



/**********************************************************************/
/* Submit code to process the user's selection.                       */
/**********************************************************************/

GRPLIST:
   call notify('GRPLIST','_GET_LAST_SEL_',rowsel,ifsel,textsel);
   if rowsel gt 0 then link UPDATE;
return;


/**********************************************************************/
/* Submit code to process the user's selection.                       */
/**********************************************************************/

HOTSPOT:
   textsel=getnitemc(hotspot,'TEXT');
   if textsel ne '' then link UPDATE;
return;


/**********************************************************************/
/* Reset the graph output object to the original chart.               */
/**********************************************************************/

RESET:
   call notify('ORGCHART','_SET_GRAPH_',graphnm);
return;



/**********************************************************************/
/* If the reporting method is Detail ({mono DRILL}), call the         */
/* defined AF program to examine the data for the selected node.      */
/**********************************************************************/

UPDATE:
   if reptmeth='DRILL' then
      call display(afpgm,detailds,textsel);


/**********************************************************************/
/* Otherwise, re-execute the graph for the selected node or level.    */
/* Verify that the requested subset has data.                         */
/* ********************************************************************/

   else do;
      orgdsid=open(orgds,'I');
      rc=where(orgdsid, 'reports="'||textsel||'"');


/**********************************************************************/
/* If it does not, issue an error message.                            */
/**********************************************************************/

      if fetch(orgdsid) ne 0 then
         do;
            _msg_='The node  '||upcase(textsel) || '  has no successors.';
            orgdsid=close(orgdsid);
            return;
         end;
      orgdsid=close(orgdsid);


/**********************************************************************/
/* Recreate the list and graph subset according to the selected       */
/* item. Present the user with the updated graph of successors to     */
/* the item selected in the organization list.                        */
/**********************************************************************/

   submit continue;


/**********************************************************************/
/* The %SHWNODE macro creates a chart of the selected subset          */
/* of data and stores the chart in the catalog entry                  */
/* WORK.ORGCHART.CORP.GRSEG.                                          */
/**********************************************************************/

      %shwnode(textsel=&textsel,catalog=work.orgchart,orgds=&orgds);
   endsubmit;

       call notify('ORGCHART','_SET_GRAPH_','WORK.ORGCHART.CORP.GRSEG');
   end;
return;


/**********************************************************************/
/* VIEWNODX.SCL Program Code                                          */
/*                                                                    */
/* The ORGCHART.FRAME entry calls the libname.ORGCHART.VIEWNODX.SCL   */
/* entry, which executes when the user selects DETAIL as the          */
/* reporting method in this example.  The program initiates an        */
/* FSEDIT session on the data set passed to the entry in the DATASET  */
/* parameter.  The program assumes that the data set contains the     */
/* variables REPORTS, GROUP, DIVCODE, and UNIT. The data are subset   */
/* by the value passed to the entry in the NODETEXT parameter.        */
/*                                                                      */
/* Typically, the program enables you to generate a report or browse  */
/* other data (for example, employee list, group financials, and      */
/* so on) for the requested subset.                                   */
/**********************************************************************/


/**********************************************************************/
/* Name of the data set to be viewed.                                 */
/**********************************************************************/


entry dataset $17
      nodetext $15;


/**********************************************************************/
/* Check for data in the requested subset.                            */
/**********************************************************************/

INIT:
   dsid=open(dataset,'I');
   rc=where(dsid, 'group=:"'||nodetext||'"'||
                  ' or divcode=:"'||nodetext||'"'||
                  ' or unit=:"'||nodetext||'"');


/**********************************************************************/
/* Add code here to handle the situation when the requested           */
/* subset is empty.                                                   */
/**********************************************************************/

   if fetch(dsid) ne 0 then
   do;


      dsid=close(dsid);
      return;
   end;
   dsid=close(dsid);


/**********************************************************************/
/* Display the desired subset of data.                                */
/**********************************************************************/

   call fsedit(dataset||'(where=(group=:"'||nodetext||'"'||
                        ' or divcode=:"'||nodetext||'"'||
                        ' or unit=:"'||nodetext||'"))',
                        dataset,'BROWSE');
return;

MAIN:
return;

TERM:
return;


/************************************************************************/
/* GENCHART.SOURCE Program Code                                         */
/*                                                                      */
/* The ORGCHART.FRAME entry calls the libname.ORGCHART.GENCHART.SOURCE  */
/* entry. This source entry contains the code that creates the initial  */
/* graph. This program also creates the data set ORGCHART.ORGAN.        */
/* The macro %SHWNODE transposes the data and creates the               */
/* PROC NETDRAW output.                                                 */
/************************************************************************/

data orgchart.organ;
   length group reports $12;
   infile cards missover;
   input group $ reports $;
datalines;

TS      APP
IPD     APP
MNR     APP
ORD     APP
STA     APP
C37     CCD
GNA     CON
LGL     CON
DEV     Corporate
EDU     Corporate
FAC     Corporate
EDA     EDU
EMS     EDU
IBT     EDU
ST      EDU
STC     EDU
TC      EDU
BMN     FAC
HKP     FAC

{it more data lines}

;
run;

%shwnode(textsel=Corporate,catalog=orgchart.orgchart,
         orgds=orgchart.organ);


/**********************************************************************/
/* libname.ORGCHART.SHWNODE.SOURCE Program Code                       */
/*                                                                    */
/* This source entry defines a macro that transposes and subsets the  */
/* data and creates the PROC NETDRAW output for the requested data.   */
/* It should contain an observation for every expected node on the    */
/* tree.  For example:                                                */
/*                                                                    */
/*    Vice-Pres | President                                           */
/*    Treasurer | President                                           */
/*    Personnel | Vice-Pres                                           */
/*  Facilities  | Vice-Pres                                           */
/*  Janitorial  | Facilities                                          */
/*                                                                    */
/**********************************************************************/



/**********************************************************************/
/* Subset the data set based on this value. Store the output in the   */
/* catalog libname.ORGCHART, and process the ORGCHART.ORGAN data set. */
/**********************************************************************/


%macro shwnode(textsel=Corporate,
               catalog=orgchart.orgchart,
               orgds=orgchart.organ);


/**********************************************************************/
/* Transpose the data by REPORTS to the variable.                     */
/**********************************************************************/

proc transpose data=&orgds out=organ;
   by reports;
   var group;
run;


/**********************************************************************/
/* Additional values are required for PROC NETDRAW.                   */
/**********************************************************************/

data organ;
   set organ(in=inorg) &orgds;
   if inorg then group=reports;
run;


/**********************************************************************/
/* Delete the graph entry if you called the macro previously.         */
/**********************************************************************/

proc catalog c=&catalog;
   delete corp/entrytype=grseg;
run;
quit;


/**********************************************************************/
/* Do not display the PROC NETDRAW output.                            */
/**********************************************************************/

goptions nodisplay;


/**********************************************************************/
/* Set the linestyle for the graph.                                   */
/**********************************************************************/

pattern1 v=e c=black r=99;


/**********************************************************************/
/* Clear any titles used previously.                                  */
/**********************************************************************/

title;


/**********************************************************************/
/* Generate the chart using PROC NETDRAW.                             */
/**********************************************************************/

proc netdraw graphics data=orgchart.organ gout=&catalog;
   where reports="&textsel";
   actnet / act=reports succ=group htext=3
            font=simplex tree name='CORP' centersubtree boxht=2
            carcs=black lwidth=1 rectilinear boxwdth=2
            nolabel pcompress
            centerid arrowhead=0
            ybetween=1 xbetween=20;
run;



/**********************************************************************/
/* Restore the option to display graphics output.                     */
/**********************************************************************/

goptions display;

%mend shwnode;




/*********************************************************************/
/* libname.ORGCHART.RUNORG.FRAME                                     */
/*                                                                   */
/* This FRAME entry generates an organizational chart and allows     */
/* the user to view lower levels of the chart by clicking on a node. */
/* The user can also drill down by selecting the DETAIL option       */
/* and then selecting the node.  A List Box provides a list of nodes */
/* that the user can also click on to subset the chart or drill      */
/* down.  The RESET button restores the original chart.              */
/*                                                                   */
/* In this example, DETAIL executes a program that displays detailed */
/* information for employees in the selected node.                   */
/*********************************************************************/


/**********************************************************************/
/* Find the application list and read generic information. These      */
/* statements locate the correct set of instance variable values      */
/* for the application.                                               */
/**********************************************************************/

%eisstart;


/**********************************************************************/
/* Assign error messages to display when general problems occur.      */
/* These statements provide error messages to                         */
/* assist in troubleshooting if errors occur.                         */
/**********************************************************************/

%let emsg1 = WARNING: The application specified;
%let emsg2 = does not exist.;
%let emsg3 = ERROR: The application specified;
%let emsg4 = is missing information.;


/**********************************************************************/
/* Delete the original code and replace it with this statement.       */
/* Initialize variables to hold the metalist and metabase values, and */
/* initialize the following variables:                                */
/*   afpgm      -- program that executes at drill down                */
/*   graphnm    -- initial graph entry                                */
/*   orgds      -- input data set                                     */
/*   textsel    -- holds text value that the user selects.            */
/**********************************************************************/


length mlname  $17
       mbname  $17
       afpgm   $35
       graphnm $32
       orgds   $17
       textsel $20 ;


/**********************************************************************/
/* In this example, the %SHWNODE macro definition is submitted within */
/* the program. The macro could instead be called from the AUTOCALL   */
/* library. Compile the macro to create the chart subset used later   */
/* in the example.                                                    */
/**********************************************************************/

INIT:
   rc=preview('COPY','ORGCHART.ORGCHART.SHWNODE.SOURCE');
   submit continue;
   endsubmit;


/**********************************************************************/
/* Initialize variables for generic information. Get instance         */
/* variables from the control record in the application database.     */
/* The instance variables are variables that define a SAS/EIS         */
/* application. SAS/EIS expects a standard set of instance variables  */
/* in all applications and a set of instance variables specific to    */
/* the kind of object used to define the application.                 */
/* These macros are part of the SAS/EIS macro library. For more       */
/* information, see the Appendix in "Extending SAS/EIS Software       */
/* Capabilities."                                                     */
/**********************************************************************/

%eisinit;

%applfndr;



/**********************************************************************/
/* Load the initial graph into the SAS/GRAPH output widget.           */
/**********************************************************************/

call notify('ORGCHART','_SET_GRAPH_',graphnm);


/**********************************************************************/
/* Inserting these statements modifies the window that the user sees. */
/* If the user does not specify a program to display a detailed data  */
/* set, the radio box containing the DETAIL and NEXT LEVEL selections */
/* is hidden. If you do not specify an AF program, the DETAIL         */
/* selection is not available. Hide the REPTMETH widget from the      */
/* window.                                                            */
/**********************************************************************/

if afpgm='' then
   call notify('REPTMETH','_HIDE_');


/**********************************************************************/
/* Fill the list box from the data set passed to the program. Provide */
/* a message to the user.                                             */
/**********************************************************************/

   if exist(orgds) then
   do;
      dsid=open(orgds,'I');
      if dsid eq 0 then
      do;
         _status_='H';
      end;
      call set(dsid);
   end;


/**********************************************************************/
/* If data are not available, provide an error message to the user    */
/* and end the program.                                               */
/**********************************************************************/

   else do;
      _status_='H';
   end;
return;


/**********************************************************************/
/* Insert these statements to enhance the application. They           */
/* handle the standard PMENU commands and enable BOOKMARK processing. */
/**********************************************************************/

MAIN:
   %eselect(pos, gbrc);
      otherwise;
   end;
   %bookmark(PROCESS);
return;


/**********************************************************************/
/* The %EISTERMR macro is part of the macro library described in      */
/* the Appendix in "Extending SAS/EIS Software Capabilities." Insert  */
/* the macro to perform standard SAS/EIS processing when the RUN      */
/* method ends. If the data are not available, issue a message and    */
/* stop the program.                                                  */
/**********************************************************************/

TERM:
   %eistermr;
   dsid=close(dsid);
return;


/**********************************************************************/
/* Insert these statements to extract the list of instance variables  */
/* from the application definition in the SAS/EIS application         */
/* database and to assign these values to the appropriate SCL         */
/* variables for processing. This processing occurs in its own        */
/* labeled section, as it does in the template RUN method.            */
/**********************************************************************/

GETAPPL:
   orgds   = getnitemc(applist,'ORGDS');
   graphnm = getnitemc(applist,'INITGRPH');
   afpgm   = getnitemc(applist,'AFPGM');
   detailds = getnitemc(applist,'DETAILDS');
   if detailds=' ' then detailds=orgds;
   reptmeth=getnitemc(applist,'REPTMETH');
   call putlist(applist);
return;


/**********************************************************************/
/* Submit code to process the selection of a new group from the       */
/* listbox.                                                           */
/**********************************************************************/

GRPLIST:
   call notify('GRPLIST','_GET_LAST_SEL_',rowsel,ifsel,textsel);
   if rowsel gt 0 then link UPDATEW;
return;


/**********************************************************************/
/* Submit code to process the selection of a new group from the       */
/* graph.                                                             */
/**********************************************************************/

HOTSPOT:
   textsel=getnitemc(hotspot,'TEXT');
   if textsel ne '' then link UPDATEW;
return;

RESET:
   return;


/**********************************************************************/
/* If reporting method is Detail (DRILL), call the defined AF         */
/* program to examine the data or report for the selected             */
/* organizational group.                                              */
/**********************************************************************/

UPDATEW:
   if reptmeth='DRILL' then
      call display(afpgm,detailds,textsel);


/**********************************************************************/
/* Display the graph for selected node or level. Check to see if      */
/* the requested subset has data.                                     */
/**********************************************************************/

   else do;
      orgdsid=open(orgds,'I');
      rc=where(orgdsid, 'reports="'||textsel||'"');


/**********************************************************************/
/* Send a message if the node has no successors.                      */
/**********************************************************************/

      if fetch(orgdsid) ne 0 then
      do;
         _msg_='The node  '||upcase(textsel) || '  has no successors.';
         orgdsid=close(orgdsid);
         return;
      end;
      orgdsid=close(orgdsid);


/**********************************************************************/
/* Recreate the list and graph subset according to the selected item. */
/* Present the user with the updated graph of successors to the item  */
/* selected in the organization list.                                 */
/**********************************************************************/

      submit continue;
         %shwnode(textsel=&textsel,catalog=work.orgchart,orgds=&orgds);
      endsubmit;


/**********************************************************************/
/* Re-execute the graph for the selected node or level.               */
/**********************************************************************/

      call notify('ORGCHART','_SET_GRAPH_','WORK.ORGCHART.CORP.GRSEG');
   end;
return;



/****************************************************************/
/* libname.ORGCHART.CREATORG.SCL                                */
/*                                                              */
/* This entry is the CREATE method for the organization chart   */
/* example. The program prompts for the name of the data set    */
/* that contains the organization chart data, the GRSEG entry   */
/* to contain the initial organization chart, and the name of   */
/* the AF program that executes when the user requests DETAIL   */
/* for a node. This information is then passed to the RUN       */
/* method in the application list.                              */
/*                                                              */
/*   DATE   BY        MAINTENANCE/HISTORY                       */
/* mmDDDyy  userid    Initial creation.                         */
/****************************************************************/


/**********************************************************************/
/* Find the application list and read the generic information.        */
/**********************************************************************/

%eisstart;


/**********************************************************************/
/* Assign error messages used in checking for generic information.    */
/**********************************************************************/

%eisstrtb;


/**********************************************************************/
/* Set the description that appears in the bookmark list.             */
/**********************************************************************/

%let leg1   = SAS/EIS: Build an Organization Chart object;
%let emsg21 = ERROR: Data set is required;
%let emsg22 = ERROR: Initial graph name is required;
%let emsg23 = WARNING: AF Program is missing.;
%let emsg24 = Reporting method will be hidden.;


/**********************************************************************/
/* Define variables for the metalist and metabase.                    */
/**********************************************************************/

length mlname mbname $17;


/**********************************************************************/
/* Initialize variables for generic information.                      */
/**********************************************************************/

INIT:
   %eisinit;


/**********************************************************************/
/* Load the application list from the control record in the           */
/* application database.                                              */
/**********************************************************************/

   %applfndb;


/**********************************************************************/
/* Add instance variables to the list. NEWFLAG is set in the          */
/* %APPLFNDB macro.                                                   */
/**********************************************************************/

   if newflag=1 then
   do;
      applist=insertc(applist,orgds,-1,'ORGDS');
      applist=insertc(applist,initgrph,-1,'INITGRPH');
      applist=insertc(applist,afpgm,-1,'AFPGM');
      applist=insertc(applist,detailds,-1,'DETAILDS');
   end;


/**********************************************************************/
/* Hide report selection if AF program is not entered.                */
/**********************************************************************/

   link AFPGM;
return;

MAIN:
   link clrfld;


/**********************************************************************/
/* Handle standard PMENU commands.                                    */
/**********************************************************************/

   %eselect(pos, gbrc);
      otherwise;
   end;


/**********************************************************************/
/* Check for a valid application name.                                */
/**********************************************************************/

   if modified(applname) then link chkname;

   link setfld;
return;

TERM:
   %eisterm;
return;

%chkdata(orgds initgrph);


/**********************************************************************/
/* Validate the AF program name entered. If an AF program is not      */
/* supplied, hide the reporting option.                               */
/**********************************************************************/

AFPGM:
   if afpgm='' then
   do;
      call notify('REPTMETH','_HIDE_');
      call notify('DETLABEL','_HIDE_');
      call notify('DETAILDS','_HIDE_');
      call notify('DETDSCTL','_HIDE_');
      return;
   end;


/**********************************************************************/
/* If the program entry does not exist, issue an error message.       */
/**********************************************************************/

   if not cexist(afpgm) then
   do;
      _msg_='ERROR: '||afpgm|| ' does not exist.';
      return;
   end;

   call notify('REPTMETH','_UNHIDE_');
   call notify('DETLABEL','_UNHIDE_');
   call notify('DETAILDS','_UNHIDE_');
   call notify('DETDSCTL','_UNHIDE_');
return;


/**********************************************************************/
/* If editing an existing object, get the instance variables from     */
/* the list.                                                          */
/**********************************************************************/

GETAPPL:
   mlname   = getnitemc(applist,'MLNAME');
   mbname   = getnitemc(applist,'MBNAME');

   applname = getnitemc(applist,'APPLNAME');
   descript = getnitemc(applist,'DESCRIPT');
   notes    = getnitemc(applist,'NOTES');
   orgds    = getnitemc(applist,'ORGDS');
   initgrph = getnitemc(applist,'INITGRPH');
   afpgm    = getnitemc(applist,'AFPGM');
   detailds = getnitemc(applist,'DETAILDS');


/**********************************************************************/
/* Assign a name to the graph.                                        */
/**********************************************************************/

   bldgraph=initgrph;

   %mlopen(kldsid,mlname);
   %mbopen(bdsid,mbname,'U',1,kldsid);
return;


/**********************************************************************/
/* Check for a valid graph name. If the name is not valid, issue a    */
/* warning message.                                                   */
/**********************************************************************/

INITGRPH:
   if not cexist(initgrph) then
   do;
      _msg_='Graph '||initgrph|| ' does not exist';
      return;
   end;
return;


/**********************************************************************/
/* Allow the user to select the entry to store or retrieve the note.  */
/**********************************************************************/

NOTE:
   tmplist=makelist();
   tmplist=setitemc(tmplist,'SOURCE',1,'Y');
   call display('SASHELP.FSP.GETENTRY.FRAME',notes,tmplist);
   rc=dellist(tmplist);
return;

%utils;


/**********************************************************************/
/* Verify that a valid data set name has been entered. A widget       */
/* attribute in the CREATE method verifies the accessibility of       */
/* the data.                                                          */
/**********************************************************************/

ORGDS:
   dsid=open(orgds,'I');


/**********************************************************************/
/* Verify that the data set contains the variables GROUP and REPORTS. */
/* Issue a message if the variables are missing.                      */
/**********************************************************************/

   if varnum(dsid,'GROUP') eq 0 or
      varnum(dsid,'REPORTS') eq 0 then
   do;
      _msg_='Input data invalid. Must have variables GROUP and REPORTS.';
      dsid=close(dsid);
      return;
   end;

   dsid=close(dsid);

return;


/**********************************************************************/
/* Save the information in the object.                                */
/**********************************************************************/

SETAPPL:

   mlname  = getnitemc(envlist('L'),'MLNAME');

   mbname  = getnitemc(envlist('L'),'MBNAME');

   applist = setnitemc(applist,mlname,'MLNAME');
   applist = setnitemc(applist,mbname,'MBNAME');
   applist = setnitemc(applist,applname,'APPLNAME');
   applist = setnitemc(applist,descript,'DESCRIPT');
   applist = setnitemc(applist,notes,'NOTES');
   applist = setnitemc(applist,orgds,'ORGDS');
   applist = setnitemc(applist,initgrph,'INITGRPH');
   applist = setnitemc(applist,afpgm,'AFPGM');
   applist = setnitemc(applist,detailds,'DETAILDS');
   applist = setnitemc(applist,reptmeth,'REPTMETH');
   call putlist(applist);
return;


/**********************************************************************/
/* An input data set name and a graph entry are required.             */
/**********************************************************************/

USERCHKS:

   if orgds eq '' or initgrph eq '' then
   do;
      _msg_='ERROR: Input data set and graph entry are required.';
      _status_='R';
      xrc=21;
      return;
   end;
   xrc=0;
return;

/**********************************************************************/
/* This code generates the employee data set used in the example.     */
/**********************************************************************/

data orgchart.employee;
input @1 group $ @4 marital $ @6 hrsweek @9 division $21.
 @30 location $14.  @46 mgr2 $20. @66 currstat $ @71 unit $ @76 addr1 $23.
 @100 addr2 $17. @118 title $16. @135 mrstat date. @143 name $18.;
cards;
CG D 35 COMPUTER GRAPHICS    San Francisco   JONES, ROGER M.     FULL CGR  917 WINDING BROOK DRIVE SAN FRANCISCO, CA SYS DEVELOPER    13FEB89 Gates, Howard L.
MS S 35 MARKETING AND SALES  Dallas          MARTIN, DANIEL      FULL MSA  6605 OAK LEAF DRIVE     DALLAS, TX        AD MGR           17JUN84 Garfield, Julie R.
HD S 25 HOST DEVELOPMENT     Nashville       SAMUELS, LAUREN     FULL HSD  101 BAKER STREET        NASHVILLE, TN     APP DEVELOPER    01JAN89 Gilliam, Renee N.
HR D 27 HUMAN RESOURCES      Denver          BENEDICT, PHILLIP   FULL HRD  719 HILLSBOROUGH ROAD   DENVER, CO        FOOD SVC SUPV    01JUN86 Green, William M.
TS M 30 TECHNICAL SUPPORT    Boston          THORNBERG, MARGARET FULL TSU  1262 LINCOLN COURT      BOSTON, MA        TECH SUP ANALYST 01JUN91 Gupton, James S.
;

proc print data=orgchart.employee;
format mrstat date7.;
run;

/****************************************************************/
/****************************************************************/
/* End of sample code for Chapter 4 in "Extending SAS/EIS       */
/* Software Capabilities."                                      */
/****************************************************************/
/****************************************************************/

/****************************************************************/
/****************************************************************/
/* The following can be used to run the examples in Chapter 5,  */
/* "Extending Your SAS/EIS Software Capabilities" with the 6.10 */
/* Release of SAS Software.  You may need to modify this sample */
/* code when running examples in other SAS Software releases.   */
/* You will need to create the FRAME entries that accompany     */
/* this sample code.                                            */
/* Copyright(c) 1994 by SAS Institute Inc., Cary, NC USA        */
/****************************************************************/
/****************************************************************/

/************************************************************************/
/*  RUN Method for object type REPGRPH.                                 */
/*  Source code for RUNREPGR.FRAME, an extended table with column       */
/*  headers and total, a chart, and another table with drill            */
/*  variables and values.                                               */
/*                                                                      */
/*  REPORT extended table and associated objects:                       */
/*  Header row:  CHDRLAB text label, CHDR1-CHDR5 text entry fields      */
/*  Table name:  REPORT  (Getrow: REPGET)                               */
/*  Table rows:  FPVAL, FCVAL1-FCVAL5 text entry fields                 */
/*  Total row:   FCTOTLAB text label, FCTOT1-FCTOT5 text entry          */
/*               fields                                                 */
/*                                                                      */
/*  VALUES extended table and associated objects:                       */
/*  Table row:  DRILLVAR text entry field                               */
/*              DRILLVAL text entry field                               */
/*                                                                      */
/*  GRAPHICS object:  CHART                                             */
/*                                                                      */
/*  Note: The program fills several "text entry" fields rather than     */
/*        allowing user data entry.                                     */
/*                                                                      */
/*  Labelled sections appear in the following order:                    */
/*                                                                      */
/*    INIT      create and initialize lists, arrays, and open data sets */
/*    GETAPPL   get information from application database list          */
/*    MAIN      process custom commands                                 */
/*    TERM      close data sets and delete lists                        */
/*    REPGET    GETROW for REPORT extended table (tabular report)       */
/*    REPPUT    PUTROW for REPORT extended table (drill down selection) */
/*    GETVAL    GETROW for VALUES extended table (drilled values)       */
/*    PUTVAL    PUTROW for VALUES extended table (drlup or newval)      */
/*                                                                      */
/*  (non-standard sections are listed here alphabetically               */
/*                                                                      */
/*    CHDR1-5   Labelled sections for column label fields               */
/*    COLNEW    Processing for when a user selects a new column         */
/*    COLS      Setup for table column definitions                      */
/*    CTYPE     Change chart type                                       */
/*    DRLDOWN   Reinitialize lists after drill down                     */
/*    DRLUP     Reinitialize lists after drill up                       */
/*    FROMHIER  Reinitialize lists after HIER command                   */
/*    LOADTOTS  Load "totals row" for table                             */
/*    NCHRTVAR  Select new dependent chart variable                     */
/*    NEWVAL    Select new value for subsetting (lateral drill)         */
/*    REINIT    Common initializations (called from other sections)     */
/*    ZOOMCHRT  Zoom business graphs                                    */
/*                                                                      */
/* NOTE: in order to recompile either the RUN or CREATE method SCL,     */
/* you need the SAS/EIS application macros, which are documented in     */
/* the Appendix of this book and available through the SAS Online       */
/* Samples facility. Instructions on how to obtain a copy of these      */
/* macros are on the inside front cover of this book.                   */
/*                                                                      */
/***********************************************************************/


/************************************************************************/
/* Provide the legend for the BOOKMARK stack and the maximum            */
/* number of drill variables as macro variable assignments.             */
/************************************************************************/

   %let legl=Report with Graphs;
   %let numdril=6;



/************************************************************************/
/* Find the application list and read in generic                        */
/* information.  (Optional)                                             */
/************************************************************************/

   %eisstart;   /* Omit this macro in early development phase. */


/************************************************************************/
/* Initialize the array LISTIDs for potential use in drill down to      */
/* build a WHERE clause.                                                */
/************************************************************************/

   array listids (&numdril) listid1-listid&numdril;


/************************************************************************/
/* Initialize a series of variable arrays and set their lengths.        */
/* Note that each numeric value in a column, as well each total, is     */
/* converted to a character value for display purposes.                 */
/* Array variables hold the following values:                           */
/*                                                                      */
/* chdrs--labels for the display                                        */
/* cfmts--formats to use for reporting                                  */
/* colnums--variable numbers returned from the SCL VARNUM functions     */
/* colvars--numeric values                                              */
/* fcvals--values converted to character                                */
/* tots--numeric totals                                                 */
/* fctots--totals converted to character.                               */
/************************************************************************/

   array chdrs (5) $ chdr1-chdr5;
   array cfmts (5) $12 cfmt1-cfmt5;
   array colnums (5)   colnum1-colnum5;
   array colvars (5)   colvar1-colvar5;     /* num vals  */
   array fcvals (5) $ fcval1-fcval5;        /* char vals */
   array tots (5)   tot1-tot5;
   array fctots (5) $ fctot1-fctot5;



/************************************************************************/
/* Initialize a series of variables and set their lengths. The          */
/* character variables set to length 200 will contain WHERE clause      */
/* specifications.                                                      */
/************************************************************************/

    length totwhr rowswhr newvalwh initwh  $ 200
           status $ 1
           repvar cname chartv $ 8
           dsname mbname mlname $ 17
           nval 8;



/************************************************************************/
/* Initializes generic variables for SAS/EIS. (Optional)                */
/************************************************************************/

INIT:
   %eisinit;       /* Omit this macro in early development phase. */


/************************************************************************/
/* Get the instance variable values from the                            */
/* control record in the application database. (Optional)               */
/************************************************************************/

   %applfndr;      /* Omit this macro in early development phase. */


/************************************************************************/
/* Assign the actual number of drill levels for this application.       */
/************************************************************************/

   numdril=listlen(hierchy);


/************************************************************************/
/* Open the data set created by the SUMMARY procedure used for the      */
/* report. The data set must be registered in the metabase, and         */
/* the registration name must be the same as the data set name.         */
/************************************************************************/


   repid=open(dsname,'I');



/************************************************************************/
/* Locate the variable _TYPE_ in the SUMMARY data set.                  */
/************************************************************************/

   vntype=varnum(repid,'_TYPE_');



/************************************************************************/
/* Set up the following lists:                                          */
/*                                                                      */
/* typelist--_TYPE_ values for each drill variable                      */
/* subsets--subset values for display in VALUES extended table          */
/* collist--all eligible column names for report                        */
/* where--for building WHERE clause and used by hierarchy window        */
/* allhier--needed for hierarchy window only                            */
/* arrows--needed for hierarchy window only.                            */
/************************************************************************/

   typelist=makelist();
   subsets=makelist();
   collist=makelist();
   where=makelist();
   allhier=makelist();
   arrows=makelist();



/************************************************************************/
/* Initialize values for hierarchy levels and for WHERE clause.         */
/************************************************************************/

   hierlevl=1;
   repvar=scan(nameitem(hierchy,1), 3, '.');
   where=insertc(where,repvar,1,'DRILL VARIABLE');
   level=varnum(repid,repvar);


/************************************************************************/
/* Initialize values for TYPE corresponding to each drill variable.     */
/************************************************************************/

   do i=1 to listlen(hierchy);
      cname=scan(nameitem(hierchy,i),3,'.');
      vn=varnum(repid,cname);
      type=2**(vntype-vn-1);
      typelist=insertn(typelist,type,i, cname );
   end;

   whrtype=getnitemn(typelist,repvar);



/************************************************************************/
/* Open the metalist and the metabase to check the necessary            */
/* registrations.     (Optional)                                        */
/************************************************************************/

   %mlopen(mlistid,mlname,'I',1,0) ;          /* Omit during initial testing  */
   %mbopen(mbaseid,mbname,'I','1',mlistid) ;  /* Omit during initial testing  */



/************************************************************************/
/* Using the metabase as a source of information, the following         */
/* program constructs a list of all possible numeric columns that       */
/* can appear in the report. (Optional)                                 */
/************************************************************************/

   qlist=makenlist('L','DSETNAME','ATTRIBUTE');  /* Omit this step during    */
   qlist=setnitemc(qlist,dsname,'DSETNAME');     /* initial testing.         */
   qlist=setnitemc(qlist,'ANALYSIS','ATTRIBUTE');
   %mbquery(qlist,mlistid,mbaseid,qlist,qlist,qlist);
   pos=nameditem(qlist,'DSETNAME');
   do i=1 to (pos-1);
      collist=insertc(collist, scan(nameitem(qlist,i), 3, '.'), -1);
   end;


/************************************************************************/
/* Define the columns to appear in the initial display of the report    */
/* report by linking to the COLS label.                                 */
/*                                                                      */
/* If the total number of columns is less than five, protect the unused */
/* portions of the display. Use a DO group rather than a DO loop        */
/* because the PROTECT statement syntax does not allow using an array   */
/* name.                                                                */
/************************************************************************/

   start=1;        /* Set start and stop for COLS loop.     */
   stop=ncols;     /* Process all columns.                  */
   link cols;      /* Define varnums and labels.            */
   if ncols < 5 then
      do;
         protect chdr5;
         if ncols < 4 then protect chdr4;
         if ncols < 3 then protect chdr3;
         if ncols < 2 then protect chdr2;
      end;


/************************************************************************/
/* Initialize graphs, WHERE clause, by linking to REINIT label.         */
/************************************************************************/


   link reinit;
   rc=where(repid,rowswhr);



/************************************************************************/
/* Assign the dependent variable for the graph.                         */
/************************************************************************/

   call notify('CHART', '_SET_DEP_VAR_', chartv);


/************************************************************************/
/* Prepare information necessary for the  application to let the user   */
/* change the chart type at run time. The default chart type is a       */
/* horizontal bar chart, corresponding to the assignment ctyp=9.        */
/*                                                                      */
/* The INIT section should also contain several validation checks to    */
/* protect the user from experiencing execution time errors. For        */
/* example, make sure that the selected data set and variables still    */
/* exist, that the _TYPE_ variable created by the SUMMARY procedure is  */
/* in the data set, and that any additional programs to be called are   */
/* available.                                                           */
/************************************************************************/

   ctyplist=makelist();
   ctyplist=setnitemc(ctyplist,'Vertical Bar','8');
   ctyplist=setnitemc(ctyplist,'Horizontal Bar','9');
   ctyplist=setnitemc(ctyplist,'Pie','15');
   ctyp=9;  /* hbar is the default */
return;




/************************************************************************/
/* Get standard instance variable values from the list in the           */
/* application database corresponding to the definition of a particular */
/* application. Link to this section from the %APPLFNDR macro.          */
/*                                                                      */
/* During initial testing, this section could consist of hard-coded     */
/* assignments, for example, DSNAME='TEST.MYDATA';.                     */
/************************************************************************/

GETAPPL:
   applname = getnitemc(applist, 'APPLNAME') ;
   descript = getnitemc(applist, 'DESCRIPT') ;
   dsname   = getnitemc(applist, 'DSNAME') ;
   mbname   = getnitemc(applist, 'MBNAME') ;
   mlname   = getnitemc(applist, 'MLNAME') ;
   hierchy  = getniteml(applist, 'HIERCHY') ;
   columns  = getniteml(applist, 'COLUMNS') ;
   notes    = getnitemc(applist, 'NOTES') ;
   chartv   = getnitemc(applist, 'CHART') ;
   userattr = getniteml(applist, 'USERATTR') ;
return;



/************************************************************************/
/* Handle standard SAS/EIS commands and actions initiated using the     */
/* command line or menu bar.                                            */
/************************************************************************/

MAIN:
   %eselect(pos, gbrc) ;


/************************************************************************/
/* Call the Hierarchy window. The code saves the lists HIERCHY and      */
/* WHERE to determine whether the user makes changes to either and      */
/* links to the label FROMHIER if any changes were made.                */
/************************************************************************/

   when('HIER')
      do;
         orighier=hierchy;
         origwher=where;
         call display('sashelp.eis.viewdrll.frame',mbaseid,dsname,
                       where,hierchy,allhier,arrows,initwh,repvar,dsname);
         if orighier ne hierchy and origwher ne where then
            link fromhier;
         else return;
      end;


/************************************************************************/
/* If possible, drill up and provide a message if the display is at     */
/* the top of the hierarchy list.                                       */
/************************************************************************/


   when('DRILLUP')
      do;
         if hierlevl - 1 <= 0 then
            call display(%acatalog(eis, ERRMSG),0, 'At top of hierarchy',
                         'Cannot drill up');
         else
            link drlup;
      end;

      otherwise;


/************************************************************************/
/* The end of command processing controlled by the macro %ESELECT.      */
/************************************************************************/

      end;


/************************************************************************/
/* Process the return code from the BOOKMARK facility.    (Optional)    */
/************************************************************************/

   %bookmark(PROCESS);    /* Optional--you can omit this macro during */
                          /* early development phase.                 */


/************************************************************************/
/* The label USERCLKC should contain an alternative SELECT method       */
/* for the object.  No such method exists in this object.               */
/************************************************************************/

   link userclkc;


/************************************************************************/
/* Check to see if the user has set the END or CANCEL status.           */
/************************************************************************/

   call send(_self_,'_GET_STATUS_',status);
   if status not in('E','C') and
      cmdline not in('END','BOOKMARK','NOTES','NOTAVAIL') then
      do;
         call notify('REPORT','_UNSELECT_ALL_');
         call notify('VALUES','_UNSELECT_ALL_');
         rc=where(repid,rowswhr);


/************************************************************************/
/* Check to see if there are data available to display at a valid drill */
/* hierarchy level, and provide a message and the previous display if   */
/* there are not data at a valid drill level.                           */
/************************************************************************/


   if fetch(repid) ne 0 then
      do;
         call display(%acatalog(eis, ERRMSG),0,
                      'No detail data at this level');
         hierlevl=1;
         repvar=scan(nameitem(hierchy,1), 3, '.');
   if subsets > 0 then rc=dellist(subsets);
      subsets=makelist();
   if where > 0 then rc=dellist(where);
      where=makelist();
      where=insertc(where,repvar,1,'DRILL VARIABLE');
      level=varnum(repid,repvar);
      whrtype=getnitemn(typelist,repvar);
      link reinit;
      rc=where(repid,rowswhr);
      end;


/************************************************************************/
/* Refresh the chart and the table with new information based upon      */
/* the user's choice at run time.                                       */
/************************************************************************/

      call notify('REPORT','_NEED_REFRESH_');
      call notify('VALUES','_NEED_REFRESH_');
      call method('RMETHODS.SCL','PIEOK',repid,ctyp,chartv,ctyplist);
      call notify('CHART','_SET_TYPE_',ctyp);
      call notify('CHART','_NEED_REFRESH_');
   end;
return;


/************************************************************************/
/* Provide termination housekeeping and handle the bookmark stack.      */
/************************************************************************/

TERM:
   %eistermr ;    /* Omit this macro in early development phase. */


/************************************************************************/
/* Close all open data sets, and delete all temporary lists.            */
/************************************************************************/


      if repid > 0 then repid=close(repid);
      if hierchy > 0 then rc=dellist(hierchy);
      if qlist > 0 then rc=dellist(qlist);
      if collist > 0 then rc=dellist(collist);
      if subsets > 0 then rc=dellist(subsets);
      if where > 0 then rc=dellist(where);
      if ctyplist > 0 then rc=dellist(ctyplist);

      do i=1 to numdril;
         if listids(i) > 0 then rc=dellist(listids(i));
         listids(i)=.;
      end;
return;



/************************************************************************/
/* If there are no more rows, end the table.                            */
/************************************************************************/

REPGET:
   if fetchobs(repid,_currow_) lt 0 then
      call notify('REPORT','_ENDTABLE_');
      else
         do;


/************************************************************************/
/* Get the appropriate formats to produce the initial report based      */
/* on whether the data to display are character or numeric.             */
/************************************************************************/

            pfmt=varfmt(repid,level);
            if vartype(repid,level)='C' then
               do; /* get character formatted value to label rows */

                   pval=getvarc(repid,level);
                      if pfmt ne ' ' then
                         fpval=putc(pval,pfmt);
                      else fpval=pval;

               end; /* get character formatted value to label rows */
         else
            do; /* get numeric formatted value to label rows */

               nval=getvarn(repid,level);
                  if pfmt eq ' ' then
                     pfmt='14.';
                  fpval=putn(nval,pfmt);

            end; /* get numeric formatted value to label rows */


/************************************************************************/
/* Get the values to display in the report columns.                     */
/************************************************************************/

      do i=1 to ncols;
         colvars(i)=getvarn(repid,colnums(i));
         fcvals(i) = putn(colvars(i), cfmts(i) );
      end;
   end;
return;



/************************************************************************/
/* Recreate the report in the extended table for the appropriate drill  */
/* level when a user drills down.                                       */
/*                                                                      */
/* The first conditional IF shows a message if a user tries to          */
/* drill down past the bottom of the drill hierarchy.                   */
/************************************************************************/

REPPUT:
   if (hierlevl) >=listlen(hierchy) then
      do;
         call display(%acatalog(eis, ERRMSG),0,
                      'At bottom of drill hierarchy');
      end;


/************************************************************************/
/* If there is a remaining drill level to display, prepare the variable */
/* values necessary to properly link to the DRLDOWN label and show the  */
/* next level of the report.                                            */
/*                                                                      */
/* The variable HIERLEVL contains the value reflecting the level in the */
/* drill hierarchy that the report displays.                            */
/*                                                                      */
/* The value assigned to variable PVAR is the variable the user         */
/* selected for drill down.                                             */
/*                                                                      */
/* The value assigned to variable FCHOICE is the value of the drill     */
/* variable to hold constant before moving to the next drill level.     */
/************************************************************************/


      do;
         hierlevl + 1;
         pvar=getnitemc(where,'DRILL VARIABLE');
         fchoice=fpval;
         link drldown;
      end;
return;



/************************************************************************/
/* Load the drill variables and values into the VALUES table.           */
/************************************************************************/

     GETVAL:


/************************************************************************/
/* Get the correct values for the current drill variable to display     */
/* in the drill values table.                                           */
/************************************************************************/

      if _currow_ > listlen(subsets) then
         call notify('VALUES','_ENDTABLE_');

      else
         do;
         drillvar=nameitem(subsets,_currow_);
         drillval=getitemc(subsets,_currow_);
      end;
   return;



/************************************************************************/
/* Determine whether a user clicked on a drill variable to drill up     */
/* or whether the user clicked on a drill value to request a selection  */
/* list of drill values.                                                */
/************************************************************************/

PUTVAL:
   call notify('DRILLVAR','_IS_MODIFIED_',varmod);
   call notify('DRILLVAL','_IS_MODIFIED_',valmod);


/************************************************************************/
/* If a user clicks in a variable name, keep track of the level         */
/* and drill up.                                                        */
/************************************************************************/


   if varmod then
      do;
         numdrlup=(listlen(subsets) - _currow_) + 1;
         do up=1 to numdrlup;
         link drlup;
         end;
      end;


/************************************************************************/
/* If a user clicks on a value, link to the label NEWVAL to change      */
/* the subset shown in the report.                                      */
/************************************************************************/


      else if valmod then
      do;
         link newval;
      end;

return;




/************************************************************************/
/* The labels for column headers link to the label COLNEW. Each         */
/* labeled section executes when a user selects a column header at run  */
/* time, preserving the number associatedwith the column in a variable. */
/************************************************************************/

CHDR1:
   cn=1;
   link colnew;
return;

CHDR2:
   cn=2;
   link colnew;
return;
CHDR3:
   cn=3;
   link colnew;
return;

CHDR4:
   cn=4;
   link colnew;
return;

CHDR5:
   cn=5;
   link colnew;
return;



/************************************************************************/
/* Create a pop-up menu with a list of variables the user can choose    */
/* to change the variable displayed in a column. When the user makes    */
/* a choice, the statements change the values displayed in the column   */
/* to the values for the new variable.                                  */
/************************************************************************/
   pos=popmenu(collist);

   if pos > 0 then
      do;
         cname=getitemc(collist,pos);
         columns=setitemc(columns,cname,cn);
         start=cn;  stop=cn; /* set start & stop for the "cols" loop     */
         link cols;          /* redefine which varnums and labels to use */
         link loadtots;      /* reload totals (one of the vars is new)   */
         call notify('REPORT','_NEED_REFRESH_');  /* flag to reload rows */
      end;
return;


/************************************************************************/
/* Create the values displayed in the columns of the report portion     */
/* of the window. The values, headers, and formats are stored in a      */
/* table created in a DO loop. The INIT section calls this label to     */
/* create the initial display, and the COLNEW label calls this section  */
/* the display with the values of a new variable that the user          */
/* specifies at run time.                                               */
/************************************************************************/

COLS:
   do i=start to stop;
      cname=getitemc(columns,i);
      colnums(i) =varnum(repid,cname);
      chdrs(i)=varlabel(repid,colnums(i));
      if chdrs(i)=' ' then chdrs(i)=cname;
      cfmts(i)=varfmt(repid,colnums(i));
      if cfmts(i)=' ' then cfmts(i)='BEST8.';
   end;
return;



/************************************************************************/
/* Execute these statements when the user requests a change in the      */
/* type of chart the application displays.                              */
/************************************************************************/

CTYPE:
   call notify('CHART','_GET_TYPE_',ctyp);
   call method('RMETHODS.SCL','CTYPE',ctyp,ctyplist);
   call method('RMETHODS.SCL','PIEOK',repid,ctyp,chartv,ctyplist);
   call notify('CHART','_SET_TYPE_',ctyp);
   call notify('CHART','_NEED_REFRESH_');
return;


/************************************************************************/
/* Execute these statements when called from the label REPPUT. Variable */
/* assignments in REPPUT pass to DRLDOWN the name of the drill variable,*/
/* the hierarchy level, and the value of the drill variable to hold     */
/* constant, and the statements in this section produce the new report. */
/*                                                                      */
/* In the first set of assignment statements, variables and their       */
/* descriptions include:                                                */
/*                                                                      */
/* REPVAR--the name of the report variable                              */
/* WHERE--the LISTID. The list is maintained to contain information     */
/*        for the current WHERE clause.                                 */
/* LEVEL--the new drill level.                                          */
/************************************************************************/

DRLDOWN:
   repvar=scan(nameitem(hierchy,hierlevl), 3, '.');
   where=setnitemc(where,repvar,'DRILL VARIABLE');
   level=varnum(repid,repvar);


/************************************************************************/
/* Determine the name of the variable used to subset the data and       */
/* the value of that variable. This information displays in the         */
/* VALUES table at run time, verbally describing the drill level        */
/* in a separate table. The DO group following the IF statement         */
/* determines the actual value if the user chooses a formatted value.   */
/************************************************************************/

   vn=varnum(repid,pvar);
   drlfmt=varfmt(repid,vn);
   drltyp=vartype(repid,vn);
   if drlfmt ne ' ' then
      do;
         find='put(' || trim(pvar) || ',' || trim(drlfmt) || ")='"
                     || trim(fchoice) || "'";
         rc=where(repid,find);
         rc=fetch(repid);
         if drltyp='C' then choice=getvarc(repid,vn);
      else if drltyp='N' then choice=putn(getvarn(repid,vn),'14.');
         rc=where(repid,'UNDO');
      end;
      else choice=fchoice;

      subsets=insertc(subsets,fchoice,-1,pvar);



/************************************************************************/
/* Add the variable, determine the character or numeric value, the name */
/* of the variable, and add the value to the table and the name to the  */
/* list of available variables.                                         */
/************************************************************************/


      pos=listlen(where) + 1;
      listids(pos)=makelist();
      if drltyp='C' then
         listids(pos)=insertc(listids(pos), choice,1,'C');
      else if drltyp='N' then
         listids(pos)=insertc(listids(pos), choice,1,'N');
      where=insertl(where,listids(pos),-1,pvar);



/************************************************************************/
/* Reset the list containing the WHERE clause specifications so totals  */
/* calculate correctly. An assignment statement sets a new value for    */
/* the variable WHRTYPE to display the correct number of rows.          */
/************************************************************************/

      call method('RMETHODS.SCL','WHERECLS',where,totwhr,whrtype);

      newtype=getnitemn(typelist, scan(nameitem(hierchy,hierlevl),3,'.') );
      whrtype + newtype;


/************************************************************************/
/* Link back to the REINIT label.                                       */
/************************************************************************/

      link reinit;

   return;



DRLUP:


/************************************************************************/
/* Execute these statements when the user drills up by selecting the    */
/* DRILLUP button from the menu bar or by clicking in the drill VALUES  */
/* table.                                                               */
/*                                                                      */
/* Decrement the hierarchy level by one level.                          */
/************************************************************************/

   hierlevl = hierlevl - 1;


/************************************************************************/
/* Remove the last value used to subset the data from the VALUES        */
/* extended table display.                                              */
/************************************************************************/

   subsets=delitem(subsets,-1);


/************************************************************************/
/* Determine the _TYPE_ value of the current level drill variable, and  */
/* replace it with the appropriate _TYPE_ value for the next level up.  */
/************************************************************************/

   oldtype=getnitemn(typelist,repvar);
   whrtype=whrtype-oldtype;


/************************************************************************/
/* Determine the report variable for the next level up in the hierarchy.*/
/************************************************************************/

   repvar=scan(nameitem(hierchy,hierlevl), 3, '.');


/************************************************************************/
/* Delete the sublist that defines the old subsetting. Reset the        */
/* positions for the new report variable.                               */
/************************************************************************/

    pos=nameditem(where,repvar);
    thislist=getiteml(where,pos);
    rc=dellist(thislist);
    where=delitem(where,pos);


/************************************************************************/
/* Switch back one level so that the current drill variable now becomes */
/* the current report variable. Reset the level.                        */
/************************************************************************/

   where=setnitemc(where,repvar,'DRILL VARIABLE');
   level=varnum(repid,repvar);


/************************************************************************/
/* Reset characteristics for the total line.                            */
/************************************************************************/

   savetype=whrtype;
   whrtype=whrtype - getnitemn(typelist,repvar);
   call method('RMETHODS.SCL','WHERECLS',where,totwhr,whrtype);
   whrtype=savetype;
   link reinit;




FROMHIER:


/************************************************************************/
/* Reinitialize all lists after the user selects the Hierarchy push     */
/* button at run time. The code ignores data subsets in the Hierarchy   */
/* window. The name of the drill variable is set to the first variable  */
/* in the new hierarchy.                                                */
/************************************************************************/

   if listlen(where) > 1 then _msg_ =
                "Subsetting ignored";
      rc=clearlist(where);
      rc=clearlist(subsets);
      repvar=scan(nameitem(hierchy,1),3,'.');
      where=insertc(where,repvar,1,'DRILL VARIABLE');
      level=varnum(repid,repvar);
      hierlevel=1;
      chdrlab=varlabel(repid,level);
      if chdrlab=' ' then chdrlab=repvar;


/************************************************************************/
/* Assign null value to variable TOTWHR, causing the value of _TYPE_    */
/* to default to 0. This assumes no subsetting in the hierarchy window. */
/************************************************************************/

      totwhr=' ';


/************************************************************************/
/* Finally, set the new top level for the next drill request.           */
/************************************************************************/

      whrtype=getnitemn(typelist,repvar);

      link reinit;
return;




/************************************************************************/
/* Produce the row with totals for the table displayed in the window.   */
/*                                                                      */
/* Clear the existing WHERE clause before applying the new WHERE        */
/* conditions for the row totals.                                       */
/************************************************************************/

LOADTOTS:

   if totwhr=' ' then totwhr='_TYPE_=0';
   rc=where(repid);
   rc=where(repid,totwhr);
   rc=fetch(repid);
   if rc=0 then
      do;
         do i=start to stop;
         tots(i)=getvarn(repid, colnums(i) );
         fctots(i)=putn(tots(i), cfmts(i) );
         end;
      end;


/************************************************************************/
/* Undo the WHERE clause just used to produce totals. Statements in the */
/* MAIN label reapply a WHERE clause for new row totals, as needed.     */
/************************************************************************/

      rc=where(repid,'UNDO');
return;


/************************************************************************/
/* Allow the user to choose a new dependent chart variable, and apply   */
/* it to create a new chart at run time.                                */
/************************************************************************/

NCHRTVAR:
   pos=popmenu(collist);


/************************************************************************/
/* The DO group executes only if the user makes a selection from        */
/* the pop-up menu.                                                     */
/************************************************************************/

   if pos > 0 then
      do;
         chartv=getitemc(collist,pos);
         call method('RMETHODS.SCL','PIEOK',repid,ctyp,chartv,ctyplist);
         call notify('CHART', '_SET_TYPE_', ctyp);
         call notify('CHART', '_SET_DEP_VAR_', chartv);
      end;
return;


/************************************************************************/
/* The user has selected a new subset by clicking in the VALUES table.  */
/************************************************************************/

NEWVAL:


/************************************************************************/
/* Determine the drill variable attributes.                             */
/************************************************************************/

    vn=varnum(repid,drillvar);
    drlfmt=varfmt(repid,vn);
    vt=vartype(repid,vn);


/************************************************************************/
/* Build the WHERE clause necessary to produce a selection list of the  */
/* values available for subsetting the data within the current drill    */
/* variable.                                                            */
/************************************************************************/

   if nvalwhr > 0 then rc=dellist(nvalwhr);
   nvalwhr=makelist();
   nvalwhr=copylist(where,'MERGE YES',nvalwhr);
   nvalwhr=delnitem(nvalwhr,drillvar,1,1,pos);
   if pos=0 then call putlist(nvalwhr);


/************************************************************************/
/* Obtain the _TYPE_ value in the WHERE clause.                         */
/************************************************************************/

   nvaltype=whrtype - getnitemn(typelist,repvar);
   call method('RMETHODS.SCL','WHERECLS',nvalwhr,newvalwh,nvaltype);

   viewname='work.' || left(drillvar);


/************************************************************************/
/* Create an SQL view with the unique values of the drill variable      */
/* that are available at this level.                                    */
/************************************************************************/

   submit sql continue;
      create view work.&drillvar as
      select distinct (&drillvar) from &dsname
      where &newvalwh and not (&drillvar is missing);
   endsubmit;
      newval=' ';
      viewid=open(viewname);


/************************************************************************/
/* Select the new value from the list of values, and verify that        */
/* character versus numeric values are displayed appropriately.         */
/************************************************************************/

   if viewid > 0 then
      do;
         if vt='C' then
            newval=datalistc(viewid,drillvar,'Values available for this level');
      else
         do;
            numval=datalistn(viewid,drillvar,'Values available for this level');
            newval=putn(numval,'BEST.');  /* temp value so there is one */
         end;
         viewid=close(viewid);
      end;


/************************************************************************/
/* Return to calling label if user makes no selection. Otherwise,       */
/* reset values for current list, WHERE clause for the rows, WHERE      */
/* clause for the totals, formatted values, and refresh the table       */
/* with new values and totals.                                          */
/************************************************************************/

   if newval=' ' then return;
   pos=nameditem(where,drillvar);

   if pos > 0 then
      do;  /* drill var found as sublist */

         thislist=getiteml(where,pos);
         thislist=setitemc(thislist, newval, 1);     /* reset value */


/************************************************************************/
/* Reset the WHERE clause for the rows.                                 */
/************************************************************************/

      call method('RMETHODS.SCL','WHERECLS',where,rowswhr,whrtype);


/************************************************************************/
/* Reset the WHERE clause for the totals.                               */
/************************************************************************/

      savetype=whrtype;  /* hold value */
      whrtype=whrtype - getnitemn(typelist,repvar);
      call method('RMETHODS.SCL','WHERECLS',where,totwhr,whrtype);
      whrtype=savetype;  /* reset back to real whrtype */


/************************************************************************/
/* Reset the formatted value in the list to display it in the table.    */
/* Use the appropriate function based on whether the value is           */
/* character or numeric.                                                */
/************************************************************************/

   if drlfmt ne ' ' then
      do;
         if vt='C' then
         newval=putc(newval,drlfmt);
      else
         newval=putn(numval,drlfmt);
      end;


/************************************************************************/
/* Add new subset criteria to the list and refresh the table.           */
/************************************************************************/

   subsets=setnitemc(subsets,newval,drillvar);
   call notify('VALUES','_NEED_REFRESH_');


/************************************************************************/
/* Load the row containing the totals for all of the columns.           */
/************************************************************************/

   start=1;
   stop=ncols;
   link loadtots;

   end;
return;


/************************************************************************/
/* Reinitialize common data elements after processing in the INIT,      */
/* FROMHIER, DRLUP, and DRLDOWN sections. Reset the WHERE clause for    */
/* the next GETROW based on the new value in variable WHRTYPE.          */
/************************************************************************/

REINIT:
   call method('RMETHODS.SCL','WHERECLS',where,rowswhr,whrtype);


/************************************************************************/
/* Reset the column header labels.                                      */
/************************************************************************/

   chdrlab=varlabel(repid,level);
   if chdrlab=' ' then chdrlab=repvar;


/************************************************************************/
/* Reset the independent and dependent chart variables.                 */
/************************************************************************/

   call notify('CHART','_SET_INDEP_VAR_',repvar);
   call notify('CHART','_SET_ID_VAR_',repvar);


/************************************************************************/
/* Load the row containing the totals for all of the columns.           */
/************************************************************************/

   start=1;
   stop=ncols;
   link loadtots;
return;


/************************************************************************/
/* Execute this section from the run method sample if the object allows */
/* a user-written SELECT method.                                        */
/************************************************************************/

UPDUSERL:


/************************************************************************/
/* Update the user control list.                                        */
/************************************************************************/

   userlist = setnitemc(userlist,cmdline,'COMMAND ');
return;


/************************************************************************/
/* If there is a selection method or target application, include this   */
/* Not required for this example.                                       */
/************************************************************************/

   %utilsr;




/************************************************************************/
/* Produce a larger chart when users select the ZOOM button.            */
/************************************************************************/

ZOOMCHRT:

   call notify('CHART','_GET_TYPE_',ctyp);
   call display('ZOOMGRPH.FRAME',repid,chartv,repvar,ctyp,ctyplist);
   call notify('CHART','_SET_TYPE_',ctyp);
return;




/******************************************************************/
/* ZOOMGRPH.SCL                                                    */
/*                                                                 */
/* This entry is the SCL for ZOOMGRPH.FRAME; it produces a more    */
/* detailed chart with additional data query features in the       */
/* REPGRPH object.                                                 */
/*                                                                 */
/* The variable...              contains...                        */
/*                                                                 */
/*     DSID                     The id number of the SAS data set  */
/*                              which the chart uses.              */
/*                                                                 */
/*     CVAR                     The name of the dependent variable */
/*                              shown in the chart.                */
/*                                                                 */
/*     REPVAR                   The name of the independent        */
/*                              variable shown in the chart.       */
/*                                                                 */
/*     TYPE                     The initial chart type.            */
/*                                                                 */
/*     CTYPLIST                 The id number for the list of      */
/*                              chart type names.                  */
/*                                                                 */
/*     METHODS                  The name of the entry to call for  */
/*                              executable methods.                */
/*                                                                 */
/*******************************************************************/

entry dsid 8 cvar $ repvar $ type 8 ctyplist 8;

INIT:
   control enter;
   call notify('CHART','_SET_DSID_',dsid);
   call notify('CHART','_SET_DEP_VAR_',cvar);
   call notify('CHART','_SET_INDEP_VAR_',repvar);
   call notify('CHART','_SET_ID_VAR_',repvar);
   call notify('CHART','_SET_TYPE_',type);
return;

MAIN:
return;


CTYPE:
   call method('RMETHODS.SCL','CTYPE',type,ctyplist);
   call method('RMETHODS.SCL','PIEOK',dsid,type,cvar,ctyplist);
   if type>0 then call notify('CHART','_SET_TYPE_',type);
   call notify('CHART','_NEED_REFRESH_');
return;

TERM:
return;




/*******************************************************************/
/* RMETHODS.SCL                                                    */
/*                                                                 */
/* This entry contains several labels with statements to perform   */
/* discrete processing tasks during the execution of the REPGRPH   */
/* object.                                                         */
/*                                                                 */
/* The label...                 performs the task(s)...            */
/*                                                                 */
/*     WHERECLS                 Creates a WHERE clause from the    */
/*                              WHERE list and the current type    */
/*                              value.                             */
/*                                                                 */
/*     CTYPE                    Provides a pop-up list from which  */
/*                              the user can select a chart type   */
/*                              at run time.                       */
/*                                                                 */
/*     PIEOK                    Checks to see if the data allows   */
/*                              the user to request a pie chart by */
/*                              ensuring no charted group has a    */
/*                              negative value.                    */
/*                                                                 */
/*******************************************************************/



/************************************************************************/
/* Create a WHERE clause from the WHERE list and the current TYPE       */
/* value. In addition, WHERE contains the ID number of the WHERE        */
/* list; WHR contains the actual text of the WHERE clause; and          */
/* TYPE is the value of _TYPE_ to add to the WHERE clause, when a       */
/* appropriate. The logic used in the statements works, assuming the    */
/* first WHERE list item is 'DRILL VARIABLE'.                           */
/************************************************************************/


WHERECLS:
   method where 8 whr $ 200
        optional=  type 8;

   whr=' ';
   numitems=listlen(where);
   do i=2 to numitems;


/************************************************************************/
/* Check to see if this is a compound WHERE clause.                     */
/************************************************************************/

   if whr ne ' '  then whr=trim(whr) || ' and (';
      else whr='(';


/************************************************************************/
/* Find the sublist of drill variable values.                           */
/************************************************************************/

   name=nameitem(where,i);
   this=getiteml(where,i);
   numthese=listlen(this);


/************************************************************************/
/* Find the subset values in the following DO loop. The loop is         */
/* general enough to accommodate OR conditions.                         */
/************************************************************************/

   do j=1 to numthese;


/************************************************************************/
/* For character variable values, insert quotation marks and            */
/* the "concatenation" operator. Do not use either for numeric values.  */
/************************************************************************/

      if nameitem(this,j)='C' then
         whr=trim(whr) || ' ' ||  trim(name)  || '?' ||
                 "'"   || getitemc(this,j) ||"'";
      else
         whr=trim(whr) || ' ' ||  trim(name)  || '=' || getitemc(this,j);


/************************************************************************/
/* Check to determine if there are more subset values, and add the OR   */
/* operator when there are subset values.                               */
/************************************************************************/

      if j <  numthese then whr=trim(whr)  ||  '  or  ';
   end;
   whr=trim(whr)  ||  ')';

   end;


/************************************************************************/
/* Append _TYPE_= when appropriate.                                     */
/************************************************************************/

   if type > 0 then
   do;
      if whr=' ' then
      whr='_TYPE_=' || left(put(type,2.));
   else
      whr='_TYPE_=' || left(put(type,2.)) || ' and ' || trim(whr);
   end; /* add _type_ where if needed */

   endmethod;


/************************************************************************/
/* Allow the user to select the chart type. The current chart type and  */
/* CTYPLIST is the ID number of the list of chart types.                */
/************************************************************************/

CTYPE:
   method ctyp 8 ctyplist 8;

   sel=popmenu(ctyplist);
   if sel > 0 then
      ctyp=input(nameitem(ctyplist,sel), 2.);

   endmethod;


/************************************************************************/
/* Ensure that no charted group has a negative value. Parameters        */
/* include REPID, the ID number of the SAS data set that the chart      */
/* uses; CTYP, the current chart type; CVAR, the name of the current    */
/* chart variable; and CTYPLIST, the ID number of the list of available */
/* chart types.                                                         */
/************************************************************************/

PIEOK:
   method repid 8 ctyp 8 cvar $8 ctyplist 8;
   rc=varstat(repid,cvar,'MIN',minval);


/************************************************************************/
/* If the minimum value of the chart variable is less than zero,        */
/* substitute a bar chart for the pie chart selection.                  */
/************************************************************************/

   if minval < 0 then
   do;
      if ctyp=15 then ctyp=9;
   rc=setlattr(ctyplist,'INACTIVE',3);
   end;
   else rc=setlattr(ctyplist,'ACTIVE',3);
   endmethod;


/*******************************************************************/
/* BLDREPGR.SCL                                                    */
/*                                                                 */
/* This entry is the SCL for BLDREPGR.FRAME, the CREATE method for */
/* the EIS Report with Graphics Object.                            */
/*                                                                 */
/* Labelled sections appear in the following order:                */
/*                                                                 */
/*    INIT     create and initialize lists and open data set       */
/*    MAIN     process custom commands                             */
/*    USERCHKS issue no error flag                                 */
/*    GETAPPL  get information from application list               */
/*    SETAPPL  save information into application list              */
/*    TERM     terminate build process                             */
/*                                                                 */
/*  (non-standard sections are alphabetical)                       */
/*                                                                 */
/*    DSNAMEC  pop up data sets for selection                      */
/*    DRILLC   pop up drill variables for selection                */
/*    CHARTC   pop up analysis variables for selection for chart   */
/*    COLUMNC  pop up analysis variables for selection for columns */
/*    NOTES    allow user to enter notes entry name                */
/*                                                                 */
/*******************************************************************/


/************************************************************************/
/* Define standard macro variables used in the CREATE method.           */
/* (Optional)                                                           */
/************************************************************************/

   %eisstrtb;         /* Omit this step during initial testing. */


/************************************************************************/
/* Generate initial program statements for the CREATE method.           */
/* (Optional)                                                           */
/************************************************************************/

   %eisstart;         /* Omit this step during initial testing. */


/************************************************************************/
/* Initialize variables with default lengths.                           */
/************************************************************************/

   length oldcols  $55 tmpvar $8 olddsn mlname mbname  $17
      tmpdrill $35 i maxitem newdsn 8;


/************************************************************************/
/* Define the description of this program for the BOOKMARK stack.       */
/* (Optional)                                                           */
/************************************************************************/

                             /* Omit this step during initial testing. */
   %let leg1   = SAS/EIS: Build Object for Flexible Report with Graph ;


/************************************************************************/
/* Define error messages to display if required fields are not          */
/* complete. (Optional)                                                 */
/************************************************************************/

   %let emsg21 = ERROR: Data set is required;          /* Omit this step  */
   %let emsg22 = ERROR: Drill variables are required;  /* during initial  */
   %let emsg23 = ERROR: Column variables are required; /* testing.        */


/************************************************************************/
/* Initialize variables for generic information.     (Optional)         */
/************************************************************************/

INIT:
   %eisinit;   /* Omit this step during initial testing. */


/************************************************************************/
/* Load the application list from the control record in the             */
/* application database.     (Optional)                                 */
/************************************************************************/

   %applfndb;  /* Omit this step during initial testing. */

return;



/************************************************************************/
/* Check for the existence of required fields. (Optional)               */
/************************************************************************/

   %chkdata(dsname drillvar colnames);     /* Omit this step during  */
                                           /* initial testing.       */


/************************************************************************/
/* Update the application database with the application                 */
/* definition.     (Optional)                                           */
/************************************************************************/

   %utils;       /* Omit this step during initial testing. */


MAIN:


/************************************************************************/
/* Clear required fields that have not been entered.                    */
/************************************************************************/

   link clrfld;


/************************************************************************/
/* Handle standard PMENU commands.                                      */
/************************************************************************/

   %eselect(pos, gbrc);   /* Omit this step during initial testing. */

      otherwise;
   end;

   refresh;


/************************************************************************/
/* Check for subsequent programs requesting to BOOKMARK past this       */
/* point. (Optional)                                                    */
/************************************************************************/

   %bookmark(PROCESS)     /* Omit this step during initial testing. */


/************************************************************************/
/* Ensure the application name is unique within the current             */
/* application database.                                                */
/************************************************************************/

   if modified(applname) then link chkname;


/************************************************************************/
/* Reassign the value to fields that have not been  entered in the      */
/* SETFLD label.                                                        */
/************************************************************************/

   link setfld;
return;


/************************************************************************/
/* Provide SAS data sets and variables registered in the current        */
/* metabase having the correct variables registered with the DRILL      */
/* and ANALYSIS attributes. The SAS/EIS predefined programming module,  */
/* MBDIRLST.PROGRAM, accepts and verifies the input.                    */
/************************************************************************/

DSNAMEC:
   call display('sashelp.eis.mbdirlst.program',bdsid,dsname,'','',.,
                1,'','attribute=DRILL ANALYSIS',' ');


/************************************************************************/
/* When the user selects a data set, open the data set, determine if it */
/* is different from the old data set, find qualified variables in the  */
/* new data set, delete intermediate lists, and reinitialize the input  */
/* CREATE screen with the new information.                              */
/************************************************************************/

   if dsname ne ' ' then
   do;  /* user picked a valid data base */
      if dsid > 0 then dsid=close(dsid);
      dsid=open(dsname);
   end; /* user picked a valid data base */

   if dsname ne olddsn then
   do;   /* data base has been changed */

        /* user did not pick any data base, close current data base
      if dsid>0 and dsname=' ' then dsid=close(dsid);

      if dsid>0 then
      do;  /* New data base has been opened--find the drill variables. */


/************************************************************************/
/* Query the metabase to find the drill variables.                      */
/************************************************************************/

      results=makelist();
      dslist=makelist();
      dslist=insertc(dslist,dsname,-1);
      qlist=makelist();
      qlist=insertc(qlist, 'DRILL', 1, 'ATTRIBUTE');

      /* pre-filled drill variables     */
   %mbquery( results, items, bdsid, dslist, 0, qlist,'NAME','');

      results=sortlist(results);
      drillvar=_blank_;
      maxitem=min(6,listlen(results));
   do i=1 to maxitem;
      drillvar=drillvar||' '||scan(nameitem(results,i),3,'.');
   end;

   rc=dellist(results);
   rc=dellist(dslist);
   rc=dellist(qlist);

   end;  /* New data base has been opened--find the drill variables. */

   /* initialize             */
   if dsname=' ' then drillvar=_blank_;
   colnames=_blank_;
   chart  =_blank_;
   refresh;
   end;  /* data base has been changed */
return;



/************************************************************************/
/* Provide a list of available DRILL variables to select for the        */
/* application definition.                                              */
/************************************************************************/

DRILLC:
   if dsid <= 0 then
   do;
     _msg_='ERROR: Dataset has not been selected or does not exist';
   end;
   else do;

      /* pop up drill variables for selection                        */
      call display('sashelp.eis.mbvarlst.program',drillvar,bdsid,
                   dsname,"DRILL",6,'','Y','','','ALL');

   end;
return;


/************************************************************************/
/* Provide a list of available column variables to select for the       */
/* application definition.                                              */
/************************************************************************/

COLUMNC:
   if dsid <= 0 then
   do;
      _msg_='ERROR: Dataset has not been selected or not exist';
   end;
   else do;

      /* pop up analysis variables for selection                     */
      call display('sashelp.eis.mbvarlst.program',colnames,bdsid,
                   dsname,'ANALYSIS',5,'','Y');

      /* user has changed columns                                    */
      if colnames ne oldcols then
         chart=scan(colnames,1);  /* take first column */

      oldcols=colnames;   /* remember previous colnames */

   end;
return;


/************************************************************************/
/* Provide a list of available ANALYSIS variables to select for the     */
/* application definition used in the chart.                            */
/************************************************************************/

CHARTC:
   if dsid <= 0 then
   do;

      _msg_='ERROR: Dataset has not been selected or does not exist';

   end;
   else do;

      /* pop up analysis variables for selection                     */
      call display('sashelp.eis.mbvarlst.program',chart,bdsid,
                   dsname,'ANALYSIS',1,'','Y');

   end;
return;


/************************************************************************/
/* Accept the name of a SOURCE catalog entry to use for NOTES at run    */
/* time.     (Optional)                                                 */
/************************************************************************/

NOTESC:
   tmplist=makelist();
   tmplist=setitemc(tmplist,'SOURCE',1,'Y');
   call display('sashelp.fsp.getentry.frame',notes,tmplist);
   rc=dellist(tmplist);
return;

USERCHKS:
   xrc=0;   /* force output */
return;


/************************************************************************/
/* Get information from the application database if the application     */
/* already exists and is being edited. (Optional)                       */
/************************************************************************/


GETAPPL:                                  /* Omit this step during  */
   mlname  =getnitemc(applist,'MLNAME');  /* initial testing.       */
   mbname  =getnitemc(applist,'MBNAME');
   applname=getnitemc(applist,'APPLNAME');
   descript=getnitemc(applist,'DESCRIPT') ;
   dsname  =getnitemc(applist,'DSNAME') ;
   hierchy =getniteml(applist,'HIERCHY') ;
   columns =getniteml(applist,'COLUMNS') ;
   notes   =getnitemc(applist,'NOTES');
   chart   =getnitemc(applist,'CHART') ;

   dsid=open(dsname);

   colnames=_blank_;
   do i=1 to listlen(columns);
      colnames=colnames||' '||getitemc(columns,i);
   end;


/************************************************************************/
/* Assign drill variables. (Optional)                                   */
/************************************************************************/

   drillvar=_blank_;
   do i=1 to listlen(hierchy);
      drillvar=drillvar||' '||scan(nameitem(hierchy,i),3,'.');
   end;

   %mlopen(kldsid, mlname);                /* open metalist */
   %mbopen(bdsid, mbname, 'U', 1, kldsid); /* open metabase */
return;



/************************************************************************/
/* Store the information for the application in an application list.    */
/************************************************************************/

SETAPPL:
   hierchy=makelist();
   i=0;
   tmpvar=_blank_;


/************************************************************************/
/* During initial testing, you could hard code each of these values.    */
/************************************************************************/

   do until(tmpvar=' ');
      i=i+1;


/************************************************************************/
/* Load the drill hierarchy list.                                       */
/************************************************************************/

      tmpvar=scan(drillvar,i);
      if tmpvar ne ' ' then
      do;

         tmpdrill=dsname||'.'||tmpvar||'.'||'DRILL';
         hierchy =setnitemc(hierchy,put(i,1.),tmpdrill,1,i);
      end;
   end;

   columns=makelist();
   i=0;
   tmpvar=_blank_;


/************************************************************************/
/* Load the list of column variables.                                   */
/************************************************************************/

   do until(tmpvar=' ');
      i=i+1;
      tmpvar=scan(colnames,i);
      if tmpvar ne ' ' then columns=insertc(columns,tmpvar,-1);
   end;

   mlname = getnitemc(envlist('L'),'MLNAME');
   mbname = getnitemc(envlist('L'),'MBNAME');

   applist=setnitemc(applist,mlname,'MLNAME');
   applist=setnitemc(applist,mbname,'MBNAME');
   applist=setnitemc(applist,applname,'APPLNAME');
   applist=setnitemc(applist,descript,'DESCRIPT') ;
   applist=setnitemc(applist,dsname,'DSNAME') ;
   applist=setniteml(applist,hierchy,'HIERCHY') ;
   applist=setniteml(applist,columns,'COLUMNS') ;
   applist=setnitemc(applist,notes,'NOTES');
   applist=setnitemc(applist,chart,'CHART') ;
return;

TERM:
   %eisterm;    /* Omit this step during initial testing. */
   if dsid>0 then dsid=close(dsid);
return;




/********************************************************************/
/* This program creates a PMENU entry with options for the flexible */
/* report and graph application.                                    */
/*                                                                  */
/********************************************************************/

/************************************************************************/
/* Execute this code to create a PMENU entry to use as the Command Menu */
/* method for the object. Identify the entry as the Command Menu Method */
/* when you identify the object to the SAS/EIS Object Manager.          */
/************************************************************************/

proc pmenu c = libname.windows;

   menu repgrph;
      item 'Goback' selection=goback;
      item 'Drillup' selection=drillup;
      item 'Hierarchy' selection=hier;
      item 'Bookmark';
      item 'Notes';
      item 'Help';
      selection goback 'END';
      selection drillup 'DRILLUP';
      selection hier 'HIER';
run;


/****************************************************************/
/****************************************************************/
/* End of sample code for Chapter 5 in "Extending SAS/EIS       */
/* Software Capabilities."                                      */
/****************************************************************/
/****************************************************************/

