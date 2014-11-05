* E13_4_1.sas
* Establishing the autocall library;

filename mymacs "<phys path to my macro definitions>";
filename prjmacs "<phys path to the project macro definitions>";
filename COmacs "<phys path to the company wide macro definitions>";
options mautosource
        sasautos=(mymacs prjmacs comacs sasautos);
