***********************************************************************************
Example Dataset:  15,487 PCI patients with or without a hypothetical blood thinner.
Local Control Phase One:  Invoke macro "LC_Cluster, then make a sequence of calls
to "LC_LTDdist” for LC_Yvar = mort6mo and increasing numbers of clusters.
Finally, finish LC Phase One by invoking macro “LC_UBtrace.
Local Control Phase Two:  Invoke macro "LC_Salient" for NCreq = 1200.
***********************************************************************************;
***	Copyright (c) 2009 Foundation for the National Institutes of Health (FNIH).
***********************************************************************************;

LIBNAME pcidata  "/omop_home/bobenchain/dev";
OPTIONS sasautos = ("/omop_home/bobenchain/dev/SAS" sasautos) mautosource;

*** Local Control Phase One (EXPLORE) **********;

%LC_Cluster(LC_Path = pcidata, LC_YTXdata = pci15k, LC_Tree = pcitree, LC_ClusMeth = ward,
          LC_Stand = STD, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id)

%LC_LTDdist(NCreq = 1, LC_LTDtable = pcimtab3h, LC_LTDoutput = pcimout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

*** Overwrite pcimtab3h and pcimout3h permanent datasets until NCreq reaches 300 *****;

%LC_LTDdist(NCreq = 10, LC_LTDtable = pcimtab3h, LC_LTDoutput = pcimout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 50, LC_LTDtable = pcimtab3h, LC_LTDoutput = pcimout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 100, LC_LTDtable = pcimtab3h, LC_LTDoutput = pcimout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 300, LC_LTDtable = pcimtab3h, LC_LTDoutput = pcimout3h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 600, LC_LTDtable = pcimtab6h, LC_LTDoutput = pcimout6h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 900, LC_LTDtable = pcimtab9h, LC_LTDoutput = pcimout9h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_LTDdist(NCreq = 1200, LC_LTDtable = pcimtab12h, LC_LTDoutput = pcimout12h,
          LC_Path = pcidata, LC_Tree = pcitree, LC_YTXdata = pci15k, LC_Yvar = mort6mo,
          LC_T01var = trtm, LC_Xvars = stent height female diabetic acutemi ejfract ves1proc,
          LC_PatID = sequen_id, LC_UnBias = pcimubtr)

%LC_UBtrace(LC_Path = pcidata, LC_UnBias = pcimubtr, LC_swidth = 2.0,
          LC_pdftrace = "/omop_home/bobenchain/dev/pcimtrace.pdf")

*** Local Control Phase Two (CONFIRM) **********;

%LC_Salient(LC_Path = pcidata, LC_LTDoutput = pcimout12h, LC_Yvar = mort6mo, LC_T01var = trtm, 
          LC_aLTDreps = 25, LC_seed = 1234567, LC_aLTDdist = pcimaltd12h, NCinform = 1112,
          LC_pdfaltdd = "/omop_home/bobenchain/dev/pcimaltdd.pdf")

********************* END *********************************************************;