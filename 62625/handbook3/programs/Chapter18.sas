ods graphics on;

data skulls;
  infile 'c:\handbook3\datasets\tibetan.dat' expandtabs;
  input length width height faceheight facewidth;
  if _n_ < 18 then type='A';
    else type='B';
run;

proc discrim data=skulls pool=test simple manova wcov crossvalidate;
  class type;
  var length--facewidth;
run;

proc stepdisc data=skulls sle=.05 sls=.05;
   class type;
   var length--facewidth;
run;

proc discrim data=skulls crossvalidate;
  class type;
  var faceheight;
run;

