***********************************************************************************
Example Dataset:  One million patients taking one of two hypothetical statins.  Because
all 7 patient X-characteristics are binary, at most 128 distinct clusters are possible.
Local Control Phase One:  Invoke macro "LC_NCreq" for non-hierarchical K-means clustering.
Local Control Phase Two:  Invoke macro "LC_Salient"
***********************************************************************************;
***	Copyright (c) 2009 Foundation for the National Institutes of Health (FNIH).
***********************************************************************************;

LIBNAME st1mdata "/omop_home/bobenchain/dev";
OPTIONS sasautos = ("/omop_home/bobenchain/dev/SAS" sasautos) mautosource;

%LC_NCreq(LC_Path = st1mdata, LC_YTXdata = statin1m, LC_LTDoutput = st1mout, LC_T01var = TRTM,
          LC_Yvar = CVE, LC_Xvars = AGE60 FEMALE HYPN DIAB APLAT CVPR MIPR,
          LC_LTDtable = st1mtab, LC_Unbias = st1mubtr, NCreq = 128)

proc print data = st1mdata.st1mubtr;
  title "LC Summary Statistics";
run;

%LC_Salient(LC_Path = st1mdata, LC_LTDoutput = st1mout, LC_T01var = TRTM, LC_Yvar = CVE, 
          LC_aLTDreps = 5, LC_seed = 33, LC_aLTDdist = st1maltd94, NCinform = 94,
          LC_pdfaltdd = "/omop_home/bobenchain/dev/st1maltdd.pdf")

********************* END *********************************************************;
