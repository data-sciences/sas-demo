/* =============================================================*/
PROC OLAPOPERATE;
CONNECT USERID="sasadm@saspw" PW="xxxxxx" HOST="hostname" PORT=5451;
    DISABLE CUBE "/Projects/Cubes/Candy_Sales";
    ENABLE CUBE "/Projects/Cubes/Candy_Sales";
RUN;
/* ===================================================== */
