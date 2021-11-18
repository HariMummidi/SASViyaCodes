data _null_;
firstper = find("&dataset",".",1); /* Get position of first period in input string */
call symputx("table",substr(trim(left("&dataset")),firstper+1)); /* extract the table name from the lib.table string */
run;

* Starting new cas session;

cas localSession sessopts=(caslib="&caslib" timeout=1800 locale="en_US");

* Removing the in-memory table "tableName" from "sourceCaslib";

proc casutil;
    droptable casdata="&table" quiet;
run;
quit;

* Load the sas data set from Base engine Library (library.tableName) into;
* specified caslib ("myCaslib") and save as "targetTableName";

proc casutil;
load data=&dataset casout="&table" promote;
run;
quit;


* Terminating the cas session;

cas localSession terminate;
