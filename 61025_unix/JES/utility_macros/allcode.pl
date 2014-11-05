#!/usr/bin/perl -w
use strict;
use Cwd;
my $Day = (localtime)[3]; my $Mon = 1+(localtime)[4]; 
my $Yr  = 1900+(localtime)[5];
my $Dat = "$Yr"."_"."$Mon"."_$Day";
my( @FILES, $folder, $file, $afile, $line, $filedat);
my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
          $atime, $mtime, $ctime, $blksize, $blocks);
my $sascode = "all_code"."_$Dat";
$folder=cwd;
open(OUT,">$folder"."/$sascode".".txt");
$filedat=scalar localtime;
print OUT ("/*>==============================================\n");
print OUT ("       $sascode \n");
print OUT ("       Last Modified $filedat\n");
print OUT ("------------------------------------------------\n");
# Writelist of sas files
opendir(TEMP, "$folder") || die;
while ($file=readdir TEMP){ chomp($file);
if($file=~m/\.sas$/){  print OUT ("------------ $file\n"); }  }
close(TEMP);
print OUT ("==============================================>*/\n\n");
# Write sas code
opendir(TEMP, "$folder") || die;
while ($file=readdir TEMP){ print("file=$file\n"); chomp($file);
if($file=~m/\.sas$/){
  print "$folder"."/"."$file\n";
        ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
         $atime, $mtime, $ctime, $blksize, $blocks)=stat("$file");
         $filedat=scalar localtime($mtime);
  print OUT ("/*>==============================================\n");
  print OUT ("       $file \n");
  print OUT ("       Last Modified $filedat\n");
  print OUT ("==============================================>*/\n");
                open(SAS,"<$folder"."/"."$file")    ||die "$!";
                while(<SAS>)    
                { #s/\/\*.*\*\//  /;
                   $line="$_";     
                   chomp($line);
				   print OUT ("$line\n");}
        	   close(SAS);
  print OUT ("/*>==============================================\n");
  print OUT ("        END    $file\n");
  print OUT ("==============================================>*/\n\n");
                } 
  } closedir(TEMP); close(OUT);


