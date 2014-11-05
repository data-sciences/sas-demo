Chapter 07 of the book discusses only use of my JMP Scripts for "Local Control."

This folder contains 5 SAS Macros, 2 SAS datasets and 4 other files that implement and illustrate basically the
same functionality as my JMP Scripts.  I created these materials under contract to the Observational Medical
Outcomes Partnership (OMOP).  They are: Copyright (c) 2009, Foundation for the National Institutes of Health
(FNIH).  These materials are being (freely) distributed under the Apache 2.0 Licensing Agreement.

FileName            Contents of File
===============     =====================================================================================

lc_cluster.sas      SAS macro for hierarchical clustering (save dendrogram tree) in LC Phase One (EXPLORE) 
lc_ltddist.sas      SAS macro for calculating the LTD distribution when NCreq clusters are requested.
lc_ubtrace.sas      SAS macro for displaying UnBiasing TRACE (sensitivity) as number of clusters increases. 
lc_ncreq.sas        SAS macro for non-hierarchical clustering (fixed # clusters) in LC Phase One (EXPLORE) 
lc_salient.sas      SAS macro for generating the artificial LTD distribution: LC Phase_Two (CONFIRM) 

LCinSAS.pdf         PDF file of documentation for the "LC" SAS macros, example applications and references.

pci15k.sas7bdat     Simulated SAS UNIX dataset for 15,487 patients receiving one of two variations on PCI.
pcim15k.sas         Example application of the "LC" macros to the "mort6mo" binary outcome in PCI data. 
pcic15k.sas         Example application of the "LC" macros to the "cardcost" continuous outcome in PCI data.

statin1m.sas7bdat   Simulated SAS UNIX dataset for 1 million patients taking one 1 of 2 hypothetical statins.
statins.sas         Example application of "LC" non-hierarchical clustering to the "CVE" binary outcome.