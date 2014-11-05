***********************************************************************************
Example Dataset:  15,487 PCI patients with or without a hypothetical blood thinner.
Local Control Phase One:  Invoke macro "LC_Cluster, then make a sequence of calls
to "LC_LTDdist” for LC_Yvar = cardcost and increasing numbers of clusters.
Finally, finish LC Phase One by invoking macro “LC_UBtrace.
Local Control Phase Two:  Invoke macro "LC_Salient" for NCreq = 1200.
***********************************************************************************;
***	Copyright (c) 2009 Foundation for the National Institutes of Health (FNIH).
***********************************************************************************;

LIBNAME pcidata "/omop_home/bobenchain/dev";
OPTIONS sasautos = ("/omop_home/bobenchain/dev/SAS" sasautos) mautosource;

*** Local Control Phase One (EXPLORE) **********;

*** Assuming the LC Clustering Tree has already been computed for analysis of the "mort6mo"
*** outcome, there is no need to invoke LC_Cluster again for analysis of the "cardcost" outcome.
/*
%LC_Cluster(LC_Path = pcidata, LC_YTXdata = pci15k, LC_Tree = pcitree, LC_ClusMeth = ward,
          LC_Stand = STD, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id)
*/

%LC_LTDdist(NCreq = 1, LC_LTDtable = pcictab3h, LC_LTDoutput = pcicout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

*** Overwrite pcictab3h and pcicout3h permanent datasets until NCreq reaches 300 *****;

%LC_LTDdist(NCreq = 10, LC_LTDtable = pcictab3h, LC_LTDoutput = pcicout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 50, LC_LTDtable = pcictab3h, LC_LTDoutput = pcicout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 100, LC_LTDtable = pcictab3h, LC_LTDoutput = pcicout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 300, LC_LTDtable = pcictab3h, LC_LTDoutput = pcicout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 600, LC_LTDtable = pcictab6h, LC_LTDoutput = pcicout6h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 900, LC_LTDtable = pcictab9h, LC_LTDoutput = pcicout9h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_LTDdist(NCreq = 1200, LC_LTDtable = pcictab12h, LC_LTDoutput = pcicout12h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = cardcost,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcicubtr)

%LC_UBtrace(LC_Path = pcidata, LC_UnBias = pcicubtr, LC_swidth = 2.0,
          LC_pdftrace = "/omop_home/bobenchain/dev/pcictrace.pdf")

*** Local Control Phase Two (CONFIRM) **********;

%LC_Salient(LC_Path = pcidata, LC_LTDoutput = pcicout12h, LC_Yvar = cardcost, LC_T01var = trtm, 
          LC_aLTDreps = 25, LC_seed = 1234567, LC_aLTDdist = pcicaltd12h, NCinform = 1112,
          LC_pdfaltdd = "/omop_home/bobenchain/dev/pcicaltdd.pdf")

********************* END *********************************************************;