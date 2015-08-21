#!/usr/bin/awk -f
# This relies on hash iteration order!
BEGIN { print "duration,origin,firstPartyLabels,thirdPartyLabels,thirdParty,firstParty,unaccounted,kind" }
/duration/ { printf "%s", $2 }
/origin/ { printf "%s", $2 }
/firstPartyLabels/ { printf "%s", $2 }
/thirdPartyLabels/ { printf "%s", $2 }
/thirdParty"/ { printf "%s", $2 }
/firstParty"/ { printf "%s", $2 }
/unaccounted/ { printf "%s,", $2 }
/kind/ { print $2 }
