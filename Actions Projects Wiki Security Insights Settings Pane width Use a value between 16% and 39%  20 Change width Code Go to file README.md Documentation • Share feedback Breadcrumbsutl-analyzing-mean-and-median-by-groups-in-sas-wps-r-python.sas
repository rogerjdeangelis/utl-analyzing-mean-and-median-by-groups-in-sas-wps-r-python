%let pgm=utl-analyzing-mean-and-median-by-groups-in-sas-wps-r-python;

Analyzing mean and median by groups in sas wps r python

github
https://tinyurl.com/5c8ews9h
https://github.com/rogerjdeangelis/utl-analyzing-mean-and-median-by-groups-in-sas-wps-r-python

StackOverflow R
https://tinyurl.com/27nexvty
https://stackoverflow.com/questions/76230009/mean-and-median-by-groups-in-within-columns-in-r

    SOLUTIONS

         1. SAS proc sql
         2. WPS proc sql
         3. WOS oric R mutate cadidate
         4. SAS  R proc sql
         5. SAS Python sql

/*---- Dropped extraneous variables to simplify documentation ----*/
/*---- Does not affect the solutions                          ----*/

data sd1.have;informat
ID 8.
SCORE 8.
GROUP 8.
;input
ID SCORE GROUP;
cards4;
1 3.63 1
4 12.57 1
10 12.63 1
19 4.64 1
2 18.77 2
5 20.69 2
9 12.94 2
12 14.38 2
13 21.9 2
3 21.76 4
6 13.94 4
17 12.51 4
18 17.69 4
7 1.25 5
8 13.07 5
16 11.88 5
11 13.01 6
14 15.13 6
15 5.76 6
20 5.77 6
;;;;
run;quit;

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

 /**************************************************************************************************************************/
 /*                                                                                                                        */
 /* Sorted by group for documentation reasons only - solutions do not require                                              */
 /*                                                                                                                        */
 /* Up to 40 obs from last table WORK.HAVE total obs=20 12MAY2023:07:57:39                                                 */
 /*                                                                                                                        */
 /*                              |  Rules                                                                                  */
 /*                              |                                                                                         */
 /* Obs    ID    SCORE    GROUP  |  MEAN   MEDIAN                                                            CANDIDATE     */
 /*                              |                                                                                         */
 /*   1     1     3.63      1    |  8.3675  8.605           mean                median                                     */
 /*   2     4    12.57      1    |  8.3675  8.605  12.57 >= 8.3675 and 12.57 >= 8.605 so candidate=top           top       */
 /*   3    10    12.63      1    |  8.3675  8.605                                                                          */
 /*   4    19     4.64      1    |  8.3675  8.605                                                                          */
 /*                              |  Rules                                                                                  */
 /*                              |  score >= mean & score >= median ) then top                                             */
 /*                              |  score >= mean & score <  median ) then competitive                                     */
 /*   5     2    18.77      2    |                                    else weak end as candidate                           */
 /*   6     5    20.69      2    |                                                                                         */
 /*   7     9    12.94      2    |                                                                                         */
 /*   8    12    14.38      2    |                                                                                         */
 /*   9    13    21.90      2    |                                                                                         */
 /*  10     3    21.76      4    |                                                                                         */
 /*  11     6    13.94      4    |                                                                                         */
 /*  12    17    12.51      4    |                                                                                         */
 /*  13    18    17.69      4    |                                                                                         */
 /*  14     7     1.25      5    |                                                                                         */
 /*  15     8    13.07      5    |                                                                                         */
 /*  16    16    11.88      5    |                                                                                         */
 /*  17    11    13.01      6    |                                                                                         */
 /*  18    14    15.13      6    |                                                                                         */
 /*  19    15     5.76      6    |                                                                                         */
 /*  20    20     5.77      6    |                                                                                         */
 /*                                                                                                                        */
 /**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Up to 40 obs from last table WORK.WANT total obs=20 13MAY2023:13:37:55                                                 */
