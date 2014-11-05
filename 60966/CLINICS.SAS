*************************************************;
* clinics.sas;
*
* Create the clinics data set.
*************************************************;

data rptdata.clinics;
infile cards missover;
input clinnum  $ 1-6
      clinname $ 7-33
      region   $ 34-35
      lname    $ 36-45
      fname    $ 46-51
      ssn      $ 52-60
      sex      $ 61
      dob        mmddyy8.
      death      mmddyy8.
      race     $ 78
      edu        79-80
      wt         81-83
      ht         84-85
      exam       mmddyy8.
      symp     $ 94-95
      dt_diag    mmddyy8.
      diag     $ 104
      admit      mmddyy8.
      proced   $ 113
      disch      mmddyy8.;

format dob death exam dt_diag admit disch date7.;

label clinnum  = 'clinic number'
      clinname = 'clinic name'
      region   = 'region'
      lname    = 'last name'
      fname    = 'first name'
      ssn      = 'social security number'
      sex      = 'patient sex'
      dob      = 'date of birth'
      death    = 'date of death'
      race     = 'race'
      edu      = 'years of education'
      wt       = 'weight in pounds'
      ht       = 'height in inches'
      exam     = 'examination date'
      symp     = 'symptom code'
      dt_diag  = 'date of diagnosis'
      diag     = 'diagnosis code'
      admit    = 'admit date'
      proced   = 'procedure code'
      disch    = 'discharge date'
      ;
cards;
031234Bethesda Pioneer Hospital   3Smith     Mike  123456789M03/18/52        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Jones     Sarah 043667543F07/02/46        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Maxwell   Linda 135798642F05/20/53        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Marshall  Robert489012567M03/11/53        1121556711/02/8702
108531Seattle Medical Complex    10James     Debra 563457897F06/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Lawless   Henry 075312468M09/17/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chu       David 784567256M06/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Halfner   John  589012773M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Cranberry David 153675389M11/21/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Simpson   Donna 373167532F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
093785Sacramento Medical Complex  9Wright    Sarah 674892109F10/21/48        2121776509/10/8306
024477New York General Hospital   2Little    Sandra376245789F08/01/50        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Johnson   Randal537890152M08/29/56        11820173
057312Indiana Help Center         5Henderson Robert932456132M02/25/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Adamson   Joan  011553218F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Rodgers   Carl  327654213M11/15/48        1131797212/20/84
066789Austin Medical Hospital     6Alexander Mark  743567875M01/15/30        1121757009/15/88
026789Geneva Memorial Hospital    2Long      Margot531895634F02/28/49        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Cranston  Rhonda287463500F01/03/3704/13/881121606203/28/881003/28/88503/28/88204/13/88
094789San Diego Memorial Hospital 9Dandy     Martin578901234M05/21/37        11218570
084890Montana Municipal Hospital  8Wills     Norma 425617894F05/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Cordoba   Juan  327654213M06/06/67        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Robertson Adam  743787764M04/07/4208/03/871121776904/29/850505/03/85603/29/87208/03/87
063742Houston General             6King      Doug  467901234M08/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Marksman  Joan  634792254F09/28/63        41411265
031234Bethesda Pioneer Hospital   3Candle    Sid   468729812M10/15/17        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4Baron     Roger 189456372M01/29/37        1101607006/15/8510
011234Boston National Medical     1Nabers    David 345751123M11/03/21        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Harbor    Samuel091550932M01/14/50        3141056405/27/830605/28/832
063742Houston General             6Davidson  Mitch 524189532M02/26/39        2162016905/12/8705        2
059372Ohio Medical Hospital       5Karson    Shawn 297854321F03/05/60        217 9862        04
023910New York Metro Medical Ctr  2Harbor    Samuel091550932M01/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Adams     Mary  079932455F08/12/51        2171556709/14/850209/14/852
107211Portland General           10Holmes    Donald315674321M06/21/40        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Simpson   Donna 373167532F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Marks     Gerald638956732M03/03/47        1102156709/02/82
065742Kansas Metropolitan         7Chang     Joseph539873164M08/20/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Masters   Martha029874182F08/20/58        2171556709/14/850209/14/852
095277San Francisco Bay General   9Marks     Gerald638956732M03/03/47        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rymes     Carol 680162534F10/05/57        1151316604/01/850204/01/852
031234Bethesda Pioneer Hospital   3Henry     Louis 467189564M04/19/53        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Stubs     Mark  319085647M06/11/47        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Haddock   Linda 219075362F04/04/51        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Uno       Robert389036754M03/21/44        1121556711/02/8702
108531Seattle Medical Complex    10Manley    Debra 366781237F01/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Mercy     Ronald190473627M09/27/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chang     Tim   198356256M02/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Most      Mat   109267433M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Rose      Mary  299816743F11/01/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Nolan     Terrie298456241F10/18/3307/21/871151876305/12/870405/12/87305/12/87207/21/87
093785Sacramento Medical Complex  9Tanner    Heidi 456178349F08/08/45        2121776509/10/8306
024477New York General Hospital   2Saunders  Liz   468045789F03/01/49        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Jackson   Ted   339984672M12/29/56        11820173
057312Indiana Help Center         5Pope      Robert832456132M02/05/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Olsen     June  743873218F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Maxim     Kurt  468721213M10/15/40        1131797212/20/84
066789Austin Medical Hospital     6Banner    John  368267875M01/25/32        1121757009/15/88
026789Geneva Memorial Hospital    2Ingram    Marcia367895634F02/13/48        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Moon      Rachel375363500F01/23/3706/13/881121606203/28/881003/28/88505/28/88206/13/88
094789San Diego Memorial Hospital 9Thomas    Daniel486301234M05/23/38        11218570
084890Montana Municipal Hospital  8East      Jody  086317894F10/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Perez     Mathew578254213M07/06/57        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Reilly    Arthur476587764M05/17/4209/03/871121776904/29/850505/03/85608/29/87209/03/87
063742Houston General             6Antler    Peter 489745234M01/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Upston    Betty 784793254F09/13/63        41411265
031234Bethesda Pioneer Hospital   3Panda     Merv  387549812M10/11/19        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4East      Clint 842576372M01/26/37        1101607006/15/8510
011234Boston National Medical     1Taber     Lee   479451123M11/05/24        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Leader    Zac   075345932M01/15/50        3141056405/27/830605/28/832
063742Houston General             6Ronson    Gerald474223532M02/27/49        2162016905/12/8705        2
059372Ohio Medical Hospital       5Carlile   Patsy 578854321F03/15/55        217 9862        04
023910New York Metro Medical Ctr  2Atwood    Teddy 066425632M02/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Batell    Mary  310967555F01/12/37        2171556709/14/850209/14/852
107211Portland General           10Hermit    Oliver471094671M06/23/38        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Temple    Linda 691487532F04/18/4305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Block     Will  549014532M03/12/51        1102156709/02/82
065742Kansas Metropolitan         7Chou      John  310986734M05/15/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Herbal    Tammy 041090882F08/23/46        2171556709/14/850209/14/852
095277San Francisco Bay General   9Mann      Steven489956732M03/27/43        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rumor     Stacy 409825614F12/05/52        1151316604/01/850204/01/852
run;
