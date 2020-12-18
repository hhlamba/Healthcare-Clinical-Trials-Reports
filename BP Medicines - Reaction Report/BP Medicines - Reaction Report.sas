PROC import DATAFILE="/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT2/CLINICAL2.xls"
DBMS=xls out= rep2 REPLACE;
run;

PROC SORT data = rep2 out=new(keep= Patient_id drug sex Visit_Date fever nausea rash);
by Patient_id drug  sex descending Visit_Date fever nausea rash;
run;

DATA new2(KEEP=Patient_id drug sex Reactionresult);
set new;
by Patient_id drug  sex descending Visit_Date;
if First.Patient_ID then do;
Reaction =0;
end;
Reaction+Fever+Nausea+Rash;
IF Reaction GT 0 then Reactionresult = "Yes"; ELSE Reactionresult="No";
If Last.Patient_ID Then output;
run;
ods html file= "/folders/myfolders/Projects/CLINICAL_BLOOD PRESSURE MED STUDY FOR ANASTASIA/REPORT2/Report_2_BPMS_Sb).html";
title italic "Blood Pressure Med Study - Summary (basic)";
PROC Report data = new2 style(Header)={background=#b0b0b0 Foreground=#264eab bordercolor=WHITE}
style(Column)={background=#d3d3d3 Foreground=#151515 bordercolor=WHITE}
style={background=#d3d3d3};
COLUMNS Patient_id drug sex Reactionresult;
DEFINE Patient_id / "Patient ID";
DEFINE drug / "Drugs Name";
DEFINE sex / "Sex";
DEFINE Reactionresult / "Reaction?";
run;
title;
ods html close;



