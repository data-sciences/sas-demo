libname SPI (SASUSER);                  /* location of data sets */

proc iml;
   /* simulate a coin toss */
   call randseed(1234);                  /* set random number seed     */
   N = 10;
   c = j(N,1);                           /* allocate Nx1 vector        */
   call randgen(c, "uniform");           /* fill with values in (0,1)  */
   c = floor(2*c);                       /* convert to integers 0 or 1 */
   print c;

   /* simulate many coin tosses */
   %include SPImodules;                  /* read module definitions    */
   call randseed(1234);                  /* set random number seed     */
   N = 100;
   g = TossCoin(N);                      /* flip a coin N times        */
   NumHeads = sum(g);                    /* count the number of heads  */
   NumTails = N - NumHeads;              /* the other tosses are tails */
   PropHeads = g[:];                     /* proportion of heads        */
   print NumHeads NumTails PropHeads[format=percent8.3];

   /* Simulate a game: flip a coin until tails appears.
      Keep count of the number of tosses.
      First approach: not optimally efficient. */
   call randseed(1234);                /* set random number seed       */
   NumGames = 1e5;                     /* repeat the game many times   */
   Results = j(NumGames,1,.);          /* number of tosses per game    */
   do i = 1 to NumGames;
      count = 1;                       /* number of tosses so far      */
      toss = TossCoin(1);              /* toss the coin                */
      do while(toss=1);                /* continue until tails appears */
         count = count + 1;
         toss = TossCoin(1);
      end;
      Results[i] = count;              /* record the results           */
   end;

   /* compute expected number of tosses per game: theoretical result   */
   flips = 1:50;               /* approximate series by first 50 terms */
   prob = 2##(-flips);         /* probability for each game            */
   e = sum(flips#prob);        /* expected number of coin flips        */
   print e;

   /* calculate average number of tosses per game in simulated data */
   AvgFlipsPerGame = Results[:];             /* mean over all games */
   print AvgFlipsPerGame;

   /* compute gain = payout for game - cost to play */
   NumHeads = Results - 1;              /* each game ends with tails   */
   Gain = choose(NumHeads<2, 0, NumHeads)-1;   /* proposed gain/loss   */
   AvgGain = Gain[:];                   /* average gain for many games */
   print AvgGain;


proc iml;
   %include SPImodules;                  /* read module definitions    */
   /* Simulate a game: flip a coin until tails appears.
      Keep count of the number of tosses.
      Second approach: more efficient. */
   call randseed(1234);              /* set random number seed         */
   NumGames = 1e5;
   N = int(2.5 * NumGames);          /* 1. Determine number of rolls   */
   toss = TossCoin(N);               /* 2. generate all random numbers */
   Results = j(NumGames,1,.);        /* 3. Allocate results vector     */
   tossIdx = 1;
   do i = 1 to NumGames;
      count = 1;                     /* number of tosses so far        */
      do while(toss[tossIdx]=1);     /* continue until tails           */
         count = count + 1;
         tossIdx = tossIdx + 1;      /* 4. Move to next toss           */
      end;
      Results[i] = count;            /* 5. Record the results          */
      tossIdx = tossIdx + 1;
   end;

   /* simulate rolling a pair of six-sided dice */ 
   call randseed(54321);
   rolls = RollDice(10);
   print rolls;  


proc iml;
   %include SPImodules;                  /* read module definitions    */
   /* simulate the game of craps: first approach
      Not optimally efficient: many calls to the random number routine */
   call randseed(54321);
   NumGames = 1e5;
   Results = j(NumGames, 1, 0);         /* win/loss status of each game */
   do i = 1 to NumGames;
      roll = RollDice(1);
      if roll=7 | roll=11 then do;
         Results[i] = 1;                /* won by a "natural"           */
      end;
      else if roll=3 | roll=2 | roll=12 then do;
         Results[i] = 0;                /* lost (rolled "craps")        */
      end;
      else do;
         game = .;                      /* game is not yet determined   */
         thePoint = roll;               /* establish the point          */
         do while (game=.);             /* keep rolling                 */
            roll = RollDice(1);
            if roll=7 then
               game = 0;                /* roll seven? Lost!            */ 
            else if roll=thePoint then
               game = 1;                /* make the point? Won!         */
         end;
         Results[i] = game;             /* record results (won/lost)    */
      end;
   end;

   won = sum(Results);                  /* count the number of 1's */
   lost = NumGames-won;
   pctWon = Results[:];             
   print won lost pctWon[format=PERCENT8.3];

   /* simulate the game of craps: second approach
      More efficient: one call to the random number routine */
   call randseed(54321);
   NumGames = 1e5;
   N = 4*NumGames;                      /* 1. Determine number of rolls */
   rolls = RollDice(N);               
                                        /* 2. Allocate results vectors  */
   Results = j(NumGames, 1, 0);         /* win/loss status of each game */
   rollsInGame = j(NumGames, 1, 1);     /* how many rolls in each game? */
   Points      = j(NumGames, 1, .);     /* "point" for each game?       */
   howEnded = j(NumGames, 1, "          "); /* "natural", "craps", ...  */

   rollIdx = 1;                     
   do i = 1 to NumGames;
      count = 1;
      roll = rolls[rollIdx];            /* 3. Keep track of current roll*/
      if roll=7 | roll=11 then do;
         game = 1;                      /* won by a "natural"           */
         howEnded[i] = "natural";
      end;
      else if roll=3 | roll=2 | roll=12 then do;
         game = 0;                      /* lost (rolled "craps")        */
         howEnded[i] = "craps";
      end;
      else do;
         game = .;                      /* game is not yet determined   */
         thePoint = roll;               /* establish the point          */
         do while (game = .);           /* keep rolling                 */
            rollIdx = rollIdx + 1;      /* examine next roll            */
            roll = rolls[rollIdx];
            if roll = 7 then
               game = 0;                /* roll seven? Lost!            */ 
            else if roll = thePoint then
               game = 1;                /* make the point? Won!         */
            count = count + 1;
         end;
         Points[i] = thePoint;          /* 4. Record results (won/lost) */
         howEnded[i] = choose(game,"point-Won","point-Lost");
      end;
      Results[i] = game;
      rollsInGame[i] = count;
      rollIdx = rollIdx + 1;         
   end;

   PctGamesWon = Results[:];              /* percentage of games won   */
   uHow = unique(howEnded);               /* "natural", "craps", ...   */
   pct = j(1,ncol(uHow));                 /* percentage for howEnded   */
   do i = 1 to ncol(uHow);
      pct[i] = sum(howEnded = uHow[i]) / NumGames;
   end;
   AvgRollsPerGame = rollsInGame[:];      /* average number of rolls   */
   print PctGamesWon, pct[colname=uHow], AvgRollsPerGame;

   /* examine conditional expectations: Given that the point
      is (4, 5, 6, 8, 9, 10), what is the expectation to win? */
   pts = {4 5 6 8 9 10};                  /* given the point...        */
   PctWonForPt = j(1,ncol(pts));          /* allocate results vector   */
   do i = 1 to ncol(pts);
      idx = loc(Points=pts[i]);           /* find the associated games */
      wl  = Results[idx];                 /* results of those games    */
      PctWonForPt[i] = wl[:];             /* percentage of games won   */
   end;
   print PctWonForPt[colname=(char(pts,2)) format=6.4
              label="Pct of games won, given point"];


proc iml;
   /* simulate drawing a sock from a drawer */
   call randseed(123);
   outcome = {"Black" "Brown" "White"};
   p = {0.5  0.2  0.3};                /* probability of events        */
   N = 1e5;                            /* number of simulated draws    */

   results = j(N,1);                
   call randgen(results, "table", p);  /* fill with values 1..ncol(p)) */


proc iml;
   %include SPImodules;                  /* read module definitions    */

   call randseed(321);
   N = 5;
   EQUAL = .;
   coinTosses = SampleWithReplace({"H" "T"}, N, EQUAL);
   diceRolls = SampleWithReplace(1:6, N||2, EQUAL);        /* two dice */
   p = {.5 .2 .3};
   sockDraws = SampleWithReplace({"Black" "Brown" "White"}, N, p);
   print coinTosses, diceRolls, sockDraws;

proc iml;
   %include SPImodules;                  /* read module definitions    */

   /* compute probability that at least two people share a birthday
      in a room that contains N people */
   N = 25;                                /* number of people in room  */
   i = 1:N;
   iQ = 1 - (i-1)/365;                    /* individual probabilities  */
   Q25 = iQ[#];                           /* product: prob of no match */
   R25 = 1 - Q25;                         /* probability of match      */
   print R25;

   /* compute vector of probabilities: R_N for N=1,2,3... */
   maxN = 50;                                    /* maximum value of N */
   Q = j(maxN,1,1);                              /* note that Q[1] = 1 */
   do i = 2 to maxN;
      Q[i] = Q[i-1] * (1 - (i-1)/365);
   end;
   ProbR = 1 - Q;

   /* Compute how many people need to be in the room before the 
      probability of two people having the same birthday exceeds 75% */
   N75 = loc(ProbR > 0.75)[1];
   print N75[label="N such that probability of match exceeds 75%"];

   /* create room with 25 people; find number of matching birthdays */
   call randseed(123);
   N = 25;                               /* number of people in room   */
   EQUAL = .;                            /* convention                 */
   bday =  SampleWithReplace(1:365, 1||N, EQUAL);
   u = unique(bday);                     /* number of unique birthdays */
   numMatch = N - ncol(u);               /* number of common birthdays */
   print bday, numMatch;

   /* simulation: record number of matching birthdays for many samples */
   N = 25;                               /* number of people in room   */
   NumRooms = 1e5;                       /* number of simulated rooms  */
   bday =  SampleWithReplace(1:365, NumRooms||N, EQUAL);
   match = j(NumRooms,1);                /* allocate results vector    */
   do j = 1 to NumRooms;
      u = unique(bday[j,]);              /* number of unique birthdays */
      match[j] = N - ncol(u);            /* number of common birthdays */
   end;

   /* estimate probability of a matching birthday */
   SimP = sum(match>0) / NumRooms;              /* any match           */
   print SimP[label="Estimate of match (N=25)"]; 

   SimP1 = sum(match=1) / NumRooms;             /* exactly one match   */
   print SimP1[label="Estimate of Exactly One Match (N=25)"];

   SimP2 = sum(match=2) / NumRooms;             /* exactly two matches */
   print SimP2[label="Estimate of Exactly Two Matched (N=25)"]; 


proc iml;
   %include SPImodules;                  /* read module definitions    */

   /* compute monthly means */
   use SPI.Birthdays2002;
   read all var {Percentage} into y;
   read all var {Month} into Group;
   close SPI.Birthdays2002;

   u = unique(Group);
   GroupMeans = j(1,ncol(u));
   do i = 1 to ncol(u);
      idx = loc(Group = u[i]);
      GroupMeans[i] = y[idx][:];
   end;

   /* compute vector of probabilities: R_N for N=1..7 */
   maxN = 7;                                     /* maximum value of N */
   S = j(maxN,1,1);                              /* note that S[1] = 1 */
   do i = 2 to maxN;
      S[i] = S[i-1] * (1 - (i-1)/7);
   end;
   ProbR = 1 - S;
   rlabl = 'N1':'N7';
   print ProbR[rowname=rlabl];

   /* compute proportion of the birthdays that occur for each DOW */
   use SPI.Birthdays2002;
   read all var {Births} into y;
   read all var {DOW} into Group;
   close SPI.Birthdays2002;

   u = unique(Group);                           
   GroupMeans = j(1,ncol(u));
   do i = 1 to ncol(u);                         
      idx = loc(Group = u[i]);
      GroupMeans[i] = (y[idx])[:]; /* mean births for each day of week */
   end;

   proportions = GroupMeans/GroupMeans[+];  /* rescale so the sum is 1 */
   labl = {"Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"};
   print proportions[colname=labl format=5.3];

   /* simulate matching BDOW by using empirical proportions from 2002  */
   p = proportions;                      /* probability of events      */
   call randseed(123);

   NumRooms = 1e5;                       /* number of simulated rooms  */
   NumPeople = 1:7;                      /* number of people in room   */

   SimR = j(7, 1, 0);                    /* est prob of matching BDOW  */
   match = j(NumRooms,1);                /* allocate results vector    */

   do N = 2 to 7;                        /* for rooms with N people... */
      bdow =  SampleWithReplace(1:7, NumRooms||N, p);      /* simulate */
      do j = 1 to NumRooms;
         u = unique(bdow[j,]);           /* number of unique BDOW      */
         match[j] = N - ncol(u);         /* number of common BDOW      */
      end;
      SimR[N] = (match>0)[:];            /* proportion of matches      */
   end;

   rlabel = "N1":"N7";
   print SimR[rowname=rlabel label="Estimate"];

   diff = SimR - ProbR;
   print diff[rowname=rlabel];


proc iml;
   %include SPImodules;                  /* read module definitions    */

   /* simulate matching birthdays by using empirical proportions from 2002 */
   use SPI.Birthdays2002;
   read all var {Births};
   close SPI.Birthdays2002;
  
   call randseed(123);
   p = Births/Births[+];                 /* probability of events      */
   NumRooms = 1e4;                       /* number of simulated rooms  */
   maxN = 50;                           
   NumPeople = 1:maxN;                   /* number of people in room   */

   SimR = j(maxN,1,0);                
   match = j(NumRooms,1);                /* allocate results vector    */

   do N = 2 to maxN;                     /* for rooms with N people... */
      bday =  SampleWithReplace(1:365, NumRooms||N, p);    /* simulate */
      do j = 1 to NumRooms;
         u = unique(bday[j,]);           /* number of unique birthdays */
         match[j] = N - ncol(u);         /* number of common birthdays */
      end;
      /* estimated prob of >= 1 matching birthdays */
      SimR[N] = (match>0)[:];
   end;

   print SimR;
quit;
