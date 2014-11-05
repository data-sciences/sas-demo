*-------------------------------------------------------------------;
* Run the OpenCDISC Validator in batch mode;
*  SOURCES= Path of the directory that contains the SAS datasets
*  OpenCDISCPath= Path of the local OpenCDISC Validator installation 
*  ValidatorJAR= Subdirectory and name of the JAR file 
*  FILES= Defaults to all .xpt files in the directory. Alternatively,
*           one specific file could be specified or a wildcard could
*           be used on a partial name (e.g. LB*.xpt)
*  CONFIG= Name of the configuration file to be used for validation.
*           Should correspond to one of the files in the CONFIG 
*           sub-directory.
*  DEFINE= Y, y, or 1 all mean a DEFINE.XML file exists for cross-
*          validation
*-------------------------------------------------------------------;
%macro run_opencdisc(sources= ,
                     opencdiscpath=c:\software\opencdisc-validator\v1-3,
                     validatorjar=lib\validator-cli-1.3.jar,
                     files=*.xpt,
                     config=config-sdtm-3.1.2-amend-1.xml,
                     define=Y
                     );
                     
        ** set the appropriate system options;
        options symbolgen xsync noxwait ;
        %let config=&opencdiscpath\config\&config;                     
                             
        ** specify the output report path;
        %let reportpath=&sources;                                                            
        
        ** specify the name(s) of the validation report;
        %if %index(%upcase(&config),SDTM)>0 %then
          %let reportfile=sdtm-validation-report-&sysdate.T%sysfunc(tranwrd(&systime,:,-)).xls;
        %else %if %index(%upcase(&config),ADAM)>0 %then
          %let reportfile=adam-validation-report-&sysdate.T%sysfunc(tranwrd(&systime,:,-)).xls;
        %else
          %let reportfile=opencdisc-validation-report-&sysdate.T%sysfunc(tranwrd(&systime,:,-)).xls;
        ;
        
        %if &define=Y or &define=y or &define=1 %then
          %let config_define=%str(-config:define="&sources\define.xml");
        %else
          %let config_define= ;
        ;
        
        %put submitting command: ;
        %put java -jar "&opencdiscpath\&validatorjar" -source="&sources\&files" -config="&config" 
          &config_define -report="&reportpath\&reportfile" -report:overwrite="yes" ;
          
        * run the report;
        x java -jar "&opencdiscpath\&validatorjar" -source="&sources\&files" -config="&config" 
          &config_define -report="&reportpath\&reportfile" -report:overwrite="yes" ;


%mend run_opencdisc;
