Chapter 07 of the book illustrates and discusses use of my JMP Scripts for "Local Control."
This folder contains my 2 JMP Scripts, the dataset analyzed in Chapter 7 plus other useful files.

FileName            Contents of File
===============     =====================================================================================
 
LocalControl.JSL    JMP Script for hierarchical clustering: Local Control Phase One (EXPLORE) 
aLTD SIM.JSL        JMP Script for generating the artificial LTD distribution: LC Phase_Two (CONFIRM) 

LCinJMP.pdf         PDF file of information on adding JMP menu items to execute my JMP Scripts.
LC.BMP              JMP menu "LC" Icon (optional)			

lsim10k.jmp         Simulated JMP dataset for 10,325 patients receiving a PCI with or without a hypothetical
                    blood thinner.

More JMP Datasets   Subfolder...

    AFV1314.JMP     Dataset used by Appleton, French and Vanderpump(1996) on smoking and 20-year-mortality
                    for 1,314 Whickham women.  The only available X-covariate is age_decade (20 to 80) at the
                    time of the original 1972-1974 survey.

    AFVbubble.JMP   JMP dataset with a built-in script to produce a "Bubble Plot" showing the location (avg
                    age vs avg mortality) and size (area of bubble) for between 1 and 7 clusters of patients
                    ...where cluster color (Red-Gray-Blue) denotes the numerical sign of the mortality LTD:
                    Red=>negative LTD=>smoking is protective; Blue=>positive LTD=>non-smoking is protective.

    lsim5k.jmp      Simulated dataset for 5,162 additional patients receiving a PCI with or without a
                    hypothetical blood thinner.  These data can be used as a hold-out sample when comparing
                    models and predictions derived from the lsim10k.jmp data ...or they can be merged with
                    the lsim10k.jmp data to produce a sample of 15,487 patients.

    Lindner.jmp     The original Lindner abciximab dataset of 996 patients analyzed by Kereiakes, Obenchain,
                    Barber, et al. (2000) using propensity score binning (5 strata.)

    LsimBubl.JMP    JMP 8 dataset with a built-in script to produce a "Bubble Plot" showing the location (avg
                    ejfract vs avg height) and size (area of bubble) for between 1 and 900 clusters of patients
                    ...where cluster color (Red-Gray-Blue or Black) denotes the numerical sign of the LTD for
                    either mort6mo or cardcost: Red=> blood thinner increases mortailty or cost; Blue=> blood
                    thinner refuces mortality or cost; Black=> cluster is un-informative about the LTD.