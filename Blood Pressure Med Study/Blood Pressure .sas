proc IMPORT datafile="/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT1/CLINICAL1.xls"
DBMS=xls out=rep1 REPLACE;
Run;

PROC sort data=work.rep1 out = new;
by Patient_ID  VISIT_DATE;
run;

ods pdf file="/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT1/BPMS.pdf";
title italic "Blood Pressure Med Study";
proc Report data= new style(Header)={background=#b0b0b0 Foreground=#264eab bordercolor=WHITE}
style(Column)={background=#d3d3d3 Foreground=#151515 bordercolor=WHITE}
style={background=#d3d3d3};
COLUMNS Patient_Id  DRUG SEX VISIT_DATE SYSTOLIC DIASTOLIC FEVER NAUSEA RASH;
DEFINE Patient_Id /"Patient ID" group;
DEFINE DRUG / "Drug Name"  group;
DEFINE SEX / "Gender" group;
DEFINE VISIT_DATE / "Visit Date" FORMAT=WORDDATE.;
DEFINE SYSTOLIC / "Systolic";
DEFINE DIASTOLIC / "Diastolic";
DEFINE FEVER / "Fever";
DEFINE NAUSEA / "Nausea";
DEFINE RASH / "Rash";
Run;
title;
ods pdf close;