/*                                                                                                                        */
/* Obs    ID    GROUP    MEDIAN      MEAN     CANDIDATE                                                                   */
/*                                                                                                                        */
/*   1     1      1       8.605     8.3675      weak                                                                      */
/*   2     2      2      18.770    17.7360      top                                                                       */
/*   3     3      4      15.815    16.4750      top                                                                       */
/*   4     4      1       8.605     8.3675      top                                                                       */
/*   5     5      2      18.770    17.7360      top                                                                       */
/*   6     6      4      15.815    16.4750      weak                                                                      */
/*   7     7      5      11.880     8.7333      weak                                                                      */
/*   8     8      5      11.880     8.7333      top                                                                       */
/*   9     9      2      18.770    17.7360      weak                                                                      */
/*  10    10      1       8.605     8.3675      top                                                                       */
/*  11    11      6       9.390     9.9175      top                                                                       */
/*  12    12      2      18.770    17.7360      weak                                                                      */
/*  13    13      2      18.770    17.7360      top                                                                       */
/*  14    14      6       9.390     9.9175      top                                                                       */
/*  15    15      6       9.390     9.9175      weak                                                                      */
/*  16    16      5      11.880     8.7333      top                                                                       */
/*  17    17      4      15.815    16.4750      weak                                                                      */
/*  18    18      4      15.815    16.4750      top                                                                       */
/*  19    19      1       8.605     8.3675      weak                                                                      */
/*  20    20      6       9.390     9.9175      weak                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                               _
/ |    ___  __ _ ___   ___  __ _| |
| |   / __|/ _` / __| / __|/ _` | |
| |_  \__ \ (_| \__ \ \__ \ (_| | |
|_(_) |___/\__,_|___/ |___/\__, |_|
                              |_|
*/

proc datasets lib=work nodetails nolist mt=view mt=data;
  delete want;
run;quit;

proc sql;
  create
     table want as
  select
     id
    ,group
    ,median(score) as median
    ,mean(score)   as mean
    ,case
       when ( score >= calculated mean & score >= calculated median ) then "top        "
       when ( score >= calculated mean & score <  calculated median ) then "competitive"
                                                                      else "weak       "
       end as candidate
  from
     sd1.have
  group
     by group
  order
     by id
;quit;

/*___                                     _
|___ \    __      ___ __  ___   ___  __ _| |
  __) |   \ \ /\ / / `_ \/ __| / __|/ _` | |
 / __/ _   \ V  V /| |_) \__ \ \__ \ (_| | |
|_____(_)   \_/\_/ | .__/|___/ |___/\__, |_|
                   |_|                 |_|
*/

