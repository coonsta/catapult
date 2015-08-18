#!/usr/bin/awk -f
# This relies on hash iteration order: thirdParty, firstParty, unaccounted
BEGIN { print "duration,thirdParty,firstParty,unaccounted" }
/duration/ { printf "%s", $2 }
/thirdParty/ { printf "%s", $2 }
/firstParty/ { printf "%s", $2 }
/unaccounted/ { print $2 }
