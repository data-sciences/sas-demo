*E14_4_5.sas
*
* Delete work data;
* included from an icon on the editor tool bar;
proc datasets library=work 
                memtype=data
                kill
                nolist;
   quit;
