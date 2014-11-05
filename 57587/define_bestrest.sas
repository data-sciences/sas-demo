libname _data_"c:\my data\decision trees\_data_";
libname library "c:\my data\decision trees\formats";

data trees.bestrest;
set _data_.best_;
run;


proc format;
value $freq
'A' = '15+  '
'B' = '11-14'
'C' = ' 8-10'
'D' =  '5-7'
'E' = '4'
'F' = '5'
'G' = '2'
'H' = '1'
'I' = '0'
;
RUN;

proc format;
value $Money
'A' = '5000+'
'B' = '3000-4999'
'C' = '2000-2999'
'D' = '1500-1999'
'E' = '1000-1499'
'F' = '900-999'
'G' = '750-899'
'H' = '500-749'
'I' = '400-499'
'J' = '300-399'
'K' = '200-299'
'L' = '150-199'
'M' = '100-149'
'N' = '75-99'
'O' = '50-74'
'P' = '25-49'
'Q' = '0-24'
'R' = '-1'
;
RUN;

proc format;
value occup
0 = 'Self employ'
1 = 'Professional'
2 = 'Admin/Manage'
3 = 'Sales/Service'
4 = 'Clerical/White'
5 = 'Crafts/Blue'
6 = 'Student'
7 = 'Hsewife/Husband'
8 = 'Retired'
;

proc format;
value $sex
'F' = 'female'
'M' = 'male'
;
run;



data trees.bestrest (rename = (hascredi = has_credit_card
hasnewca=has_new_car
hastecar=has_card
has_bank=has_bank_card
has_stor=has_store_card
length_o = length_of_residence
mysteryf=mystery_field
numberof = adults_in_hh
owns_a_m = owns_motorcyle
owns_a_r = owns_RV
owns_a_t = owns_truck
presence=children_home
rec = Recent
upscales=has_upscale_store_card 
__adults = Num_Mature_Prod));
format gender $6.;
*(drop = recency);
set _data_.best_;
if age = 0 then age = .;
if carvalue = 0 then carvalue = .;
gender = put(gender,$sex.);
frequency = put(frequenc, $freq.);
if gender = '???' then gender = ' ';
if income = 0 then income = .;
if length_o = 0 then length_o = .;
if marital = '???' then marital = ' ';
if adults = 0 then adults = .;
run;



