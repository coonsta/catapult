#!/usr/bin/awk -f
# This relies on hash iteration order: thirdParty, firstParty, unaccounted
BEGIN { print "duration,thirdParty,firstParty,unaccounted,kind" }
/duration/ { printf "%s", $2 }
/thirdParty/ { printf "%s", $2 }
/firstParty/ { printf "%s", $2 }
/unaccounted/ { printf "%s,", $2 }
/kind/ { print $2 }
