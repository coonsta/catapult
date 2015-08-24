#!/usr/bin/awk -f
$1 == "\"isMainFrame\":" {
  nframe_navigations++;
  match(last_url, /^"(([^:]+):(\/\/)?([^/]+))/, x);
  if ($2 == "true,") {
    origins[x[1]]++;
  } else if (x[1] != "about:blank") {
    third_party_origins[x[1]]++;
  }
}
$1 == "\"name\":" && $2 == "\"frames\"," { ntraces++; }
$1 == "\"url\":" { last_url = $2 }
END {
  for (o in origins) {
    nsites++;
  }
  for (o in third_party_origins) {
    nthird_party_origins++;
  }
  printf "traces: %d\nframes: %d\n", ntraces, nframe_navigations;
  printf "sites: %d\nthird-party origins: %d\n", nsites, nthird_party_origins;
}
