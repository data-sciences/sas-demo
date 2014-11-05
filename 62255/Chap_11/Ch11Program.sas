Example 11.1  Creating an Information Map with PROC INFOMAPS

%MACRO mapper(libname=,table=,mapname=);

PROC INFOMAPS
METAUSER="&userid"
METAPASS="&pw"
METAPORT=8561
METASERVER="&host"
METAREPOSITORY=Foundation
MAPPATH="&infomap_path”;

%* create new map from SAS data source;
NEW INFOMAP "&mapname" AUTO_REPLACE=YES;

%* add all of the variables in the table to the map;
INSERT DATASOURCE SASSERVER="SASApp"
TABLE="&libname"."&table" _ALL_;

%* don''t forget to save the resulting map;
SAVE;
RUN;

%MEND mapper;


 
Example 11.2  Creating Cubes with PROC OLAP

/********    Uncomment this code if you want to delete the cube 
OPTIONS VALIDVARNAME=ANY;

PROC OLAP
CUBE           = "/Shared Data/Cubes/shoes" DELETE;

METASVR
HOST        = "hrothgar"
PORT        = 8561
OLAP_SCHEMA = "SASApp - OLAP Schema";
RUN;
********    end of code comment block    ********/

OPTIONS VALIDVARNAME=ANY;

libname sashelp list;
PROC OLAP
CUBE                   = "/Shared Data/Shoes"
DATA                   = data.SHOES
DRILLTHROUGH_TABLE     = data.SHOES
PATH                   = '/export/home/sas/Data'
DESCRIPTION            = 'Shoe sales cube';
METASVR
HOST        = "hrothgar"
PORT        = 8561
OLAP_SCHEMA = "SASApp - OLAP Schema";

DIMENSION Area
CAPTION          = 'Region\Subsidiary'
SORT_ORDER       = ASCENDING
HIERARCHIES      = ( Area ) /* HIERARCHIES */;

HIERARCHY Area 
ALL_MEMBER = 'All Area'
CAPTION    = 'Area'
LEVELS     = ( Region Subsidiary ) /* LEVELS */
DEFAULT;

LEVEL Region
CAPTION        =  'Region'
SORT_ORDER     =  ASCENDING;

LEVEL Subsidiary
CAPTION        =  'Subsidiary'
SORT_ORDER     =  ASCENDING;

DIMENSION Product_type
CAPTION          = 'Product Type'
SORT_ORDER       = ASCENDING
HIERARCHIES      = ( Product_type ) /* HIERARCHIES */;

HIERARCHY Product_type 
ALL_MEMBER = 'All Product_type'
CAPTION    = 'Product Type'
LEVELS     = ( Product ) /* LEVELS */
DEFAULT;

LEVEL Product
CAPTION        =  'Product'
SORT_ORDER     =  ASCENDING;

MEASURE Stores
STAT        = SUM
COLUMN      = Stores
CAPTION     = 'Sum of Stores'
DEFAULT;

MEASURE Sales
STAT        = SUM
COLUMN      = Sales
CAPTION     = 'Sum of Sales'
FORMAT      = DOLLAR12.;

MEASURE Returns
STAT        = SUM
COLUMN      = Returns
CAPTION     = 'Sum of Returns'
FORMAT      = DOLLAR12.;

MEASURE Inventory
STAT        = SUM
COLUMN      = Inventory
CAPTION     = 'Sum of Inventory'
FORMAT      = DOLLAR12.;

AGGREGATION /* Default */
/* levels */
Region Subsidiary Product 
/* options */
/NAME      = 'Default';

RUN;


 
Example 11.3  Replacing a Cube with PROC OLAP

%macro METASVR;
METASVR HOST="&host" PORT=8561
OLAP_SCHEMA="SASApp - OLAP Schema";
%mend;

%let CUBE = “/Shared Data/Cubes/shoes”;

options validvarname=any;
libname SASHELP list;

proc olap cube = &CUBE delete_physical;
%METASVR	
run;

proc olap cube = &CUBE;
%METASVR	
run;

