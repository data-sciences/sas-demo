These instructions describe how to install the data and programs 
that are associated with the book
     Wicklin, R. (2010),
     Statistical Programming with SAS/IML Software,
     Cary, NC: SAS Press.

The data and programs are contained in a Zip file.
The following steps unpack the Zip file so that the 
data and programs can be easily used in SAS/IML Studio:


1. Put the Zip file in the SAS/IML Studio "Personal Files Directory" (PFD).

   To determine the PFD:
      a.  Type the following statements into a SAS/IML Studio program window.

         run GetPersonalFilesDirectory( path );
         print path;

      b. Select  Program-->Run  from the main menu to run the program.

   By default, the PFD corresponds to one of the following Windows directories:
 
   Windows XP       C:\Documents and Settings\<userid>\My Documents\My IML Studio Files 
   Windows Vista    C:\Users\<userid>\Documents\My IML Studio Files 
   Windows 7        C:\Users\<userid>\Documents\My IML Studio Files


2. Extract the contents of the Zip file into the PFD.

   Data sets are extracted to the "Data Sets" folder.
   IMLPlus modules are extracted to the "Modules" folder.
   IMLPlus programs are extracted to the "SPI Programs" folder.
   PROC IML programs are extracted to the "SPI Proc IML Programs" folder.


3. Determine whether you have SAS/IML 9.22 or later.  (This information
   will be used in Step 5b.) The easiest way to determine this is to 
   attempt to run a function that was introduced in SAS/IML 9.22.
      a. Run the following statements in SAS or SAS/IML Studio:

         proc iml;
         call qntl(q, ranuni(j(10,2)));  /* QNTL function exists in 9.22 */

      b. If you get an error (ERROR: Invocation of unresolved module QNTL),
         then you are NOT running SAS/IML 9.22 or later.
 
      c. If the statements execute without error, you are running
         SAS/IML 9.22 or later.


4. Determine whether your copy of SAS/IML Studio is connected to a
   local or a remote SAS Workspace Server. To do this:
      a. Launch SAS/IML Studio and select Tools-->Options.
      b. Click the Server tab on the Options dialog box.

   If the selected server is "My SAS Server," SAS/IML Studio is
      connected to a LOCAL SAS server; proceed to Step 5.
   Otherwise, SAS/IML Studio is connected to a REMOTE server; proceed
      to Step 6.
   

5. Install Data for Local SAS Workspace Server.

   a. To install the data sets on the PC that is running SAS/IML Studio,
      run the program named "SPI_LocalInstallData.sx" that is located
      in the "SPI Programs" folder.

   b. If you are running SAS/IML 9.22 or later (see Step 3), you are done.
      Otherwise, add a new directory to your module search path:
         i.   In SAS/IML Studio, select Tools-->Options.
	 ii.  Click the Directories tab.
	 iii. Make sure the tab is displaying directories for Modules.
	 iv.  Click Add.
	 v.   Browse to the PFD (see Step 1) and click Modules-->Pre9.22
	 vi.  Click OK, which adds <PFD>/Modules/Pre9.22 to your search path.


6. Install Data for Remote SAS Workspace Servers.

   Install the sample data in a SAS library on the server that you
   want to use to run the examples in the book.

      a. Ask your site administrator to use the SAS Management Console to
         set up a library named SPI in which you can store the book's
         data sets.

      b. Make sure that SAS/IML Studio can see the SPI directory:
         select File-->Open-->Server Data Set
         and browse to the SPI library.

      c. Run the program named "SPI_RemoteInstallData.sx" that is located
         in the "SPI Programs" folder.

      d. Complete Step 5b.
