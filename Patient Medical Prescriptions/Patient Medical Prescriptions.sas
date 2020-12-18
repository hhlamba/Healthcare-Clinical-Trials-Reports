PROC import DATAFILE="/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT3/CLINICAL3.xls"
DBMS=xls out= rep3 REPLACE;

run;


PROC Sort data = rep3 out=new(Keep=Patient_Id Drug Sex Visit_Date Systolic Diastolic Fever Nausea Rash) ;
by _ALL_ ;
run;

DATA new;
set new;
Slash = "/";
run;

OPTIONS NOBYLINE;
ods HTML FILE ="/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT3/Report_3_BPMS_Db.html";
ods NOPROCTITLE;
title italic "Blood Pressure Med Study - Detail (basic)";
Proc Report data = new style(Header)={background=#b0b0b0 Foreground=#0033AA bordercolor=WHITE}
style(Column)={background=#d3d3d3 Foreground=#151515 bordercolor=WHITE} NOWD;
COLUMNS Patient_Id Drug SEX Visit_Date ("Blood Pressure" Systolic slash Diastolic) Fever Nausea Rash;
BY Patient_Id  ;
DEFINE Patient_Id / group "Patient_ID"  ;
DEFINE Drug / group "Drug";
DEFINE SEX / group "Gender";
DEFINE Visit_Date /  "Visit Date";
DEFINE Systolic / "Systolic";
DEFINE slash / "" ;
DEFINE Diastolic / "Diastolic";
DEFINE Fever / "Fever";
DEFINE Nausea / "Nausea";
DEFINE Rash / "Rash";
run;
title;
ods proctitle ON;
ods HTML Close;