%utl_submit_wps64('
libname sd1 "d:/sd1";
options validvarname=upcase;
proc sql;
  create
     table want as
  select
     id
    ,group
    ,median(score) as MID
    ,mean(score)   as AVG
    ,case
       when ( score >= calculated avg & score >= calculated mid ) then "top        "
       when ( score >= calculated avg & score <  calculated mid ) then "competitive"
                             else "weak       "
       end as CANDIDATE
  from
     sd1.have
  group
     by group
  order
     by id
;quit;
proc print;
run;quit;
');

/**************************************************************************************************************************/
/*                                                                                                                        */
/* The WPS System                                                                                                         */
/*                                                                                                                        */
/* Obs    ID    GROUP    MEDIAN      MEAN     CANDIDATE                                                                   */
/*                                                                                                                        */
/*   1     1      1       8.605     8.3675      weak                                                                      */
/*   2     2      2      18.770    17.7360      top                                                                       */
/*   3     3      4      15.815    16.4750      top                                                                       */
/*   4     4      1       8.605     8.3675      top                                                                       */
/*   5     5      2      18.770    17.7360      top                                                                       */
/*   6     6      4      15.815    16.4750      weak                                                                      */
/*   7     7      5      11.880     8.7333      weak                                                                      */
/*   8     8      5      11.880     8.7333      top                                                                       */
/*   9     9      2      18.770    17.7360      weak                                                                      */
/*  10    10      1       8.605     8.3675      top                                                                       */
/*  11    11      6       9.390     9.9175      top                                                                       */
/*  12    12      2      18.770    17.7360      weak                                                                      */
/*  13    13      2      18.770    17.7360      top                                                                       */
/*  14    14      6       9.390     9.9175      top                                                                       */
/*  15    15      6       9.390     9.9175      weak                                                                      */
/*  16    16      5      11.880     8.7333      top                                                                       */
/*  17    17      4      15.815    16.4750      weak                                                                      */
/*  18    18      4      15.815    16.4750      top                                                                       */
/*  19    19      1       8.605     8.3675      weak                                                                      */
/*  20    20      6       9.390     9.9175      weak                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                                                _        _
|___ /   __      ___ __  ___   _ __   _ __ ___  _   _| |_ __ _| |_ ___
  |_ \   \ \ /\ / / `_ \/ __| | `__| | `_ ` _ \| | | | __/ _` | __/ _ \
 ___) |   \ V  V /| |_) \__ \ | |    | | | | | | |_| | || (_| | ||  __/
|____(_)   \_/\_/ | .__/|___/ |_|    |_| |_| |_|\__,_|\__\__,_|\__\___|
                  |_|
*/

proc datasets lib=work nodetails nolist mt=view mt=data;
  delete want_r;
run;quit;

%utl_submit_wps64('

libname sd1 "d:/sd1";

proc r;
export data=sd1.have r=have;
submit;
library(dplyr);
want_r <- have %>%
  mutate(mean_score = mean(SCORE, na.rm = TRUE),
         median_score = median(SCORE, na.rm = TRUE),
         candidate = case_when(SCORE >= mean_score & SCORE >= median_score ~ "top",
                               SCORE >= mean_score & SCORE <  median_score ~ "competitive",
                               TRUE ~ "weak"


   ), .by=GROUP);
want_r;
endsubmit;
import data=sd1.want_r r=want_r;
run;quit;
');

proc print data=sd1.want_r;
run;quit;

/*---- this soltion provides long variable names in sas ----*/

/*  _                                       _
| || |     ___  __ _ ___   _ __   ___  __ _| |
| || |_   / __|/ _` / __| | `__| / __|/ _` | |
|__   _|  \__ \ (_| \__ \ | |    \__ \ (_| | |
   |_|(_) |___/\__,_|___/ |_|    |___/\__, |_|
                                         |_|
*/

%utlfkil(d:/xpt/want.xpt);

proc datasets lib=work nodetails nolist mt=data mt=view;
 delete want ;
run;quit;


%utl_submit_r64('
library(haven);
library(SASxport);
library(sqldf);
library(Hmisc);
have<-read_sas("d:/sd1/have.sas7bdat");
colnames(have)[colnames(have)=="GROUP"] <- "GRP";
have;
want<-sqldf("
  select
     l.id
    ,score
    ,r.mid as median_score
    ,r.avg as mean_score
    ,l.grp
    ,case
       when ( l.score >= r.avg and l.score >= r.mid ) then \"top\"
       when ( l.score >= r.avg and l.score <  r.mid ) then \"competitive\"
        else \"weak\"
       end as candidate
  from
      have as l left join (
         select
            id
           ,grp
           ,avg(score)    as avg
           ,median(score) as mid
         from
            have
         group
            by grp
         ) as r
  on
     l.grp = r.grp
  order
     by l.id
  ;
  ");
for (i in seq_along(want)) {
          label(want[,i])<- colnames(want)[i];
    };
want;
str(want);
write.xport(want,file="d:/xpt/want.xpt");
');

libname xpt xport "d:/xpt/want.xpt";
proc contents data=xpt._all_;
run;quit;

data want_r_long_names;
  %utl_rens(xpt.want) ;
  set want;
run;quit;
libname xpt clear;

proc print data=want_r_long_names width=min;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Up to 40 obs from SD1.HAVE_UNSORT total obs=20 12MAY2023:08:5                                                         */
/*                                                                                                                        */
/*  LABELS HAVE THE LONG VATRIABLE NAMES                                                                                  */
/*                                                                                                                        */
/*   Alphabetic List of Variables and Attributes                                                                          */
/*                                                                                                                        */
/*  #    Variable    Type    Len    Label                                                                                 */
/*                                                                                                                        */
/*  5    CANDIDAT    Char      4    candidate                                                                             */
/*  1    ID          Num       8    ID                                                                                    */
/*  4    MEAN_SCO    Num       8    mean_score                                                                            */
/*  3    MEDIAN_S    Num       8    median_score                                                                          */
/*  2    SCORE       Num       8    SCORE                                                                                 */
/*                                                                                                                        */
/*  HAS LONG VARIABLE NAMES (I the label has an issue with special charaters the copy contets output and paste            */
/*                                                                                                                        */
/*  Up to 40 obs from WANT_R_LONG_NAMES total obs=20 12MAY2023:09:48:26                                                   */
/*                        MEDIAN_     MEAN_                                                                               */
/*  Obs    ID    SCORE     SCORE      SCORE     CANDIDATE                                                                 */
/*                                                                                                                        */
/*    1     1     3.63      8.605     8.3675      weak                                                                    */
/*    2     2    18.77     18.770    17.7360      top                                                                     */
/*    3     3    21.76     15.815    16.4750      top                                                                     */
/*    4     4    12.57      8.605     8.3675      top                                                                     */
/*    5     5    20.69     18.770    17.7360      top                                                                     */
/*    6     6    13.94     15.815    16.4750      weak                                                                    */
/*    7     7     1.25     11.880     8.7333      weak                                                                    */
/*    8     8    13.07     11.880     8.7333      top                                                                     */
/*    9     9    12.94     18.770    17.7360      weak                                                                    */
/*   10    10    12.63      8.605     8.3675      top                                                                     */
/*   11    11    13.01      9.390     9.9175      top                                                                     */
/*   12    12    14.38     18.770    17.7360      weak                                                                    */
/*   13    13    21.90     18.770    17.7360      top                                                                     */
/*   14    14    15.13      9.390     9.9175      top                                                                     */
/*   15    15     5.76      9.390     9.9175      weak                                                                    */
/*   16    16    11.88     11.880     8.7333      top                                                                     */
/*   17    17    12.51     15.815    16.4750      weak                                                                    */
/*   18    18    17.69     15.815    16.4750      top                                                                     */
/*   19    19     4.64      8.605     8.3675      weak                                                                    */
/*   20    20     5.77      9.390     9.9175      weak                                                                    */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*___                 _   _
| ___|    _ __  _   _| |_| |__   ___  _ __    _ __
|___ \   | `_ \| | | | __| `_ \ / _ \| `_ \  | `__|
 ___) |  | |_) | |_| | |_| | | | (_) | | | | | |
|____(_) | .__/ \__, |\__|_| |_|\___/|_| |_| |_|
         |_|    |___/
*/

proc datasets lib=work kill nodetails nolist;
run;quit;

%utlfkil(d:/xpt/res.xpt);

%utl_pybegin;
parmcards4;
from os import path
import pandas as pd
import xport
import xport.v56
import pyreadstat
import numpy as np
import pandas as pd
from pandasql import sqldf
mysql = lambda q: sqldf(q, globals())
from pandasql import PandaSQL
pdsql = PandaSQL(persist=True)
sqlite3conn = next(pdsql.conn.gen).connection.connection
sqlite3conn.enable_load_extension(True)
sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll')
mysql = lambda q: sqldf(q, globals())
have, meta = pyreadstat.read_sas7bdat("d:/sd1/have_unsort.sas7bdat")
df =pdsql("""
  select
     l.id
    ,score
    ,r.mid as median_score
    ,r.avg as mean_score
    ,case
       when ( l.score >= r.avg and l.score >= r.mid ) then \"top\"
       when ( l.score >= r.avg and l.score <  r.mid ) then \"competitive\"
        else \"weak\"
       end as candidate
  from
      have as l left join (
         select
            id
           ,grp
           ,avg(score)    as avg
           ,median(score) as mid
         from
            have
         group
            by grp
         ) as r
  on
     l.grp = r.grp
  ;
""")

lbl = list(df.columns.values)
df  = df.rename(columns={k: k.upper()[:8] for k in df});
print(lbl);
print(df);
ds = xport.Dataset(df, name='want')
idx=-1;
for k, v in ds.items():
    idx=idx+1
    print(idx)
    v.label = lbl[idx]
print(ds)
library = xport.Library({'want': ds})
with open('d:/xpt/want.xpt', 'wb') as f:
    xport.v56.dump(library, f)
;;;;
%utl_pyend;

libname xpt xport "d:/xpt/want.xpt";
ods output variables=namLbl;
proc contents data=xpt._all_;
run;quit;

%array(_var _lbl,data=namLbl,var=variable label);

%put &_var1;
%put &_varn;

%put &_lbl1;
%put &_lbln;

proc print data=xpt.want;
run;quit;

data want_r_long_names; /*---- cannot use name want because a view named want exists ----*/
  label
     %do_over(_var _lbl,phrase=%str(?_lbl = "?_var"))
  ;
  %utl_rens(xpt.want) ;
  set want;
run;quit;

/*---- if you want the generated code ----*/
%utlnopts;
data _null_;
%do_over(_var _lbl,phrase=%str(put "?_lbl = '?_var'";))
;run;quit;
%utlopts;

proc print data=want_r_long_names;
run;quit;

/*---- SEQUENCE_BY_10_UNITS = 'SEQUENCE'   ----*/
/*---- STUDENTS_IN_MATH_CLASS = 'STUDENTS' ----*/

%arraydelete(_var);
%arraydelete(_lbl);

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
