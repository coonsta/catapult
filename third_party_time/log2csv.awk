#!/usr/bin/awk -f
# This relies on hash iteration order!
BEGIN { n=8; print "duration,origin,firstPartyLabels,thirdPartyLabels,thirdParty,firstParty,unaccounted,kind" }
$1 ~ /duration/ {
  if (n != 8)
    printf "1: Things off the rails around line %d\n", FNR > "/dev/stderr";
  n = 1;
  printf "%s", $2
}
$1 ~ /origin/ { n++; printf "%s", $2 }
$1 ~ /firstPartyLabels/ { n++; printf "%s", $2 }
$1 ~ /thirdPartyLabels/ { n++; printf "%s", $2 }
$1 ~ /thirdParty"/ { n++; printf "%s", $2 }
$1 ~ /firstParty"/ { n++; printf "%s", $2 }
$1 ~ /unaccounted/ { n++; printf "%s,", $2 }
$1 ~ /kind/ {
  n++;
  print $2;
  if (n != 8)
    printf "2: Things off the rails around line %d\n", FNR > "/dev/stderr";
}
